#
# Copyright (C) 2019 University of Amsterdam
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#


# TODO: Expose priors specification to users in Bxxx?
# TODO: Add 3rd level random effects grouping factors ;) (not that difficult actually)

# Workaround for afex::mixed with parametric bootstrap calling glmer with REML argument
# glmer() does not accept REML (GLMMs are always fit with ML), but afex passes REML = FALSE
# Patch lme4::glmer to accept but ignore REML argument
# This runs via .onLoad to ensure namespace is properly unlocked
.glmerPatchEnv <- new.env()
assign(".glmer_patched", FALSE, envir = .glmerPatchEnv)

.onLoad <- function(libname, pkgname) {
  # Only patch once
  if (!get(".glmer_patched", envir = .glmerPatchEnv)) {
    ns <- asNamespace("lme4")
    if (unlockBinding("glmer", ns)) {
      .glmer_orig <<- get("glmer", envir = ns, inherits = FALSE)
      ns$glmer <- function(...) {
        args <- list(...)
        args$REML <- NULL
        do.call(.glmer_orig, args)
      }
      lockBinding("glmer", ns)
      assign(".glmer_patched", TRUE, envir = .glmerPatchEnv)
    }
  }
}

.mmRunAnalysis   <- function(jaspResults, dataset, options, type) {

  .setOptions()

  if (.mmReady(options, type))
    dataset <- .mmCheckData(jaspResults, dataset, options, type)

  # fit the model
  if (.mmReady(options, type)) {
    if (type %in% c("LMM", "GLMM")).mmFitModel(jaspResults, dataset, options, type)
    if (type %in% c("BLMM", "BGLMM")).mmFitModelB(jaspResults, dataset, options, type)
  }


  # create (default) summary tables
  if (type %in% c("LMM", "GLMM")).mmSummaryAnova(jaspResults, dataset, options, type)
  if (type %in% c("BLMM", "BGLMM")).mmSummaryStanova(jaspResults, dataset, options, type)


  if (!is.null(jaspResults[["mmModel"]]) && !jaspResults[[ifelse(type %in% c("LMM", "GLMM"), "ANOVAsummary", "STANOVAsummary")]]$getError()) {


    # show fit statistics
    if (options$modelSummary) {
      if (type %in% c("LMM", "GLMM")).mmFitStats(jaspResults, options, type)
      if (type %in% c("BLMM", "BGLMM")).mmFitStatsB(jaspResults, options, type)
    }


    # show fixed / random effects summary
    if (options$fixedEffectEstimate) {
      if (type %in% c("LMM", "GLMM")).mmSummaryFE(jaspResults, options, type)
      if (type %in% c("BLMM", "BGLMM")).mmSummaryFEB(jaspResults, options, type)
    }
    if (options$varianceCorrelationEstimate) {
      if (type %in% c("LMM", "GLMM")).mmSummaryRE(jaspResults, options, type)
      if (type %in% c("BLMM", "BGLMM")).mmSummaryREB(jaspResults, options, type)
    }
    if (options$randomEffectEstimate)
      .mmSummaryREEstimates(jaspResults, options, type)

    # sampling diagnostics
    if (type %in% c("BLMM", "BGLMM")) {
      if (length(options$mcmcDiagnosticsHorizontal) != 0)
        .mmDiagnostics(jaspResults, options, dataset, type)
    }


    # create plots
    if (length(options$plotHorizontalAxis))
      .mmPlot(jaspResults, dataset, options, type)


    # marginal means
    if (length(options$marginalMeansTerms) > 0)
      .mmMarginalMeans(jaspResults, dataset, options, type)

    if (length(options$marginalMeansTerms) > 0 && options$marginalMeansContrast && !is.null(jaspResults[["EMMresults"]]))
      .mmContrasts(jaspResults, options, type, what = "Means")


    # trends
    if (length(options$trendsTrendVariable) > 0 &&  length(options$trendsVariables) > 0)
      .mmTrends(jaspResults, dataset, options, type)

    if (options$trendsContrast && length(options$trendsTrendVariable) > 0 && length(options$trendsVariables) > 0 && !is.null(jaspResults[["EMTresults"]]))
      .mmContrasts(jaspResults, options, type, what = "Trends")

  }

  return()
}

### common mixed-models functions
.mmCheckData     <- function(jaspResults, dataset, options, type = "LMM") {

  # omit NAs/NaN/Infs and store the number of omitted observations
  allRows <- nrow(dataset)
  dataset <- na.omit(dataset)

  # store the number of missing values into a jaspState object
  nMissing <- createJaspState()
  nMissing$object <- allRows - nrow(dataset)
  jaspResults[["nMissing"]] <- nMissing

  # check the data set
  if (nrow(dataset) < length(options$fixedEffects))
    .quitAnalysis("The dataset contains fewer observations than predictors (after excluding NAs/NaN/Inf).")

  checkVariables <- 1:ncol(dataset)
  if (type %in% c("GLMM", "BGLMM"))
    if (options$dependentAggregation != "")
      checkVariables <- checkVariables[-which(options$dependentAggregation == colnames(dataset))]


  .hasErrors(
    dataset,
    type = 'infinity',
    exitAnalysisIfErrors = TRUE
  )

  # the aggregation variable for bernoulli can have zero variance and can be without factor levels
  .hasErrors(
    dataset[, checkVariables],
    type = c('variance', 'factorLevels'),
    factorLevels.amount  = "< 2",
    exitAnalysisIfErrors = TRUE,
    custom = .mmCustomChecks
  )

  for(var in unlist(options$fixedEffects)) {

    if ((is.factor(dataset[, var]) || is.character(dataset[, var])) && length(unique(dataset[, var])) == nrow(dataset))
      .quitAnalysis(gettextf("The categorical fixed effect '%s' must have fewer levels than the overall number of observations.", var))

  }

  for(var in unlist(options$randomVariables)) {

    if (length(unique(dataset[, var])) == nrow(dataset))
      .quitAnalysis(gettextf("The random effects grouping factor '%s' must have fewer levels than the overall number of observations.", var))

  }

  # check hack-able options
  if (type %in% c("BLMM", "BGLMM")) {

    if (options$mcmcSamples - 1 <= options$mcmcBurnin)
      .quitAnalysis(gettext("The number of iterations must be at least 2 iterations higher than the burnin"))

  }

  # check families
  if (type %in% c("GLMM","BGLMM")) {

    familyText <- .mmMessageGLMMtype(options$family, options$link)
    familyText <- substr(familyText, 1, nchar(familyText) - 1)

    if (options$family %in% c("gamma", "inverseGaussian")) {

      if (any(dataset[, options$dependent] <= 0))
        .quitAnalysis(gettextf("%s requires that the dependent variable is positive.",familyText))

    } else if (options$family %in% c("negativeBinomial", "poisson")) {

      if (any(dataset[, options$dependent] < 0 | any(!.is.wholenumber(dataset[, options$dependent]))))
        .quitAnalysis(gettextf("%s requires that the dependent variable is an integer.",familyText))

    } else if (options$family == "bernoulli") {

      if (length(unique(dataset[, options$dependent])) != 2)
        .quitAnalysis(gettextf("%s requires that the dependent variable contains only two levels.",familyText))

      # transform to 0/1 outcome
      attr(dataset, "binomialSuccess") <- sort(unique(dataset[[options$dependent]]))[2]
      dataset[[options$dependent]] <- as.numeric(dataset[[options$dependent]] == attr(dataset, "binomialSuccess"))

    } else if (options$family == "binomial") {

      if (any(dataset[, options$dependentAggregation] < 0) || any(!.is.wholenumber(dataset[, options$dependentAggregation])))
        .quitAnalysis(gettextf("%s requires that the number of trials variable is an integer.",familyText))

      if (all(.is.wholenumber(dataset[, options$dependent]))){
        if(any(dataset[, options$dependent] > dataset[, options$dependentAggregation]))
          .quitAnalysis(gettextf("%s requires that the number of successes is lower that the number of trials.",familyText))

        dataset[, options$dependent] <- dataset[, options$dependent] / dataset[, options$dependentAggregation]
      }

      if (any(dataset[, options$dependent] < 0 | dataset[, options$dependent] > 1))
        .quitAnalysis(gettextf("%s requires that the dependent variable is higher than 0 and lower than 1.",familyText))

      if (any(!.is.wholenumber(dataset[, options$dependent] * dataset[, options$dependentAggregation])))
        .quitAnalysis(gettextf("%s requires that the dependent variable is either the number or proportion of successes out of the number of trials.",familyText))

    } else if (options$family == "beta") {

      if (any(dataset[, options$dependent] <= 0 | dataset[, options$dependent] >= 1))
        .quitAnalysis(gettextf("%s requires that the dependent variable is higher than 0 and lower than 1.",familyText))

    }
  }

  return(dataset)
}
.mmReady         <- function(options, type = "LMM") {

  if (type %in% c("LMM","BLMM")) {

    if (options$dependent       == "" ||
        length(options$randomVariables) == 0  ||
        (length(options$fixedEffects)   == 0 && !options$includeIntercept))
      return(FALSE)


  } else if (type %in% c("GLMM","BGLMM")) {

    if (options$family == "binomial") {
      if (options$dependent            == "" ||
          options$dependentAggregation == "" ||
          length(options$randomVariables) == 0  ||
          (length(options$fixedEffects)   == 0 && !options$includeIntercept))
        return(FALSE)

    }else {

      if (options$dependent       == "" ||
          length(options$randomVariables) == 0  ||
          (length(options$fixedEffects)   == 0 && !options$includeIntercept))
        return(FALSE)

    }
  }

  return(TRUE)
}
.mmModelFormula  <- function(options, dataset) {

  # fixed effects
  feTerms  <-  sapply(options[["fixedEffects"]], function(x) paste(unlist(x), collapse = "*"))
  # simplify the terms
  feTerms  <- .mmSimplifyTerms(feTerms)
  # intercept
  if (options$includeIntercept)
    feTerms <- c("1", feTerms)
  else
    feTerms <- c("0", feTerms)
  # create the FE formula
  fixedEffects <- paste0(feTerms, collapse = "+")

  # random effects
  randomEffects <- NULL
  removedMe     <- list()
  removedTe     <- list()
  addedRe       <- list()

  for (tempRe in options[["randomEffects"]]) {

    # unlist selected random effects
    tempVars <- sapply(tempRe[["randomComponents"]], function(x) {
      if (x$randomSlopes)
        return(unlist(x[["value"]]))
      else
        return(NA)
    })
    tempVarsRem <- sapply(tempRe[["randomComponents"]], function(x) {
      if (x[["randomSlopes"]])
        return(NA)
      else
        return(unlist(x$value))
    })
    tempVars     <- tempVars[!is.na(tempVars)]
    tempVars     <- sapply(tempVars, function(x) paste(unlist(x), collapse = "*"))
    tempVarsRem  <- tempVarsRem[!is.na(tempVarsRem)]
    tempVarsRem  <- sapply(tempVarsRem, function(x) paste(unlist(x), collapse = "*"))

    # check whether the random intercept is specified, and remove it from the list of slopes
    tempHasIntercept <- any(tempVars == "Intercept")
    tempVars         <- tempVars[tempVars != "Intercept"]
    tempVarsRem      <- tempVarsRem[tempVarsRem != "Intercept"]

    ### test sensibility of random slopes
    # main effect check #1
    # - remove main effects that have only one level of selected variable for the random effect grouping factor (eg only between subject variables)
    # - and associated interactions
    meToRemove <- NULL
    for (me in tempVars[!grepl("\\*", tempVars)]) {

      tempTable <- table(dataset[, c(tempRe$value, me)])

      if (all(apply(tempTable, 1, function(x) sum(x > 0)) <= 1))
        meToRemove <- c(meToRemove, me)

    }

    if (!is.null(meToRemove))
      tempVars <- tempVars[!tempVars %in% unique(as.vector(sapply(meToRemove, function(x)
        tempVars[grepl(x, tempVars, fixed = TRUE)])))]

    tempVars <- na.omit(tempVars)

    # terms check #2
    # - remove terms that have at maximum one measure across the level of variables (targeted at interactions of between subject variables)
    teToRemove <- NULL
    for (te in tempVars) {

      tempTerms <- unlist(strsplit(te, "\\*"))

      if (any(sapply(tempTerms, function(x) typeof(dataset[, x]) == "double")))
        next

      tempTable <- table(dataset[, c(tempRe$value, tempTerms)])

      if (all(tempTable <= 1))
        teToRemove <- c(teToRemove, te)

    }
    if (!is.null(teToRemove)) {
      teToRemove <- unique(as.vector(sapply(teToRemove, function(x) tempVars[grepl(x, tempVars, fixed = TRUE)])))
      tempVars   <- tempVars[!tempVars %in% teToRemove]
    }

    # simplify the formula
    reAdded <- .mmAddedRETerms(tempVars, tempVarsRem)
    reTerms <- .mmSimplifyTerms(tempVars)

    # check whether at least one random effect was specified
    if (!tempHasIntercept && length(reTerms) == 0)
      .quitAnalysis(gettextf(
        "At least one random effect needs to be specified for the '%1$s' random effect grouping factors.%2$s",
        tempRe$value,
        if (length(meToRemove) + length(teToRemove) > 0) gettextf(
        " Note that the following random effects were removed because they could not be estimated from the data: %1$s.",
        paste0("'", c(meToRemove, teToRemove), "'", collapse = ", ")) else ""))

    newRe <-
      paste0(
        "(",
        if (tempHasIntercept)    "1" else "0",
        if (length(reTerms) > 0) "+" else "",
        paste0(reTerms, collapse = "+"),
        if (tempRe[["correlations"]] || length(reTerms) == 0) "|" else "||",
        tempRe$value,
        ")"
      )

    randomEffects <- c(randomEffects, newRe)
    removedMe[[tempRe$value]] <- meToRemove
    removedTe[[tempRe$value]] <- teToRemove
    addedRe[[tempRe$value]]   <- reAdded
  }
  randomEffects <- paste0(randomEffects, collapse = "+")

  modelFormula <-
    paste0(options$dependent,
           "~",
           fixedEffects,
           "+",
           randomEffects)

  return(
    list(
      modelFormula = modelFormula,
      removedMe    = removedMe,
      removedTe    = removedTe,
      addedRe      = addedRe
    )
  )
}
.mmSimplifyTerms <- function(terms) {

  if (length(terms) > 1) {

    splitTerms    <- sapply(terms, strsplit, "\\*")
    splitTerms    <- sapply(splitTerms, function(x) trimws(x, which = c("both")))
    termsToRemove <- rep(NA, length(splitTerms))

    for (i in 1:length(terms)) {
      termsToRemove[i] <- any(sapply(splitTerms[-i], function(x) all(splitTerms[[i]] %in% x)))
    }

    terms <- terms[!termsToRemove]
  }

  return(terms)
}
.mmSetContrasts  <- function(dataset, options) {

  for (i in seq_along(options[["fixedVariables"]])) {
    if (is.factor(dataset[[options[["fixedVariables"]][i]]])) {
      contrasts(dataset[[options[["fixedVariables"]][i]]]) <- switch(
        options$factorContrast,
        "sum"       = contr.sum,
        "treatment" = contr.treatment
      )
    } else if (is.character(dataset[[options[["fixedVariables"]][i]]])) {
      dataset[[options[["fixedVariables"]][i]]] <- factor(dataset[[options[["fixedVariables"]][i]]])
      contrasts(dataset[[options[["fixedVariables"]][i]]]) <- switch(
        options$factorContrast,
        "sum"       = contr.sum,
        "treatment" = contr.treatment
      )
    }
  }

  return(dataset)
}
.mixedInterceptML   <- function(formula, dataset, type, family = NULL) {
  # this is a simple function to fit a mixed-effects model with a fixed intercept only
  # because afex does not allow those models for GLMMs (or LMMs with LRT/PB)
  if (type == "LMM") {
    fit <- lmerTest::lmer(
      formula         = formula,
      data            = dataset,
      REML            = FALSE
    )
  } else if (type == "GLMM") {
    fit <- lme4::glmer(
      formula         = formula,
      data            = dataset,
      family          = family
    )
  }

  return(list(
    anova_table = data.frame(),
    full_model  = fit
  ))
}
.isInterceptML      <- function(options) {
  return(length(options$fixedEffects) == 0 && options$includeIntercept && options$testMethod %in% c("likelihoodRatioTest", "parametricBootstrap"))
}
.mmGetTestIntercept <- function(options) {
   out <- if (options[["testMethod"]] %in% c("likelihoodRatioTest", "parametricBootstrap")) options[["interceptTest"]] else FALSE
   return(out)
}

