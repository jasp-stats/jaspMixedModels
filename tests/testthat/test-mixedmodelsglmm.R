context("Generalized Linear Mixed Models")


### bernoulli + logit, default, all selected output using LRT testMethod
{
  skip_on_os("mac")   # problems with precision outside of windows
  skip_on_os("linux") # problems with precision outside of windows
  options <- jaspTools::analysisOptions("MixedModelsGLMM")
  options$contrasts <- list(list(isContrast = FALSE, levels = c("1", "2", "3", "4",
                                                                "5", "6"), name = "cA", values = c("1", "2", "1", "2", "1", "2"
                                                                )), list(isContrast = FALSE, levels = c("1", "2", "3", "4", "5",
                                                                                                        "6"), name = "y_beta", values = c("-1", "-1", "0", "0", "1",
                                                                                                                                          "1")), list(isContrast = TRUE, levels = c("1", "2", "3", "4",
                                                                                                                                                                                    "5", "6"), name = "Contrast 1", values = c("0", "1", "-1", "0",
                                                                                                                                                                                                                               "0", "0")), list(isContrast = TRUE, levels = c("1", "2", "3",
                                                                                                                                                                                                                                                                              "4", "5", "6"), name = "Contrast 2", values = c("1", "-1", "0",
                                                                                                                                                                                                                                                                                                                              "0", "0", "0")))
  options$bootstrapSamples <- 500
  options$dependent <- "Variable5"
  options$modelSummary <- TRUE
  options$fixedEffects <- list(list(components = "Variable1"),
                               list(components = "Variable7"),
                               list(components = c("Variable1", "Variable7")))
  options$includeIntercept <- TRUE
  options$factorContrast <- "sum"
  options$fixedVariables <- c("Variable1", "Variable7")
  options$marginalMeansTerms <- list(list(variable = "Variable1"), list(variable = "Variable7"))
  options$marginalMeansContrast <- TRUE
  options$testMethod <- "likelihoodRatioTest"
  options$plotTransparency <- 0.7
  options$plotDodge <- 0.3
  options$plotElementWidth <- 1
  options$plotJitterHeight <- 0
  options$plotJitterWidth <- 0.1
  options$plotLegendPosition <- "none"
  options$plotRelativeSizeData <- 1
  options$plotRelativeSizeText <- 1.5
  options$plotBackgroundData <- "Variable0"
  options$plotBackgroundColor <- "darkgrey"
  options$plotCiType <- "model"
  options$plotCiLevel <- 0.95
  options$plotEstimatesTable <- TRUE
  options$plotBackgroundElement <- "jitter"
  options$plotLevelsByColor <- FALSE
  options$plotLevelsByFill <- FALSE
  options$plotLevelsByLinetype <- TRUE
  options$plotLevelsByShape <- TRUE
  options$plotSeparatePlots <- list()
  options$plotTheme <- "jasp"
  options$plotSeparateLines <- list()
  options$plotHorizontalAxis <- list(list(variable = "Variable1"))
  options$vovkSellke <- FALSE
  options$randomEffects <- list(
    list(correlations = TRUE,
         randomComponents = list(list(randomSlopes = TRUE, value = "Variable1")),
         value = "Variable0"))
  options$randomEffects[[1]]$randomComponents[[length(options$randomEffects[[1]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$randomEffectEstimate <- FALSE
  options$randomVariables <- "Variable0"
  options$seed <- 1
  options$setSeed <- FALSE
  options$fixedEffectEstimate <- TRUE
  options$varianceCorrelationEstimate <- TRUE
  options$interceptTest <- FALSE
  options$trendsComparison <- TRUE
  options$trendsContrast <- TRUE
  options$trendsContrasts <- list(list(isContrast = FALSE, levels = c("1", "2"), name = "cA",
                                       values = c("1", "2")), list(isContrast = TRUE, levels = c("1",
                                                                                                 "2"), name = "Contrast 1", values = c("-1", "1")))
  options$trendsTrendVariable <- list(list(variable = "Variable7"))
  options$trendsVariables <- list(list(variable = "Variable1"))
  options$type <- "3"
  options$link <- "logit"
  set.seed(1)
  dataset <- structure(list(Variable0 = c(1L, 2L, 3L, 4L, 5L,
                                                       6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L,
                                                       1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L,
                                                       6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L,
                                                       1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L,
                                                       6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L,
                                                       1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L,
                                                       6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L,
                                                       1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L,
                                                       6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L,
                                                       1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L,
                                                       6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L,
                                                       1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L,
                                                       6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L,
                                                       1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L,
                                                       6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L,
                                                       1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L,
                                                       6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L,
                                                       1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L,
                                                       6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L,
                                                       1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L), Variable1 = c(1L,
                                                                                                                            1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
                                                                                                                            2L, 2L, 2L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L,
                                                                                                                            2L, 2L, 2L, 2L, 2L, 2L, 2L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
                                                                                                                            1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 1L, 1L, 1L, 1L, 1L,
                                                                                                                            1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 1L,
                                                                                                                            1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
                                                                                                                            2L, 2L, 2L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L,
                                                                                                                            2L, 2L, 2L, 2L, 2L, 2L, 2L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
                                                                                                                            1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 1L, 1L, 1L, 1L, 1L,
                                                                                                                            1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 1L,
                                                                                                                            1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
                                                                                                                            2L, 2L, 2L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L,
                                                                                                                            2L, 2L, 2L, 2L, 2L, 2L, 2L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
                                                                                                                            1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 1L, 1L, 1L, 1L, 1L,
                                                                                                                            1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 1L,
                                                                                                                            1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
                                                                                                                            2L, 2L, 2L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L,
                                                                                                                            2L, 2L, 2L, 2L, 2L, 2L, 2L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
                                                                                                                            1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L), Variable2 = c(1L,
                                                                                                                                                                                                    1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
                                                                                                                                                                                                    1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
                                                                                                                                                                                                    2L, 2L, 2L, 2L, 2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L,
                                                                                                                                                                                                    3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 1L, 1L, 1L, 1L, 1L,
                                                                                                                                                                                                    1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L,
                                                                                                                                                                                                    2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
                                                                                                                                                                                                    2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L,
                                                                                                                                                                                                    3L, 3L, 3L, 3L, 3L, 3L, 3L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
                                                                                                                                                                                                    1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L,
                                                                                                                                                                                                    2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 3L,
                                                                                                                                                                                                    3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L,
                                                                                                                                                                                                    3L, 3L, 3L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
                                                                                                                                                                                                    1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
                                                                                                                                                                                                    2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L,
                                                                                                                                                                                                    3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 1L,
                                                                                                                                                                                                    1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
                                                                                                                                                                                                    1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
                                                                                                                                                                                                    2L, 2L, 2L, 2L, 2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L,
                                                                                                                                                                                                    3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L), Variable3 = c(1L,
                                                                                                                                                                                                                                                                            1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
                                                                                                                                                                                                                                                                            1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
                                                                                                                                                                                                                                                                            1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
                                                                                                                                                                                                                                                                            1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L,
                                                                                                                                                                                                                                                                            2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
                                                                                                                                                                                                                                                                            2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
                                                                                                                                                                                                                                                                            2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
                                                                                                                                                                                                                                                                            2L, 2L, 2L, 2L, 2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L,
                                                                                                                                                                                                                                                                            3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L,
                                                                                                                                                                                                                                                                            3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L,
                                                                                                                                                                                                                                                                            3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L,
                                                                                                                                                                                                                                                                            3L, 3L, 3L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L,
                                                                                                                                                                                                                                                                            4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L,
                                                                                                                                                                                                                                                                            4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L,
                                                                                                                                                                                                                                                                            4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 5L,
                                                                                                                                                                                                                                                                            5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L,
                                                                                                                                                                                                                                                                            5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L,
                                                                                                                                                                                                                                                                            5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L,
                                                                                                                                                                                                                                                                            5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L), Variable4 = c(-0.653989689,
                                                                                                                                                                                                                                                                                                                                                    0.597847379, 0.53124944, -0.919283666, 1.549214002, -0.964337181,
                                                                                                                                                                                                                                                                                                                                                    0.758624407, -0.633353539, 0.093434858, 0.081944247, 1.251310302,
                                                                                                                                                                                                                                                                                                                                                    1.399815493, -0.942716455, -0.495601118, 0.917930091, 0.344838602,
                                                                                                                                                                                                                                                                                                                                                    -1.226474961, -1.405114801, 0.686194991, 0.017571144, -0.337816215,
                                                                                                                                                                                                                                                                                                                                                    0.384985065, 1.430491376, 1.866825203, 0.752814251, 1.31909783,
                                                                                                                                                                                                                                                                                                                                                    0.447452196, -1.346206879, 0.479402493, -0.848513454, 0.850545592,
                                                                                                                                                                                                                                                                                                                                                    -3.037579176, 0.545769791, -1.182557897, -0.128004891, 1.11267647,
                                                                                                                                                                                                                                                                                                                                                    0.616535768, -0.669227302, 0.076114909, 0.816454623, 0.422781459,
                                                                                                                                                                                                                                                                                                                                                    -0.094856662, -0.374461304, 0.691431944, -1.528712893, 1.05380469,
                                                                                                                                                                                                                                                                                                                                                    -0.545337415, -0.026770503, -2.189233221, -0.616004017, 1.150339483,
                                                                                                                                                                                                                                                                                                                                                    -0.133211268, 0.252652295, 1.399980471, -0.513151105, 1.117392323,
                                                                                                                                                                                                                                                                                                                                                    -0.610869543, 0.331300534, -0.992903801, -0.895568118, 0.623585941,
                                                                                                                                                                                                                                                                                                                                                    1.05882918, -1.58627026, 0.947877674, 2.033833295, 0.179956552,
                                                                                                                                                                                                                                                                                                                                                    1.573438425, -1.694333909, 1.079726669, 1.508240792, 0.90600351,
                                                                                                                                                                                                                                                                                                                                                    -0.290763172, -0.496024515, 1.946237186, -0.893948592, 0.830769682,
                                                                                                                                                                                                                                                                                                                                                    0.440062416, -0.57837005, 1.790515054, 0.137924932, 0.055424081,
                                                                                                                                                                                                                                                                                                                                                    0.547806104, -0.748529992, 1.71335853, 1.808028443, 0.017313744,
                                                                                                                                                                                                                                                                                                                                                    0.988861738, -1.43975293, 0.338108584, -0.365015598, 1.86933575,
                                                                                                                                                                                                                                                                                                                                                    1.699421632, 0.308476418, 1.556020356, -0.952816041, 1.874185874,
                                                                                                                                                                                                                                                                                                                                                    1.104225239, -1.318714635, 1.431532182, 0.756206118, 1.892566353,
                                                                                                                                                                                                                                                                                                                                                    -0.933657521, 1.277498726, 0.407372551, 1.021542579, 0.74476069,
                                                                                                                                                                                                                                                                                                                                                    0.571588797, -0.762850791, -2.287992665, -0.596915582, 2.920177191,
                                                                                                                                                                                                                                                                                                                                                    -0.853565433, -0.771818751, 0.492465518, -0.455610621, 2.667902824,
                                                                                                                                                                                                                                                                                                                                                    1.953870427, 0.14233637, -1.188999386, -0.185194402, 2.751932451,
                                                                                                                                                                                                                                                                                                                                                    0.1714291, 0.495442662, 0.007490023, -1.381723611, -0.360288418,
                                                                                                                                                                                                                                                                                                                                                    1.228175718, 1.270669023, -0.317481349, -1.121300988, 0.248833912,
                                                                                                                                                                                                                                                                                                                                                    -0.936079972, -0.019929997, -0.752375481, 1.745747293, 0.005492604,
                                                                                                                                                                                                                                                                                                                                                    0.407922866, 0.061474844, 0.69299688, 0.597159811, 2.949895836,
                                                                                                                                                                                                                                                                                                                                                    -0.24811046, 0.034494308, -0.78621074, 0.614844377, 1.095323201,
                                                                                                                                                                                                                                                                                                                                                    0.672793259, 0.057114702, 0.072950494, 0.346984663, -0.452874548,
                                                                                                                                                                                                                                                                                                                                                    -0.114694466, 0.536167379, 2.672375374, 0.618138653, 2.749195306,
                                                                                                                                                                                                                                                                                                                                                    2.199564155, -1.821705402, 0.662389551, -0.086448818, 2.350030519,
                                                                                                                                                                                                                                                                                                                                                    1.42969294, -0.082903446, 1.526255915, -0.77415644, 1.646198365,
                                                                                                                                                                                                                                                                                                                                                    0.550819959, -1.912875322, -0.170004512, -0.153966373, 3.216473665,
                                                                                                                                                                                                                                                                                                                                                    -2.384187974, 0.730941972, -0.065087507, 1.330153598, 1.27618167,
                                                                                                                                                                                                                                                                                                                                                    1.956183459, 0.436215424, -1.232486611, -0.455381093, 0.83128861,
                                                                                                                                                                                                                                                                                                                                                    0.152153259, -0.45491991, -0.256058166, -0.193076508, -0.334064589,
                                                                                                                                                                                                                                                                                                                                                    0.215860632, -1.749746886, 0.358765965, 0.211328495, -0.112055855,
                                                                                                                                                                                                                                                                                                                                                    0.945593904, 0.532860661, 0.01631963, -0.695297425, -0.182978288,
                                                                                                                                                                                                                                                                                                                                                    1.940983578, -1.052570114, 1.265312559, -0.21744826, 2.122842478,
                                                                                                                                                                                                                                                                                                                                                    1.291844321, -0.694666126, 2.001880096, 0.977066134, 1.383692522,
                                                                                                                                                                                                                                                                                                                                                    -0.085431624, -1.152918968, -1.621837649, 0.647353218, 1.079628054,
                                                                                                                                                                                                                                                                                                                                                    -0.220121984, -0.562039994, 2.441868908, 0.688842095, 0.572532136,
                                                                                                                                                                                                                                                                                                                                                    1.049670153, -1.439036257, 0.673783789, 0.810812932, -0.557921732,
                                                                                                                                                                                                                                                                                                                                                    -0.055039468, 1.065618622, -0.653057442, -0.537812988, 0.818735764,
                                                                                                                                                                                                                                                                                                                                                    0.874036767, -0.264722867, -1.083081897, 0.132684797, 1.282776406,
                                                                                                                                                                                                                                                                                                                                                    0.980202012, 0.912757975, 0.395195197, -1.294487302, -0.149088612,
                                                                                                                                                                                                                                                                                                                                                    1.042843997, -1.213788746, -1.842337004, -0.087241521, 1.759125287,
                                                                                                                                                                                                                                                                                                                                                    -0.65217472, -0.468828649, -1.128895132, 0.355130761, -1.13143679,
                                                                                                                                                                                                                                                                                                                                                    -0.231067871, -1.353450121, -1.710583197, 0.186715205, -0.543962675,
                                                                                                                                                                                                                                                                                                                                                    0.292958499, -0.4283386, 2.670479768, 2.379591267, 1.278406268,
                                                                                                                                                                                                                                                                                                                                                    2.298737024, -0.737706867, 1.468454399, 0.055981228, 0.149251786,
                                                                                                                                                                                                                                                                                                                                                    -0.332347905, -0.191862331, -0.012294677, 0.139243256, -1.123574851,
                                                                                                                                                                                                                                                                                                                                                    -0.034383926, -0.512343287, 0.812126437, 0.486944352, 0.595358492,
                                                                                                                                                                                                                                                                                                                                                    1.224605923, 0.863959031, -1.789032311, 0.489475508, 2.019401428,
                                                                                                                                                                                                                                                                                                                                                    2.492383813, 0.177655849, -0.587024392, 0.299497534, 1.602179556,
                                                                                                                                                                                                                                                                                                                                                    -1.502343948, -1.37596223, 0.74894869, 0.664588217, 1.321486377,
                                                                                                                                                                                                                                                                                                                                                    1.888462109, -0.903168893, -3.201437624, -0.535609031, 0.554010178,
                                                                                                                                                                                                                                                                                                                                                    -0.547718747, 1.542488798, 1.851156869, 0.154379085, 0.617288371,
                                                                                                                                                                                                                                                                                                                                                    1.273637679, -1.466949312, -0.150368723, -0.256217966), Variable5 = c(1L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       0L, 1L, 0L, 1L, 0L, 1L, 0L, 1L, 0L, 0L, 1L, 0L, 1L, 1L, 1L, 1L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       0L, 1L, 0L, 1L, 1L, 1L, 0L, 1L, 0L, 0L, 0L, 1L, 0L, 0L, 0L, 0L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       0L, 0L, 1L, 1L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 0L, 1L, 0L, 1L, 1L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       0L, 1L, 1L, 0L, 1L, 0L, 1L, 1L, 0L, 1L, 0L, 1L, 1L, 0L, 1L, 1L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       1L, 1L, 0L, 1L, 1L, 1L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 1L, 1L, 1L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       1L, 0L, 0L, 1L, 1L, 1L, 0L, 0L, 1L, 1L, 0L, 1L, 1L, 0L, 0L, 1L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       0L, 0L, 1L, 1L, 0L, 1L, 0L, 0L, 1L, 0L, 0L, 0L, 0L, 1L, 1L, 1L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       0L, 0L, 1L, 1L, 0L, 1L, 0L, 1L, 1L, 0L, 1L, 0L, 0L, 1L, 1L, 0L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       0L, 1L, 0L, 0L, 1L, 1L, 0L, 1L, 1L, 1L, 1L, 1L, 0L, 0L, 0L, 0L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       0L, 1L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 0L, 1L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       0L, 0L, 0L, 0L, 1L, 1L, 0L, 0L, 0L, 1L, 0L, 1L, 0L, 0L, 1L, 1L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       0L, 0L, 1L, 0L, 0L, 0L, 1L, 1L, 0L, 1L, 0L, 1L, 0L, 0L, 1L, 1L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       0L, 0L, 0L, 1L, 0L, 1L, 1L, 1L, 0L, 0L, 1L, 1L, 1L, 0L, 0L, 0L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       1L, 0L, 1L, 0L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 0L, 1L, 0L, 1L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       0L, 0L, 0L, 0L, 1L, 0L, 1L, 0L, 1L, 0L, 0L, 1L, 0L, 0L, 0L, 1L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       0L, 0L, 0L, 1L, 1L, 0L, 0L, 0L, 1L, 1L, 0L, 0L, 1L, 1L, 1L, 1L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       0L, 1L, 1L, 0L, 0L, 1L, 0L, 1L, 1L, 1L, 0L, 1L, 1L, 1L, 1L, 0L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       0L, 0L, 0L, 1L, 0L, 0L, 1L, 1L, 0L, 0L, 1L, 1L, 1L, 1L, 0L, 0L,
                                                                                                                                                                                                                                                                                                                                                                                                                                       0L, 1L, 0L, 1L, 0L, 1L, 1L, 1L, 0L, 1L, 0L), Variable6 = c(2L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               2L, 4L, 3L, 8L, 0L, 2L, 1L, 1L, 1L, 6L, 4L, 0L, 1L, 2L, 1L, 0L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0L, 4L, 1L, 0L, 1L, 3L, 10L, 3L, 1L, 1L, 1L, 2L, 1L, 2L, 0L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               2L, 0L, 3L, 4L, 2L, 1L, 0L, 2L, 1L, 1L, 0L, 2L, 0L, 1L, 0L, 1L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0L, 0L, 5L, 1L, 2L, 3L, 1L, 3L, 0L, 1L, 0L, 0L, 0L, 1L, 0L, 4L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               4L, 2L, 6L, 0L, 4L, 6L, 7L, 1L, 2L, 12L, 0L, 2L, 1L, 1L, 6L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               2L, 1L, 0L, 0L, 12L, 2L, 0L, 2L, 1L, 1L, 2L, 8L, 5L, 2L, 3L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0L, 7L, 1L, 0L, 2L, 3L, 7L, 0L, 4L, 2L, 4L, 3L, 3L, 0L, 0L, 2L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               11L, 1L, 0L, 3L, 0L, 12L, 5L, 2L, 1L, 0L, 19L, 2L, 1L, 1L, 0L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0L, 4L, 1L, 0L, 0L, 5L, 1L, 0L, 1L, 4L, 0L, 1L, 2L, 1L, 0L, 16L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               1L, 0L, 0L, 1L, 2L, 3L, 4L, 1L, 0L, 2L, 0L, 1L, 12L, 0L, 18L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               7L, 0L, 2L, 0L, 11L, 5L, 1L, 5L, 0L, 7L, 4L, 0L, 1L, 0L, 23L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0L, 2L, 1L, 1L, 6L, 11L, 1L, 0L, 0L, 1L, 0L, 1L, 2L, 1L, 0L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               2L, 0L, 1L, 1L, 1L, 3L, 2L, 0L, 0L, 2L, 5L, 0L, 5L, 2L, 8L, 4L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               1L, 10L, 3L, 4L, 0L, 0L, 0L, 1L, 2L, 0L, 0L, 7L, 2L, 1L, 3L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0L, 1L, 2L, 0L, 1L, 6L, 0L, 1L, 3L, 2L, 0L, 0L, 1L, 2L, 3L, 4L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               2L, 1L, 1L, 2L, 1L, 0L, 1L, 4L, 0L, 0L, 0L, 3L, 0L, 0L, 1L, 0L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0L, 0L, 0L, 0L, 18L, 10L, 4L, 12L, 0L, 9L, 1L, 1L, 1L, 0L, 3L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               3L, 0L, 0L, 0L, 4L, 1L, 1L, 4L, 1L, 0L, 4L, 5L, 14L, 2L, 1L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               1L, 3L, 0L, 0L, 2L, 2L, 5L, 9L, 0L, 0L, 2L, 1L, 0L, 3L, 6L, 0L,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               4L, 6L, 0L, 1L, 1L), Variable7 = c(0.427219425,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.220688309, 0.570053273, 0.231100824, 0.131067892, 1, 0.076567255,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.405903343, 0.474725634, 0.990018262, 0.192843674, 0.224774893,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               1, 0.740614383, 0.851823829, 0.653432541, 1, 1, 0.624686075,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.607677759, 1, 0.105184005, 0.178594546, 0.002517108, 0.769499354,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.543466466, 0.904824708, 0.597340464, 0.102275177, 0.939954609,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.644957841, 1, 0.092147577, 1, 0.052178635, 0.108955976, 0.103881947,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.307079922, 1, 0.640638174, 0.998201291, 0.358593487, 1, 0.098677587,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               1, 0.625249783, 1, 0.94040242, 1, 1, 0.108139376, 0.01932307,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.068532055, 0.319257561, 0.317226161, 0.042847799, 1, 0.907828255,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               1, 1, 1, 0.817368982, 1, 0.120666731, 0.211511707, 0.157775565,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.160599299, 1, 0.223432249, 0.071663969, 0.152479944, 0.4318303,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.064199554, 0.084701885, 1, 0.214182802, 0.250437733, 0.64748267,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.221051177, 0.8792932, 0.102889819, 1, 1, 0.004530114, 0.056033505,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               1, 0.107350229, 0.341537754, 0.560227328, 0.56788941, 0.029397749,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.128741443, 0.340319883, 0.438422074, 1, 0.363424137, 0.64064305,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               1, 0.669024544, 0.097899144, 0.184498989, 1, 0.626521215, 0.646898637,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.263503489, 0.147692887, 0.131565273, 1, 1, 0.132856326, 0.045526628,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.585667955, 1, 0.549235367, 1, 0.020705723, 0.029918293, 0.456543362,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.856084292, 1, 0.033240023, 0.000931051, 0.141747406, 0.691832666,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               1, 1, 0.119549448, 0.459920161, 1, 1, 0.63650842, 0.885468904,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               1, 0.66929208, 0.086900934, 1, 0.00297873, 0.387909833, 0.16488008,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               1, 0.154010162, 0.688411372, 1, 1, 0.374140598, 0.489588998,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.656373572, 0.253907352, 0.341392293, 1, 0.341498251, 1, 0.039745196,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.049899045, 1, 0.004291585, 0.064142592, 1, 0.162245865, 1,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               9.52e-05, 0.334425874, 0.55930246, 0.023006289, 1, 0.092510628,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.179388773, 1, 0.298066521, 1, 0.020858126, 1, 0.219817914,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.381100323, 0.383832334, 0.031687818, 0.021982156, 0.100909454,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               1, 1, 0.90886201, 1, 0.133518321, 0.321278177, 0.977561022, 1,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.377386837, 1, 0.924968583, 0.22384265, 0.001476047, 0.141017063,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.079471224, 1, 1, 0.003846134, 0.056555377, 1, 0.120304732,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.289193756, 0.021411919, 0.003588727, 0.815915327, 0.186839249,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.124749619, 0.215773542, 1, 1, 1, 0.09331221, 0.227188488, 1,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               1, 0.304550487, 0.242236769, 0.915177329, 0.038263021, 1, 0.690036211,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.115890253, 1, 0.377763011, 0.214936317, 1, 0.409689095, 0.016033388,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.696195914, 1, 1, 0.579652169, 0.111762879, 0.288249519, 0.685298051,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.029751715, 0.34902306, 0.740039564, 0.160866749, 0.934899752,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               1, 0.089958756, 0.101130973, 1, 1, 1, 0.000367582, 1, 1, 0.501846786,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               1, 1, 1, 1, 1, 0.012013178, 0.003237151, 0.37217903, 0.009178291,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               1, 0.091345794, 0.743160189, 0.983801698, 0.74850986, 1, 0.152319066,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.47288842, 1, 1, 1, 0.006951365, 0.522907566, 0.477519199, 0.077229532,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.344051985, 1, 0.268246943, 0.222762224, 0.013367555, 0.157375875,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.794346784, 0.403181111, 0.097897052, 1, 1, 0.243050875, 0.188878481,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.067540856, 0.169211418, 1, 1, 0.052260709, 0.052824504, 1,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.12313927, 0.085084118, 1, 0.018040391, 0.055642594, 1, 0.901317881,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.859124256)), class = "data.frame", row.names = c(NA, -300L))
  results <-  jaspTools::runAnalysis("MixedModelsGLMM", dataset, options)


  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "Variable1", 0.991431446812136, 0.000115332462996776, 1, "Variable7",
                                        0.0187024091233807, 5.529129388505, 1, "Variable1<unicode><unicode><unicode>Variable7",
                                        0.528941245929824, 0.396425171878718))
  })

  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, 0.134346556802761, 0.676527258187159, 0.526204871639591, 1,
                                        0.0706706360833217, 0.79750940103397, 2, 0.134346556802761,
                                        0.690096706343528, 0.554820516270961, 2, 0.0633313417850653,
                                        0.799147666791784, 1, 0.527784183943333, 0.48076506407191, 0.361880278948504,
                                        3, 0.062438549626601, 0.601868592224231, 2, 0.527784183943333,
                                        0.538667954839526, 0.423590622583212, 4, 0.0587080458859666,
                                        0.649766554024045, 1, 0.921221811083906, 0.290735756446608,
                                        0.183385182450686, 5, 0.0633119427468566, 0.427992128521476,
                                        2, 0.921221811083906, 0.379750142563304, 0.249901315326978,
                                        6, 0.0731304723655697, 0.529446117503751))
  })

  test_that("Estimated Means and Confidence Intervals table results match", {
    table <- results[["results"]][["EstimatesTable"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, 0.361880278948504, 0.48076506407191, 0.601868592224231, 2,
                                        0.423590622583212, 0.538667954839526, 0.649766554024045))
  })

  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1.01117702219211, 0.188735946354063, 0.769349238488262, 1.31432770919359,
                                        "Intercept", 0.00492156595204526, 0.991593339633844, 0.467102114476777,
                                        0.0105363812312392, "Variable1", -2.50123784341205, 0.0208973494592507,
                                        1.082864789328, -2.30983394054605, "Variable7", 0.430171005827875,
                                        0.528658998950714, 0.682752175485791, 0.630054390558039, "Variable1<unicode><unicode><unicode>Variable7"
                                   ))
  })

  test_that("Variable0: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "Intercept", -0.860595480493162, 1, "Variable1"))
  })

  test_that("Residual Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_RES1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, 1))
  })

  test_that("Variable0: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.889184917605895, 0.790649817697802, "Intercept", 0.47040560808488,
                                        0.221281436117705, "Variable1"))
  })

  test_that("contrasts table results match", {
    table <- results[["results"]][["contrastsMeans"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("Contrast 1", "<unicode>", 0.209331642271618, 0.0542528119453667,
                                        0.0163073939348355, 0.0791233061165884, 2.64563821389322, 0.364410472597869,
                                        "Contrast 2", "<unicode>", -0.0135694481563691, -0.18357601923892,
                                        0.875687129224548, 0.0867396403319353, -0.156438833553396, 0.156437122926182
                                   ))
  })

  test_that("contrasts table results match", {
    table <- results[["results"]][["contrastsTrends"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("Contrast 1", "<unicode>", 0.430171005827878, -0.907998668490652,
                                        0.528658998950714, 0.682752175485795, 0.630054390558039, 1.76834068014641
                                   ))
  })

  test_that("Sample sizes table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitSizes"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(10, 300))
  })

  test_that("Fit statistics table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_modelSummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(385.217480468647, 411.14395779124, 351.863777611662, 7, -185.608740234323
                                   ))
  })

  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-glmm-1")
  })

  test_that("Estimated Trends table results match", {
    table <- results[["results"]][["trendsSummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, -3.02560475765744, 1, 2.11353786433203e-05, 0.487018091966243,
                                        -2.07106683758419, -4.25254599725988, -1.11652891751094, 2,
                                        -2.58915824541817, 2, 0.000694938426723015, 0.483816244146133,
                                        -1.64089583175631, -3.39156828984165, -0.692633418094453))
  })
}

