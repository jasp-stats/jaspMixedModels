context("Linear Mixed Models -- plot estimates table cache")

.plotEstimatesFixture <- data.frame(
  y = c(
    7.7, 8.3, 10.7, 11.3, 8.7, 9.3, 13.7, 14.3,
    9.7, 10.3, 14.2, 14.8, 9.7, 10.3, 13.2, 13.8,
    10.7, 11.3, 15.7, 16.3, 11.7, 12.3, 14.7, 15.3,
    9.7, 10.3, 14.7, 15.3, 10.7, 11.3, 17.7, 18.3,
    11.7, 12.3, 18.2, 18.8, 11.7, 12.3, 17.2, 17.8,
    12.7, 13.3, 19.7, 20.3, 13.7, 14.3, 18.7, 19.3
  ),
  Time = rep(c("Pre", "Pre", "Post", "Post"), 12),
  Group = rep(c("A", "B"), each = 24),
  Subject = rep(c(paste0("A", 1:6), paste0("B", 1:6)), each = 4)
)
class(.plotEstimatesFixture) <- c("plotEstimatesFixture", "data.frame")

as.matrix.plotEstimatesFixture <- function(x, ...) {
  # The module's collinearity callback applies as.numeric to the complete data
  # matrix. Encode categorical columns there without changing their model labels.
  data.matrix(as.data.frame(x), ...)
}
registerS3method(
  "as.matrix",
  "plotEstimatesFixture",
  as.matrix.plotEstimatesFixture,
  envir = asNamespace("base")
)

.plotEstimatesOptions <- jaspTools::analysisOptions("MixedModelsLMM")
.plotEstimatesOptions$dependent <- "y"
.plotEstimatesOptions$dependent.types <- "scale"
.plotEstimatesOptions$fixedVariables <- c("Time", "Group")
.plotEstimatesOptions$fixedVariables.types <- c("nominal", "nominal")
.plotEstimatesOptions$randomVariables <- "Subject"
.plotEstimatesOptions$randomVariables.types <- "nominal"
.plotEstimatesOptions$fixedEffects <- list(
  list(components = "Time"),
  list(components = "Group"),
  list(components = c("Time", "Group"))
)
.plotEstimatesOptions$randomEffects <- list(
  list(
    correlations = TRUE,
    randomComponents = list(
      list(randomSlopes = TRUE, value = "Intercept"),
      list(randomSlopes = FALSE, value = "Time"),
      list(randomSlopes = FALSE, value = "Group"),
      list(randomSlopes = FALSE, value = c("Time", "Group"))
    ),
    value = "Subject"
  )
)
.plotEstimatesOptions$plotHorizontalAxis <- list(list(variable = "Time"))
.plotEstimatesOptions$plotSeparateLines <- list(list(variable = "Group"))
.plotEstimatesOptions$plotSeparatePlots <- list()
.plotEstimatesOptions$plotBackgroundData <- "Subject"
.plotEstimatesOptions$plotBackgroundData.types <- "nominal"
.plotEstimatesOptions$plotEstimatesTable <- FALSE
.plotEstimatesOptions$plotTransparency <- 0.7
.plotEstimatesOptions$plotDodge <- 0.3
.plotEstimatesOptions$plotElementWidth <- 1
.plotEstimatesOptions$plotJitterHeight <- 0
.plotEstimatesOptions$plotJitterWidth <- 0.1
.plotEstimatesOptions$plotLegendPosition <- "none"
.plotEstimatesOptions$plotRelativeSizeData <- 1
.plotEstimatesOptions$plotRelativeSizeText <- 1.5
.plotEstimatesOptions$plotBackgroundColor <- "darkgrey"
.plotEstimatesOptions$plotTheme <- "jasp"
.plotEstimatesOptions$plotLevelsByColor <- FALSE
.plotEstimatesOptions$plotCiType <- "model"
.plotEstimatesOptions$plotCiLevel <- 0.95
.plotEstimatesOptions$plotBackgroundElement <- "jitter"
.plotEstimatesOptions$plotLevelsByShape <- TRUE
.plotEstimatesOptions$plotLevelsByLinetype <- TRUE
.plotEstimatesOptions$plotLevelsByFill <- FALSE
.plotEstimatesOptions$fixedEffectEstimate <- FALSE
.plotEstimatesOptions$randomEffectEstimate <- FALSE
.plotEstimatesOptions$varianceCorrelationEstimate <- FALSE
.plotEstimatesOptions$modelSummary <- FALSE
.plotEstimatesOptions$factorContrast <- "sum"
.plotEstimatesOptions$testMethod <- "satterthwaite"
.plotEstimatesOptions$includeIntercept <- TRUE
.plotEstimatesOptions$bootstrapSamples <- 500
.plotEstimatesOptions$vovkSellke <- FALSE
.plotEstimatesOptions$seed <- 1
.plotEstimatesOptions$setSeed <- FALSE
.plotEstimatesOptions$interceptTest <- FALSE
.plotEstimatesOptions$type <- "3"
.plotEstimatesOptions$marginalMeansTerms <- list()
.plotEstimatesOptions$marginalMeansContrast <- FALSE
.plotEstimatesOptions$trendsTrendVariable <- list()
.plotEstimatesOptions$trendsVariables <- list()
.plotEstimatesOptions$trendsContrast <- FALSE