.mmGetTestMethod <- function(options) {
  out <- switch(
    options[["testMethod"]],
    satterthwaite       = "S",
    kenwardRoger        = "KR",
    likelihoodRatioTest = "LRT",
    parametricBootstrap = "PB",
    options[["testMethod"]]
  )
  return(out)
}

.mmAddedRETerms  <- function(terms, removed) {

  added <- NULL
  if (length(terms) > 1 && length(removed) >= 1) {

    splitTerms   <- lapply(terms,   function(x) trimws(unlist(strsplit(x, "\\*")), which = c("both")))
    splitRemoved <- lapply(removed, function(x) trimws(unlist(strsplit(x, "\\*")), which = c("both")))

    termsToRemove <- rep(NA, length(splitTerms))

    for (i in 1:length(removed)) {

      if (any(sapply(splitTerms, function(x) all(splitRemoved[[i]] %in% x))))
        added <- c(added, paste0(splitRemoved[[i]], collapse = "*"))

    }
  }

  return(added)
}
.mmFitModel      <- function(jaspResults, dataset, options, type = "LMM") {

  if (!is.null(jaspResults[["mmModel"]]))
    return()

  mmModel <- createJaspState()
  #maybe you should define some columns here
  jaspResults[["mmModel"]] <- mmModel

  if (options$testMethod == "parametricBootstrap") {
    seedDependencies <- c("seed", "setSeed")
    .setSeedJASP(options)
  } else {
    seedDependencies <- NULL
  }

  dependencies <- c(.mmSwichDependencies(type), seedDependencies)
  mmModel$dependOn(dependencies)

  # specify model formula
  modelFormula <- .mmModelFormula(options, dataset)

  # specify contrasts
  dataset <- .mmSetContrasts(dataset, options)

  if (type == "LMM") {
    if (.isInterceptML(options))
      model <- try(
        .mixedInterceptML(
          formula         = as.formula(modelFormula$modelFormula),
          data            = dataset,
          type            = "LMM"
        ))
    else
      model <- try(
        afex::mixed(
          formula         = as.formula(modelFormula$modelFormula),
          data            = dataset,
          type            = options$type,
          method          = .mmGetTestMethod(options),
          test_intercept  = .mmGetTestIntercept(options),
          args_test       = list(nsim = options$bootstrapSamples),
          check_contrasts = FALSE
        ))
  } else if (type == "GLMM") {
    # needs to be evaluated in the global environment
    glmmLink   <<- options$link
    glmmFamily <<- .mmGetRFamily(options[["family"]])
    glmmFamily <<- eval(call(glmmFamily, glmmLink))

    # I wish there was a better way to do this
    if (options$family == "binomial") {

      if (.isInterceptML(options))
        .quitAnalysis(gettext("Mixed-effects models with a fixed intercept only are not supported for aggregated binomial family."))

      glmmWeight <<- dataset[, options$dependentAggregation]
      model <- try(
        afex::mixed(
          formula         = as.formula(modelFormula$modelFormula),
          data            = dataset,
          type            = options$type,
          method          = .mmGetTestMethod(options),
          test_intercept  = .mmGetTestIntercept(options),
          args_test       = list(nsim = options$bootstrapSamples),
          check_contrasts = FALSE,
          family          = glmmFamily,
          weights         = glmmWeight
        ))
    } else {
      if (.isInterceptML(options))
        model <- try(
          .mixedInterceptML(
            formula         = as.formula(modelFormula$modelFormula),
            data            = dataset,
            family          = glmmFamily,
            type            = "GLMM"
          ))
      else
        model <- try(
          afex::mixed(
            formula         = as.formula(modelFormula$modelFormula),
            data            = dataset,
            type            = options$type,
            method          = .mmGetTestMethod(options),
            test_intercept  = .mmGetTestIntercept(options),
            args_test       = list(nsim = options$bootstrapSamples),
            check_contrasts = FALSE,
            #start           = start,
            family          = glmmFamily
        ))
    }
  }


  object <- list(
    model            = model,
    removedMe        = modelFormula$removedMe,
    removedTe        = modelFormula$removedTe,
    addedRe          = modelFormula$addedRe
  )

  mmModel$object <- object

  return()
}