### bernoulli + probit, type II with LRT, no random slopes, custom options
{
  options <- jaspTools::analysisOptions("MixedModelsGLMM")
  options$contrasts <- list(list(isContrast = FALSE, levels = c("2", "3", "4", "5",
                                                                "6", "7"), name = "contNormal", values = c("-1.11", "0", "1.11",
                                                                                                           "-1.11", "0", "1.11")), list(isContrast = FALSE, levels = c("2",
                                                                                                                                                                       "3", "4", "5", "6", "7"), name = "facGender", values = c("f",
                                                                                                                                                                                                                                "f", "f", "m", "m", "m")), list(isContrast = TRUE, levels = c("2",
                                                                                                                                                                                                                                                                                              "3", "4", "5", "6", "7"), name = "Contrast 1", values = c("1",
                                                                                                                                                                                                                                                                                                                                                        "-1", "0", "0", "0", "0")), list(isContrast = TRUE, levels = c("2",
                                                                                                                                                                                                                                                                                                                                                                                                                       "3", "4", "5", "6", "7"), name = "Contrast 2", values = c("0",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 "1", "-1", "0", "0", "0")))
  options$bootstrapSamples <- 500
  options$dependent <- "contBinom"
  options$modelSummary <- TRUE
  options$fixedEffects <- list(list(components = "contNormal"),
                               list(components = "facGender"),
                               list(components = c("contNormal", "facGender")))
  options$includeIntercept <- TRUE
  options$factorContrast <- "sum"
  options$fixedVariables <- c("contNormal", "facGender")
  options$link <- "probit"
  options$marginalMeansTerms <- list(list(variable = "contNormal"), list(variable = "facGender"))
  options$marginalMeansPAdjustment <- "mvt"
  options$marginalMeansComparison <- TRUE
  options$marginalMeansContrast <- TRUE
  options$marginalMeansResponse <- FALSE
  options$marginalMeansSd <- 1.11
  options$testMethod <- "likelihoodRatioTest"
  options$plotTransparency <- 0.7
  options$plotDodge <- 0.3
  options$plotElementWidth <- 1
  options$plotJitterHeight <- 0
  options$plotJitterWidth <- 0.1
  options$plotLegendPosition <- "right"
  options$plotRelativeSizeData <- 1
  options$plotRelativeSizeText <- 1.5
  options$plotBackgroundData <- "facFive"
  options$plotBackgroundColor <- "darkgrey"
  options$plotCiType <- "model"
  options$plotCiLevel <- 0.95
  options$plotEstimatesTable <- TRUE
  options$plotBackgroundElement <- "violin"
  options$plotLevelsByColor <- FALSE
  options$plotLevelsByFill <- TRUE
  options$plotLevelsByLinetype <- TRUE
  options$plotLevelsByShape <- TRUE
  options$plotSeparatePlots <- list()
  options$plotTheme <- "jasp"
  options$plotSeparateLines <- list()
  options$plotHorizontalAxis <- list(list(variable = "facGender"))
  options$vovkSellke <- FALSE
  options$randomEffects <- list(list(correlations = TRUE, randomComponents = list(
    list(randomSlopes = FALSE, value = "contNormal"),
    list(randomSlopes = FALSE, value = "facGender"),
    list(randomSlopes = FALSE, value = c("contNormal", "facGender"))),
    value = "facFive"))
  options$randomEffects[[1]]$randomComponents[[length(options$randomEffects[[1]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$randomEffectEstimate <- FALSE
  options$randomVariables <- "facFive"
  options$seed <- 1
  options$setSeed <- FALSE
  options$fixedEffectEstimate <- TRUE
  options$varianceCorrelationEstimate <- TRUE
  options$interceptTest <- FALSE
  options$trendsContrasts <- list(list(isContrast = TRUE, levels = list(), name = "Contrast 1",
                                       values = list()))
  options$trendsTrendVariable <- list()
  options$type <- "2"
  set.seed(1)
  results <- jaspTools::runAnalysis("MixedModelsGLMM", "debug.csv", options)


  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "contNormal", 0.609594107923912, 0.260766411860658, 1, "facGender",
                                        0.284327625868679, 1.14628764586067, 1, "contNormal<unicode><unicode><unicode>facGender",
                                        0.33457776193542, 0.931098042304654))
  })

  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(-1.36358769374441, 0.149244029378276, "f", -0.357948919869974,
                                        1, 0.564122485436689, 0.25877666796376, 0.576729078987818, 0.656436978626526,
                                        -0.18874858754, -0.102631617037894, "f", -0.465632317985414,
                                        2, 0.579481029909843, 0.185207842496507, -0.554142932904311,
                                        0.260369083909626, 0.98609051866441, -0.354507263454064, "f",
                                        -1.01489203089251, 3, 0.292732377650732, 0.336937195095151,
                                        -1.05214641961375, 0.305877503984378, -1.36358769374441, -0.407989734747062,
                                        "m", -0.979730682484735, 4, 0.161928612420611, 0.291709925410616,
                                        -1.39861451122298, 0.163751212990612, -0.18874858754, -0.366884673848823,
                                        "m", -0.730841927282632, 5, 0.0481855262534015, 0.185695888447266,
                                        -1.97572857921951, -0.00292742041501315, 0.98609051866441, -0.325779612950584,
                                        "m", -0.787115539841138, 6, 0.166340279126062, 0.235379798062369,
                                        -1.38405936122123, 0.13555631393997))
  })

  test_that("Estimated Means and Confidence Intervals table results match", {
    table <- results[["results"]][["EstimatesTable"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("f", 0.320739352984108, 0.459127674282166, 0.602710455894467,
                                        "m", 0.232437855334374, 0.356852521999701, 0.498832129892008
                                   ))
  })

  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(-0.251689251201327, 0.0615661713134421, 0.134635856367069, -1.86940728861356,
                                        "Intercept", -0.0897018938188372, 0.48643709680009, 0.128884475846304,
                                        -0.695986799262056, "contNormal", 0.108591520764834, 0.419921634510777,
                                        0.134635856367069, 0.80655721064953, "facGender (1)", -0.124689715284057,
                                        0.333317461325264, 0.128884475846304, -0.967453329544131, "contNormal<unicode><unicode><unicode>facGender (1)"
                                   ))
  })

  test_that("Residual Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_RES1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, 1))
  })

  test_that("facFive: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0, 0, "Intercept"))
  })

  test_that("contrasts table results match", {
    table <- results[["results"]][["contrastsMeans"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("Contrast 1", "<unicode>", 0.25187564641617, -0.211704827210082,
                                        0.286920844138782, 0.236524996011618, 1.06490075325399, 0.715456120042422,
                                        "Contrast 2", "<unicode>", 0.25187564641617, -0.211704827210082,
                                        0.286920844138782, 0.236524996011619, 1.06490075325399, 0.715456120042422
                                   ))
  })

  test_that("Sample sizes table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitSizes"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(5, 100))
  })

  test_that("Fit statistics table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_modelSummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(143.384651734201, 156.410502664141, 133.384651734201, 5, -66.6923258671005
                                   ))
  })

  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-glmm-2")
  })
}