.plotEstimatesDvWarning <- "Additional arguments ignored: dv"
.plotEstimatesDeprecationWarnings <- c(
  "the ‘findbars’ function has moved to the reformulas package. Please update your imports, or ask an upstream package maintainer to do so.\nThis warning is displayed once per session.",
  "Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.\nℹ Please use `linewidth` instead.\nℹ The deprecated feature was likely used in the afex package.\n  Please report the issue at <https://github.com/singmann/afex/issues>.",
  "`themeJasp()` was deprecated in jaspGraphs 0.5.2.6.\nℹ Please use `themeJaspRaw()` instead.\nℹ The deprecated feature was likely used in the jaspMixedModels package.\n  Please report the issue to the authors."
)

.plotEstimatesDeprecationsSeen <- character()

.expectPlotEstimatesWarnings <- function(code, expectedDvWarnings) {
  warnings <- character()
  value <- withCallingHandlers(
    force(code),
    warning = function(warning) {
      warningMessage <- conditionMessage(warning)
      if (identical(warningMessage, .plotEstimatesDvWarning) ||
          warningMessage %in% .plotEstimatesDeprecationWarnings) {
        warnings <<- c(warnings, warningMessage)
        if (warningMessage %in% .plotEstimatesDeprecationWarnings)
          .plotEstimatesDeprecationsSeen <<- c(.plotEstimatesDeprecationsSeen, warningMessage)
        invokeRestart("muffleWarning")
      }
    }
  )

  expect_identical(sum(warnings == .plotEstimatesDvWarning), expectedDvWarnings)
  value
}

.runCachedPlotEstimatesAnalysis <- function(options) {
  args <- jaspTools:::fetchRunArgs("MixedModelsLMM", options)
  args$name <- "MixedModelsLMMPlotEstimatesToggle"
  resultObject <- suppressMessages(
    .expectPlotEstimatesWarnings(
      do.call(jaspBase::runJaspResults, args),
      expectedDvWarnings = 1L
    )
  )
  jsonResults <- jaspTools:::getJsonResultsFromJaspResults(resultObject)

  list(
    object = resultObject,
    results = jaspTools:::processJsonResults(jsonResults)
  )
}

.rerunCachedPlotEstimatesAnalysis <- function(resultObject, options) {
  resultObject$.__enclos_env__$private$changeOptions(jsonlite::toJSON(options))
  expectedDvWarnings <- if (options$plotEstimatesTable) 2L else 1L
  suppressMessages(
    .expectPlotEstimatesWarnings(
      jaspMixedModels:::MixedModelsLMMInternal(resultObject, .plotEstimatesFixture, options),
      expectedDvWarnings = expectedDvWarnings
    )
  )
  resultObject$.__enclos_env__$private$complete()

  jsonResults <- jaspTools:::getJsonResultsFromJaspResults(resultObject)
  list(
    object = resultObject,
    results = jaspTools:::processJsonResults(jsonResults)
  )
}