.mmGetRFamily <- function(family) {
  family <- switch(
    family,
    bernoulli       = "binomial",
    gamma           = "Gamma",
    inverseGaussian = "inverse.gaussian",
    family
  )
  return(family)
}
.mmSummaryAnova  <- function(jaspResults, dataset, options, type = "LMM") {

  if (!is.null(jaspResults[["ANOVAsummary"]]))
    return()

  model <- jaspResults[["mmModel"]]$object$model

  ANOVAsummary <- createJaspTable(title = gettext("ANOVA Summary"))
  #defining columns first to give the user something nice to look at
  ANOVAsummary$addColumnInfo(name = "effect",         title = gettext("Effect"),             type = "string")

  if (options$testMethod %in% c("satterthwaite", "kenwardRoger")) {
    ANOVAsummary$addColumnInfo(name = "df",           title = gettext("df"),                 type = "string")
    ANOVAsummary$addColumnInfo(name = "stat",         title = gettext("F"),                  type = "number")
  } else if (options$testMethod %in% c("parametricBootstrap", "likelihoodRatioTest")) {
    ANOVAsummary$addColumnInfo(name = "df",           title = gettext("df"),                 type = "integer")
    ANOVAsummary$addColumnInfo(name = "stat",         title = gettext("ChiSq"),              type = "number")
  }

  ANOVAsummary$addColumnInfo(name = "pval",           title = gettext("p"),                  type = "pvalue")

  if (options$testMethod == "parametricBootstrap")
    ANOVAsummary$addColumnInfo(name = "pvalBoot",     title = gettext("p (bootstrap)"),      type = "pvalue")

  if (options$vovkSellke) {
    ANOVAsummary$addColumnInfo(name = "vovkSellke",       title = gettext("VS-MPR"),             type = "number")

    if (options$testMethod == "parametricBootstrap")
      ANOVAsummary$addColumnInfo(name = "pvalBootVS", title = gettext("VS-MPR (bootstrap)"), type = "number")

    ANOVAsummary$addFootnote(.mmMessageVovkSellke(), symbol = "\u002A", colNames = c("vovkSellke", "pvalBootVS"))
  }

  jaspResults[["ANOVAsummary"]] <- ANOVAsummary

  ANOVAsummary$position <- 1
  dependencies <- .mmSwichDependencies(type)

  if (options$testMethod == "parametricBootstrap")
    seedDependencies <- c("seed", "setSeed")
  else
    seedDependencies <- NULL

  ANOVAsummary$dependOn(c(dependencies, seedDependencies, "vovkSellke"))

  # some error management for GLMMS - and oh boy, they can fail really easily
  if (!is.null(model) && inherits(model, c("std::runtime_error", "C++Error", "try-error"))) {
    ANOVAsummary$setError(.mmErrorOnFit(model))
    return()
  }


  if (is.null(model)) {

    if (options$dependent != "" && length(options$fixedVariables) > 0 &&  length(options$randomVariables) == 0)
      ANOVAsummary$addFootnote(.mmMessageMissingRE())

    if (type == "GLMM" && options$family == "binomial" && options$dependentAggregation == "")
      ANOVAsummary$addFootnote(.mmMessageMissingAgg())

    return()
  }


  if (nrow(model$anova_table) > 0) {
    for (i in 1:nrow(model$anova_table)) {

      if (rownames(model$anova_table)[i] == "(Intercept)")
        effectName <- "Intercept"
      else
        effectName <- jaspBase::gsubInteractionSymbol(rownames(model$anova_table)[i])

      tempRow <- list(effect = effectName, df = afex::nice(model)$df[i])

      if (options$testMethod %in% c("satterthwaite", "kenwardRoger")) {
        tempRow$stat   = model$anova_table$`F`[i]
        tempRow$pval   = model$anova_table$`Pr(>F)`[i]
      } else if (options$testMethod == "parametricBootstrap") {
        tempRow$stat     = model$anova_table$Chisq[i]
        tempRow$pval     = model$anova_table$`Pr(>Chisq)`[i]
        tempRow$pvalBoot = model$anova_table$`Pr(>PB)`[i]
      } else if (options$testMethod == "likelihoodRatioTest") {
        tempRow$stat     = model$anova_table$Chisq[i]
        tempRow$pval     = model$anova_table$`Pr(>Chisq)`[i]
      }
      if (options$vovkSellke) {
        tempRow$vovkSellke <- VovkSellkeMPR(tempRow$pval)
        if (options$testMethod == "parametricBootstrap")
          tempRow$pvalBootVS <- VovkSellkeMPR(tempRow$pvalBoot)
      }

      ANOVAsummary$addRows(tempRow)
    }
  }

  # add message about (lack of) random effect grouping factors
  ANOVAsummary$addFootnote(.mmMessageREgrouping(options$randomVariables))

  # add warning messages
  # deal with type II multiple models stuff
  if (is.list(model$full_model)) {

    if (lme4::isSingular(model$full_model[[length(model$full_model)]]))
      ANOVAsummary$addFootnote(.mmMessageSingularFit(), symbol = gettext("Warning:"))
    else if (!is.null(model$full_model[[length(model$full_model)]]@optinfo$conv$lme4$messages))
      ANOVAsummary$addFootnote(.mmMessageNumericalProblems(), symbol = gettext("Warning:"))

  } else {

    if (lme4::isSingular(model$full_model))
      ANOVAsummary$addFootnote(.mmMessageSingularFit(), symbol = gettext("Warning:"))
    else if (!is.null(model$full_model@optinfo$conv$lme4$messages))
      ANOVAsummary$addFootnote(.mmMessageNumericalProblems(), symbol = gettext("Warning:"))

  }
  if (jaspResults[["nMissing"]]$object != 0) {
    ANOVAsummary$addFootnote(.mmMessageMissingRows(jaspResults[["nMissing"]]$object))
  }

  removedMe <- jaspResults[["mmModel"]]$object$removedMe
  removedTe <- jaspResults[["mmModel"]]$object$removedTe
  addedRe   <- jaspResults[["mmModel"]]$object$addedRe

  for (i in seq_along(removedMe))
    ANOVAsummary$addFootnote(.mmMessageOmmitedTerms1(removedMe[[i]], names(removedMe)[i]), symbol = gettext("Note:"))

  for (i in seq_along(removedTe))
    ANOVAsummary$addFootnote(.mmMessageOmmitedTerms2(removedTe[[i]], names(removedTe)[i]), symbol = gettext("Note:"))

  for (i in seq_along(addedRe))
    ANOVAsummary$addFootnote(.mmMessageAddedTerms(addedRe[[i]], names(addedRe)[i]), symbol = gettext("Note:"))

  ANOVAsummary$addFootnote(.mmMessageANOVAtype(ifelse(options$type == 3, gettext("III"), gettext("II"))))
  if (type == "GLMM")
    ANOVAsummary$addFootnote(.mmMessageGLMMtype(options$family, options$link))
  if (type == "GLMM" && options$family == "bernoulli")
    ANOVAsummary$addFootnote(gettextf("'%1$s' level coded as success.", attr(dataset, "binomialSuccess")))

  ANOVAsummary$addFootnote(.mmMessageTermTest(options$testMethod))


  return()
}
.mmFitStats      <- function(jaspResults, options, type = "LMM") {

  if (!is.null(jaspResults[["modelSummary"]]))
    return()

  model <- jaspResults[["mmModel"]]$object$model
  if (is.list(model$full_model))
    full_model <- model$full_model[[length(model$full_model)]]
  else
    full_model <- model$full_model


  fitSummary <- createJaspContainer("Model summary")
  fitSummary$position <- 2

  dependencies <- .mmSwichDependencies(type)

  if (options$testMethod == "parametricBootstrap")
    dependencies <- c(dependencies, "seed", "setSeed")

  fitSummary$dependOn(c(dependencies, "modelSummary"))
  jaspResults[["fitSummary"]] <- fitSummary


  ### fit statistics
  modelSummary <- createJaspTable(title = gettext("Fit statistics"))
  modelSummary$position <- 1

  if (!lme4::isREML(full_model))
    modelSummary$addColumnInfo(name = "deviance", title = gettext("Deviance"), type = "number")
  if (lme4::isREML(full_model))
    modelSummary$addColumnInfo(name = "devianceREML", title = gettext("Deviance (REML)"), type = "number")

  modelSummary$addColumnInfo(name = "loglik", title = gettext("log Lik."), type = "number")
  modelSummary$addColumnInfo(name = "df",     title = gettext("df"),       type = "integer")
  modelSummary$addColumnInfo(name = "aic",    title = gettext("AIC"),      type = "number")
  modelSummary$addColumnInfo(name = "bic",    title = gettext("BIC"),      type = "number")
  jaspResults[["fitSummary"]][["modelSummary"]] <- modelSummary


  tempRow <- list(
    loglik   = logLik(full_model),
    df       = attr(logLik(full_model) , "df"),
    aic      = AIC(full_model),
    bic      = BIC(full_model)
  )

  if (!lme4::isREML(full_model))
    tempRow$deviance     <- deviance(full_model, REML = FALSE)
  else
    tempRow$devianceREML <- lme4::REMLcrit(full_model)


  modelSummary$addRows(tempRow)
  modelSummary$addFootnote(.mmMessageFitType(lme4::isREML(full_model)))


  ### sample sizes
  fitSizes <- createJaspTable(title = gettext("Sample sizes"))
  fitSizes$position <- 2

  fitSizes$addColumnInfo(name = "observations", title = gettext("Observations"), type = "integer")
  tempRow <- list(
    observations = nrow(full_model@frame)
  )
  for (thisName in names(full_model@flist)) {
    fitSizes$addColumnInfo(name = thisName, title = thisName, type = "integer", overtitle = gettext("Levels of RE grouping factors"))
    tempRow[[thisName]] <- length(levels(full_model@flist[[thisName]]))
  }
  fitSizes$addRows(tempRow)
  jaspResults[["fitSummary"]][["fitSizes"]] <- fitSizes

  return()
}
.mmSummaryRE     <- function(jaspResults, options, type = "LMM") {

  if (!is.null(jaspResults[["REsummary"]]))
    return()

  model <- jaspResults[["mmModel"]]$object$model

  REsummary <- createJaspContainer(title = gettext("Variance/Correlation Estimates"))

  REsummary$position <- 4

  dependencies <- .mmSwichDependencies(type)

  if (options$testMethod == "parametricBootstrap")
    seedDependencies <- c("seed", "setSeed")
  else
    seedDependencies <- NULL

  REsummary$dependOn(c(dependencies, seedDependencies, "varianceCorrelationEstimate"))

  # deal with SS type II stuff
  if (is.list(model$full_model))
    VarCorr <- lme4::VarCorr(model$full_model[[length(model$full_model)]])
  else
    VarCorr <- lme4::VarCorr(model$full_model)

  # go over each random effect grouping factor
  for (gi in 1:length(VarCorr)) {
    tempVarCorr <- VarCorr[[gi]]

    # add variance summary
    REvar <- createJaspTable(title = gettextf("%s: Variance Estimates",names(VarCorr)[gi]))

    REvar$addColumnInfo(name = "variable", title = gettext("Term"),           type = "string")
    REvar$addColumnInfo(name = "std",      title = gettext("Std. Deviation"), type = "number")
    REvar$addColumnInfo(name = "var",      title = gettext("Variance"),       type = "number")

    tempStdDev <- attr(tempVarCorr, "stddev")

    for (i in 1:length(tempStdDev)) {

      tempRow <- list(
        variable = .mmVariableNames(names(tempStdDev)[i], options$fixedVariables),
        std      = tempStdDev[i],
        var      = tempStdDev[i]^2
      )

      REvar$addRows(tempRow)
    }

    REvar$addFootnote(.mmMessageInterpretability(options[["factorContrast"]]))

    REsummary[[paste0("VE", gi)]] <- REvar


    # add correlation summary
    if (length(tempStdDev) > 1) {
      tempCorr <- attr(tempVarCorr, "correlation")
      REcor    <- createJaspTable(title = gettextf("%s: Correlation Estimates",names(VarCorr)[gi]))

      # add columns
      REcor$addColumnInfo(name = "variable", title = gettext("Term"), type = "string")
      for (i in 1:nrow(tempCorr)) {
        REcor$addColumnInfo(name = paste0("v", i), title = .mmVariableNames(names(tempStdDev)[i], options$fixedVariables), type = "number")
      }

      # fill rows
      for (i in 1:nrow(tempCorr)) {

        tempRow <- list(variable = .mmVariableNames(rownames(tempCorr)[i], options$fixedVariables))

        for (j in 1:i) {
          tempRow[paste0("v", j)] <- tempCorr[i, j]
        }

        REcor$addRows(tempRow)
      }

      REcor$addFootnote(.mmMessageInterpretability(options[["factorContrast"]]))

      REsummary[[paste0("CE", gi)]] <- REcor

    }
  }

  # add residual variance summary
  REres <-  createJaspTable(title = gettext("Residual Variance Estimates"))

  REres$addColumnInfo(name = "std", title = gettext("Std. Deviation"), type = "number")
  REres$addColumnInfo(name = "var", title = gettext("Variance"),       type = "number")

  if (is.list(model$full_model))
    tempRow <- list(
      std      = sigma(model$full_model[[length(model$full_model)]]),
      var      = sigma(model$full_model[[length(model$full_model)]])^2
    )
  else
    tempRow <- list(
      std      = sigma(model$full_model),
      var      = sigma(model$full_model)^2
    )

  REres$addRows(tempRow)
  REsummary[[paste0("RES", gi)]] <- REres

  jaspResults[["REsummary"]] <- REsummary

  return()
}
.mmSummaryREEstimates <- function(jaspResults, options, type = "LMM") {

  if (!is.null(jaspResults[["REEstimatesSummary"]]))
    return()

  model <- jaspResults[["mmModel"]]$object$model

  REEstimatesSummary <- createJaspContainer(title = gettext("Random Effect Estimates"))
  REEstimatesSummary$position <- 5

  dependencies <- .mmSwichDependencies(type)

  if ((type %in% c("LMM", "GLMM") && options$testMethod == "parametricBootstrap") || type %in% c("BLMM", "BGLMM"))
    seedDependencies <- c("seed", "setSeed")
  else
    seedDependencies <- NULL

  REEstimatesSummary$dependOn(c(dependencies, seedDependencies, "randomEffectEstimate"))
  jaspResults[["REEstimatesSummary"]] <- REEstimatesSummary

  # deal with SS type II stuff
  if (type %in% c("LMM", "GLMM")) {
    if (is.list(model$full_model))
      estimates <- lme4::ranef(model$full_model[[length(model$full_model)]])
    else
      estimates <- lme4::ranef(model$full_model)
  } else if (type %in% c("BLMM", "BGLMM")) {
    estimates <- rstanarm::ranef(model)
  }

  # go over each random effect grouping factor
  for (gi in seq_along(estimates)) {
    tempEstimates <- estimates[[gi]]

    # add variance summary
    tempTable <- createJaspTable(title = gettextf("%s: Random Effect Estimates", names(estimates)[gi]))
    tempTable$position <- gi

    tempTable$addColumnInfo(name = "level", title = names(estimates)[gi], type = "string")
    for(j in 1:ncol(tempEstimates)){
      tempTable$addColumnInfo(name = paste0("col", j), title = colnames(tempEstimates)[j], type = "number")
    }

    tempEstimates <- cbind.data.frame("level" = rownames(tempEstimates), tempEstimates)
    colnames(tempEstimates) <- c("level", paste0("col", 1:(ncol(tempEstimates)-1)))
    tempTable$setData(tempEstimates)

    REEstimatesSummary[[paste0("REEstimates", gi)]] <- tempTable
  }

  return()
}
.mmSummaryFE     <- function(jaspResults, options, type = "LMM") {

  if (!is.null(jaspResults[["FEsummary"]]))
    return()

  model <- jaspResults[["mmModel"]]$object$model

  if (is.list(model$full_model))
    FEcoef <- summary(model$full_model[[length(model$full_model)]])$coeff
  else
    FEcoef <- summary(model$full_model)$coeff

  FEsummary <- createJaspTable(title = gettext("Fixed Effects Estimates"))

  FEsummary$position <- 3
  dependencies <- .mmSwichDependencies(type)

  if (options$testMethod == "parametricBootstrap")
    seedDependencies <- c("seed", "setSeed")
  else
    seedDependencies <- NULL

  FEsummary$dependOn(c(dependencies, seedDependencies, "fixedEffectEstimate", "vovkSellke"))

  FEsummary$addColumnInfo(name = "term",       title = gettext("Term"),       type = "string")
  FEsummary$addColumnInfo(name = "estimate",   title = gettext("Estimate"),   type = "number")
  FEsummary$addColumnInfo(name = "se",         title = gettext("SE"),         type = "number")
  if (type == "LMM")
    FEsummary$addColumnInfo(name = "df",       title = gettext("df"),         type = "number")

  FEsummary$addColumnInfo(name = "stat",       title = gettext("t"),          type = "number")
  if (ncol(FEcoef) >= 4)
    FEsummary$addColumnInfo(name = "pval",     title = gettext("p"),          type = "pvalue")

  if (options$vovkSellke) {
    FEsummary$addColumnInfo(name = "vovkSellke",     title = gettext("VS-MPR"),     type = "number")
    FEsummary$addFootnote(.mmMessageVovkSellke(), symbol = "\u002A", colNames = "vovkSellke")
  }

  jaspResults[["FEsummary"]] <- FEsummary

  for (i in 1:nrow(FEcoef)) {

    if (type == "LMM") {

      tempRow <- list(
        term     = .mmVariableNames(rownames(FEcoef)[i], options$fixedVariables),
        estimate = FEcoef[i, 1],
        se       = FEcoef[i, 2],
        df       = FEcoef[i, 3],
        stat     = FEcoef[i, 4],
        pval     = FEcoef[i, 5]
      )

    } else if (type == "GLMM") {

      tempRow <- list(
        term     = .mmVariableNames(rownames(FEcoef)[i], options$fixedVariables),
        estimate = FEcoef[i, 1],
        se       = FEcoef[i, 2],
        stat     = FEcoef[i, 3]
      )

      if (ncol(FEcoef) >= 4)
        tempRow$pval <- FEcoef[i, 4]

    }

    if (options$vovkSellke)
      tempRow$vovkSellke <- VovkSellkeMPR(tempRow$pval)

    FEsummary$addRows(tempRow)
  }

  # add warning messages
  FEsummary$addFootnote(.mmMessageInterpretability(options[["factorContrast"]]))

  return()
}
.mmFixPlotAxis   <- function(p) {

  yTicks <- jaspGraphs::getPrettyAxisBreaks(ggplot2::layer_scales(p)$y$range$range)
  yRange <- range(yTicks)
  xTicks <- ggplot2::layer_scales(p)$x$range$range

  p <- p + ggplot2::scale_y_continuous(breaks = yTicks, limits = yRange) +
    ggplot2::scale_x_discrete(breaks = xTicks)

  return(p)
}
.mmPlot          <- function(jaspResults, dataset, options, type = "LMM") {

  if (!is.null(jaspResults[["plots"]]))
    return()

  model <- jaspResults[["mmModel"]]$object$model

  # automatic size specification will somewhat work unless there is more than 2 variables in panel
  height <- 350
  width  <- 150 * prod(sapply(unlist(options$plotHorizontalAxis), function(x) length(unique(dataset[, x])) / 2))

  if (length(options$plotSeparatePlots) > 0)
    width  <- width * length(unique(dataset[, unlist(options$plotSeparatePlots)[1]]))
  else if (length(options$plotSeparatePlots) > 1)
    height <- height * length(unique(dataset[, unlist(options$plotSeparatePlots)[2]]))

  if (options$plotLegendPosition %in% c("bottom", "top"))
    height <- height + 50
  else if (options$plotLegendPosition %in% c("left", "right"))
    width  <- width + 100

  width <- width + 150

  plots  <- createJaspPlot(title = gettext("Plot"), width = width, height = height)

  plots$position <- 6
  dependencies <- .mmSwichDependencies(type)

  plots$dependOn(
    c(
      dependencies,
      "plotHorizontalAxis",
      "plotSeparateLines",
      "plotSeparatePlots",
      "plotBackgroundData",
      "plotBackgroundElement",
      "plotSeparateLines",
      "plotSeparatePlots",
      "plotTheme",
      "plotCiLevel",
      "plotCiType",
      "plotTransparency",
      "plotJitterWidth",
      "plotJitterHeight",
      "plotElementWidth",
      "plotDodge",
      "plotBackgroundColor",
      "plotRelativeSizeData",
      "plotRelativeSizeText",
      "plotLegendPosition",
      "plotLevelsByColor",
      "plotLevelsByShape",
      "plotLevelsByLinetype",
      "plotLevelsByFill",
      "seed",
      "setSeed"
    )
  )

  jaspResults[["plots"]] <- plots
  plots$status <- "running"

  # stop with message if there is no random effects grouping factor selected
  if (length(options$plotBackgroundData) == 0) {
    plots$setError(gettext("At least one random effects grouping factor needs to be selected in field 'Background data show'."))
    return()
  }
  if (all(!c(options$plotLevelsByColor, options$plotLevelsByShape, options$plotLevelsByLinetype, options$plotLevelsByFill))) {
    plots$setError(gettext("Factor levels need to be distinguished by at least one feature. Please, check one of the 'Distinguish factor levels' options."))
    return()
  }

  # select mapping
  mapping <- c("color", "shape", "linetype", "fill")[c(options$plotLevelsByColor, options$plotLevelsByShape, options$plotLevelsByLinetype, options$plotLevelsByFill)]

  if (length(mapping) == 0)
    mapping <- ""

  # specify data_arg
  if (options$plotBackgroundElement == "jitter")
    data_arg <- list(
      position =
        ggplot2::position_jitterdodge(
          jitter.width  = options$plotJitterWidth,
          jitter.height = options$plotJitterHeight,
          dodge.width   = options$plotDodge
        )
    )
  else if (options$plotBackgroundElement == "violin")
    data_arg <- list(width = options$plotElementWidth)
  else if (options$plotBackgroundElement == "boxplot")
    data_arg <- list(width = options$plotElementWidth)
  else if (options$plotBackgroundElement == "count")
    data_arg <- list()
  else if (options$plotBackgroundElement == "beeswarm") # disabled due to package loading
    data_arg <- list(dodge.width = options$plotDodge)
  else if (options$plotBackgroundElement == "boxjitter") # temporarily disabled due to incompatibility with new ggplot
    data_arg <- list(
      width             = options$plotElementWidth,
      jitter.width      = options$plotJitterWidth,
      jitter.height     = options$plotJitterHeight,
      outlier.intersect = TRUE
    )

  if (options$plotBackgroundColor != "none" && options$plotBackgroundElement != "jitter" && "color" %in% mapping)
    data_arg$color <- options$plotBackgroundColor

  # deal with type II SS
  if (type %in% c("LMN", "GLMM")) {
    if (is.list(model$full_model))
      model <- model$full_model[[length(model$full_model)]]
    else
      model <- model$full_model
  }

  .setSeedJASP(options)
  p <- try(
    afex::afex_plot(
      model,
      dv          = options$dependent,
      x           = unlist(options$plotHorizontalAxis),
      trace       = if (length(options$plotSeparateLines) != 0) unlist(options$plotSeparateLines),
      panel       = if (length(options$plotSeparatePlots) != 0) unlist(options$plotSeparatePlots),
      id          = options$plotBackgroundData,
      data_geom   = .mmGetPlotElementFun(options[["plotBackgroundElement"]]),
      mapping     = mapping,
      error       = options$plotCiType,
      error_level = options$plotCiLevel,
      data_alpha  = options$plotTransparency,
      data_arg    = if (length(data_arg) != 0) data_arg,
      error_arg   = list(
        width = 0,
        size  = .5 * options$plotRelativeSizeData
      ),
      point_arg   = list(size = 1.5 * options$plotRelativeSizeData),
      line_arg    = list(size = .5 * options$plotRelativeSizeData),
      legend_title = paste(unlist(options$plotSeparateLines), collapse = "\n"),
      dodge       = options$plotDodge
    ))

  if (jaspBase::isTryError(p)) {
    plots$setError(p)
    return()
  }

  if (options$plotBackgroundElement == "violin" && (length(options$plotBackgroundData) == 1 && length(unique(dataset[, options$plotBackgroundData])) < 3)) {
    plots$setError(gettext("Violin geom requires that the random effects grouping factors has at least 3 levels."))
    return()
  }

  # fix the axis
  p <- .mmFixPlotAxis(p)

  # fix names of the variables
  p <- p + ggplot2::labs(x = unlist(options$plotHorizontalAxis), y = options$dependent)

  # add theme
  if (options$plotTheme == "jasp") {

    p <- jaspGraphs::themeJasp(p, legend.position = options$plotLegendPosition)

  } else  if (options$plotTheme != "jasp") {

    p <- p + switch(
      options$plotTheme,
      "whiteBackground"      = ggplot2::theme_bw()       + ggplot2::theme(legend.position = "bottom"),
      "light"   = ggplot2::theme_light()    + ggplot2::theme(legend.position = "bottom"),
      "minimal" = ggplot2::theme_minimal()  + ggplot2::theme(legend.position = "bottom"),
      "pubr"    = jaspGraphs::themePubrRaw(legend = options$plotLegendPosition),
      "apa"     = jaspGraphs::themeApaRaw(legend.pos = switch(
        options$plotLegendPosition,
        "none"   = "none",
        "bottom" = "bottommiddle",
        "right"  = "bottomright",
        "top"    = "topmiddle",
        "left"   = "bottomleft"
      ))
    )

    p <- p + ggplot2::theme(
      legend.text  = ggplot2::element_text(size = ggplot2::rel(options$plotRelativeSizeText)),
      legend.title = ggplot2::element_text(size = ggplot2::rel(options$plotRelativeSizeText)),
      axis.text    = ggplot2::element_text(size = ggplot2::rel(options$plotRelativeSizeText)),
      axis.title   = ggplot2::element_text(size = ggplot2::rel(options$plotRelativeSizeText)),
      legend.position = options$plotLegendPosition
    )

  }


  plots$plotObject <- p

  if (options$plotEstimatesTable) {
    plotData <- afex::afex_plot(
      model,
      x           = unlist(options$plotHorizontalAxis),
      dv          = options$dependent,
      trace       = if (length(options$plotSeparateLines) != 0)
        unlist(options$plotSeparateLines),
      panel       = if (length(options$plotSeparatePlots) != 0)
        unlist(options$plotSeparatePlots),
      id          = options$plotBackgroundData,
      data_geom   = .mmGetPlotElementFun(options[["plotBackgroundElement"]]),
      error       = options$plotCiType,
      error_level = options$plotCiLevel,
      return      = "data"
    )$means

    EstimatesTable <- createJaspTable(title = if(options$plotCiType == "none") gettext("Estimated Means") else gettext("Estimated Means and Confidence Intervals"))
    EstimatesTable$position <- 5
    EstimatesTable$dependOn(
      c(
        dependencies,
        "plotHorizontalAxis",
        "plotSeparateLines",
        "plotSeparatePlots",
        "plotBackgroundData",
        "plotCiLevel",
        "plotCiType",
        "seed",
        "setSeed",
        "plotEstimatesTable"
      )
    )

    for (variable in attr(plotData, "pri.vars")) {
      EstimatesTable$addColumnInfo(name = variable, title = variable, type = "string")
    }

    EstimatesTable$addColumnInfo(name = "mean", title = gettext("Mean"), type = "number")

    if (options$plotCiType != "none") {
      EstimatesTable$addColumnInfo(name = "lowerCI", title = gettext("Lower"), type = "number", overtitle = gettextf("%s%% CI", 100 * options$plotCiLevel)      )
      EstimatesTable$addColumnInfo(name = "upperCI", title = gettext("Upper"), type = "number", overtitle = gettextf("%s%% CI", 100 * options$plotCiLevel)      )
    }

    jaspResults[["EstimatesTable"]] <- EstimatesTable

    for (i in 1:nrow(plotData)) {

      tempRow <- list()
      for (variable in attr(plotData, "pri.vars")) {
        tempRow[variable] <- as.character(plotData[i, variable])
      }

      tempRow$mean     <- plotData[i, "y"]
      if (options$plotCiType != "none") {
        tempRow$lowerCI  <- plotData[i, "lower"]
        tempRow$upperCI  <- plotData[i, "upper"]
      }

      EstimatesTable$addRows(tempRow)
    }

  }

  return()
}

