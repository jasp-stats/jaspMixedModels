context("Linear Mixed Models -- Verification project")

## Testing standard LMM --- 

options <- jaspTools::analysisOptions("MixedModelsLMM")
options$Contrasts <- list(list(isContrast=TRUE, levels=list(), name="Contrast 1", values=list()))
options$bootstrap_samples <- 500
options$dependentVariable <- "rt"
options$fitStats <- TRUE

options$fixedEffects <- list(list(components="task"),
                             list(components="stimulus"),
                             list(components=c("task", "stimulus")))
options$fixedVariables <- c("task", "stimulus")
options$method <- "S"

# Probably not necessary
options$plotAlpha <- 0.7
options$plotdodge <- 0.3
options$plotGeomWidth <- 1
options$plotJitterHeight <- 0
options$plotJitterWidth <- 0.1
options$plotLegendPosition <- "none"
options$plotRelativeSize <- 1
options$plotRelativeSizeText <- 1.5
options$plotsAgregatedOver <- "id"
options$plotsBackgroundColor <- "darkgrey"
options$plotsCImethod <- "model"
options$plotsCIwidth <- 0.95
options$plotsEstimatesTable <- FALSE
options$plotsGeom <- "geom_jitter"
options$plotsMappingColor <- FALSE
options$plotsMappingFill <- FALSE
options$plotsMappingLineType <- TRUE
options$plotsMappingShape <- TRUE
options$plotsPanel <- list()
options$plotsTheme <- "JASP"
options$plotsTrace <- list()
options$plotsX <- list()

options$pvalVS <- FALSE

randomComponents <- list(list(randomSlopes=FALSE, value="task"),
                         list(randomSlopes=TRUE, value="stimulus"),
                         list(randomSlopes=FALSE, value=c("task", "stimulus"))
)


options$randomEffects <- list(list(correlations=TRUE, randomComponents=randomComponents, value="id"))
options$randomVariables <- "id"
options$seed <- 1
options$setSeed <- FALSE
options$showFE <- TRUE
options$showRE <- FALSE
options$test_intercept <- FALSE
options$trendsTrend <- list()
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
  resultTable <- results$results$fitSummary$collection$fitSummary_fitStats$data
  jaspTools::expect_equal_tables(
    "test"=resultTable,
    "ref"=list(14417.0742986659, 14476.8312824251, 14375.9948109478, 14401.0742986659,
               8, -7200.53714933294)
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