.plotEstimatesModelSignature <- function(resultObject) {
  model <- resultObject[["mmModel"]]$object$model$full_model
  if (is.list(model))
    model <- model[[length(model)]]

  c(
    fixedEffects = unname(lme4::fixef(model)),
    randomEffects = unname(lme4::getME(model, "theta")),
    residualSd = stats::sigma(model)
  )
}

.expectPlotEstimatesTable <- function(results) {
  estimates <- results$results$EstimatesTable
  expect_identical(estimates$status, "complete")
  if (is.null(estimates))
    return(invisible())

  rows <- estimates$data
  expect_identical(vapply(rows, `[[`, character(1), "Time"), c("Post", "Pre", "Post", "Pre"))
  expect_identical(vapply(rows, `[[`, character(1), "Group"), c("A", "A", "B", "B"))
  expect_equal(vapply(rows, `[[`, numeric(1), "mean"), c(14, 10, 18, 12), tolerance = 1e-6)
  expect_equal(
    vapply(rows, `[[`, numeric(1), "lowerCI"),
    c(12.628869845176645, 8.628869845176645, 16.628869845176688, 10.628869845176686),
    tolerance = 1e-6
  )
  expect_equal(
    vapply(rows, `[[`, numeric(1), "upperCI"),
    c(15.371130154823422, 11.371130154823419, 19.371130154823469, 13.371130154823467),
    tolerance = 1e-6
  )
}

test_that("plot estimates table follows checkbox changes after the plot completes", {
  oldLanguage <- Sys.getenv("LANGUAGE")
  oldLang <- Sys.getenv("LANG")
  oldLegacyRngKind <- getOption("jaspLegacyRngKind")
  options(jaspLegacyRngKind = FALSE)
  .plotEstimatesDeprecationsSeen <<- character()
  on.exit({
    jaspTools:::.resetRunTimeInternals()
    Sys.setenv(LANGUAGE = oldLanguage, LANG = oldLang)
    options(jaspLegacyRngKind = oldLegacyRngKind)
  }, add = TRUE)

  jaspTools:::initAnalysisRuntime(
    dataset = .plotEstimatesFixture,
    options = .plotEstimatesOptions,
    makeTests = FALSE,
    encodedDataset = TRUE
  )

  initial <- .runCachedPlotEstimatesAnalysis(.plotEstimatesOptions)
  expect_identical(initial$results$results$plots$status, "complete")
  expect_null(initial$results$results$EstimatesTable)

  initialModel <- .plotEstimatesModelSignature(initial$object)
  initialAnova <- initial$results$results$ANOVAsummary$data

  enabledOptions <- .plotEstimatesOptions
  enabledOptions$plotEstimatesTable <- TRUE
  enabled <- .rerunCachedPlotEstimatesAnalysis(initial$object, enabledOptions)

  .expectPlotEstimatesTable(enabled$results)
  expect_equal(.plotEstimatesModelSignature(enabled$object), initialModel, tolerance = 1e-12)
  expect_equal(enabled$results$results$ANOVAsummary$data, initialAnova, tolerance = 1e-12)

  disabled <- .rerunCachedPlotEstimatesAnalysis(enabled$object, .plotEstimatesOptions)
  expect_null(disabled$results$results$EstimatesTable)
  expect_equal(.plotEstimatesModelSignature(disabled$object), initialModel, tolerance = 1e-12)
  expect_equal(disabled$results$results$ANOVAsummary$data, initialAnova, tolerance = 1e-12)

  reenabled <- .rerunCachedPlotEstimatesAnalysis(disabled$object, enabledOptions)
  .expectPlotEstimatesTable(reenabled$results)
  expect_equal(reenabled$results$results$EstimatesTable$data, enabled$results$results$EstimatesTable$data, tolerance = 1e-12)
  expect_equal(.plotEstimatesModelSignature(reenabled$object), initialModel, tolerance = 1e-12)
  expect_equal(reenabled$results$results$ANOVAsummary$data, initialAnova, tolerance = 1e-12)

  deprecationCounts <- table(factor(
    .plotEstimatesDeprecationsSeen,
    levels = .plotEstimatesDeprecationWarnings
  ))
  expect_true(all(deprecationCounts <= 1L), info = "Plot deprecations must be emitted at most once per session")
})