.mmGetPlotElementFun <- function(element = c("jitter", "violin", "boxplot", "count", "beeswarm", "boxjitter"), prefix = "geom_") {
  element <- match.arg(element)
  fromPkg <- switch(element,
                    beeswarm  = "ggbeeswarm",
                    boxjitter = "ggpol",
                    "ggplot2")
  element <- paste0(prefix, element)
  fun <- try(utils::getFromNamespace(element, fromPkg))
  if(isTryError(fun)) .quitAnalysis(gettextf("Cannot find function: %s", element))
  return(fun)
}
.mmMarginalMeans <- function(jaspResults, dataset, options, type = "LMM") {

  if (!is.null(jaspResults[["EMMresults"]]))
    return()

  model <- jaspResults[["mmModel"]]$object$model

  # deal with continuous predictors
  at <- NULL
  for (var in unlist(options$marginalMeansTerms)) {
    if (typeof(dataset[, var]) == "double") {
      at[[var]] <-c(mean(dataset[, var], na.rm = TRUE) + c(-1, 0, 1) * options$marginalMeansSd * sd(dataset[, var], na.rm = TRUE))
    }
  }

  # compute the results
  if (type == "LMM")
    emmeans::emm_options(
      pbkrtest.limit = if (options$marginalMeansDfEstimated) Inf,
      mmrTest.limit  = if (options$marginalMeansDfEstimated) Inf)

  emm <- emmeans::emmeans(
    object  = model,
    specs   = unlist(options$marginalMeansTerms),
    at      = at,
    options = list(level  = options$marginalMeansCiLevel),
    lmer.df = if (type == "LMM")
      options$marginalMeansDf
    else if (type == "GLMM" && options$family == "gaussian" && options$link == "identity")
      "asymptotic",
    type    = if (type %in% c("GLMM", "BGLMM") && options$marginalMeansResponse) "response"
  )

  emmTable  <- as.data.frame(emm)
  if (type %in% c("LMM", "GLMM") && options$marginalMeansComparison)
    emmTest <- as.data.frame(emmeans::test(emm, null = options$marginalMeansComparisonWith))

  EMMsummary <- createJaspTable(title = gettext("Estimated Marginal Means"))
  EMMresults <- createJaspState()

  EMMsummary$position <- 8

  dependencies <- .mmSwichDependencies(type)
  if (type %in% c("GLMM", "BGLMM"))
    dependencies <- c(.mmDependenciesGLMM, "marginalMeansResponse")

  if (type %in% c("LMM", "GLMM"))
    dependenciesAdd <- c(
      "marginalMeansTerms",
      "marginalMeansSd",
      "marginalMeansComparison",
      "marginalMeansComparisonWith",
      "marginalMeansCiLevel",
      "vovkSellke",
      "marginalMeansContrast"
    )
  else
    dependenciesAdd <- c(
      "marginalMeansTerms",
      "marginalMeansSd",
      "marginalMeansCiLevel",
      "marginalMeansContrast"
    )

  if (type == "LMM")
    dependenciesAdd <- c(
      dependenciesAdd,
      "marginalMeansDfEstimated",
      "marginalMeansDf")

  EMMsummary$dependOn(c(dependencies, dependenciesAdd))
  EMMresults$dependOn(c(dependencies, dependenciesAdd))

  if (options$marginalMeansContrast)
    EMMsummary$addColumnInfo(name = "number", title = gettext("Row"), type = "integer")

  for (variable in unlist(options$marginalMeansTerms)) {

    if (typeof(dataset[, variable]) == "double")
      EMMsummary$addColumnInfo(name = variable, title = variable, type = "number")
    else
      EMMsummary$addColumnInfo(name = variable, title = variable, type = "string")

  }

  if (type %in% c("LMM", "GLMM")) {

    EMMsummary$addColumnInfo(name = "estimate", title = gettext("Estimate"), type = "number")
    EMMsummary$addColumnInfo(name = "se",       title = gettext("SE"),       type = "number")
    if (type == "LMM" && options$marginalMeansDf != "asymptotic")
      EMMsummary$addColumnInfo(name = "df",     title = gettext("df"),       type = "number")

    EMMsummary$addColumnInfo(name = "lowerCI",  title = gettext("Lower"),    type = "number", overtitle = gettextf("%s%% CI", 100 * options$marginalMeansCiLevel))
    EMMsummary$addColumnInfo(name = "upperCI",  title = gettext("Upper"),    type = "number", overtitle = gettextf("%s%% CI", 100 * options$marginalMeansCiLevel))

    if (options$marginalMeansComparison) {
      EMMsummary$addColumnInfo(name = "stat",   title = ifelse(colnames(emmTest)[ncol(emmTest) - 1] == "t.ratio", gettext("t"), gettext("z")), type = "number")
      EMMsummary$addColumnInfo(name = "pval",   title = gettext("p"),         type = "pvalue")
      EMMsummary$addFootnote(.mmMessageTestNull(options$marginalMeansComparisonWith), symbol = "\u2020", colNames = "pval")

      if (options$vovkSellke) {
        EMMsummary$addColumnInfo(name = "vovkSellke", title = gettext("VS-MPR"), type = "number")
        EMMsummary$addFootnote(.mmMessageVovkSellke(), symbol = "\u002A", colNames = "vovkSellke")
      }
    }

  } else if (type %in% c("BLMM", "BGLMM")) {

    EMMsummary$addColumnInfo(name = "estimate", title = gettext("Median"), type = "number")
    EMMsummary$addColumnInfo(name = "lowerCI",  title = gettext("Lower"),  type = "number", overtitle = gettextf("%s%% HPD", 100 * options$marginalMeansCiLevel))
    EMMsummary$addColumnInfo(name = "upperCI",  title = gettext("Upper"),  type = "number", overtitle = gettextf("%s%% HPD", 100 * options$marginalMeansCiLevel))

  }

  jaspResults[["EMMsummary"]] <- EMMsummary

  for (i in 1:nrow(emmTable)) {
    tempRow <- list()

    if (options$marginalMeansContrast)
      tempRow$number <- i


    for (variable in unlist(options$marginalMeansTerms)) {

      if (typeof(dataset[, variable]) == "double")
        tempRow[variable] <- emmTable[i, variable]
      else
        tempRow[variable] <- as.character(emmTable[i, variable])

    }

    if (type %in% c("LMM", "GLMM")) {
      # the estimate is before SE (names change for GLMM)
      tempRow$estimate <- emmTable[i, grep("SE", colnames(emmTable)) - 1]
      tempRow$se       <- emmTable[i, "SE"]
      if (type == "LMM" && options$marginalMeansDf != "asymptotic")
        tempRow$df       <- emmTable[i, "df"]

      if (options$marginalMeansComparison) {
        tempRow$stat <- emmTest[i, grep("ratio", colnames(emmTest))]
        tempRow$pval <- emmTest[i, "p.value"]
        if (options$vovkSellke)
          tempRow$vovkSellke <- VovkSellkeMPR(tempRow$pval)

      }
    } else if (type %in% c("BLMM", "BGLMM")) {
      tempRow$estimate <- emmTable[i, ncol(emmTable) - 2]
    }

    tempRow$lowerCI  <- emmTable[i, ncol(emmTable) - 1]
    tempRow$upperCI  <- emmTable[i, ncol(emmTable)]


    EMMsummary$addRows(tempRow)
  }


  if (length(emm@misc$avgd.over) != 0)
    EMMsummary$addFootnote(.mmMessageAveragedOver(emm@misc$avgd.over))

  # add warning message
  if (type == "LMM" && options$marginalMeansDf != attr(emm@dffun, "mesg"))
    EMMsummary$addFootnote(.mmMessageDFdisabled(), symbol = gettext("Warning:"))

  if (type %in% c("GLMM","BGLMM"))
    EMMsummary$addFootnote(ifelse(options$marginalMeansResponse, .mmMessageResponse(), .mmMessageNotResponse()))


  object <- list(
    emm        = emm,
    emmTable   = emmTable
  )

  EMMresults$object <- object
  jaspResults[["EMMresults"]] <- EMMresults

  return()
}
.mmTrends        <- function(jaspResults, dataset, options, type = "LMM") {

  if (!is.null(jaspResults[["contrastsTrends"]]))
    return()

  model <- jaspResults[["mmModel"]]$object$model

  if (type %in% c("LMN", "GLMM")) {
    # deal with type II SS
    if (is.list(model$full_model))
      model <- model$full_model[[length(model$full_model)]]
    else
      model <- model$full_model
  }


  # deal with continuous predictors
  at <- NULL
  for (var in unlist(options$trendsVariables)) {

    if (typeof(dataset[, var]) == "double")
      at[[var]] <-mean(dataset[, var], na.rm = TRUE) + c(-1, 0, 1) * options$trendsSd * sd(dataset[, var], na.rm = TRUE)

  }

  # compute the results
  if (type == "LMM")
    emmeans::emm_options(
      pbkrtest.limit = if (options$trendsDfEstimated) Inf,
      mmrTest.limit  = if (options$trendsDfEstimated) Inf)


  # TODO: deal with the emtrends scoping problems
  trendsCI      <<- options$trendsCiLevel
  trendsAt      <<- at

  if (type == "LMM" || (type == "GLMM" && options$family == "gaussian" && options$link == "identity"))
    trendsType <- "LMM"
  else
    trendsType <- type

  trendsDataset <<- dataset
  trendsModel   <<- model

  if (type == "LMM")
    trendsDf <<- switch(
      options$trendsDf,
      kenwardRoger = "kenward-roger",
      options$trendsDf
    )
  else if (type == "GLMM" && options$family == "gaussian" && options$link == "identity")
    trendsDf <<- "asymptotic"

  emm <- emmeans::emtrends(
    object  = trendsModel,
    data    = trendsDataset,
    specs   = unlist(options$trendsVariables),
    var     = unlist(options$trendsTrendVariable),
    at      = trendsAt,
    options = list(level = trendsCI),
    lmer.df = if (trendsType == "LMM") trendsDf
  )
  emmTable  <- as.data.frame(emm)
  if (type %in% c("LMM", "GLMM") && options$trendsComparison)
    emmTest <- as.data.frame(emmeans::test(emm, null = options$trendsComparisonWith))


  trendsSummary <- createJaspTable(title = gettext("Estimated Trends"))
  EMTresults    <- createJaspState()

  trendsSummary$position <- 10
  dependencies <- .mmSwichDependencies(type)

  if (type %in% c("LMM", "GLMM"))
    dependenciesAdd <- c(
      "trendsVariables",
      "trendsTrendVariable",
      "trendsSd",
      "trendsComparison",
      "trendsComparisonWith",
      "trendsCiLevel",
      "vovkSellke",
      "trendsContrast"
    )
  else
    dependenciesAdd <- c(
      "trendsVariables",
      "trendsTrendVariable",
      "trendsSd",
      "trendsCiLevel",
      "trendsContrast"
    )

  if (type == "LMM")
    dependenciesAdd <-c(dependenciesAdd, "trendsDf", "trendsDfEstimated")

  trendsSummary$dependOn(c(dependencies, dependenciesAdd))
  EMTresults$dependOn(c(dependencies, dependenciesAdd))

  if (options$trendsContrast)
    trendsSummary$addColumnInfo(name = "number", title = gettext("Row"), type = "integer")

  trendsVarNames <- colnames(emmTable)[1:(grep(".trend", colnames(emmTable), fixed = TRUE) - 1)]

  for (variable in trendsVarNames) {

    if (typeof(dataset[, variable]) == "double")
      trendsSummary$addColumnInfo(name = variable, title = variable, type = "number")
    else
      trendsSummary$addColumnInfo(name = variable, title = variable, type = "string")

  }
  trendsSummary$addColumnInfo(name = "slope",  title = gettextf("%s (slope)",unlist(options$trendsTrendVariable)), type = "number")
  if (type %in% c("LMM", "GLMM")) {

    trendsSummary$addColumnInfo(name = "se",   title = gettext("SE"), type = "number")
    if (type == "LMM" && options$trendsDf != "asymptotic")
      trendsSummary$addColumnInfo(name = "df", title = gettext("df"), type = "number")

    trendsSummary$addColumnInfo(name = "lowerCI", title = gettext("Lower"), type = "number", overtitle = gettextf("%s%% CI", 100 * options$trendsCiLevel))
    trendsSummary$addColumnInfo(name = "upperCI", title = gettext("Upper"), type = "number", overtitle = gettextf("%s%% CI", 100 * options$trendsCiLevel))

    if (options$trendsComparison) {
      trendsSummary$addColumnInfo(name = "stat",  title = ifelse(colnames(emmTest)[ncol(emmTest) - 1] == "t.ratio", gettext("t"), gettext("z")), type = "number")
      trendsSummary$addColumnInfo(name = "pval",  title = gettext("p"), type = "pvalue")
      trendsSummary$addFootnote(.mmMessageTestNull(options$trendsComparisonWith), symbol = "\u2020", colNames = "pval")

      if (options$vovkSellke) {
        trendsSummary$addColumnInfo(name = "vovkSellke", title = gettext("VS-MPR"), type = "number")
        trendsSummary$addFootnote(.mmMessageVovkSellke(), symbol = "\u002A", colNames = "vovkSellke")
      }
    }
  } else if (type %in% c("BLMM", "BGLMM")) {
    trendsSummary$addColumnInfo(name = "lowerCI", title = gettext("Lower"), type = "number", overtitle = gettextf("%s%% HPD", 100 * options$trendsCiLevel))
    trendsSummary$addColumnInfo(name = "upperCI", title = gettext("Upper"), type = "number", overtitle = gettextf("%s%% HPD", 100 * options$trendsCiLevel))
  }

  jaspResults[["trendsSummary"]] <- trendsSummary


  for (i in 1:nrow(emmTable)) {
    tempRow <- list()

    if (options$trendsContrast) {
      tempRow$number <- i
    }

    for (vi in 1:length(trendsVarNames)) {

      if (typeof(dataset[, trendsVarNames[vi]]) == "double")
        tempRow[trendsVarNames[vi]] <- emmTable[i, vi]
      else
        tempRow[trendsVarNames[vi]] <- as.character(emmTable[i, vi])

    }
    tempRow$slope <- emmTable[i, length(trendsVarNames) + 1]

    if (type %in% c("LMM", "GLMM")) {
      # the estimate is before SE (names change for GLMM)
      tempRow$se       <- emmTable[i, "SE"]
      if (type == "LMM" && options$trendsDf != "asymptotic")
        tempRow$df <- emmTable[i, "df"]

      if (options$trendsComparison) {
        tempRow$stat <- emmTest[i, grep("ratio", colnames(emmTest))]
        tempRow$pval <- emmTest[i, "p.value"]
        if (options$vovkSellke)
          tempRow$vovkSellke <- VovkSellkeMPR(tempRow$pval)

      }
    }

    tempRow$lowerCI  <- emmTable[i, ncol(emmTable) - 1]
    tempRow$upperCI  <- emmTable[i, ncol(emmTable)]

    trendsSummary$addRows(tempRow)
  }


  if (length(emm@misc$avgd.over) != 0)
    trendsSummary$addFootnote(.mmMessageAveragedOver(emm@misc$avgd.over))

  # add warning message
  if (type == "LMM" && options$trendsDf != attr(emm@dffun, "mesg"))
    trendsSummary$addFootnote(.mmMessageDFdisabled(), symbol = gettext("Warning:"))

  if (type == "GLMM")
    trendsSummary$addFootnote(.mmMessageNotResponse())


  object <- list(
    emm         = emm,
    emmTable   = emmTable
  )
  EMTresults$object <- object

  jaspResults[["EMTresults"]]    <- EMTresults

  return()
}
.mmContrasts     <- function(jaspResults, options, type = "LMM", what = "Means") {

  if (what == "Means") {

    if (!is.null(jaspResults[["contrastsMeans"]]))
      return()

    emm       <- jaspResults[["EMMresults"]]$object$emm
    emmTable  <- jaspResults[["EMMresults"]]$object$emmTable

  } else if (what == "Trends") {

    if (!is.null(jaspResults[["contrastsTrends"]]))
      return()

    emm      <- jaspResults[["EMTresults"]]$object$emm
    emmTable <- jaspResults[["EMTresults"]]$object$emmTable

  }


  EMMCsummary <- createJaspTable(title = gettext("contrasts"))

  EMMCsummary$position <- ifelse(what == "Means", 9, 11)

  dependencies <- .mmSwichDependencies(type)
  if (type %in% c("GLMM", "BGLMM") && what == "Means")
    dependencies <- c(dependencies, "marginalMeansResponse")

  if (what == "Means") {
    if (type %in% c("LMM", "GLMM"))
      dependenciesAdd <- c(
        "marginalMeansTerms",
        "marginalMeansDf",
        "marginalMeansSd",
        "marginalMeansComparison",
        "marginalMeansComparisonWith",
        "marginalMeansContrast",
        "marginalMeansCiLevel",
        "vovkSellke",
        "marginalMeansDfEstimated",
        "contrasts",
        "marginalMeansPAdjustment"
      )
    else
      dependenciesAdd <- c(
        "marginalMeansTerms",
        "marginalMeansSd",
        "marginalMeansContrast",
        "marginalMeansCiLevel",
        "contrasts"
      )

  } else if (what == "Trends") {
    if (type %in% c("LMM", "GLMM"))
      dependenciesAdd <- c(
        "trendsVariables",
        "trendsTrendVariable",
        "trendsDf",
        "trendsSd",
        "trendsComparison",
        "trendsComparisonWith",
        "trendsContrast",
        "trendsContrasts",
        "trendsCiLevel",
        "vovkSellke",
        "trendsDfEstimated",
        "trendsPAdjustment"
      )
    else
      dependenciesAdd <-c(
        "trendsVariables",
        "trendsTrendVariable",
        "trendsSd",
        "trendsCiLevel",
        "trendsContrast",
        "trendsContrasts"
      )

  }

  EMMCsummary$dependOn(c(dependencies, dependenciesAdd))


  if (type %in% c("LMM", "GLMM")) {

    EMMCsummary$addColumnInfo(name = "contrast", title = "",                  type = "string")
    EMMCsummary$addColumnInfo(name = "estimate", title = gettext("Estimate"), type = "number")
    EMMCsummary$addColumnInfo(name = "se",       title = gettext("SE"),       type = "number")
    EMMCsummary$addColumnInfo(name = "df",       title = gettext("df"),       type = "number")

    if (what == "Means") {
      overtitle   <- gettextf("%s%% CI", 100 * options$marginalMeansCiLevel)
      tempCiQuant <- c((1-options$marginalMeansCiLevel)/2, 1-((1-options$marginalMeansCiLevel)/2) )
    } else {
      overtitle   <- gettextf("%s%% CI", 100 * options$trendsCiLevel)
      tempCiQuant <- c((1-options$trendsCiLevel)/2, 1-((1-options$trendsCiLevel)/2) )
    }


    EMMCsummary$addColumnInfo(name = "lowerCI",  title = gettext("Lower"),    type = "number", overtitle = overtitle)
    EMMCsummary$addColumnInfo(name = "upperCI",  title = gettext("Upper"),    type = "number", overtitle = overtitle)


    EMMCsummary$addColumnInfo(name = "stat",     title = gettext("z"),        type = "number")
    EMMCsummary$addColumnInfo(name = "pval",     title = gettext("p"),        type = "pvalue")

    if (options$vovkSellke) {
      EMMCsummary$addColumnInfo(name = "vovkSellke", title = gettext("VS-MPR"),   type = "number")
      EMMCsummary$addFootnote(.mmMessageVovkSellke(), symbol = "\u002A", colNames = "vovkSellke")
    }

  } else if (type %in% c("BLMM", "BGLMM")) {

    if (what == "Means")
      overtitle <- gettextf("%s%% HPD", 100 * options$marginalMeansCiLevel)
    else
      overtitle <- gettextf("%s%% HPD", 100 * options$trendsCiLevel)

    EMMCsummary$addColumnInfo(name = "contrast",  title = "", type = "string")
    EMMCsummary$addColumnInfo(name = "estimate",  title = gettext("Estimate"), type = "number")
    EMMCsummary$addColumnInfo(name = "lowerCI",   title = gettext("Lower"),    type = "number", overtitle = overtitle)
    EMMCsummary$addColumnInfo(name = "upperCI",   title = gettext("Upper"),    type = "number", overtitle = overtitle)

  }

  # Columns have been specified, show to user
  jaspResults[[paste0("contrasts", what)]] <- EMMCsummary

  if (what == "Means") {
    selectedContrasts  <- options$contrasts
    selectedAdjustment <- options$marginalMeansPAdjustment

    if (type %in% c("GLMM", "BGLMM"))
      selectedResponse   <- options$marginalMeansResponse



  } else if (what == "Trends") {
    selectedContrasts  <- options$trendsContrasts
    selectedAdjustment <- options$trendsPAdjustment
  }

  contrs <- list()
  i      <- 0
  for (cont in selectedContrasts[sapply(selectedContrasts, function(x) x$isContrast)]) {

    if (all(cont$values == 0))
      next

    i <- i + 1
    contrs[[cont$name]] <- unname(sapply(cont$values, function(x) eval(parse(text = x))))

  }

  if (length(contrs) == 0)
    return()


  # take care of the scale
  if (type %in% c("LMM", "BLMM") || what == "Trends") {
    emmContrast <- try(
      as.data.frame(
        emmeans::contrast(
          emm,
          contrs,
          adjust = if (type %in% c("LMM", "GLMM")) selectedAdjustment)
      ))
  } else if (type %in% c("GLMM", "BGLMM")) {
    if (selectedResponse) {
      emmContrast <- try(
        as.data.frame(
          emmeans::contrast(
            emmeans::regrid(emm),
            contrs,
            adjust = if (type == "GLMM") selectedAdjustment
          )
        ))
    } else {
      emmContrast <- try(
        as.data.frame(
          emmeans::contrast(
            emm,
            contrs,
            adjust = if (type == "GLMM") selectedAdjustment)
        ))
    }
  }

  if (jaspBase::isTryError(emmContrast)) {
    EMMCsummary$setError(emmContrast)
    return()
  }

  # fix the title name if there is a t-stats
  if (type %in% c("LMM", "GLMM"))

    if (colnames(emmContrast)[5] == "t.ratio")
      EMMCsummary$setColumnTitle("stat", gettext("t"))

  if (type %in% c("GLMM", "BGLMM")) {

    if (type == "GLMM")
      tempEstName <- colnames(emmContrast)[ncol(emmContrast) - 4]
    else if (type == "BGLMM")
      tempEstName <- colnames(emmContrast)[ncol(emmContrast) - 2]

    if (tempEstName == "odds.ratio")
      EMMCsummary$setColumnTitle("estimate", gettext("Odds Ratio"))
    else if (tempEstName == "ratio")
      EMMCsummary$setColumnTitle("estimate", gettext("Ratio"))
    else if (tempEstName == "estimate")
      EMMCsummary$setColumnTitle("estimate", gettext("Estimate"))
    else
      EMMCsummary$setColumnTitle("estimate", tempEstName)

  }

  for (i in 1:nrow(emmContrast)) {

    if (type %in% c("LMM", "GLMM")) {

      tempRow <- list(
        contrast =  names(contrs)[i],
        estimate =  emmContrast[i, ncol(emmContrast) - 4],
        se       =  emmContrast[i, "SE"],
        df       =  emmContrast[i, "df"],
        lowerCI  =  emmContrast[i, ncol(emmContrast) - 4] + stats::qt(tempCiQuant[1], df = emmContrast[i, "df"]) * emmContrast[i, "SE"],
        upperCI  =  emmContrast[i, ncol(emmContrast) - 4] + stats::qt(tempCiQuant[2], df = emmContrast[i, "df"]) * emmContrast[i, "SE"],
        stat     =  emmContrast[i, ncol(emmContrast) - 1],
        pval     =  emmContrast[i, "p.value"]
      )

      if (options$vovkSellke)
        tempRow$vovkSellke <- VovkSellkeMPR(tempRow$pval)

      EMMCsummary$addFootnote(.messagePvalAdjustment(selectedAdjustment), symbol = "\u2020", colNames = "pval")

    } else if (type %in% c("BLMM", "BGLMM")) {

      tempRow <- list(
        contrast = names(contrs)[i],
        estimate = emmContrast[i, ncol(emmContrast) - 2],
        lowerCI  = emmContrast[i, "lower.HPD"],
        upperCI  = emmContrast[i, "upper.HPD"]
      )

    }


    if (type %in% c("GLMM", "BGLMM") && what == "Means") {

      if (!selectedResponse)
        EMMCsummary$addFootnote(.mmMessageNotResponse())
      else
        EMMCsummary$addFootnote(.mmMessageResponse())

    }

    EMMCsummary$addRows(tempRow)
  }

  return()
}