### gamma + log, parametric bootstrap, no correlation
{
  skip("Does not work: https://github.com/singmann/afex/issues/134")
  options <- jaspTools::analysisOptions("MixedModelsGLMM")
  options$contrasts <- list(list(isContrast = FALSE, levels = c("2", "3"), name = "facGender",
                                 values = c("f", "m")), list(isContrast = TRUE, levels = c("2",
                                                                                           "3"), name = "Contrast 1", values = c("1", "0")), list(isContrast = TRUE,
                                                                                                                                                  levels = c("2", "3"), name = "Contrast 2", values = c("0",
                                                                                                                                                                                                        "0")))
  options$bootstrapSamples <- 10
  options$dependent <- "contGamma"
  options$family <- "gamma"
  options$modelSummary <- FALSE
  options$fixedEffects <- list(list(components = "facGender"),
                               list(components = "contBinom"),
                               list(components = c("facGender", "contBinom")))
  options$includeIntercept <- TRUE
  options$factorContrast <- "sum"
  options$fixedVariables <- c("facGender", "contBinom")
  options$link <- "log"
  options$marginalMeansTerms <- list(list(variable = "facGender"))
  options$marginalMeansPAdjustment <- "mvt"
  options$marginalMeansComparison <- TRUE
  options$marginalMeansContrast <- TRUE
  options$marginalMeansResponse <- FALSE
  options$marginalMeansSd <- 1.11
  options$testMethod <- "parametricBootstrap"
  options$plotTransparency <- 0.7
  options$plotDodge <- 0.3
  options$plotElementWidth <- 1
  options$plotJitterHeight <- 0
  options$plotJitterWidth <- 0.1
  options$plotLegendPosition <- "right"
  options$plotRelativeSizeData <- 1
  options$plotRelativeSizeText <- 1.5
  options$plotBackgroundData <- "facFive"
  options$plotBackgroundColor <- "darkgrey"
  options$plotCiType <- "model"
  options$plotCiLevel <- 0.95
  options$plotEstimatesTable <- TRUE
  options$plotBackgroundElement <- "boxjitter"
  options$plotLevelsByColor <- FALSE
  options$plotLevelsByFill <- TRUE
  options$plotLevelsByLinetype <- TRUE
  options$plotLevelsByShape <- TRUE
  options$plotSeparatePlots <- list()
  options$plotTheme <- "jasp"
  options$plotSeparateLines <- list()
  options$plotHorizontalAxis <- list(list(variable = "facGender"))
  options$vovkSellke <- FALSE
  options$randomEffects <- list(list(correlations = FALSE, randomComponents = list(list(
    randomSlopes = TRUE, value = "facGender"),
    list(randomSlopes = FALSE, value = "contBinom"),
    list(randomSlopes = FALSE, value = c("facGender", "contBinom"))),
    value = "facFive"))
  options$randomEffects[[1]]$randomComponents[[length(options$randomEffects[[1]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$randomEffectEstimate <- FALSE
  options$randomVariables <- "facFive"
  options$seed <- 1
  options$setSeed <- FALSE
  options$fixedEffectEstimate <- TRUE
  options$varianceCorrelationEstimate <- TRUE
  options$interceptTest <- FALSE
  options$trendsContrasts <- list(list(isContrast = TRUE, levels = list(), name = "Contrast 1",
                                       values = list()))
  options$trendsTrendVariable <- list()
  options$type <- "3"
  set.seed(1)
  results <- jaspTools::runAnalysis("MixedModelsGLMM", "debug.csv", options)


  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "facGender", 0.447004500743224, 0.272727272727273, 0.578236212970523,
                                        1, "contBinom", 0.377291093565023, 0.636363636363636, 0.77950982853497,
                                        1, "facGender<unicode><unicode><unicode>contBinom", 0.547514203844492,
                                        0.272727272727273, 0.361789256147745))
  })

  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.587430344676266, "f", 0.37458694201089, 1, 6.32574573837542e-08,
                                        0.108595568257508, 5.40933993994414, 0.800273747341642, 0.746196682539556,
                                        "m", 0.413133378648097, 2, 1.12771879979508e-05, 0.169933379653208,
                                        4.39111305890791, 1.07925998643101))
  })

  test_that("Estimated Means and Confidence Intervals table results match", {
    table <- results[["results"]][["EstimatesTable"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("f", 1.45439054289628, 1.79935873784759, 2.22615024780132, "m",
                                        1.51154662053427, 2.10896368553216, 2.9425012543254))
  })

  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.728064594347703, 6.66648936521263e-09, 0.125547485528779, 5.79911729240334,
                                        "Intercept", -0.0356589672364708, 0.749565019225593, 0.111709015978617,
                                        -0.319212974208782, "facGender (1)", -0.122502161479584, 0.407130511821325,
                                        0.14777922655215, -0.828953868129454, "contBinom", -0.0874484033903483,
                                        0.547831173835027, 0.145501627716119, -0.601013231006354, "facGender (1)<unicode><unicode><unicode>contBinom"
                                   ))
  })

  test_that("facFive.1: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE2"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "facGender (f)", 0.820565921340386, 1, "facGender (m)"))
  })

  test_that("Residual Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_RES2"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.69832135980351, 0.487652721557823))
  })

  test_that("facFive: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.06251298006749, 0.0039078726769184, "Intercept"))
  })

  test_that("facFive.1: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE2"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.0273977073255754, 0.000750634366697887, "facGender (f)", 0.223252099074577,
                                        0.0498414997412049, "facGender (m)"))
  })

  test_that("contrasts table results match", {
    table <- results[["results"]][["contrastsMeans"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("Contrast 1", "<unicode>", 0.587430344676266, 0.37458694201089,
                                        6.32574573837542e-08, 0.108595568257508, 5.40933993994414, 0.800273747341642
                                   ))
  })

  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-glmm-3")
  })
}

