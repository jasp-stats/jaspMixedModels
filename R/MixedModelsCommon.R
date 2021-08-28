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

.mmRunAnalysis   <- function(jaspResults, dataset, options, type) {

  if (.mmReady(options, type))
    dataset <- .mmReadData(jaspResults, dataset, options, type)

  if (.mmReady(options, type))
    .mmCheckData(dataset, options, type)


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
    if (options$fitStats) {
      if (type %in% c("LMM", "GLMM")).mmFitStats(jaspResults, options, type)
      if (type %in% c("BLMM", "BGLMM")).mmFitStatsB(jaspResults, options, type)
    }


    # show fixed / random effects summary
    if (options$showFE) {
      if (type %in% c("LMM", "GLMM")).mmSummaryFE(jaspResults, options, type)
      if (type %in% c("BLMM", "BGLMM")).mmSummaryFEB(jaspResults, options, type)
    }
    if (options$showRE) {
      if (type %in% c("LMM", "GLMM")).mmSummaryRE(jaspResults, options, type)
      if (type %in% c("BLMM", "BGLMM")).mmSummaryREB(jaspResults, options, type)
    }


    # sampling diagnostics
    if (type %in% c("BLMM", "BGLMM")) {
      if (length(options$samplingVariable1) != 0)
        .mmDiagnostics(jaspResults, options, dataset, type)
    }


    # create plots
    if (length(options$plotsX))
      .mmPlot(jaspResults, dataset, options, type)


    # marginal means
    if (length(options$marginalMeans) > 0)
      .mmMarginalMeans(jaspResults, dataset, options, type)

    if (length(options$marginalMeans) > 0 && options$marginalMeansContrast && !is.null(jaspResults[["EMMresults"]]))
      .mmContrasts(jaspResults, options, type, what = "Means")


    # trends
    if (length(options$trendsTrend) > 0 &&  length(options$trendsVariables) > 0)
      .mmTrends(jaspResults, dataset, options, type)

    if (options$trendsContrast && length(options$trendsTrend) > 0 && length(options$trendsVariables) > 0 && !is.null(jaspResults[["EMTresults"]]))
      .mmContrasts(jaspResults, options, type, what = "Trends")

  }

  return()
}