# specific Bayesian
.mmFitModelB      <- function(jaspResults, dataset, options, type = "BLMM") {

  # hopefully fixing the random errors
  contr.bayes <<- stanova::contr.bayes
  stan_glmer  <- rstanarm::stan_glmer

  if (!is.null(jaspResults[["mmModel"]]))
    return()

  mmModel <- createJaspState()
  mmModel$dependOn(.mmSwichDependencies(type))

  modelFormula <- .mmModelFormula(options, dataset)

  if (type == "BLMM") {

    model <- try(stanova::stanova(
      formula           = as.formula(modelFormula$modelFormula),
      check_contrasts   = "contr.bayes",
      data              = dataset,
      chains            = options$mcmcChains,
      iter              = options$mcmcSamples,
      warmup            = options$mcmcBurnin,
      adapt_delta       = options$mcmcAdaptDelta,
      control           = list(max_treedepth = options$mcmcMaxTreedepth),
      seed              = .getSeedJASP(options),
      model_fun         = "lmer"
    ))

  } else if (type == "BGLMM") {

    # needs to be evaluated in the global environment
    glmmLink <<- options$link
    if (options$family == "negativeBinomial") {
      glmmFamily <<- rstanarm::neg_binomial_2(link = glmmLink)
    } else if (options$family == "beta") {
      glmmFamily <<- do.call(mgcv::betar, list(link = glmmLink))
    } else {
      glmmFamily <<- .mmGetRFamily(options[["family"]])
      glmmFamily <<- eval(call(glmmFamily, glmmLink))
    }

    # I wish there was a better way to do this
    if (options$family == "binomial") {
      glmmWeight <<- dataset[, options$dependentAggregation]

      model <- try(stanova::stanova(
        formula           = as.formula(modelFormula$modelFormula),
        check_contrasts   = "contr.bayes",
        data              = dataset,
        chains            = options$mcmcChains,
        iter              = options$mcmcSamples,
        warmup            = options$mcmcBurnin,
        adapt_delta       = options$mcmcAdaptDelta,
        control           = list(max_treedepth = options$mcmcMaxTreedepth),
        weights           = glmmWeight,
        family            = glmmFamily,
        seed              = .getSeedJASP(options),
        model_fun         = "glmer"
      ))

    } else {

      model <- try(stanova::stanova(
        formula           = as.formula(modelFormula$modelFormula),
        check_contrasts   = "contr.bayes",
        data              = dataset,
        chains            = options$mcmcChains,
        iter              = options$mcmcSamples,
        warmup            = options$mcmcBurnin,
        adapt_delta       = options$mcmcAdaptDelta,
        control           = list(max_treedepth = options$mcmcMaxTreedepth),
        family            = glmmFamily,
        seed              = .getSeedJASP(options),
        model_fun         = "glmer"
      ))

    }

  }

  if (jaspBase::isTryError(model)) {
    if (grepl("Dropping columns failed to produce full column rank design matrix", model))
      .quitAnalysis(gettext("The specified combination of factors does not produce an estimable model. A factor or combination of factors resulted in more levels than the effective sample size."))
    else
      .quitAnalysis(paste0(gettextf("Please, report the following error message at JASP GitHub %s", "https://github.com/jasp-stats/jasp-issues: "), model))
  }

  object <- list(
    model            = model,
    removedMe        = modelFormula$removedMe,
    removedTe        = modelFormula$removedTe
  )

  mmModel$object <- object
  jaspResults[["mmModel"]] <- mmModel

  return()
}
.mmFitStatsB      <- function(jaspResults, options, type = "BLMM") {

  if (!is.null(jaspResults[["modelSummary"]]))
    return()

  model <- jaspResults[["mmModel"]]$object$model

  fitSummary <- createJaspContainer("Model summary")
  fitSummary$position <- 2
  fitSummary$dependOn(c(.mmSwichDependencies(type), "modelSummary"))

  jaspResults[["fitSummary"]] <- fitSummary

  ### fit statistics
  modelSummary <- createJaspTable(title = gettext("Fit Statistics"))
  modelSummary$position <- 1

  modelSummary$addColumnInfo(name = "waic",   title = gettext("WAIC"),      type = "number")
  modelSummary$addColumnInfo(name = "waicSE", title = gettext("SE (WAIC)"), type = "number")
  modelSummary$addColumnInfo(name = "loo",    title = gettext("LOO"),       type = "number")
  modelSummary$addColumnInfo(name = "looSE",  title = gettext("SE (LOO)"),  type = "number")

  jaspResults[["fitSummary"]][["modelSummary"]] <- modelSummary

  waic <- loo::waic(model)
  loo  <- loo::loo(model)


  nBadWAIC <- sum(waic$pointwise[,2] > 0.4)
  nBadLOO  <- length(loo::pareto_k_ids(loo, threshold = .7))


  if (nBadWAIC > 0)
    modelSummary$addFootnote(.mmMessageBadWAIC(nBadWAIC), symbol = gettext("Warning:"))
  if (nBadLOO > 0)
    modelSummary$addFootnote(.mmMessageBadLOO(nBadLOO), symbol = gettext("Warning:"))


  tempRow <- list(
    waic   = waic$estimates["waic", "Estimate"],
    waicSE = waic$estimates["waic", "SE"],
    loo    = loo$estimates["looic", "Estimate"],
    looSE  = loo$estimates["looic", "SE"]
  )

  modelSummary$addRows(tempRow)

  ### sample sizes
  stanovaSummary <- stanova:::summary.stanova(model)

  fitSizes <- createJaspTable(title = gettext("Sample sizes"))
  fitSizes$position <- 2

  fitSizes$addColumnInfo(name = "observations", title = gettext("Observations"), type = "integer")
  tempRow <- list(
    observations = attr(stanovaSummary, "nobs")
  )

  for (n in names(attr(stanovaSummary, "ngrps"))) {
    fitSizes$addColumnInfo(name = n, title = n, type = "integer", overtitle = gettext("Levels of RE grouping factors"))
    tempRow[[n]] <- attr(stanovaSummary, "ngrps")[[n]]
  }

  fitSizes$addRows(tempRow)
  jaspResults[["fitSummary"]][["fitSizes"]] <- fitSizes

  return()
}
.mmSummaryREB     <- function(jaspResults, options, type = "BLMM") {

  if (!is.null(jaspResults[["REsummary"]]))
    return()

  model <- jaspResults[["mmModel"]]$object$model

  REsummary <- createJaspContainer(title = gettext("Variance/Correlation Estimates"))
  REsummary$position <- 4
  REsummary$dependOn(c(.mmSwichDependencies(type), "varianceCorrelationEstimate", "ciLevel"))

  ### keep this if we decide to change things
  #modelSummary <- rstan::summary(model$stanfit, probs = c(.5-options$ciLevel/2, .5+options$ciLevel/2))$summary
  #namesSummary <- rownames(modelSummary)
  #re_names  <- namesSummary[grepl("Sigma[", namesSummary, fixed = T)]
  #re_groups <- sapply(re_names, function(x) {
  #  substr(x,7,regexpr(":", x, fixed = TRUE)[1]-1)
  #})
  #re_summary    <- modelSummary[namesSummary %in% re_names,]
  #s_summary     <- modelSummary[namesSummary == "sigma",]

  VarCorr <- rstanarm:::VarCorr.stanreg(model)
  # go over each random effect grouping factor
  for (gi in 1:length(VarCorr)) {
    tempVarCorr <- VarCorr[[gi]]

    # add variance summary
    REvar <- createJaspTable(title = gettextf("%s: Variance Estimates",names(VarCorr)[gi]))

    REvar$addColumnInfo(name = "variable", title = gettext("Term"),           type = "string")
    REvar$addColumnInfo(name = "std",      title = gettext("Std. Deviation"), type = "number")
    REvar$addColumnInfo(name = "var",      title = gettext("Variance"),       type = "number")

    tempStdDev <- attr(tempVarCorr, "stddev")

    for (i in 1:length(tempStdDev)) {

      tempRow <- list(
        variable = .mmVariableNames(names(tempStdDev)[i], options$fixedVariables),
        std      = tempStdDev[i],
        var      = tempStdDev[i]^2
      )

      REvar$addRows(tempRow)
    }

    REvar$addFootnote(.mmMessageInterpretabilityBayesian())

    REsummary[[paste0("VE", gi)]] <- REvar


    # add correlation summary
    if (length(tempStdDev) > 1) {
      tempCorr <- attr(tempVarCorr, "correlation")
      REcor    <- createJaspTable(title = gettextf("%s: Correlation Estimates",names(VarCorr)[gi]))

      # add columns
      REcor$addColumnInfo(name = "variable",    title = gettext("Term"),  type = "string")

      for (i in 1:nrow(tempCorr)) {

        varName <- .mmVariableNames(rownames(tempCorr)[i], options$fixedVariables)
        REcor$addColumnInfo(name = paste0("v", i), title = varName, type = "number")

      }

      # fill rows
      for (i in 1:nrow(tempCorr)) {

        tempRow <- list(variable = .mmVariableNames(rownames(tempCorr)[i], options$fixedVariables))

        for (j in 1:i) {
          tempRow[paste0("v", j)] <- tempCorr[i, j]
        }

        REcor$addRows(tempRow)
      }

      REcor$addFootnote(.mmMessageInterpretabilityBayesian())

      REsummary[[paste0("CE", gi)]] <- REcor

    }

  }

  # add residual variance summary
  REres <- createJaspTable(title = gettext("Residual Variance Estimates"))

  REres$addColumnInfo(name = "std",   title = gettext("Std. Deviation"), type = "number")
  REres$addColumnInfo(name = "var",   title = gettext("Variance"),       type = "number")

  jaspResults[["REsummary"]] <- REsummary

  tempRow <- list(
    std      = rstanarm:::sigma.stanreg(model),
    var      = rstanarm:::sigma.stanreg(model)^2
  )

  REres$addRows(tempRow)
  REsummary[["RES"]] <- REres

  return()
}
.mmSummaryFEB     <- function(jaspResults, options, type = "BLMM") {

  if (!is.null(jaspResults[["FEsummary"]]))
    return()

  model <- jaspResults[["mmModel"]]$object$model

  FEsummary <- createJaspTable(title = "Fixed Effects Estimates")
  FEsummary$position <- 3
  FEsummary$dependOn(c(.mmSwichDependencies(type), "fixedEffectEstimate", "ciLevel"))

  FEsummary$addColumnInfo(name = "term",     title = "Term",           type = "string")
  FEsummary$addColumnInfo(name = "estimate", title = "Estimate",       type = "number")
  FEsummary$addColumnInfo(name = "se",       title = "SE",             type = "number")
  FEsummary$addColumnInfo(name = "lowerCI",  title = gettext("Lower"), type = "number", overtitle = gettextf("%s%% CI", 100 * options$ciLevel))
  FEsummary$addColumnInfo(name = "upperCI",  title = gettext("Upper"), type = "number", overtitle = gettextf("%s%% CI", 100 * options$ciLevel))
  FEsummary$addColumnInfo(name = "rhat",     title = "R-hat",          type = "number")
  FEsummary$addColumnInfo(name = "neff",     title = "ESS",            type = "number")

  jaspResults[["FEsummary"]] <- FEsummary

  modelSummary <- rstan::summary(
    model$stanfit,
    probs = c(.5 - options$ciLevel / 2, .5 + options$ciLevel / 2)
  )$summary
  namesSummary <- rownames(modelSummary)
  feSummary    <- modelSummary[!grepl("b[", namesSummary, fixed = T) & !namesSummary %in% c("mean_PPD", "log-posterior") & namesSummary != "sigma" & !grepl("Sigma[", namesSummary, fixed = TRUE),,drop = FALSE]

  for (i in 1:nrow(feSummary)) {

    tempRow <- list(
      term     = .mmVariableNames(rownames(feSummary)[i], options$fixedVariables),
      estimate = feSummary[i, 1],
      se       = feSummary[i, 3],
      lowerCI  = feSummary[i, 4],
      upperCI  = feSummary[i, 5],
      rhat     = feSummary[i, 7],
      neff     = feSummary[i, 6]
    )

    FEsummary$addRows(tempRow)
  }


  # add warning messages
  FEsummary$addFootnote(.mmMessageInterpretabilityBayesian())

  return()
}
.mmSummaryStanova <- function(jaspResults, dataset, options, type = "BLMM") {

  if (!is.null(jaspResults[["STANOVAsummary"]]))
    return()

  model <- jaspResults[["mmModel"]]$object$model
  if (!is.null(model) && !jaspBase::isTryError(model)) {

    modelSummary <-
      summary(
        model,
        probs = c(.50 - options$ciLevel / 2, .50, .50 + options$ciLevel / 2),
        diff_intercept = options$estimateType == "deviation"
      )

    if (any(sapply(modelSummary, is.null)))
      .quitAnalysis("The model summary could not be produced. Please, verify that the predictors and the outcome variable have reasonable scaling  and that there are sufficient observations for each factor level.")

  } else {
    # dummy object for creating empty summary
    modelSummary <- list("Model summary" = matrix(NA, nrow = 0, ncol = 0))
  }

  STANOVAsummary <- createJaspContainer(title = "")
  STANOVAsummary$position <- 1
  STANOVAsummary$dependOn(c(.mmSwichDependencies(type), "ciLevel", "estimateType"))

  jaspResults[["STANOVAsummary"]] <- STANOVAsummary

  # go over each random effect grouping factor
  for (i in 1:length(modelSummary)) {
    tempSummary <- modelSummary[[i]]

    if (names(modelSummary)[i] == "Model summary") {

      varName   <- gettext("Model summary")
      tableName <- varName

    } else if (names(modelSummary)[i] == "(Intercept)") {

      varName   <- "Intercept"
      tableName <- varName

    } else {

      varName   <- jaspBase::gsubInteractionSymbol(names(modelSummary)[i])

      if (options$estimateType == "deviation") {
        tableName <- gettextf("%s (differences from intercept)",varName)

      } else if (options$estimateType == "marginalMeans") {

        if (nrow(tempSummary) == 1)
          tableName <- gettextf("%s (trend)",varName)
        else
          tableName <- gettextf("%s (marginal means)",varName)

      }
    }

    tempTable <- createJaspTable(title = tableName)
    STANOVAsummary[[paste0("summary_", i)]] <- tempTable

    if (varName != "Intercept" && nrow(tempSummary) > 1)
      tempTable$addColumnInfo(name = "level",  title = gettext("Level"), type = "string")

    tempTable$addColumnInfo(name = "estimate", title = gettext("Estimate"),   type = "number")
    tempTable$addColumnInfo(name = "se",       title = gettext("SE"),         type = "number")
    tempTable$addColumnInfo(name = "lowerCI",  title = gettext("Lower"),      type = "number", overtitle = gettextf("%s%% CI", 100 * options$ciLevel))
    tempTable$addColumnInfo(name = "upperCI",  title = gettext("Upper"),      type = "number", overtitle = gettextf("%s%% CI", 100 * options$ciLevel))
    tempTable$addColumnInfo(name = "rhat",     title = gettext("R-hat"),      type = "number")
    tempTable$addColumnInfo(name = "ess_bulk", title = gettext("ESS (bulk)"), type = "number")
    tempTable$addColumnInfo(name = "ess_tail", title = gettext("ESS (tail)"), type = "number")

    if (tableName == "Model summary") {

      if (options$dependent != "" && length(options$fixedVariables) > 0 && length(options$randomVariables) == 0)
        tempTable$addFootnote(.mmMessageMissingRE())

      if (type == "BGLMM" && options$family == "binomial" && options$dependentAggregation == "")
        tempTable$addFootnote(.mmMessageMissingAgg())


      if (jaspBase::isTryError(jaspResults[["mmModel"]]$object$model))
        STANOVAsummary$setError(gettext("The model could not be estimated. Please, check the options and dataset for errors."))

      return()
    }

    for (j in 1:nrow(tempSummary)) {

      tempRow <- list(
        estimate   = tempSummary$Mean[j],
        se         = tempSummary$MAD_SD[j],
        lowerCI    = tempSummary[j, paste0((.50 - options$ciLevel / 2) *
                                             100, "%")],
        upperCI    = tempSummary[j, paste0((.50 + options$ciLevel / 2) *
                                             100, "%")],
        rhat       = tempSummary$rhat[j],
        ess_bulk   = tempSummary$ess_bulk[j],
        ess_tail   = tempSummary$ess_tail[j]
      )

      if (varName != "Intercept" && nrow(tempSummary) > 1) {

        varName <- paste(unlist(strsplit(as.character(tempSummary$Variable[j]), ",")), collapse = jaspBase::interactionSymbol)
        varName <- gsub(" ", "", varName, fixed = TRUE)

        if (grepl(":", names(modelSummary)[i], fixed = TRUE)) {

          for (n in unlist(strsplit(names(modelSummary)[i], ":"))) {
            varName <- gsub(n, "", varName, fixed = TRUE)
          }

        } else {

          varName <- gsub(names(modelSummary)[i], "", varName, fixed = TRUE)

        }

        tempRow$level <- varName
      }

      tempTable$addRows(tempRow)
    }

    # add message about (lack of) random effects grouping factors
    tempTable$addFootnote(.mmMessageREgrouping(options$randomVariables))

    # check model fit
    divIterations <- rstan::get_num_divergent(model$stanfit)
    lowBmfi       <- rstan::get_low_bfmi_chains(model$stanfit)
    maxTreedepth  <- rstan::get_num_max_treedepth(model$stanfit)

    if (any(is.nan(rstan::summary(model$stanfit)$summary[, "n_eff"])))
      minESS <- NaN
    else
      minESS <- min(rstan::summary(model$stanfit)$summary[, "n_eff"])

    if (any(is.infinite(rstan::summary(model$stanfit)$summary[, "Rhat"])))
      maxRhat <- Inf
    else if (any(is.nan(rstan::summary(model$stanfit)$summary[, "Rhat"])))
      maxRhat <- NaN
    else
      maxRhat <- max(rstan::summary(model$stanfit)$summary[, "Rhat"])

    if (divIterations != 0)
      tempTable$addFootnote(.mmMessageDivergentIter(divIterations), symbol = gettext("Warning:"))

    if (length(lowBmfi) != 0)
      tempTable$addFootnote(.mmMessageLowBMFI(length(lowBmfi)), symbol = gettext("Warning:"))

    if (maxTreedepth != 0)
      tempTable$addFootnote(.mmMessageMaxTreedepth(maxTreedepth))

    if (is.nan(maxRhat) || maxRhat > 1.01)
      tempTable$addFootnote(.mmMessageMaxRhat(maxRhat), symbol = gettext("Warning:"))

    if (is.nan(minESS) || minESS < 100 * options$mcmcChains)
      tempTable$addFootnote(.mmMessageMinESS(minESS, 100 * options$mcmcChains), symbol = gettext("Warning:"))


    removedMe <- jaspResults[["mmModel"]]$object$removedMe
    removedTe <- jaspResults[["mmModel"]]$object$removedTe
    addedRe   <- jaspResults[["mmModel"]]$object$addedRe

    for (j in seq_along(removedMe)) {
      tempTable$addFootnote(.mmMessageOmmitedTerms1(removedMe[[j]], names(removedMe)[j]), symbol = gettext("Note:"))
    }
    for (j in seq_along(removedTe)) {
      tempTable$addFootnote(.mmMessageOmmitedTerms2(removedTe[[j]], names(removedTe)[j]), symbol = gettext("Note:"))
    }
    for (i in seq_along(addedRe)) {
      tempTable$addFootnote(.mmMessageAddedTerms(addedRe[[i]], names(addedRe)[i]), symbol = gettext("Note:"))
    }

    if (jaspResults[["nMissing"]]$object != 0)
      tempTable$addFootnote(.mmMessageMissingRows(jaspResults[["nMissing"]]$object))

    if (type == "BGLMM") {
      tempTable$addFootnote(.mmMessageGLMMtype(options$family, options$link))

      if (options$family == "bernoulli")
        tempTable$addFootnote(gettextf("'%1$s' level coded as success.", attr(dataset, "binomialSuccess")))
    }
  }

  return()
}
.mmDiagnostics    <- function(jaspResults, options, dataset, type = "BLMM") {

  if (!is.null(jaspResults[["diagnosticPlots"]]))
    return()

  diagnosticPlots <- createJaspContainer(title = gettext("Sampling diagnostics"))
  diagnosticPlots$position <- 6
  diagnosticPlots$dependOn(c(.mmSwichDependencies(type), "mcmcDiagnosticsType", "mcmcDiagnosticsHorizontal", "mcmcDiagnosticsVertical"))
  jaspResults[["diagnosticPlots"]] <- diagnosticPlots


  if (options$mcmcDiagnosticsType == "scatterplot" && length(options$mcmcDiagnosticsVertical) == 0) {
    diagnosticPlots[["emptyPlot"]] <- createJaspPlot()
    return()
  }

  model     <- jaspResults[["mmModel"]]$object$model

  if (options$mcmcDiagnosticsType != "scatterplot")
    pars <- paste0(unlist(options$mcmcDiagnosticsHorizontal), collapse = ":")
  else
    pars <- c(
      paste0(unlist(options$mcmcDiagnosticsHorizontal), collapse = ":"),
      paste0(unlist(options$mcmcDiagnosticsVertical), collapse = ":")
    )


  plotData <- .mmGetPlotSamples(model = model, pars = pars, options = options)

  for (i in 1:length(plotData)) {

    if (names(plotData)[i] == "Intercept") {
      varName <- "Intercept"
    } else {
      varName <- strsplit(as.character(pars), ":")
      varName <- sapply(varName, function(x) paste(unlist(strsplit(x, ",")), collapse = ":"))
      varName <- sapply(varName, function(x) gsub(" ", "", x, fixed = TRUE))
      varName <- sapply(varName, function(x) .mmVariableNames(x, options$fixedVariables))
      varName <- paste0(varName, collapse = " by ")
    }

    plots  <- createJaspPlot(title = varName, width = 400, height = 300)

    p <- switch(
      options$mcmcDiagnosticsType,
      "traceplot"        = .rstanPlotTrace(plotData[[i]]),
      "scatterplot"      = .rstanPlotScat (plotData[[i]]),
      "histogram"        = .rstanPlotHist (plotData[[i]]),
      "density"          = .rstanPlotDens (plotData[[i]]),
      "autocorrelation"  = .rstanPlotAcor (plotData[[i]])
    )

    if (options$mcmcDiagnosticsType %in% c("histogram", "density")) {
      p <- jaspGraphs::themeJasp(p, sides = "b")
      p <- p + ggplot2::theme(
        axis.title.y = ggplot2::element_blank(),
        axis.text.y  = ggplot2::element_blank(),
        axis.ticks.y = ggplot2::element_blank()
      )
    } else {
      p <- jaspGraphs::themeJasp(p)
    }

    if (options$mcmcDiagnosticsType == "traceplot")
      p <- p + ggplot2::theme(plot.margin = ggplot2::margin(r = 10 * (nchar(options$mcmcSamples - options$mcmcBurnin) - 2)))

    plots$plotObject <- p

    diagnosticPlots[[names(plotData)[i]]] <- plots
  }

  return()
}