### poisson + log, type II parametric bootsrap
{
  skip("Does not work: https://github.com/singmann/afex/issues/134")
  options <- jaspTools::analysisOptions("MixedModelsGLMM")
  options$contrasts <- list(list(isContrast = FALSE, levels = c("2", "3"), name = "facGender",
                                 values = c("f", "m")), list(isContrast = TRUE, levels = c("2",
                                                                                           "3"), name = "Contrast 1", values = c("0", "0")))
  options$bootstrapSamples <- 10
  options$dependent <- "facFifty"
  options$family <- "poisson"
  options$modelSummary <- FALSE
  options$fixedEffects <- list(list(components = "facGender"))
  options$includeIntercept <- TRUE
  options$factorContrast <- "sum"
  options$fixedVariables <- "facGender"
  options$link <- "log"
  options$marginalMeansTerms <- list(list(variable = "facGender"))
  options$testMethod <- "parametricBootstrap"
  options$plotTransparency <- 0.7
  options$plotDodge <- 0.3
  options$plotElementWidth <- 1
  options$plotJitterHeight <- 0
  options$plotJitterWidth <- 0.1
  options$plotLegendPosition <- "top"
  options$plotRelativeSizeData <- 1
  options$plotRelativeSizeText <- 1.5
  options$plotBackgroundData <- "facFive"
  options$plotBackgroundColor <- "darkgrey"
  options$plotCiType <- "model"
  options$plotCiLevel <- 0.95
  options$plotEstimatesTable <- FALSE
  options$plotBackgroundElement <- "boxplot"
  options$plotLevelsByColor <- FALSE
  options$plotLevelsByFill <- FALSE
  options$plotLevelsByLinetype <- TRUE
  options$plotLevelsByShape <- TRUE
  options$plotSeparatePlots <- list()
  options$plotTheme <- "jasp"
  options$plotSeparateLines <- list()
  options$plotHorizontalAxis <- list(list(variable = "facGender"))
  options$vovkSellke <- FALSE
  options$randomEffects <- list(list(correlations = TRUE, randomComponents = list(
    list(randomSlopes = TRUE, value = "facGender")), value = "facFive"))
  options$randomEffects[[1]]$randomComponents[[length(options$randomEffects[[1]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$randomEffectEstimate <- FALSE
  options$randomVariables <- "facFive"
  options$seed <- 1
  options$setSeed <- FALSE
  options$fixedEffectEstimate <- TRUE
  options$varianceCorrelationEstimate <- TRUE
  options$interceptTest <- FALSE
  options$trendsContrasts <- list()
  options$trendsTrendVariable <- list()
  options$type <- "2"
  set.seed(1)
  results <- jaspTools::runAnalysis("MixedModelsGLMM", "debug.csv", options)


  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "facGender", 0.323811589816613, 0.363636363636364, 0.973488924913681
                                   ))
  })

  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(26.9632681863974, "f", 23.4528367885457, 1.91888508411733, 30.9991425705339,
                                        23.8823095639431, "m", 21.3136484431691, 1.38654415019449, 26.7605385173184
                                   ))
  })

  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(3.23380675074198, 0, 0.0282088980895584, 114.637825996436, "Intercept",
                                        0.0606687514862075, 0.299679559121684, 0.0584972850308832, 1.037120807473,
                                        "facGender (1)"))
  })

  test_that("facFive: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "Intercept", 0.413199633101234, 1, "facGender (1)"))
  })

  test_that("Residual Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_RES1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, 1))
  })

  test_that("facFive: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.0442623073281687, 0.00195915185001325, "Intercept", 0.12287221532645,
                                        0.0150975812992296, "facGender (1)"))
  })

  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-glmm-4")
  })
}