### common mixed-models functions
.mmReadData      <- function(jaspResults, dataset, options, type = "LMM") {

  if (is.null(dataset)) {
    if (type %in% c("LMM","BLMM")) {
      dataset <- readDataSetToEnd(
        columns.as.numeric = options$dependentVariable,
        columns = c(
          options$fixedVariables,
          options$randomVariables
        )
      )
    } else if (type %in% c("GLMM","BGLMM")) {
      if (options$family == "binomialAgg") {
        dataset <- readDataSetToEnd(
          columns.as.numeric = c(options$dependentVariable, options$dependentVariableAggregation),
          columns = c(
            options$fixedVariables,
            options$randomVariables
          )
        )
      } else  if (options$dependentVariableAggregation == "") {
        dataset <- readDataSetToEnd(
          columns.as.numeric = options$dependentVariable,
          columns = c(
            options$fixedVariables,
            options$randomVariables
          )
        )
      }
    }
  }

  dataset <- data.frame(dataset)

  # check and use only the variables that actually used for modeling
  usedVariables <- c(
    options$dependentVariable,
    if (type %in% c("GLMM", "BGLMM")) if (options$dependentVariableAggregation != "") options$dependentVariableAggregation,
    unique(unlist(options$fixedEffects)),
    if (length(options$randomVariables) != 0) options$randomVariables
  )
  dataset <- dataset[, usedVariables]

  # omit NAs/NaN/Infs and store the number of omitted observations
  allRows <- nrow(dataset)
  dataset <- na.omit(dataset)

  # store the number of missing values into a jaspState object
  nMissing <- createJaspState()
  nMissing$object <- allRows - nrow(dataset)
  jaspResults[["nMissing"]] <- nMissing

  return(dataset)
}
.mmCheckData     <- function(dataset, options, type = "LMM") {

  if (nrow(dataset) < length(options$fixedEffects))
    .quitAnalysis("The dataset contains fewer observations than predictors (after excluding NAs/NaN/Inf).")

  checkVariables <- 1:ncol(dataset)
  if (type %in% c("GLMM", "BGLMM"))
    if (options$dependentVariableAggregation != "")
      checkVariables <- checkVariables[-which(options$dependentVariableAggregation == colnames(dataset))]


  .hasErrors(
    dataset,
    type = 'infinity',
    exitAnalysisIfErrors = TRUE
  )

  # the aggregation variable for binomial can have zero variance and can be without factor levels
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

    if (options$iteration - 1 <= options$warmup)
      .quitAnalysis(gettext("The number of iterations must be at least 2 iterations higher than the burnin"))

  }

  # check families
  if (type %in% c("GLMM","BGLMM")) {

    familyText <- .mmMessageGLMMtype(options$family, options$link)
    familyText <- substr(familyText, 1, nchar(familyText) - 1)

    if (options$family %in% c("Gamma", "inverse.gaussian")) {

      if (any(dataset[, options$dependentVariable] <= 0))
        .quitAnalysis(gettextf("%s requires that the dependent variable is positive.",familyText))

    } else if (options$family %in% c("neg_binomial_2", "poisson")) {

      if (any(dataset[, options$dependentVariable] < 0 | any(!.is.wholenumber(dataset[, options$dependentVariable]))))
        .quitAnalysis(gettextf("%s requires that the dependent variable is an integer.",familyText))

    } else if (options$family == "binomial") {

      if (any(!dataset[, options$dependentVariable] %in% c(0, 1)))
        .quitAnalysis(gettextf("%s requires that the dependent variable contains only 0 and 1.",familyText))

    } else if (options$family == "binomialAgg") {

      if (any(dataset[, options$dependentVariable] < 0 | dataset[, options$dependentVariable] > 1))
        .quitAnalysis(gettextf("%s requires that the dependent variable is higher than 0 and lower than 1.",familyText))

      if (any(dataset[, options$dependentVariableAggregation] < 0) || any(!.is.wholenumber(dataset[, options$dependentVariableAggregation])))
        .quitAnalysis(gettextf("%s requires that the number of trials variable is an integer.",familyText))

      if (any(!.is.wholenumber(dataset[, options$dependentVariable] * dataset[, options$dependentVariableAggregation])))
        .quitAnalysis(gettextf("%s requires that the dependent variable is proportion of successes out of the number of trials.",familyText))

    } else if (options$family == "betar") {

      if (any(dataset[, options$dependentVariable] <= 0 | dataset[, options$dependentVariable] >= 1))
        .quitAnalysis(gettextf("%s requires that the dependent variable is higher than 0 and lower than 1.",familyText))

    }
  }

  return()
}
.mmReady         <- function(options, type = "LMM") {

  if (type %in% c("LMM","BLMM")) {

    if (options$dependentVariable       == "" ||
        length(options$randomVariables) == 0  ||
        length(options$fixedEffects)    == 0)
      return(FALSE)


  } else if (type %in% c("GLMM","BGLMM")) {

    if (options$family == "binomialAgg") {
      if (options$dependentVariable            == "" ||
          options$dependentVariableAggregation == "" ||
          length(options$randomVariables)      == 0  ||
          length(options$fixedEffects)         == 0)
        return(FALSE)

    }else {

      if (options$dependentVariable       == "" ||
          length(options$randomVariables) == 0  ||
          length(options$fixedEffects)    == 0)
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
  # create the FE formula
  fixedEffects <- paste0(feTerms, collapse = "+")

  if (fixedEffects == "")
    fixedEffects <- 1

  # random effects
  randomEffects <- NULL
  removedMe     <- list()
  removedTe     <- list()
  addedRe       <- list()

  for (tempRe in options[["randomEffects"]]) {
    # unlist selected random effects
    tempVars <- sapply(tempRe$randomComponents, function(x) {
      if (x$randomSlopes)
        return(unlist(x$value))
      else
        return(NA)
    })
    tempVarsRem <- sapply(tempRe$randomComponents, function(x) {
      if (x$randomSlopes)
        return(NA)
      else
        return(unlist(x$value))
    })
    tempVars     <- tempVars[!is.na(tempVars)]
    tempVars     <- sapply(tempVars, function(x) paste(unlist(x), collapse = "*"))
    tempVarsRem  <- tempVarsRem[!is.na(tempVarsRem)]
    tempVarsRem  <- sapply(tempVarsRem, function(x) paste(unlist(x), collapse = "*"))

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
    reTerms <- paste0(reTerms, collapse = "+")

    newRe <-
      paste0(
        "(",
        ifelse(reTerms == "", 1, reTerms),
        ifelse(tempRe$correlation || reTerms == "", "|", "||"),
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
    paste0(options$dependentVariable,
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
.mmAddedRETerms  <- function(terms, removed) {

  added <- NULL
  if (length(terms) > 1 && length(removed) >= 1) {
    splitTerms  <- sapply(terms, strsplit, "\\*")
    splitTerms  <- sapply(splitTerms, function(x) trimws(x, which = c("both")))

    splitRemoved <- sapply(removed, strsplit, "\\*")
    splitRemoved <- sapply(splitRemoved, function(x) trimws(x, which = c("both")))

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

  if (options$method == "PB") {
    seedDependencies <- c("seed", "setSeed")
    .setSeedJASP(options)
  } else {
    seedDependencies <- NULL
  }

  dependencies <- c(.mmSwichDependencies(type), seedDependencies)

  mmModel$dependOn(dependencies)


  modelFormula <- .mmModelFormula(options, dataset)

  if (type == "LMM") {
    model <- try(
      afex::mixed(
        formula         = as.formula(modelFormula$modelFormula),
        data            = dataset,
        type            = options$type,
        method          = options$method,
        test_intercept  = if (options$method %in% c("LRT", "PB")) options$test_intercept else FALSE,
        args_test       = list(nsim = options$bootstrapSamples),
        check_contrasts = TRUE
      ))
  } else if (type == "GLMM") {
    # needs to be avaluated in the global environment
    glmmFamily <<- options$family
    glmmLink   <<- options$link

    # I wish there was a better way to do this
    if (options$family == "binomialAgg") {
      glmmWeight <<- dataset[, options$dependentVariableAggregation]
      model <- try(
        afex::mixed(
          formula         = as.formula(modelFormula$modelFormula),
          data            = dataset,
          type            = options$type,
          method          = options$method,
          test_intercept  = if (options$method %in% c("LRT", "PB")) options$test_intercept else FALSE,
          args_test       = list(nsim = options$bootstrapSamples),
          check_contrasts = TRUE,
          family          = eval(call("binomial", glmmLink)),
          weights         = glmmWeight
        ))
    } else {
      model <- try(
        afex::mixed(
          formula         = as.formula(modelFormula$modelFormula),
          data            = dataset,
          type            = options$type,
          method          = options$method,
          test_intercept  = if (options$method %in% c("LRT", "PB")) options$test_intercept else FALSE,
          args_test       = list(nsim = options$bootstrapSamples),
          check_contrasts = TRUE,
          #start           = start,
          family          = eval(call(glmmFamily, glmmLink))
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
.mmSummaryAnova  <- function(jaspResults, dataset, options, type = "LMM") {

  if (!is.null(jaspResults[["ANOVAsummary"]]))
    return()

  model <- jaspResults[["mmModel"]]$object$model

  ANOVAsummary <- createJaspTable(title = gettext("ANOVA Summary"))
  #defining columns first to give the user something nice to look at
  ANOVAsummary$addColumnInfo(name = "effect",         title = gettext("Effect"),             type = "string")

  if (options$method %in% c("S", "KR")) {
    ANOVAsummary$addColumnInfo(name = "df",           title = gettext("df"),                 type = "string")
    ANOVAsummary$addColumnInfo(name = "stat",         title = gettext("F"),                  type = "number")
  } else if (options$method %in% c("PB", "LRT")) {
    ANOVAsummary$addColumnInfo(name = "df",           title = gettext("df"),                 type = "integer")
    ANOVAsummary$addColumnInfo(name = "stat",         title = gettext("ChiSq"),              type = "number")
  }

  ANOVAsummary$addColumnInfo(name = "pval",           title = gettext("p"),                  type = "pvalue")

  if (options$method == "PB")
    ANOVAsummary$addColumnInfo(name = "pvalBoot",     title = gettext("p (bootstrap)"),      type = "pvalue")

  if (options$pvalVS) {
    ANOVAsummary$addColumnInfo(name = "pvalVS",       title = gettext("VS-MPR"),             type = "number")

    if (options$method == "PB")
      ANOVAsummary$addColumnInfo(name = "pvalBootVS", title = gettext("VS-MPR (bootstrap)"), type = "number")

    ANOVAsummary$addFootnote(.mmMessageVovkSellke(), symbol = "\u002A", colNames = c("pvalVS", "pvalBootVS"))
  }

  jaspResults[["ANOVAsummary"]] <- ANOVAsummary

  ANOVAsummary$position <- 1
  dependencies <- .mmSwichDependencies(type)

  if (options$method == "PB")
    seedDependencies <- c("seed", "setSeed")
  else
    seedDependencies <- NULL

  ANOVAsummary$dependOn(c(dependencies, seedDependencies, "pvalVS"))

  # some error management for GLMMS - and oh boy, they can fail really easily
  if (!is.null(model) && inherits(model, c("std::runtime_error", "C++Error", "try-error"))) {
    ANOVAsummary$setError(.mmErrorOnFit(model))
    return()
  }


  if (is.null(model)) {

    if (options$dependentVariable != "" && length(options$fixedVariables) > 0 &&  length(options$randomVariables) == 0)
      ANOVAsummary$addFootnote(.mmMessageMissingRE())

    if (type == "GLMM" && options$family == "binomialAgg" && options$dependentVariableAggregation == "")
      ANOVAsummary$addFootnote(.mmMessageMissingAgg())

    return()
  }


  for (i in 1:nrow(model$anova_table)) {

    if (rownames(model$anova_table)[i] == "(Intercept)")
      effectName <- gettext("Intercept")
    else
      effectName <- jaspBase::gsubInteractionSymbol(rownames(model$anova_table)[i])

    tempRow <- list(effect = effectName, df = afex::nice(model)$df[i])

    if (options$method %in% c("S", "KR")) {
      tempRow$stat   = model$anova_table$`F`[i]
      tempRow$pval   = model$anova_table$`Pr(>F)`[i]
    } else if (options$method == "PB") {
      tempRow$stat     = model$anova_table$Chisq[i]
      tempRow$pval     = model$anova_table$`Pr(>Chisq)`[i]
      tempRow$pvalBoot = model$anova_table$`Pr(>PB)`[i]
    } else if (options$method == "LRT") {
      tempRow$stat     = model$anova_table$Chisq[i]
      tempRow$pval     = model$anova_table$`Pr(>Chisq)`[i]
    }
    if (options$pvalVS) {
      tempRow$pvalVS <- VovkSellkeMPR(tempRow$pval)
      if (options$method == "PB")
        tempRow$pvalBootVS <- VovkSellkeMPR(tempRow$pvalBoot)
    }

    ANOVAsummary$addRows(tempRow)
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

  ANOVAsummary$addFootnote(.mmMessageTermTest(options$method))


  return()
}
.mmFitStats      <- function(jaspResults, options, type = "LMM") {

  if (!is.null(jaspResults[["fitStats"]]))
    return()

  model <- jaspResults[["mmModel"]]$object$model
  if (is.list(model$full_model))
    full_model <- model$full_model[[length(model$full_model)]]
  else
    full_model <- model$full_model


  fitSummary <- createJaspContainer("Model summary")
  fitSummary$position <- 2

  dependencies <- .mmSwichDependencies(type)

  if (options$method == "PB")
    dependencies <- c(dependencies, "seed", "setSeed")

  fitSummary$dependOn(c(dependencies, "fitStats"))
  jaspResults[["fitSummary"]] <- fitSummary


  ### fit statistics
  fitStats <- createJaspTable(title = gettext("Fit statistics"))
  fitStats$position <- 1

  if (!lme4::isREML(full_model))
    fitStats$addColumnInfo(name = "deviance", title = gettext("Deviance"), type = "number")
  if (lme4::isREML(full_model))
    fitStats$addColumnInfo(name = "devianceREML", title = gettext("Deviance (REML)"), type = "number")

  fitStats$addColumnInfo(name = "loglik", title = gettext("log Lik."), type = "number")
  fitStats$addColumnInfo(name = "df",     title = gettext("df"),       type = "integer")
  fitStats$addColumnInfo(name = "aic",    title = gettext("AIC"),      type = "number")
  fitStats$addColumnInfo(name = "bic",    title = gettext("BIC"),      type = "number")
  jaspResults[["fitSummary"]][["fitStats"]] <- fitStats


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


  fitStats$addRows(tempRow)
  fitStats$addFootnote(.mmMessageFitType(lme4::isREML(full_model)))


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

  if (options$method == "PB")
    seedDependencies <- c("seed", "setSeed")
  else
    seedDependencies <- NULL

  REsummary$dependOn(c(dependencies, seedDependencies, "showRE"))

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

    REvar$addFootnote(.mmMessageInterpretability())

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

      REcor$addFootnote(.mmMessageInterpretability())

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
      var      = sqrt(sigma(model$full_model[[length(model$full_model)]]))
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

  if (options$method == "PB")
    seedDependencies <- c("seed", "setSeed")
  else
    seedDependencies <- NULL

  FEsummary$dependOn(c(dependencies, seedDependencies, "showFE", "pvalVS"))

  FEsummary$addColumnInfo(name = "term",       title = gettext("Term"),       type = "string")
  FEsummary$addColumnInfo(name = "estimate",   title = gettext("Estimate"),   type = "number")
  FEsummary$addColumnInfo(name = "se",         title = gettext("SE"),         type = "number")
  if (type == "LMM")
    FEsummary$addColumnInfo(name = "df",       title = gettext("df"),         type = "number")

  FEsummary$addColumnInfo(name = "stat",       title = gettext("t"),          type = "number")
  if (ncol(FEcoef) >= 4)
    FEsummary$addColumnInfo(name = "pval",     title = gettext("p"),          type = "pvalue")

  if (options$pvalVS) {
    FEsummary$addColumnInfo(name = "pvalVS",     title = gettext("VS-MPR"),     type = "number")
    FEsummary$addFootnote(.mmMessageVovkSellke(), symbol = "\u002A", colNames = "pvalVS")
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

    if (options$pvalVS)
      tempRow$pvalVS <- VovkSellkeMPR(tempRow$pval)

    FEsummary$addRows(tempRow)
  }

  # add warning messages
  FEsummary$addFootnote(.mmMessageInterpretability())

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
  width  <- 150 * prod(sapply(unlist(options$plotsX), function(x) length(unique(dataset[, x])) / 2))

  if (length(options$plotsPanel) > 0)
    width  <- width * length(unique(dataset[, unlist(options$plotsPanel)[1]]))
  else if (length(options$plotsPanel) > 1)
    height <- height * length(unique(dataset[, unlist(options$plotsPanel)[2]]))

  if (options$plotLegendPosition %in% c("bottom", "top"))
    height <- height + 50
  else if (options$plotLegendPosition %in% c("left", "right"))
    width  <- width + 100

  width <- width + 150

  plots  <- createJaspPlot(title = gettext("Plot"), width = width, height = height)

  plots$position <- 5
  dependencies <- .mmSwichDependencies(type)

  plots$dependOn(
    c(
      dependencies,
      "plotsX",
      "plotsTrace",
      "plotsPanel",
      "plotsAgregatedOver",
      "plotsGeom",
      "plotsTrace",
      "plotsPanel",
      "plotsTheme",
      "plotsCIwidth",
      "plotsCImethod",
      "plotAlpha",
      "plotJitterWidth",
      "plotJitterHeight",
      "plotGeomWidth",
      "plotDodge",
      "plotsBackgroundColor",
      "plotRelativeSize",
      "plotRelativeSizeText",
      "plotLegendPosition",
      "plotsMappingColor",
      "plotsMappingShape",
      "plotsMappingLineType",
      "plotsMappingFill",
      "seed",
      "setSeed"
    )
  )

  jaspResults[["plots"]] <- plots
  plots$status <- "running"

  # stop with message if there is no random effects grouping factor selected
  if (length(options$plotsAgregatedOver) == 0) {
    plots$setError(gettext("At least one random effects grouping factor needs to be selected in field 'Background data show'."))
    return()
  }
  if (all(!c(options$plotsMappingColor, options$plotsMappingShape, options$plotsMappingLineType, options$plotsMappingFill))) {
    plots$setError(gettext("Factor levels need to be distinguished by at least one feature. Please, check one of the 'Distinguish factor levels' options."))
    return()
  }

  # select geom
  if (options$plotsGeom %in% c("geom_jitter", "geom_violin", "geom_boxplot", "geom_count"))
    geomPackage <- "ggplot2"
  else if (options$plotsGeom == "geom_beeswarm")
    geomPackage <- "ggbeeswarm"
  else if (options$plotsGeom == "geom_boxjitter")
    geomPackage <- "ggpol"


  # select mapping
  mapping <- c("color", "shape", "linetype", "fill")[c(options$plotsMappingColor, options$plotsMappingShape, options$plotsMappingLineType, options$plotsMappingFill)]

  if (length(mapping) == 0)
    mapping <- ""

  # specify data_arg
  if (options$plotsGeom == "geom_jitter")
    data_arg <- list(
      position =
        ggplot2::position_jitterdodge(
          jitter.width  = options$plotJitterWidth,
          jitter.height = options$plotJitterHeight,
          dodge.width   = options$plotDodge
        )
    )
  else if (options$plotsGeom == "geom_violin")
    data_arg <- list(width = options$plotGeomWidth)
  else if (options$plotsGeom == "geom_boxplot")
    data_arg <- list(width = options$plotGeomWidth)
  else if (options$plotsGeom == "geom_count")
    data_arg <- list()
  else if (options$plotsGeom == "geom_beeswarm")
    data_arg <- list(dodge.width = options$plotDodge)
  else if (options$plotsGeom == "geom_boxjitter")
    data_arg <- list(
      width             = options$plotGeomWidth,
      jitter.width      = options$plotJitterWidth,
      jitter.height     = options$plotJitterHeight,
      outlier.intersect = TRUE
    )

  if (options$plotsBackgroundColor != "none" && options$plotsGeom != "geom_jitter" && "color" %in% mapping)
    data_arg$color <- options$plotsBackgroundColor

  # fixing afex issues with bootstrap and LRT type II SS - hopefully removeable in the future
  if (type %in% c("LMM", "GLMM") && options$method %in% c("LRT", "PB") && options$type == 2)
    model <- model$full_model[[length(model$full_model)]]

  .setSeedJASP(options)
  p <- try(
    afex::afex_plot(
      model,
      dv          = options$dependentVariable,
      x           = unlist(options$plotsX),
      trace       = if (length(options$plotsTrace) != 0) unlist(options$plotsTrace),
      panel       = if (length(options$plotsPanel) != 0) unlist(options$plotsPanel),
      id          = options$plotsAgregatedOver,
      data_geom   = getFromNamespace(options$plotsGeom, geomPackage),
      mapping     = mapping,
      error       = options$plotsCImethod,
      error_level = options$plotsCIwidth,
      data_alpha  = options$plotAlpha,
      data_arg    = if (length(data_arg) != 0) data_arg,
      error_arg   = list(
        width = 0,
        size  = .5 * options$plotRelativeSize
      ),
      point_arg   = list(size = 1.5 * options$plotRelativeSize),
      line_arg    = list(size = .5 * options$plotRelativeSize),
      legend_title = paste(unlist(options$plotsTrace), collapse = "\n"),
      dodge       = options$plotDodge
    ))

  if (jaspBase::isTryError(p)) {
    plots$setError(p)
    return()
  }

  if (options$plotsGeom == "geom_violin" && (length(options$plotsAgregatedOver) == 1 && length(unique(dataset[, options$plotsAgregatedOver])) < 3)) {
    plots$setError(gettext("Violin geom requires that the random effects grouping factors has at least 3 levels."))
    return()
  }

  # fix the axis
  p <- .mmFixPlotAxis(p)

  # fix names of the variables
  p <- p + ggplot2::labs(x = unlist(options$plotsX), y = options$dependentVariable)

  # add theme
  if (options$plotsTheme == "JASP") {

    p <- jaspGraphs::themeJasp(p, legend.position = options$plotLegendPosition)

  } else  if (options$plotsTheme != "JASP") {

    p <- p + switch(
      options$plotsTheme,
      "theme_bw"      = ggplot2::theme_bw()       + ggplot2::theme(legend.position = "bottom"),
      "theme_light"   = ggplot2::theme_light()    + ggplot2::theme(legend.position = "bottom"),
      "theme_minimal" = ggplot2::theme_minimal()  + ggplot2::theme(legend.position = "bottom"),
      "theme_pubr"    = jaspGraphs::themePubrRaw(legend = options$plotLegendPosition),
      "theme_apa"     = jaspGraphs::themeApaRaw(legend.pos = switch(
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

  if (options$plotsEstimatesTable) {
    plotData <- afex::afex_plot(
      model,
      x           = unlist(options$plotsX),
      dv          = options$dependentVariable,
      trace       = if (length(options$plotsTrace) != 0)
        unlist(options$plotsTrace),
      panel       = if (length(options$plotsPanel) != 0)
        unlist(options$plotsPanel),
      id          = options$plotsAgregatedOver,
      data_geom   = getFromNamespace(options$plotsGeom, geomPackage),
      error       = options$plotsCImethod,
      error_level = options$plotsCIwidth,
      return      = "data"
    )$means

    EstimatesTable <- createJaspTable(title = gettext("Estimated Means and Confidence Intervals"))
    EstimatesTable$position <- 5
    EstimatesTable$dependOn(
      c(
        dependencies,
        "plotsX",
        "plotsTrace",
        "plotsPanel",
        "plotsAgregatedOver",
        "plotsCIwidth",
        "plotsCImethod",
        "seed",
        "setSeed",
        "plotsEstimatesTable"
      )
    )

    for (variable in attr(plotData, "pri.vars")) {
      EstimatesTable$addColumnInfo(name = variable, title = variable, type = "string")
    }

    EstimatesTable$addColumnInfo(name = "mean", title = gettext("Mean"), type = "number")

    if (options$plotsCImethod != "none") {
      EstimatesTable$addColumnInfo(name = "lowerCI", title = gettext("Lower"), type = "number", overtitle = gettextf("%s%% CI", 100 * options$plotsCIwidth)      )
      EstimatesTable$addColumnInfo(name = "upperCI", title = gettext("Upper"), type = "number", overtitle = gettextf("%s%% CI", 100 * options$plotsCIwidth)      )
    }

    jaspResults[["EstimatesTable"]] <- EstimatesTable

    for (i in 1:nrow(plotData)) {

      tempRow <- list()
      for (variable in attr(plotData, "pri.vars")) {
        tempRow[variable] <- as.character(plotData[i, variable])
      }

      tempRow$mean     <- plotData[i, "y"]
      if (options$plotsCImethod != "none") {
        tempRow$lowerCI  <- plotData[i, "lower"]
        tempRow$upperCI  <- plotData[i, "upper"]
      }

      EstimatesTable$addRows(tempRow)
    }

  }

  return()
}
.mmMarginalMeans <- function(jaspResults, dataset, options, type = "LMM") {

  if (!is.null(jaspResults[["EMMresults"]]))
    return()

  model <- jaspResults[["mmModel"]]$object$model

  # deal with continuous predictors
  at <- NULL
  for (var in unlist(options$marginalMeans)) {
    if (typeof(dataset[, var]) == "double") {
      at[[var]] <-c(mean(dataset[, var], na.rm = TRUE) + c(-1, 0, 1) * options$marginalMeansSD * sd(dataset[, var], na.rm = TRUE))
    }
  }

  # compute the results
  if (type == "LMM")
    emmeans::emm_options(
      pbkrtest.limit = if (options$marginalMeansOverride) Inf,
      mmrTest.limit  = if (options$marginalMeansOverride) Inf)

  emm <- emmeans::emmeans(
    object  = model,
    specs   = unlist(options$marginalMeans),
    at      = at,
    options = list(level  = options$marginalMeansCIwidth),
    lmer.df = if (type == "LMM")
      options$marginalMeansDf
    else if (type == "GLMM" && options$family == "gaussian" && options$link == "identity")
      "asymptotic",
    type    = if (type %in% c("GLMM", "BGLMM") && options$marginalMeansResponse) "response"
  )

  emmTable  <- as.data.frame(emm)
  if (type %in% c("LMM", "GLMM") && options$marginalMeansCompare)
    emmTest <- as.data.frame(emmeans::test(emm, null = options$marginalMeansCompareTo))

  EMMsummary <- createJaspTable(title = gettext("Estimated Marginal Means"))
  EMMresults <- createJaspState()

  EMMsummary$position <- 7

  dependencies <- .mmSwichDependencies(type)
  if (type %in% c("GLMM", "BGLMM"))
    dependencies <- c(.mmDependenciesGLMM, "marginalMeansResponse")

  if (type %in% c("LMM", "GLMM"))
    dependenciesAdd <- c(
      "marginalMeans",
      "marginalMeansSD",
      "marginalMeansCompare",
      "marginalMeansCompareTo",
      "marginalMeansCIwidth",
      "pvalVS",
      "marginalMeansContrast"
    )
  else
    dependenciesAdd <- c(
      "marginalMeans",
      "marginalMeansSD",
      "marginalMeansCIwidth",
      "marginalMeansContrast"
    )

  if (type == "LMM")
    dependenciesAdd <- c(
      dependenciesAdd,
      "marginalMeansOverride",
      "marginalMeansDf")

  EMMsummary$dependOn(c(dependencies, dependenciesAdd))
  EMMresults$dependOn(c(dependencies, dependenciesAdd))

  if (options$marginalMeansContrast)
    EMMsummary$addColumnInfo(name = "number", title = gettext("Row"), type = "integer")

  for (variable in unlist(options$marginalMeans)) {

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

    EMMsummary$addColumnInfo(name = "lowerCI",  title = gettext("Lower"),    type = "number", overtitle = gettextf("%s%% CI", 100 * options$marginalMeansCIwidth))
    EMMsummary$addColumnInfo(name = "upperCI",  title = gettext("Upper"),    type = "number", overtitle = gettextf("%s%% CI", 100 * options$marginalMeansCIwidth))

    if (options$marginalMeansCompare) {
      EMMsummary$addColumnInfo(name = "stat",   title = ifelse(colnames(emmTest)[ncol(emmTest) - 1] == "t.ratio", gettext("t"), gettext("z")), type = "number")
      EMMsummary$addColumnInfo(name = "pval",   title = gettext("p"),         type = "pvalue")
      EMMsummary$addFootnote(.mmMessageTestNull(options$marginalMeansCompareTo), symbol = "\u2020", colNames = "pval")

      if (options$pvalVS) {
        EMMsummary$addColumnInfo(name = "pvalVS", title = gettext("VS-MPR"), type = "number")
        EMMsummary$addFootnote(.mmMessageVovkSellke(), symbol = "\u002A", colNames = "pvalVS")
      }
    }

  } else if (type %in% c("BLMM", "BGLMM")) {

    EMMsummary$addColumnInfo(name = "estimate", title = gettext("Median"), type = "number")
    EMMsummary$addColumnInfo(name = "lowerCI",  title = gettext("Lower"),  type = "number", overtitle = gettextf("%s%% HPD", 100 * options$marginalMeansCIwidth))
    EMMsummary$addColumnInfo(name = "upperCI",  title = gettext("Upper"),  type = "number", overtitle = gettextf("%s%% HPD", 100 * options$marginalMeansCIwidth))

  }

  jaspResults[["EMMsummary"]] <- EMMsummary

  for (i in 1:nrow(emmTable)) {
    tempRow <- list()

    if (options$marginalMeansContrast)
      tempRow$number <- i


    for (variable in unlist(options$marginalMeans)) {

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

      if (options$marginalMeansCompare) {
        tempRow$stat <- emmTest[i, grep("ratio", colnames(emmTest))]
        tempRow$pval <- emmTest[i, "p.value"]
        if (options$pvalVS)
          tempRow$pvalVS <- VovkSellkeMPR(tempRow$pval)

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

  # deal with continuous predictors
  at <- NULL
  for (var in unlist(options$trendsVariables)) {

    if (typeof(dataset[, var]) == "double")
      at[[var]] <-mean(dataset[, var], na.rm = TRUE) + c(-1, 0, 1) * options$trendsSD * sd(dataset[, var], na.rm = TRUE)

  }

  # compute the results
  if (type == "LMM")
    emmeans::emm_options(
      pbkrtest.limit = if (options$trendsOverride) Inf,
      mmrTest.limit  = if (options$trendsOverride) Inf)


  # TODO: deal with the emtrends scoping problems
  trendsCI      <<- options$trendsCIwidth
  trendsAt      <<- at

  if (type == "LMM" || (type == "GLMM" && options$family == "gaussian" && options$link == "identity"))
    trendsType <- "LMM"
  else
    trendsType <- type

  trendsDataset <<- dataset
  trendsModel   <<- model

  if (type == "LMM")
    trendsDf <<- options$trendsDf
  else if (type == "GLMM" && options$family == "gaussian" && options$link == "identity")
    trendsDf <<- "asymptotic"

  emm <- emmeans::emtrends(
    object  = trendsModel,
    data    = trendsDataset,
    specs   = unlist(options$trendsVariables),
    var     = unlist(options$trendsTrend),
    at      = trendsAt,
    options = list(level = trendsCI),
    lmer.df = if (trendsType == "LMM") trendsDf
  )
  emmTable  <- as.data.frame(emm)
  if (type %in% c("LMM", "GLMM") && options$trendsCompare)
    emmTest <- as.data.frame(emmeans::test(emm, null = options$trendsCompareTo))


  trendsSummary <- createJaspTable(title = gettext("Estimated Trends"))
  EMTresults    <- createJaspState()

  trendsSummary$position <- 9
  dependencies <- .mmSwichDependencies(type)

  if (type %in% c("LMM", "GLMM"))
    dependenciesAdd <- c(
      "trendsVariables",
      "trendsTrend",
      "trendsSD",
      "trendsCompare",
      "trendsCompareTo",
      "trendsCIwidth",
      "pvalVS",
      "trendsContrast"
    )
  else
    dependenciesAdd <- c(
      "trendsVariables",
      "trendsTrend",
      "trendsSD",
      "trendsCIwidth",
      "trendsContrast"
    )

  if (type == "LMM")
    dependenciesAdd <-c(dependenciesAdd, "trendsDf", "trendsOverride")

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
  trendsSummary$addColumnInfo(name = "slope",  title = gettextf("%s (slope)",unlist(options$trendsTrend)), type = "number")
  if (type %in% c("LMM", "GLMM")) {

    trendsSummary$addColumnInfo(name = "se",   title = gettext("SE"), type = "number")
    if (type == "LMM" && options$trendsDf != "asymptotic")
      trendsSummary$addColumnInfo(name = "df", title = gettext("df"), type = "number")

    trendsSummary$addColumnInfo(name = "lowerCI", title = gettext("Lower"), type = "number", overtitle = gettextf("%s%% CI", 100 * options$trendsCIwidth))
    trendsSummary$addColumnInfo(name = "upperCI", title = gettext("Upper"), type = "number", overtitle = gettextf("%s%% CI", 100 * options$trendsCIwidth))

    if (options$trendsCompare) {
      trendsSummary$addColumnInfo(name = "stat",  title = ifelse(colnames(emmTest)[ncol(emmTest) - 1] == "t.ratio", gettext("t"), gettext("z")), type = "number")
      trendsSummary$addColumnInfo(name = "pval",  title = gettext("p"), type = "pvalue")
      trendsSummary$addFootnote(.mmMessageTestNull(options$trendsCompareTo), symbol = "\u2020", colNames = "pval")

      if (options$pvalVS) {
        trendsSummary$addColumnInfo(name = "pvalVS", title = gettext("VS-MPR"), type = "number")
        trendsSummary$addFootnote(.mmMessageVovkSellke(), symbol = "\u002A", colNames = "pvalVS")
      }
    }
  } else if (type %in% c("BLMM", "BGLMM")) {
    trendsSummary$addColumnInfo(name = "lowerCI", title = gettext("Lower"), type = "number", overtitle = gettextf("%s%% HPD", 100 * options$trendsCIwidth))
    trendsSummary$addColumnInfo(name = "upperCI", title = gettext("Upper"), type = "number", overtitle = gettextf("%s%% HPD", 100 * options$trendsCIwidth))
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

      if (options$trendsCompare) {
        tempRow$stat <- emmTest[i, grep("ratio", colnames(emmTest))]
        tempRow$pval <- emmTest[i, "p.value"]
        if (options$pvalVS)
          tempRow$pvalVS <- VovkSellkeMPR(tempRow$pval)

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


  EMMCsummary <- createJaspTable(title = gettext("Contrasts"))

  EMMCsummary$position <- ifelse(what == "Means", 8, 10)

  dependencies <- .mmSwichDependencies(type)
  if (type %in% c("GLMM", "BGLMM") && what == "Means")
    dependencies <- c(dependencies, "marginalMeansResponse")

  if (what == "Means") {
    if (type %in% c("LMM", "GLMM"))
      dependenciesAdd <- c(
        "marginalMeans",
        "marginalMeansDf",
        "marginalMeansSD",
        "marginalMeansCompare",
        "marginalMeansCompareTo",
        "marginalMeansContrast",
        "marginalMeansCIwidth",
        "pvalVS",
        "marginalMeansOverride",
        "Contrasts",
        "marginalMeansAdjustment"
      )
    else
      dependenciesAdd <- c(
        "marginalMeans",
        "marginalMeansSD",
        "marginalMeansContrast",
        "marginalMeansCIwidth",
        "Contrasts"
      )

  } else if (what == "Trends") {
    if (type %in% c("LMM", "GLMM"))
      dependenciesAdd <- c(
        "trendsVariables",
        "trendsTrend",
        "trendsDf",
        "trendsSD",
        "trendsCompare",
        "trendsCompareTo",
        "trendsContrast",
        "trendsContrasts",
        "trendsCIwidth",
        "pvalVS",
        "trendsOverride",
        "trendsAdjustment"
      )
    else
      dependenciesAdd <-c(
        "trendsVariables",
        "trendsTrend",
        "trendsSD",
        "trendsCIwidth",
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
    EMMCsummary$addColumnInfo(name = "stat",     title = gettext("z"),        type = "number")
    EMMCsummary$addColumnInfo(name = "pval",     title = gettext("p"),        type = "pvalue")

    if (options$pvalVS) {
      EMMCsummary$addColumnInfo(name = "pvalVS", title = gettext("VS-MPR"),   type = "number")
      EMMCsummary$addFootnote(.mmMessageVovkSellke(), symbol = "\u002A", colNames = "pvalVS")
    }

  } else if (type %in% c("BLMM", "BGLMM")) {

    if (what == "Means")
      overtitle <- gettextf("%s%% HPD", 100 * options$marginalMeansCIwidth)
    else
      overtitle <- gettextf("%s%% HPD", 100 * options$trendsCIwidth)

    EMMCsummary$addColumnInfo(name = "contrast",  title = "", type = "string")
    EMMCsummary$addColumnInfo(name = "estimate",  title = gettext("Estimate"), type = "number")
    EMMCsummary$addColumnInfo(name = "lowerCI",   title = gettext("Lower"),    type = "number", overtitle = overtitle)
    EMMCsummary$addColumnInfo(name = "upperCI",   title = gettext("Upper"),    type = "number", overtitle = overtitle)

  }

  # Columns have been specified, show to user
  jaspResults[[paste0("contrasts", what)]] <- EMMCsummary

  if (what == "Means") {
    selectedContrasts  <- options$Contrasts
    selectedAdjustment <- options$marginalMeansAdjustment

    if (type %in% c("GLMM", "BGLMM"))
      selectedResponse   <- options$marginalMeansResponse



  } else if (what == "Trends") {
    selectedContrasts  <- options$trendsContrasts
    selectedAdjustment <- options$trendsAdjustment
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
        stat     =  emmContrast[i, ncol(emmContrast) - 1],
        pval     =  emmContrast[i, "p.value"]
      )

      if (options$pvalVS)
        tempRow$pvalVS <- VovkSellkeMPR(tempRow$pval)

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
.mmReadDataB      <- function(dataset, options, type = "BLMM") {

  if (!is.null(dataset))
    return(dataset)

  if (type == "LMM") {

    return(
      readDataSetToEnd(
        columns.as.numeric = options$dependentVariable,
        columns.as.factor  = c(options$fixedVariables, options$randomVariables)
      )
    )

  } else if (type == "GLMM") {
    if (options$dependentVariableAggregation == "") {

      return(readDataSetToEnd(
        columns = c(
          options$dependentVariable,
          options$fixedVariables,
          options$randomVariables
        )
      ))

    } else {

      return(readDataSetToEnd(
        columns = c(
          options$dependentVariable,
          options$fixedVariables,
          options$randomVariables,
          options$dependentVariableAggregation
        )
      ))

    }
  }
}
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
      chains            = options$chains,
      iter              = options$iteration,
      warmup            = options$warmup,
      adapt_delta       = options$adapt_delta,
      control           = list(max_treedepth = options$max_treedepth),
      seed              = .getSeedJASP(options),
      model_fun         = "lmer"
    ))

  } else if (type == "BGLMM") {

    # needs to be evaluated in the global environment
    glmmLink      <<- options$link
    if (options$family == "neg_binomial_2") {
      glmmFamily <<- rstanarm::neg_binomial_2(link = glmmLink)
    } else if (options$family == "betar") {
      glmmFamily <<- mgcv::betar(link = glmmLink)
    } else if (options$family != "binomialAgg") {
      tempFamily <<- options$family
      glmmFamily <<- eval(call(tempFamily, glmmLink))
    }

    # I wish there was a better way to do this
    if (options$family == "binomialAgg") {
      glmmWeight <<- dataset[, options$dependentVariableAggregation]

      model <- try(stanova::stanova(
        formula           = as.formula(modelFormula$modelFormula),
        check_contrasts   = "contr.bayes",
        data              = dataset,
        chains            = options$chains,
        iter              = options$iteration,
        warmup            = options$warmup,
        adapt_delta       = options$adapt_delta,
        control           = list(max_treedepth = options$max_treedepth),
        weights           = glmmWeight,
        family            = eval(call("binomial", glmmLink)),
        seed              = .getSeedJASP(options),
        model_fun         = "glmer"
      ))

    } else {

      model <- try(stanova::stanova(
        formula           = as.formula(modelFormula$modelFormula),
        check_contrasts   = "contr.bayes",
        data              = dataset,
        chains            = options$chains,
        iter              = options$iteration,
        warmup            = options$warmup,
        adapt_delta       = options$adapt_delta,
        control           = list(max_treedepth = options$max_treedepth),
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
      .quitAnalysis(paste0(gettext("Please, report the following error message at JASP GitHub https://github.com/jasp-stats/jasp-issues: "), model))
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

  if (!is.null(jaspResults[["fitStats"]]))
    return()

  model <- jaspResults[["mmModel"]]$object$model

  fitSummary <- createJaspContainer("Model summary")
  fitSummary$position <- 2
  fitSummary$dependOn(c(.mmSwichDependencies(type), "fitStats"))

  jaspResults[["fitSummary"]] <- fitSummary

  ### fit statistics
  fitStats <- createJaspTable(title = gettext("Fit Statistics"))
  fitStats$position <- 1

  fitStats$addColumnInfo(name = "waic",   title = gettext("WAIC"),      type = "number")
  fitStats$addColumnInfo(name = "waicSE", title = gettext("SE (WAIC)"), type = "number")
  fitStats$addColumnInfo(name = "loo",    title = gettext("LOO"),       type = "number")
  fitStats$addColumnInfo(name = "looSE",  title = gettext("SE (LOO)"),  type = "number")

  jaspResults[["fitSummary"]][["fitStats"]] <- fitStats

  waic <- loo::waic(model)
  loo  <- loo::loo(model)


  nBadWAIC <- sum(waic$pointwise[,2] > 0.4)
  nBadLOO  <- length(loo::pareto_k_ids(loo, threshold = .7))


  if (nBadWAIC > 0)
    fitStats$addFootnote(.mmMessageBadWAIC(nBadWAIC), symbol = gettext("Warning:"))
  if (nBadLOO > 0)
    fitStats$addFootnote(.mmMessageBadLOO(nBadLOO), symbol = gettext("Warning:"))


  tempRow <- list(
    waic   = waic$estimates["waic", "Estimate"],
    waicSE = waic$estimates["waic", "SE"],
    loo    = loo$estimates["looic", "Estimate"],
    looSE  = loo$estimates["looic", "SE"]
  )

  fitStats$addRows(tempRow)

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
  REsummary$dependOn(c(.mmSwichDependencies(type), "showRE", "summaryCI"))

  ### keep this if we decide to change things
  #modelSummary <- rstan::summary(model$stanfit, probs = c(.5-options$summaryCI/2, .5+options$summaryCI/2))$summary
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
  FEsummary$dependOn(c(.mmSwichDependencies(type), "showFE", "summaryCI"))

  FEsummary$addColumnInfo(name = "term",     title = "Term",           type = "string")
  FEsummary$addColumnInfo(name = "estimate", title = "Estimate",       type = "number")
  FEsummary$addColumnInfo(name = "se",       title = "SE",             type = "number")
  FEsummary$addColumnInfo(name = "lowerCI",  title = gettext("Lower"), type = "number", overtitle = gettextf("%s%% CI", 100 * options$summaryCI))
  FEsummary$addColumnInfo(name = "upperCI",  title = gettext("Upper"), type = "number", overtitle = gettextf("%s%% CI", 100 * options$summaryCI))
  FEsummary$addColumnInfo(name = "rhat",     title = "R-hat",          type = "number")
  FEsummary$addColumnInfo(name = "neff",     title = "ESS",            type = "number")

  jaspResults[["FEsummary"]] <- FEsummary

  modelSummary <- rstan::summary(
    model$stanfit,
    probs = c(.5 - options$summaryCI / 2, .5 + options$summaryCI / 2)
  )$summary
  namesSummary <- rownames(modelSummary)
  feSummary    <- modelSummary[!grepl("b[", namesSummary, fixed = T) & !namesSummary %in% c("mean_PPD", "log-posterior") & namesSummary != "sigma" & !grepl("Sigma[", namesSummary, fixed = TRUE), ]

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
        probs = c(.50 - options$summaryCI / 2, .50, .50 + options$summaryCI / 2),
        diff_intercept = options$show == "deviation"
      )

    if (any(sapply(modelSummary, is.null)))
      .quitAnalysis("The model summary could not be produced. Please, verify that the predictors and the outcome variable have reasonable scaling  and that there are sufficient observations for each factor level.")

  } else {
    # dummy object for creating empty summary
    modelSummary <- list("Model summary" = matrix(NA, nrow = 0, ncol = 0))
  }

  STANOVAsummary <- createJaspContainer(title = "")
  STANOVAsummary$position <- 1
  STANOVAsummary$dependOn(c(.mmSwichDependencies(type), "summaryCI", "show"))

  jaspResults[["STANOVAsummary"]] <- STANOVAsummary

  # go over each random effect grouping factor
  for (i in 1:length(modelSummary)) {
    tempSummary <- modelSummary[[i]]

    if (names(modelSummary)[i] == "Model summary") {

      varName   <- gettext("Model summary")
      tableName <- varName

    } else if (names(modelSummary)[i] == "(Intercept)") {

      varName   <- gettext("Intercept")
      tableName <- varName

    } else {

      varName   <- jaspBase::gsubInteractionSymbol(names(modelSummary)[i])

      if (options$show == "deviation") {
        tableName <- gettextf("%s (differences from intercept)",varName)

      } else if (options$show == "mmeans") {

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
    tempTable$addColumnInfo(name = "lowerCI",  title = gettext("Lower"),      type = "number", overtitle = gettextf("%s%% CI", 100 * options$summaryCI))
    tempTable$addColumnInfo(name = "upperCI",  title = gettext("Upper"),      type = "number", overtitle = gettextf("%s%% CI", 100 * options$summaryCI))
    tempTable$addColumnInfo(name = "rhat",     title = gettext("R-hat"),      type = "number")
    tempTable$addColumnInfo(name = "ess_bulk", title = gettext("ESS (bulk)"), type = "number")
    tempTable$addColumnInfo(name = "ess_tail", title = gettext("ESS (tail)"), type = "number")

    if (tableName == "Model summary") {

      if (options$dependentVariable != "" && length(options$fixedVariables) > 0 && length(options$randomVariables) == 0)
        tempTable$addFootnote(.mmMessageMissingRE())

      if (type == "BGLMM" && options$family == "binomialAgg" && options$dependentVariableAggregation == "")
        tempTable$addFootnote(.mmMessageMissingAgg())


      if (jaspBase::isTryError(jaspResults[["mmModel"]]$object$model))
        STANOVAsummary$setError(gettext("The model could not be estimated. Please, check the options and dataset for errors."))

      return()
    }

    for (j in 1:nrow(tempSummary)) {

      tempRow <- list(
        estimate   = tempSummary$Mean[j],
        se         = tempSummary$MAD_SD[j],
        lowerCI    = tempSummary[j, paste0((.50 - options$summaryCI / 2) *
                                             100, "%")],
        upperCI    = tempSummary[j, paste0((.50 + options$summaryCI / 2) *
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
    minESS        <- min(rstan::summary(model$stanfit)$summary[, "n_eff"])

    if (any(is.infinite(rstan::summary(model$stanfit)$summary[, "Rhat"])))
      maxRhat     <- Inf
    else
      maxRhat     <- max(rstan::summary(model$stanfit)$summary[, "Rhat"])


    if (divIterations != 0)
      tempTable$addFootnote(.mmMessageDivergentIter(divIterations), symbol = gettext("Warning:"))

    if (length(lowBmfi) != 0)
      tempTable$addFootnote(.mmMessageLowBMFI(length(lowBmfi)), symbol = gettext("Warning:"))

    if (maxTreedepth != 0)
      tempTable$addFootnote(.mmMessageMaxTreedepth(maxTreedepth))

    if (maxRhat > 1.01)
      tempTable$addFootnote(.mmMessageMaxRhat(maxRhat), symbol = gettext("Warning:"))

    if (minESS < 100 * options$chains || is.nan(minESS))
      tempTable$addFootnote(.mmMessageMinESS(minESS, 100 * options$chains), symbol = gettext("Warning:"))


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

    if (type == "BGLMM")
      tempTable$addFootnote(.mmMessageGLMMtype(options$family, options$link))

  }

  return()
}
.mmDiagnostics    <- function(jaspResults, options, dataset, type = "BLMM") {

  if (!is.null(jaspResults[["diagnosticPlots"]]))
    return()

  diagnosticPlots <- createJaspContainer(title = gettext("Sampling diagnostics"))
  diagnosticPlots$position <- 5
  diagnosticPlots$dependOn(c(.mmSwichDependencies(type), "samplingPlot", "samplingVariable1", "samplingVariable2"))
  jaspResults[["diagnosticPlots"]] <- diagnosticPlots


  if (options$samplingPlot == "stan_scat" && length(options$samplingVariable2) == 0) {
    diagnosticPlots[["emptyPlot"]] <- createJaspPlot()
    return()
  }

  model     <- jaspResults[["mmModel"]]$object$model

  if (options$samplingPlot != "stan_scat")
    pars <- paste0(unlist(options$samplingVariable1), collapse = ":")
  else
    pars <- c(
      paste0(unlist(options$samplingVariable1), collapse = ":"),
      paste0(unlist(options$samplingVariable2), collapse = ":")
    )


  plotData <- .mmGetPlotSamples(model = model, pars = pars, options = options)

  for (i in 1:length(plotData)) {

    if (names(plotData)[i] == "Intercept") {
      varName <- gettext("Intercept")
    } else {
      varName <- strsplit(as.character(pars), ":")
      varName <- sapply(varName, function(x) paste(unlist(strsplit(x, ",")), collapse = ":"))
      varName <- sapply(varName, function(x) gsub(" ", "", x, fixed = TRUE))
      varName <- sapply(varName, function(x) .mmVariableNames(x, options$fixedVariables))
      varName <- paste0(varName, collapse = " by ")
    }

    plots  <- createJaspPlot(title = varName, width = 400, height = 300)

    p <- switch(
      options$samplingPlot,
      "stan_trace" = .rstanPlotTrace(plotData[[i]]),
      "stan_scat"  = .rstanPlotScat(plotData[[i]]),
      "stan_hist"  = .rstanPlotHist(plotData[[i]]),
      "stan_dens"  = .rstanPlotDens(plotData[[i]]),
      "stan_ac"    = .rstanPlotAcor(plotData[[i]])
    )

    if (options$samplingPlot %in% c("stan_hist", "stan_dens")) {
      p <- jaspGraphs::themeJasp(p, sides = "b")
      p <- p + ggplot2::theme(
        axis.title.y = ggplot2::element_blank(),
        axis.text.y  = ggplot2::element_blank(),
        axis.ticks.y = ggplot2::element_blank()
      )
    } else {
      p <- jaspGraphs::themeJasp(p)
    }

    if (options$samplingPlot == "stan_trace")
      p <- p + ggplot2::theme(plot.margin = ggplot2::margin(r = 10 * (nchar(options$iteration - options$warmup) - 2)))

    plots$plotObject <- p

    diagnosticPlots[[names(plotData)[i]]] <- plots
  }

  return()
}

# helper functions
.mmVariableNames      <- function(varName, variables) {

  if (varName == "(Intercept)")
    return(gettext("Intercept"))

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

  matrixDiff <- stanova::stanova_samples(model, return = "array", diff_intercept = options$show == "deviation")

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
          iteration = rep(1:dim(samples)[1], dim(samples)[3])
        ),
        nchains = options$chains,
        nparams = 1,
        warmup  = 0
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
            iteration = c(rep(
              1:dim(samples1)[1], dim(samples1)[3]
            ),
            rep(
              1:dim(samples2)[1], dim(samples2)[3]
            ))
          ),
          nchains = options$chains,
          nparams = 2,
          warmup  = 0
        )
      }
    }

  }

  return(plotData)
}
# as explained in ?is.integer
.is.wholenumber <- function(x, tol = .Machine$double.eps^0.5)  abs(x - round(x)) < tol
# modified rstan plotting functions
.rstanPlotHist  <- function(plotData) {

  dots      <- rstan:::.add_aesthetics(list(), c("fill", "color"))
  thm       <- rstan:::rstanvis_hist_theme()
  base      <- ggplot2::ggplot(plotData$samp, ggplot2::aes_string(x = "value"))
  graph     <- base + do.call(ggplot2::geom_histogram, dots) +
    thm + ggplot2::xlab(unique(plotData$samp$parameter))

  return(graph)
}
.rstanPlotTrace <- function(plotData) {

  thm  <- rstan:::rstanvis_theme()
  clrs <- rep_len(rstan:::rstanvis_aes_ops("chain_colors"), plotData$nchains)
  base <- ggplot2::ggplot(plotData$samp,ggplot2::aes_string(x = "iteration", y = "value", color = "chain"))

  graph <- base + ggplot2::geom_path() + ggplot2::scale_color_manual(values = clrs) +
    ggplot2::labs(x = "", y = levels(plotData$samp$parameter)) + thm

  graph <- graph + ggplot2::scale_x_continuous(
    breaks = jaspGraphs::getPrettyAxisBreaks(c(1,max(plotData$samp$iteration))))

  return(graph)
}
.rstanPlotDens  <- function(plotData, separate_chains = TRUE) {

  clrs <- rep_len(rstan:::rstanvis_aes_ops("chain_colors"), plotData$nchains)
  thm  <- rstan:::rstanvis_hist_theme()
  base <- ggplot2::ggplot(plotData$samp, ggplot2::aes_string(x = "value"))

  if (!separate_chains) {
    dots <- rstan:::.add_aesthetics(list(), c("fill", "color"))
    graph <- base + do.call(ggplot2::geom_density, dots) + thm
  } else {
    dots <- rstan:::.add_aesthetics(list(), c("color", "alpha"))
    dots$mapping <- ggplot2::aes_string(fill = "chain")
    graph <- base + do.call(ggplot2::geom_density, dots) +
      ggplot2::scale_fill_manual(values = clrs) + thm
  }

  graph <- graph + ggplot2::xlab(unique(plotData$samp$parameter))

  return(graph)
}
.rstanPlotScat  <- function(plotData) {

  thm  <- rstan:::rstanvis_theme()
  dots <- rstan:::.add_aesthetics(list(), c("fill", "pt_color", "pt_size", "alpha", "shape"))

  p1    <- plotData$samp$parameter == levels(plotData$samp$parameter)[1]
  p2    <- plotData$samp$parameter == levels(plotData$samp$parameter)[2]
  val1  <- plotData$samp[p1, "value"]
  val2  <- plotData$samp[p2, "value"]
  df    <- data.frame(x = val1, y = val2)
  base  <- ggplot2::ggplot(df, ggplot2::aes_string("x", "y"))
  graph <- base + do.call(ggplot2::geom_point, dots) + ggplot2::labs(
    x = levels(plotData$samp$parameter)[1],
    y = levels(plotData$samp$parameter)[2]
  ) + thm

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
    "dependentVariable",
    "fixedEffects",
    "randomEffects",
    "randomVariables",
    "method",
    "bootstrapSamples",
    "test_intercept",
    "type"
  )
.mmDependenciesGLMM  <- c(
  .mmDependenciesLMM,
  "dependentVariableAggregation",
  "family",
  "link"
)
.mmDependenciesBLMM  <-
  c(
    "dependentVariable",
    "fixedEffects",
    "randomEffects",
    "randomVariables",
    "warmup",
    "iteration",
    "adapt_delta",
    "max_treedepth",
    "chains",
    "seed",
    "setSeed"
  )
.mmDependenciesBGLMM <- c(
  .mmDependenciesBLMM,
  "dependentVariableAggregation",
  "family",
  "link"
)