# helper functions
.mmVariableNames      <- function(varName, variables) {

  if (varName == "(Intercept)")
    return("Intercept")

  for (vn in variables) {
    inf <- regexpr(vn, varName, fixed = TRUE)

    if (inf[1] != -1) {
      varName <- paste0(
        substr(varName, 0, inf[1] - 1),
        substr(varName, inf[1], inf[1] + attr(inf, "match.length") - 1),
        " (",
        substr(varName, inf[1] + attr(inf, "match.length"), nchar(varName))
      )
    }

  }

  varName <- gsub(":", paste0(")", jaspBase::interactionSymbol), varName, fixed = TRUE)
  varName <- paste0(varName, ")")
  varName <- gsub(" ()", "", varName, fixed = TRUE)

  return(varName)
}
.mmAddCoefNameStanova <- function(samples, par, coefsName) {
  # this is a mess but the stanova::stanova_samples returns an incomplete variable names

  coefsTrend <- attr(samples, "estimate")
  coefsTrend <- gsub("trend ('", "", coefsTrend, fixed = TRUE)
  coefsTrend <- gsub("')", "", coefsTrend, fixed = TRUE)
  coefsTrend <- strsplit(coefsTrend, ",")

  for(cft in coefsTrend) {
    if (cft %in% strsplit(par, ":")[[1]] && !grepl(cft, coefsName)) {
      coefsName <- paste0(coefsName, jaspBase::interactionSymbol, cft)
    }
  }

  return(coefsName)
}
.mmGetPlotSamples <- function(model, pars, options) {

  matrixDiff <- stanova::stanova_samples(model, return = "array", diff_intercept = options$estimateType == "deviation")

  if (length(pars) == 1) {
    samples <- matrixDiff[[pars]]
    coefs   <- dim(matrixDiff[[pars]])[2]

    plotData <- list()

    for (coef in 1:coefs) {

      coefsName <- paste(unlist(strsplit(dimnames(samples)$Parameter[coef], ",")), collapse = ":")
      coefsName <- gsub(" ", "", coefsName, fixed = TRUE)
      coefsName <- .mmVariableNames(coefsName, options$fixedVariables)
      coefsName <- .mmAddCoefNameStanova(samples, pars, coefsName)


      plotData[[dimnames(samples)$Parameter[coef]]] <- list(
        samp = data.frame(
          value     = as.vector(samples[, coef,]),
          parameter = as.factor(rep(coefsName, length(as.vector(samples[, coef,])))),
          chain     = as.factor(c(unlist(
            sapply(1:dim(samples)[3], function(x)
              rep(x, dim(samples)[1]))
          ))),
          mcmcSamples = rep(1:dim(samples)[1], dim(samples)[3])
        ),
        nchains = options$mcmcChains,
        nparams = 1,
        mcmcBurnin  = 0
      )
    }

  } else {
    samples1 <- matrixDiff[[pars[1]]]
    samples2 <- matrixDiff[[pars[2]]]
    coefs1   <- dim(matrixDiff[[pars[1]]])[2]
    coefs2   <- dim(matrixDiff[[pars[2]]])[2]

    plotData <- list()

    for (cf1 in 1:coefs1) {
      for (cf2 in 1:coefs2) {

        coefs1Name <- paste(unlist(strsplit(dimnames(samples1)$Parameter[cf1], ",")), collapse = ":")
        coefs1Name <- gsub(" ", "", coefs1Name, fixed = TRUE)
        coefs1Name <- .mmVariableNames(coefs1Name, options$fixedVariables)
        coefs1Name <- .mmAddCoefNameStanova(samples1, pars[[1]], coefs1Name)

        coefs2Name <- paste(unlist(strsplit(dimnames(samples2)$Parameter[cf2], ",")), collapse = ":")
        coefs2Name <- gsub(" ", "", coefs2Name, fixed = TRUE)
        coefs2Name <- .mmVariableNames(coefs2Name, options$fixedVariables)
        coefs2Name <- .mmAddCoefNameStanova(samples2, pars[[2]], coefs2Name)


        plotData[[paste0(coefs1Name, ":", coefs2Name)]] <- list(
          samp = data.frame(
            value     = c(as.vector(samples1[, cf1,]),
                          as.vector(samples2[, cf2,])),
            parameter = factor(c(
              rep(coefs1Name, dim(samples1)[1] * dim(samples1)[3]),
              rep(coefs2Name, dim(samples2)[1] * dim(samples2)[3])
            ), levels = c(coefs1Name, coefs2Name)),
            chain     = as.factor(c(
              unlist(sapply(1:dim(samples1)[3], function(x)
                rep(x, dim(samples2)[1]))),
              unlist(sapply(1:dim(samples2)[3], function(x)
                rep(x, dim(samples2)[1])))
            )),
            mcmcSamples = c(rep(
              1:dim(samples1)[1], dim(samples1)[3]
            ),
            rep(
              1:dim(samples2)[1], dim(samples2)[3]
            ))
          ),
          nchains = options$mcmcChains,
          nparams = 2,
          mcmcBurnin  = 0
        )
      }
    }

  }

  return(plotData)
}
# as explained in ?is.integer
.is.wholenumber <- function(x, tol = 0.01)  abs(x - round(x)) < tol
# modified rstan plotting functions
.rstanPlotHist  <- function(plotData) {

  #thm       <- rstan:::rstanvis_hist_theme()
  dots      <- rstan:::.add_aesthetics(list(), c("fill", "color"))
  base      <- ggplot2::ggplot(plotData$samp, ggplot2::aes_string(x = "value"))
  graph     <- base + do.call(ggplot2::geom_histogram, dots) +
    ggplot2::xlab(unique(plotData$samp$parameter))

  return(graph)
}
.rstanPlotTrace <- function(plotData) {

  #thm  <- rstan:::rstanvis_theme()
  clrs <- rep_len(rstan:::rstanvis_aes_ops("chain_colors"), plotData$nchains)
  base <- ggplot2::ggplot(plotData$samp,ggplot2::aes_string(x = "mcmcSamples", y = "value", color = "chain"))

  graph <- base + ggplot2::geom_path() + ggplot2::scale_color_manual(values = clrs) +
    ggplot2::labs(x = NULL, y = levels(plotData$samp$parameter))
  graph <- graph + ggplot2::scale_x_continuous(
    breaks = jaspGraphs::getPrettyAxisBreaks(c(1,max(plotData$samp$mcmcSamples))))

  return(graph)
}
.rstanPlotDens  <- function(plotData, separate_chains = TRUE) {

  clrs <- rep_len(rstan:::rstanvis_aes_ops("chain_colors"), plotData$nchains)
  #thm  <- rstan:::rstanvis_hist_theme()
  base <- ggplot2::ggplot(plotData$samp, ggplot2::aes_string(x = "value"))

  if (!separate_chains) {
    dots <- rstan:::.add_aesthetics(list(), c("fill", "color"))
    graph <- base + do.call(ggplot2::geom_density, dots) + thm
  } else {
    dots <- rstan:::.add_aesthetics(list(), c("color", "alpha"))
    dots$mapping <- ggplot2::aes_string(fill = "chain")
    graph <- base + do.call(ggplot2::geom_density, dots) +
      ggplot2::scale_fill_manual(values = clrs)
  }

  graph <- graph + ggplot2::xlab(unique(plotData$samp$parameter))

  return(graph)
}
.rstanPlotScat  <- function(plotData) {

  #thm  <- rstan:::rstanvis_theme()
  dots <- rstan:::.add_aesthetics(list(), c("fill", "pt_color", "pt_size", "alpha", "shape"))

  p1    <- plotData$samp$parameter == levels(plotData$samp$parameter)[1]
  p2    <- plotData$samp$parameter == levels(plotData$samp$parameter)[2]
  val1  <- plotData$samp[p1, "value"]
  val2  <- plotData$samp[p2, "value"]
  df    <- data.frame(x = val1, y = val2)
  base  <- ggplot2::ggplot(df, ggplot2::aes_string("x", "y"))
  graph <- base + do.call(ggplot2::geom_point, dots) +
    ggplot2::scale_x_continuous(name = levels(plotData$samp$parameter)[1], breaks = jaspGraphs::getPrettyAxisBreaks(range(df$val1))) +
    ggplot2::scale_y_continuous(name = levels(plotData$samp$parameter)[2], breaks = jaspGraphs::getPrettyAxisBreaks(range(df$val2)))

  return(graph)
}
.rstanPlotAcor  <- function(plotData, lags = 30) {

  clrs     <- rep_len(rstan:::rstanvis_aes_ops("chain_colors"), plotData$nchains)
  thm      <- rstan:::rstanvis_theme()
  dots     <- rstan:::.add_aesthetics(list(), c("size", "color", "fill"))
  acDat    <- rstan:::.ac_plot_data(dat = plotData$samp, lags = lags, partial = FALSE)

  dots$position <- "dodge"
  dots$stat     <- "summary"
  dots$fun.y    <- "mean"

  graph         <- ggplot2::ggplot(acDat, ggplot2::aes_string(x = "lag", y = "ac")) +
    do.call(ggplot2::geom_bar, dots) +
    ggplot2::scale_y_continuous(breaks = seq(0, 1, 0.25)) +
    ggplot2::labs(title = unique(plotData$samp$parameter), x = "Lag", y = gettext("Avg. autocorrelation")) + thm

  return(graph)
}