### aggregated binomial
{
  options <- jaspTools::analysisOptions("MixedModelsGLMM")
  options$contrasts <- list(list(isContrast = FALSE, levels = c("2", "3"), name = "cA",
                                 values = c("1", "2")), list(isContrast = TRUE, levels = c("2",
                                                                                           "3"), name = "Contrast 1", values = c("-1", "1")))
  options$bootstrapSamples <- 500
  options$dependent <- "binom_mean"
  options$dependentAggregation <- "rep"
  options$family <- "binomial"
  options$modelSummary <- TRUE
  options$fixedEffects <- list(list(components = "cA"),
                               list(components = "cB"),
                               list(components = c("cA", "cB")))
  options$includeIntercept <- TRUE
  options$factorContrast <- "sum"
  options$fixedVariables <- c("cA", "cB")
  options$marginalMeansTerms <- list(list(variable = "cA"))
  options$marginalMeansContrast <- TRUE
  options$testMethod <- "likelihoodRatioTest"
  options$plotTransparency <- 0.7
  options$plotDodge <- 0.3
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
  options$plotSeparateLines <- list(list(variable = "cB"))
  options$plotHorizontalAxis <- list(list(variable = "cA"))
  options$vovkSellke <- FALSE
  options$randomEffects <- list(list(correlations = TRUE, randomComponents = list(list(randomSlopes = TRUE, value = "cA")), value = "id"))
  options$randomEffects[[1]]$randomComponents[[length(options$randomEffects[[1]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$randomEffectEstimate <- FALSE
  options$randomVariables <- "id"
  options$seed <- 1
  options$setSeed <- FALSE
  options$fixedEffectEstimate <- TRUE
  options$varianceCorrelationEstimate <- TRUE
  options$interceptTest <- FALSE
  options$trendsContrasts <- list(list(isContrast = TRUE, levels = list(), name = "Contrast 1",
                                       values = list()))
  options$trendsTrendVariable <- list()
  options$type <- "3"
  options$link <- "logit"
  set.seed(1)
  dataset <- structure(list(id = c(1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L,
                                   1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L,
                                   6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L,
                                   1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 1L, 2L, 3L, 4L, 5L,
                                   6L, 7L, 8L, 9L, 10L), cA = c(1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
                                                                1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 1L, 1L, 1L, 1L,
                                                                1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
                                                                1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L,
                                                                2L, 2L, 2L, 2L), cB = c(1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
                                                                                        1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L,
                                                                                        2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 3L, 3L,
                                                                                        3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L,
                                                                                        3L, 3L), binom_mean = c(0.6, 1, 0.6, 0.8, 0.8, 0.6, 0.2, 0.2,
                                                                                                                0.4, 0.6, 0.6, 0.6, 0, 0.6, 0.8, 1, 1, 0.4, 0.8, 0.6, 0.6, 0.6,
                                                                                                                0.2, 0.8, 0.6, 1, 0.8, 0.2, 0.4, 0.6, 0.2, 0.8, 0.2, 0.6, 0.4,
                                                                                                                0.8, 0.6, 0.6, 0.8, 0.4, 0, 0.4, 0.4, 0, 0.8, 0.8, 0.4, 0.4,
                                                                                                                0.2, 0.6, 0.4, 0.4, 0.4, 0.4, 0.8, 0.2, 0.8, 0.2, 0.6, 0.2),
                            rep = c(5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L,
                                    5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L,
                                    5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L,
                                    5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L,
                                    5L, 5L)), class = "data.frame", row.names = c(NA, -60L))
  results <- jaspTools::runAnalysis("MixedModelsGLMM", dataset = dataset, options)


  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "cA", 0.768666936589639, 0.0865060140104958, 1, "cB", 0.479800713357095,
                                        0.499316242701497, 1, "cA<unicode><unicode><unicode>cB", 0.859034758351994,
                                        0.031542830127961))
  })

  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, 0.521557923880247, 0.411151465030417, 1, 0.0567205115241829,
                                        0.629901441101518, 2, 0.543531352735364, 0.424297968083058,
                                        2, 0.0607262923153063, 0.657976328706945))
  })

  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.661227504395588, 0.525989206215448, 1.04271469794619, 0.634140389214797,
                                        "Intercept", 0.194514831494138, 0.768585189821104, 0.661106803176433,
                                        0.294226032101847, "cA", -0.331612250089613, 0.480839156002498,
                                        0.470402992765527, -0.704953529610952, "cB", -0.053116323141788,
                                        0.858982330488374, 0.298960955867488, -0.177669766233057, "cA<unicode><unicode><unicode>cB"
                                   ))
  })

  test_that("id: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "Intercept", -0.717633169548817, 1, "cA"))
  })

  test_that("Residual Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_RES1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, 1))
  })

  test_that("id: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.672328111728483, 0.452025089820388, "Intercept", 0.385999853393285,
                                        0.148995886819638, "cA"))
  })

  test_that("contrasts table results match", {
    table <- results[["results"]][["contrastsMeans"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("Contrast 1", "<unicode>", 0.021973428855117, -0.110026385038528,
                                        0.744222663598295, 0.0673480813600878, 0.326266590099759, 0.153973242748762
                                   ))
  })

  test_that("Sample sizes table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitSizes"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(10, 60))
  })

  test_that("Fit statistics table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_modelSummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(202.867152008122, 217.527563943677, 64.2562363767916, 7, -94.433576004061
                                   ))
  })

  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-glmm-5")
  })
}
