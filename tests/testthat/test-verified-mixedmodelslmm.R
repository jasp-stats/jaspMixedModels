context("Linear Mixed Models -- Verification project")

## Testing standard LMM ---

options <- jaspTools::analysisOptions("MixedModelsLMM")
options$contrasts <- list(list(isContrast=TRUE, levels=list(), name="Contrast 1", values=list()))
options$bootstrap_samples <- 500
options$dependent <- "rt"
options$modelSummary <- TRUE

options$fixedEffects <- list(list(components="task"),
                             list(components="stimulus"),
                             list(components=c("task", "stimulus")))
options$includeIntercept <- TRUE
options$factorContrast <- "sum"
options$fixedVariables <- c("task", "stimulus")
options$testMethod <- "satterthwaite"

# Probably not necessary
options$plotTransparency <- 0.7
options$plotdodge <- 0.3
options$plotElementWidth <- 1
options$plotJitterHeight <- 0
options$plotJitterWidth <- 0.1
options$plotLegendPosition <- "none"
options$plotRelativeSizeData <- 1
options$plotRelativeSizeText <- 1.5
options$plotBackgroundData <- "id"
options$plotBackgroundColor <- "darkgrey"
options$plotCiType <- "model"
options$plotCiLevel <- 0.95
options$plotEstimatesTable <- FALSE
options$plotBackgroundElement <- "jitter"
options$plotLevelsByColor <- FALSE
options$plotLevelsByFill <- FALSE
options$plotLevelsByLinetype <- TRUE
options$plotLevelsByShape <- TRUE
options$plotSeparatePlots <- list()
options$plotTheme <- "jasp"
options$plotSeparateLines <- list()
options$plotHorizontalAxis <- list()

options$vovkSellke <- FALSE

randomComponents <- list(list(randomSlopes=FALSE, value="task"),
                         list(randomSlopes=TRUE, value="stimulus"),
                         list(randomSlopes=FALSE, value=c("task", "stimulus"))
)


options$randomEffects <- list(list(correlations=TRUE, randomComponents=randomComponents, value="id"))
options$randomVariables <- "id"
options$seed <- 1
options$setSeed <- FALSE
options$fixedEffectEstimate <- TRUE
options$varianceCorrelationEstimate <- FALSE
options$interceptTest <- FALSE
options$trendsTrendVariable <- list()
options$trendsContrasts <- list(list(isContrast=TRUE, levels=list(), name="Contrast 1", values=list()))
options$type <- "3"

results <- jaspTools::runAnalysis("MixedModelsLMM", "LMM.csv", options)

# Main table

# https://jasp-stats.github.io/jasp-verification-project/mixed-models.html
test_that("ANOVA Summary table results match R, SPSS, SAS, Minitab", {
  resultTable <- results$results$ANOVAsummary$data
  jaspTools::expect_equal_tables(
    "test"=resultTable,
    "ref"=list("1, 42.98", "task", 0.000351222533151404, 15.0731435511512, "1, 42.89",
               "stimulus", 5.28695837489198e-12, 88.7031885191476, "1, 42.89",
               "task * stimulus", 2.22107236776295e-07, 37.8428657533078)
  )
})

# Model summary

# https://jasp-stats.github.io/jasp-verification-project/mixed-models.html
test_that("Model Summary table results match R, SPSS, SAS, Minitab", {
  resultTable <- results$results$fitSummary$collection$fitSummary_modelSummary$data
  jaspTools::expect_equal_tables(
    "test"=resultTable,
    "ref"=list(14417.0742986659, 14476.8312824251, 14401.0742986659, 8, -7200.53714933294)
  )
})

# Sample sizes table

# https://jasp-stats.github.io/jasp-verification-project/mixed-models.html
test_that("Sample sizes table results match R, SPSS, SAS, Minitab", {
  resultTable <- results$results$fitSummary$collection$fitSummary_fitSizes$data
  jaspTools::expect_equal_tables(
    "test"=resultTable,
    "ref"=list(45, 12960)
  )
})


# https://jasp-stats.github.io/jasp-verification-project/mixed-models.html
test_that("Fixed effects estimates results match R, SPSS, SAS, Minitab", {
  resultTable <- results$results$FEsummary$data
  jaspTools::expect_equal_tables(
    "test"=resultTable,
    "ref"=list(42.9838615979763, 0.998025488327415, 1.44485879519381e-30, 0.0330673736400386,
               30.1815771398, "Intercept", 42.9838615964832, 0.128381256013046,
               0.000351222533151404, 0.0330673736400386, 3.8824146547157, "task (1)",
               42.890230529555, 0.0879934888513215, 5.28695837489195e-12, 0.00934288324738019,
               9.41823701757115, "stimulus (1)", 42.8902305292584, -0.0574741993899762,
               2.22107236776295e-07, 0.00934288324738019, -6.15165552947398,
               "task (1) * stimulus (1)")
  )
})