.mmCustomChecks <- list(
  collinCheck = function(dataset) {
    corMat       <- cor(apply(dataset,2,as.numeric))
    diag(corMat) <- 0
    corMat[lower.tri(corMat)] <- 0
    nearOne <- 1 - abs(corMat) < sqrt(.Machine$double.eps)

    if (any(nearOne)) {
      varInd   <- which(nearOne, arr.ind = TRUE)
      varNames <- paste("'", rownames(corMat)[varInd[,"row"]],"' and '", colnames(corMat)[varInd[,"col"]],"'", sep = "", collapse = ", ")
      return(gettextf("The following variables are a linear combination of each other, please, remove one of them from the analysis: %s", varNames))
    }
  }
)
.mmSwichDependencies   <- function(type) {
  return(switch(
    type,
    "LMM"   = .mmDependenciesLMM,
    "GLMM"  = .mmDependenciesGLMM,
    "BLMM"  = .mmDependenciesBLMM,
    "BGLMM" = .mmDependenciesBGLMM,
  ))
}
.mmDependenciesLMM   <-
  c(
    "dependent",
    "dependent.types",
    "fixedEffects",
    "fixedVariables",
    "includeIntercept",
    "randomEffects",
    "randomVariables",
    "testMethod",
    "factorContrast",
    "bootstrapSamples",
    "interceptTest",
    "type"
  )
.mmDependenciesGLMM  <- c(
  .mmDependenciesLMM,
  "dependentAggregation",
  "family",
  "link"
)
.mmDependenciesBLMM  <-
  c(
    "dependent",
    "dependent.types",
    "fixedEffects",
    "includeIntercept",
    "randomEffects",
    "randomVariables",
    "mcmcBurnin",
    "mcmcSamples",
    "mcmcAdaptDelta",
    "mcmcMaxTreedepth",
    "mcmcChains",
    "seed",
    "setSeed"
  )
.mmDependenciesBGLMM <- c(
  .mmDependenciesBLMM,
  "dependentAggregation",
  "family",
  "link"
)

.setOptions <- function() {
  # this needs to be set after the latest afex update (otherwise null on initiation for some reason)
  afexOptions <- afex::afex_options(
    type = 3,
    set_data_arg = FALSE,
    check_contrasts = TRUE,
    method_mixed = "S",
    return_aov = "afex_aov",
    es_aov = "ges",
    correction_aov = "GG",
    factorize = TRUE,
    lmer_function = "lmerTest",
    sig_symbols = c(" +", " *", " **", " ***"),
    emmeans_model = c("multivariate"),
    include_aov = FALSE
  )
  oldOptions <- options(lme4.summary.cor.max = 12)

  withr::defer_parent({
    afex::afex_options(afexOptions)
    options(oldOptions)
  })
}
