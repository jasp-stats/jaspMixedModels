context("Linear Mixed Models")

### default, all selected output using Satterwhite testMethod
{
  options <- jaspTools::analysisOptions("MixedModelsLMM")
  options$contrasts <- list(list(isContrast = FALSE, levels = c("1", "2", "3", "4",
                                                                "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15",
                                                                "16", "17", "18"), name = "cA", values = c("1", "2", "1", "2",
                                                                                                           "1", "2", "1", "2", "1", "2", "1", "2", "1", "2", "1", "2", "1",
                                                                                                           "2")), list(isContrast = FALSE, levels = c("1", "2", "3", "4",
                                                                                                                                                      "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15",
                                                                                                                                                      "16", "17", "18"), name = "cB", values = c("1", "1", "2", "2",
                                                                                                                                                                                                 "3", "3", "1", "1", "2", "2", "3", "3", "1", "1", "2", "2", "3",
                                                                                                                                                                                                 "3")), list(isContrast = FALSE, levels = c("1", "2", "3", "4",
                                                                                                                                                                                                                                            "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15",
                                                                                                                                                                                                                                            "16", "17", "18"), name = "y_beta", values = c("-1", "-1", "-1",
                                                                                                                                                                                                                                                                                           "-1", "-1", "-1", "0", "0", "0", "0", "0", "0", "1", "1", "1",
                                                                                                                                                                                                                                                                                           "1", "1", "1")), list(isContrast = TRUE, levels = c("1", "2",
                                                                                                                                                                                                                                                                                                                                               "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14",
                                                                                                                                                                                                                                                                                                                                               "15", "16", "17", "18"), name = "Contrast 1", values = c("1",
                                                                                                                                                                                                                                                                                                                                                                                                        "-1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
                                                                                                                                                                                                                                                                                                                                                                                                        "0", "0", "0", "0", "0")), list(isContrast = TRUE, levels = c("1",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                      "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                      "14", "15", "16", "17", "18"), name = "Contrast 2", values = c("0",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     "1", "-1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     "0", "0", "0", "0", "0")))
  options$bootstrapSamples <- 500
  options$dependent <- "Variable4"
  options$modelSummary <- TRUE
  options$fixedEffects <- list(list(components = "Variable1"),
                               list(components = "Variable2"),
                               list(components = c("Variable1", "Variable2")),
                               list(components = "Variable7"),
                               list(components = c("Variable1", "Variable7")),
                               list(components = c("Variable2", "Variable7")),
                               list(components = c("Variable1", "Variable2", "Variable7")))
  options$includeIntercept <- TRUE
  options$factorContrast <- "sum"
  options$fixedVariables <- c("Variable1", "Variable2", "Variable7")
  options$marginalMeansTerms <- list(list(variable = "Variable1"), list(variable = "Variable2"),
                                list(variable = "Variable7"))
  options$marginalMeansComparison <- TRUE
  options$marginalMeansContrast <- TRUE
  options$testMethod <- "satterthwaite"
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
  options$plotSeparateLines <- list(list(variable = "Variable2"))
  options$plotHorizontalAxis <- list(list(variable = "Variable1"))
  options$vovkSellke <- FALSE
  options$randomEffects <- list(list(correlations = TRUE, randomComponents = list(
    list(randomSlopes = TRUE, value = "Variable1"),
    list(randomSlopes = FALSE, value = "Variable2"),
    list(randomSlopes = FALSE, value = c("Variable1", "Variable2" )),
    list(randomSlopes = FALSE, value = "Variable7"),
    list(randomSlopes = FALSE, value = c("Variable1", "Variable7")),
    list(randomSlopes = FALSE, value = c("Variable2", "Variable7")),
    list(randomSlopes = FALSE, value = c("Variable1", "Variable2", "Variable7"))), value = "Variable0"))
  options$randomEffects[[1]]$randomComponents[[length(options$randomEffects[[1]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$randomEffectEstimate <- TRUE
  options$randomVariables <- "Variable0"
  options$seed <- 1
  options$setSeed <- FALSE
  options$fixedEffectEstimate <- TRUE
  options$varianceCorrelationEstimate <- TRUE
  options$randomEffectEstimate
  options$interceptTest <- FALSE
  options$trendsContrast <- TRUE
  options$trendsContrasts <- list(list(isContrast = FALSE, levels = c("1", "2", "3", "4",
                                                                      "5", "6"), name = "cB", values = c("1", "2", "3", "1", "2", "3"
                                                                      )), list(isContrast = FALSE, levels = c("1", "2", "3", "4", "5",
                                                                                                              "6"), name = "cA", values = c("1", "1", "1", "2", "2", "2")),
                                  list(isContrast = TRUE, levels = c("1", "2", "3", "4", "5",
                                                                     "6"), name = "Contrast 1", values = c("1", "-1", "0", "0",
                                                                                                           "0", "0")), list(isContrast = TRUE, levels = c("1", "2",
                                                                                                                                                          "3", "4", "5", "6"), name = "Contrast 2", values = c("0",
                                                                                                                                                                                                               "1", "0", "0", "0", "0")))
  options$trendsTrendVariable <- list(list(variable = "Variable7"))
  options$trendsVariables <- list(list(variable = "Variable2"), list(variable = "Variable1"))
  options$type <- "3"
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
  dataset$Variable1 <- as.factor(dataset$Variable1)
  dataset$Variable2 <- as.factor(dataset$Variable2)
  results <-  jaspTools::runAnalysis("MixedModelsLMM", dataset, options)


  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("1, 35.30", "Variable1", 0.213945078054209, 1.60174616940147,
                                        "2, 277.59", "Variable2", 0.309343042485159, 1.17827777546627,
                                        "1, 282.17", "Variable7", 1.05836297841345e-37, 224.177295418877,
                                        "2, 277.57", "Variable1<unicode><unicode><unicode>Variable2",
                                        0.945697296669635, 0.0558439754925916, "1, 262.96", "Variable1<unicode><unicode><unicode>Variable7",
                                        0.363781953823721, 0.827664139846734, "2, 280.56", "Variable2<unicode><unicode><unicode>Variable7",
                                        0.400279660081596, 0.918586340240702, "2, 280.51", "Variable1<unicode><unicode><unicode>Variable2<unicode><unicode><unicode>Variable7",
                                        0.885178421723061, 0.122019094979098))
  })

  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, 1, 0.134346556802761, 0.736155006201862, 0.342393423701632,
                                        1, 0.000248073210555289, 0.200902458211565, 3.66424090951958,
                                        1.12991658870209, 2, 1, 0.134346556802761, 0.970099302524613,
                                        0.635342206174057, 2, 1.34837403764265e-08, 0.170797575359076,
                                        5.67981893469579, 1.30485639887517, 1, 2, 0.134346556802761,
                                        1.00178427381358, 0.616871475069543, 3, 3.37766585957781e-07,
                                        0.196387689661736, 5.10105432544716, 1.38669707255761, 2, 2,
                                        0.134346556802761, 1.19068283055357, 0.864944840125712, 4, 7.81661362562319e-13,
                                        0.166195906147886, 7.16433309430655, 1.51642082098142, 1, 3,
                                        0.134346556802761, 0.844388701356924, 0.450412814048416, 5,
                                        2.66100137260325e-05, 0.201011799408632, 4.20069221727819, 1.23836458866543,
                                        2, 3, 0.134346556802761, 0.969527995376983, 0.647253028619123,
                                        6, 3.71672516615009e-09, 0.164429024869806, 5.89633123558722,
                                        1.29180296213484, 1, 1, 0.527784183943333, 0.150291764934123,
                                        -0.157327577404923, 7, 0.33828062857611, 0.156951528071693,
                                        0.957568026132707, 0.457911107273169, 2, 1, 0.527784183943333,
                                        0.325419304660903, 0.0636346562238179, 8, 0.0148345838940844,
                                        0.13356605044889, 2.43639235844161, 0.587203953097988, 1, 2,
                                        0.527784183943333, 0.349095318512296, 0.0429110530350465, 9,
                                        0.0254404251175091, 0.156219332545083, 2.23464863679116, 0.655279583989545,
                                        2, 2, 0.527784183943333, 0.390440750717584, 0.126863453705241,
                                        10, 0.00369226595348432, 0.134480683875524, 2.90332216840136,
                                        0.654018047729927, 1, 3, 0.527784183943333, 0.108168134737725,
                                        -0.199035981744495, 11, 0.490122936314294, 0.156739674251878,
                                        0.690113305734582, 0.415372251219945, 2, 3, 0.527784183943333,
                                        0.188766091926349, -0.0741969072013631, 12, 0.159443399709109,
                                        0.134167260828225, 1.40694600725305, 0.451729091054061, 1, 1,
                                        0.921221811083906, -0.435571476333615, -0.793523489764854, 13,
                                        0.0170805669841959, 0.182631934185893, -2.38496886251156, -0.0776194629023758,
                                        2, 1, 0.921221811083906, -0.319260693202807, -0.66519969409243,
                                        14, 0.0704798360881783, 0.176502733528956, -1.80881444054481,
                                        0.0266783076868157, 1, 2, 0.921221811083906, -0.303593636788984,
                                        -0.677701723400159, 15, 0.111713908535933, 0.190874980133356,
                                        -1.59053657308505, 0.0705144498221917, 2, 2, 0.921221811083906,
                                        -0.4098013291184, -0.777150910375174, 16, 0.0287818326861408,
                                        0.187426699752843, -2.18646185233374, -0.0424517478616264, 1,
                                        3, 0.921221811083906, -0.628052431881474, -0.990856730839675,
                                        17, 0.00069155877166049, 0.185107635558589, -3.3929039717148,
                                        -0.265248132923273, 2, 3, 0.921221811083906, -0.591995811524284,
                                        -0.947636646709221, 18, 0.00110420758749543, 0.181452739943277,
                                        -3.26253443022874, -0.236354976339348))
  })

  test_that("Estimated Means and Confidence Intervals table results match", {
    table <- results[["results"]][["EstimatesTable"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, 1, -0.177418257095192, 0.150291764934123, 0.478001786963439,
                                        2, 1, 0.0517368457565581, 0.325419304660903, 0.599101763565247,
                                        1, 2, 0.0225417565025579, 0.349095318512296, 0.675648880522034,
                                        2, 2, 0.115142857421496, 0.390440750717584, 0.665738644013672,
                                        1, 3, -0.219231561530436, 0.108168134737725, 0.435567831005885,
                                        2, 3, -0.0860428729184415, 0.188766091926349, 0.463575056771139
                                   ))
  })

  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(16.2306089536174, 1.19116029635175, 2.18869798960833e-08, 0.118334626707059,
                                        10.0660333285244, "Intercept", 35.3032297366049, -0.105610070763506,
                                        0.213945086124028, 0.0834465708091049, -1.2656010874923, "Variable1 (1)",
                                        277.81260417867, -0.127937264306791, 0.237630444901206, 0.108102548269185,
                                        -1.18348055947964, "Variable2 (1)", 276.610380395872, 0.153138347192313,
                                        0.151182900097123, 0.106394322322049, 1.43934698628723, "Variable2 (2)",
                                        282.166679989969, -1.77938274268387, 1.05836241786697e-37, 0.118842987431374,
                                        -14.9725514407098, "Variable7", 277.437452308716, -0.0214041122540725,
                                        0.84328700844482, 0.108169334244241, -0.197875972923556, "Variable1 (1)<unicode><unicode><unicode>Variable2 (1)",
                                        274.504412706236, -0.0140315797377453, 0.895493628531909, 0.106722015925341,
                                        -0.13147783628414, "Variable1 (1)<unicode><unicode><unicode>Variable2 (2)",
                                        262.958608266277, 0.106290129469689, 0.363781940974619, 0.116833087810459,
                                        0.90976050930132, "Variable1 (1)<unicode><unicode><unicode>Variable7",
                                        280.768969888669, 0.215547519201563, 0.187445142898525, 0.163121068333652,
                                        1.32139595089383, "Variable2 (1)<unicode><unicode><unicode>Variable7",
                                        278.764702187189, -0.0670738935266586, 0.685011814699131, 0.165183208902999,
                                        -0.406057576748292, "Variable2 (2)<unicode><unicode><unicode>Variable7",
                                        280.578153316786, -0.0315428855120625, 0.846958786302005, 0.163283458128582,
                                        -0.193178695953531, "Variable1 (1)<unicode><unicode><unicode>Variable2 (1)<unicode><unicode><unicode>Variable7",
                                        276.271849657447, 0.081227680668467, 0.625068593623528, 0.166032423105515,
                                        0.489227821585461, "Variable1 (1)<unicode><unicode><unicode>Variable2 (2)<unicode><unicode><unicode>Variable7"
                                   ))
  })

  test_that("Variable0: Random Effect Estimates table results match", {
    table <- results[["results"]][["REEstimatesSummary"]][["collection"]][["REEstimatesSummary_REEstimates1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.402775358291333, 0.142689540606, 1, -0.106160422159156, 0.0324230307761484,
                                        2, -0.0831533638398433, 0.0202788224676554, 3, 0.0760706510403953,
                                        -0.036860778559647, 4, 0.0307796094651438, 0.0141641809314601,
                                        5, 0.201686511007182, 0.00302378484776545, 6, 0.247309398961227,
                                        0.0493268239762933, 7, -0.48908276442082, -0.0653495722257102,
                                        8, -0.231455211148659, -0.135657369441085, 9, -0.0487697671967913,
                                        -0.0240384633788782, 10))
  })

  test_that("Variable0: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "Intercept", 0.533641870616633, 1, "Variable1 (1)"))
  })

  test_that("Residual Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_RES1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.769891689595146, 0.592733213707669))
  })

  test_that("Variable0: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.284187792131844, 0.0807627011967724, "Intercept", 0.108185898440959,
                                        0.0117041886214776, "Variable1 (1)"))
  })

  test_that("contrasts table results match", {
    table <- results[["results"]][["contrastsMeans"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("Contrast 1", "<unicode>", -0.233944296322751, -0.696303715348727,
                                        0.642686601522133, 0.235901997522918, -0.991701209736571, 0.228415122703225,
                                        "Contrast 2", "<unicode>", -0.0316849712889628, -0.4865200168714,
                                        0.891397489278759, 0.232062960937098, -0.136536098483856, 0.423150074293474
                                   ))
  })

  test_that("contrasts table results match", {
    table <- results[["results"]][["contrastsTrends"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("Contrast 1", "<unicode>", 0.169850846547693, -0.620941632576639,
                                        0.673775481501695, 0.403472964484043, 0.420972063803325, 0.960643325672026,
                                        "Contrast 2", "<unicode>", -1.65893882607238, -2.22903094692442,
                                        2.34889273398185e-08, 0.290868671745428, -5.70339464926737,
                                        -1.08884670522034))
  })

  test_that("Sample sizes table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitSizes"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(10, 300))
  })

  test_that("Fit statistics table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_modelSummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(769.200410528667, 828.460930123167, 737.200410528667, 16, -368.600205264334
                                   ))
  })

  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot")
  })

  test_that("Estimated Trends table results match", {
    table <- results[["results"]][["trendsSummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, 1, -2.03987627521154, 1, 0.281019600376027, -1.48908797952469,
                                        -0.938299683837836, 1, 2, -2.22903094692442, 2, 0.290868671745428,
                                        -1.65893882607238, -1.08884670522034, 1, 3, -2.43415334868443,
                                        3, 0.287200335862819, -1.8712510340455, -1.30834871940657, 2,
                                        1, -2.19158075804869, 4, 0.282147169524912, -1.63858246743994,
                                        -1.0855841768312, 2, 2, -2.60826616216846, 5, 0.293011361611596,
                                        -2.03397444634869, -1.45968273052893, 2, 3, -2.52972123409858,
                                        6, 0.27819875045024, -1.98446170267207, -1.43920217124555))
  })
}

### no correlations between random effects, Kernwald Roggers testMethod, custom values
{
  options <- jaspTools::analysisOptions("MixedModelsLMM")
  options$contrasts <- list(list(isContrast = FALSE, levels = c("2", "3", "4", "5",
                                                                "6", "7"), name = "contGamma", values = c("-3.2", "0", "3.2",
                                                                                                          "-3.2", "0", "3.2")), list(isContrast = FALSE, levels = c("2",
                                                                                                                                                                    "3", "4", "5", "6", "7"), name = "contBinom", values = c("0",
                                                                                                                                                                                                                             "0", "0", "1", "1", "1")), list(isContrast = TRUE, levels = c("2",
                                                                                                                                                                                                                                                                                           "3", "4", "5", "6", "7"), name = "Contrast 1", values = c("-1",
                                                                                                                                                                                                                                                                                                                                                     "1", "0", "0", "0", "0")), list(isContrast = TRUE, levels = c("2",
                                                                                                                                                                                                                                                                                                                                                                                                                   "3", "4", "5", "6", "7"), name = "Contrast 2", values = c("0",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             "0", "1", "-1", "0", "0")))
  options$bootstrapSamples <- 500
  options$dependent <- "contNormal"
  options$modelSummary <- FALSE
  options$fixedEffects <- list(list(components = "contGamma"), list(components = "contBinom"),
                               list(components = "facExperim"), list(components = "facGender"),
                               list(components = c("contGamma", "contBinom")),
                               list(components = c("contGamma", "facExperim")),
                               list(components = c("contGamma", "facGender")),
                               list(components = c("contBinom", "facExperim")),
                               list(components = c("contBinom", "facGender")),
                               list(components = c("facExperim", "facGender")),
                               list(components = c("contGamma", "contBinom", "facExperim")),
                               list(components = c("contGamma", "contBinom", "facGender")),
                               list(components = c("contGamma", "facExperim", "facGender")),
                               list(components = c("contBinom", "facExperim", "facGender")),
                               list(components = c("contGamma", "contBinom", "facExperim", "facGender")))
  options$includeIntercept <- TRUE
  options$factorContrast <- "sum"
  options$fixedVariables <- c("contGamma", "contBinom", "facExperim", "facGender")
  options$marginalMeansTerms <- list(list(variable = "contGamma"), list(variable = "contBinom"))
  options$marginalMeansPAdjustment <- "none"
  options$marginalMeansComparison <- TRUE
  options$marginalMeansComparisonWith <- 1
  options$marginalMeansContrast <- TRUE
  options$marginalMeansDf <- "satterthwaite"
  options$marginalMeansSd <- 3.2
  options$testMethod <- "kenwardRoger"
  options$plotTransparency <- 0.7
  options$plotDodge <- 0.3
  options$plotElementWidth <- 1
  options$plotJitterHeight <- 0
  options$plotJitterWidth <- 0.1
  options$plotLegendPosition <- "bottom"
  options$plotRelativeSizeData <- 1
  options$plotRelativeSizeText <- 1.5
  options$plotBackgroundData <- "facFive"
  options$plotBackgroundColor <- "darkgrey"
  options$plotCiType <- "model"
  options$plotCiLevel <- 0.95
  options$plotEstimatesTable <- FALSE
  options$plotBackgroundElement <- "violin"
  options$plotLevelsByColor <- FALSE
  options$plotLevelsByFill <- TRUE
  options$plotLevelsByLinetype <- TRUE
  options$plotLevelsByShape <- TRUE
  options$plotSeparatePlots <- list()
  options$plotTheme <- "whiteBackground"
  options$plotSeparateLines <- list(list(variable = "facExperim"))
  options$plotHorizontalAxis <- list(list(variable = "contBinom"))
  options$vovkSellke <- TRUE
  options$randomEffects <- list(list(correlations = FALSE, randomComponents = list(
    list(randomSlopes = TRUE, value = "contGamma"),
    list(randomSlopes = TRUE, value = "contBinom"),
    list(randomSlopes = TRUE, value = "facExperim"),
    list(randomSlopes = TRUE, value = "facGender"),
    list(randomSlopes = FALSE, value = c("contGamma", "contBinom")),
    list(randomSlopes = FALSE, value = c("contGamma", "facExperim")),
    list(randomSlopes = FALSE, value = c("contGamma", "facGender")),
    list(randomSlopes = FALSE, value = c("contBinom", "facExperim")),
    list(randomSlopes = FALSE, value = c("contBinom", "facGender")),
    list(randomSlopes = FALSE,  value = c("facExperim", "facGender")),
    list(randomSlopes = FALSE, value = c("contGamma", "contBinom", "facExperim")),
    list(randomSlopes = FALSE, value = c("contGamma", "contBinom", "facGender")),
    list(randomSlopes = FALSE, value = c("contGamma", "facExperim", "facGender")),
    list(randomSlopes = FALSE, value = c("contBinom",  "facExperim", "facGender")),
    list(randomSlopes = FALSE, value = c("contGamma", "contBinom", "facExperim", "facGender"))),
    value = "facFive"))
  options$randomEffects[[1]]$randomComponents[[length(options$randomEffects[[1]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$randomEffectEstimate <- FALSE
  options$randomVariables <- "facFive"
  options$seed <- 1
  options$setSeed <- TRUE
  options$fixedEffectEstimate <- TRUE
  options$varianceCorrelationEstimate <- TRUE
  options$interceptTest <- FALSE
  options$trendsPAdjustment <- "mvt"
  options$trendsComparison <- TRUE
  options$trendsComparisonWith <- 9
  options$trendsContrast <- TRUE
  options$trendsContrasts <- list(list(isContrast = FALSE, levels = c("2", "3", "4", "5"),
                                       name = "facExperim", values = c("control", "experimental",
                                                                       "control", "experimental")), list(isContrast = FALSE, levels = c("2",
                                                                                                                                        "3", "4", "5"), name = "facGender", values = c("f", "f", "m",
                                                                                                                                                                                       "m")), list(isContrast = TRUE, levels = c("2", "3", "4", "5"),
                                                                                                                                                                                                   name = "Contrast 1", values = c("-1", "0", "1", "0")))
  options$trendsDf <- "Kenward-Roger"
  options$trendsTrendVariable <- list(list(variable = "contGamma"))
  options$trendsVariables <- list(list(variable = "facExperim"), list(variable = "facGender"))
  options$type <- "3"
  set.seed(1)
  results <- jaspTools::runAnalysis("MixedModelsLMM", "debug.csv", options)

  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("1, 21.86", "contGamma", 0.582171780033264, 0.31193525663984,
                                        1, "1, 31.03", "contBinom", 0.986544852893351, 0.000289026282986652,
                                        1, "1, 25.80", "facExperim", 0.780943389083148, 0.0789670785510523,
                                        1, "1, 35.71", "facGender", 0.261512376217912, 1.30161608876553,
                                        1.04880771259372, "1, 66.46", "contGamma<unicode><unicode><unicode>contBinom",
                                        0.825255324361962, 0.0491348548955305, 1, "1, 57.44", "contGamma<unicode><unicode><unicode>facExperim",
                                        0.891374917956014, 0.0188160284374158, 1, "1, 64.26", "contBinom<unicode><unicode><unicode>facExperim",
                                        0.290416618051626, 1.13633532506296, 1.02449876437337, "1, 77.18",
                                        "contGamma<unicode><unicode><unicode>facGender", 0.6966527576059,
                                        0.153116712189459, 1, "1, 74.52", "contBinom<unicode><unicode><unicode>facGender",
                                        0.582020400478242, 0.305643708294029, 1, "1, 71.27", "facExperim<unicode><unicode><unicode>facGender",
                                        0.0556124822673931, 3.78646994504997, 2.28946202966146, "1, 62.62",
                                        "contGamma<unicode><unicode><unicode>contBinom<unicode><unicode><unicode>facExperim",
                                        0.298379587407784, 1.09962159693895, 1.01946063212796, "1, 75.18",
                                        "contGamma<unicode><unicode><unicode>contBinom<unicode><unicode><unicode>facGender",
                                        0.537963831281211, 0.382827864192125, 1, "1, 59.02", "contGamma<unicode><unicode><unicode>facExperim<unicode><unicode><unicode>facGender",
                                        0.0935207779706305, 2.90579897728263, 1.66007444141911, "1, 75.97",
                                        "contBinom<unicode><unicode><unicode>facExperim<unicode><unicode><unicode>facGender",
                                        0.265822237899568, 1.25662381324755, 1.0445328502512, "1, 73.23",
                                        "contGamma<unicode><unicode><unicode>contBinom<unicode><unicode><unicode>facExperim<unicode><unicode><unicode>facGender",
                                        0.148931563758695, 2.1277223523188, 1.29715123043457))
  })

  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0, -2.8707548076634, 53.3504900361426, 0.161271944866672, -0.779737764116134,
                                        1, 0.0795438647442738, 0.469228917393325, -1.78746028653276,
                                        1.10228165384948, 1.82696425671216, 0, 2.03296079621, 3.39473091587362,
                                        -0.0686383229161619, -0.512102405691351, 2, 0.00362793390019775,
                                        0.1486633693947, -7.18830958337109, 0.374825759859028, 18.0459609063436,
                                        0, 6.9366764000834, 54.8820487013315, -0.298548590698996, -1.22276669028592,
                                        3, 0.00674469955513991, 0.461154092411721, -2.81586699991734,
                                        0.625669508887925, 10.9108834699388, 1, -2.8707548076634, 74.2044879593499,
                                        0.327057898927487, -1.5548369614597, 4, 0.478404386707991, 0.944511893818821,
                                        -0.712476047656419, 2.20895275931467, 1, 1, 2.03296079621, 17.6156942283673,
                                        -0.170011464578027, -0.553648259283189, 5, 5.37621916510818e-06,
                                        0.182318490451247, -6.41740429992698, 0.213625330127135, 5639.51241879488,
                                        1, 6.9366764000834, 75.0721491326038, -0.66708082808354, -2.59441773596485,
                                        6, 0.0889921442497099, 0.967504233989541, -1.72307341871701,
                                        1.26025607979777, 1.70875887872865))
  })

  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(43.2849442842532, 0.0313691115175071, 0.898865457969666, 0.245372448003178,
                                        0.127842843696537, "Intercept", 1, 78.4907272023169, -0.0741253867489902,
                                        0.490881369736284, 0.10709332635926, -0.692156918352934, "contGamma",
                                        1, 75.87810154047, -0.00469224921382239, 0.984243679008777,
                                        0.236813614810774, -0.0198141024010453, "contBinom (1)", 1,
                                        26.2326488187137, 0.0854089489158654, 0.745225230227994, 0.260085409592967,
                                        0.328388082397741, "facExperim (1)", 1, 45.8623051860287, -0.294953022822834,
                                        0.22321343589118, 0.238877203490829, -1.23474747071944, "facGender (1)",
                                        1.09901084201583, 76.9120956383881, 0.027240476131166, 0.794734508926211,
                                        0.104340717206231, 0.261072348940489, "contGamma<unicode><unicode><unicode>contBinom (1)",
                                        1, 78.8128225592629, -0.0182562341165608, 0.864044324764509,
                                        0.106271715562111, -0.171788269531519, "contGamma<unicode><unicode><unicode>facExperim (1)",
                                        1, 78.8325354937522, 0.296461701351092, 0.216962882353814, 0.238196583613831,
                                        1.24460937622733, "contBinom (1)<unicode><unicode><unicode>facExperim (1)",
                                        1.10965629876451, 79.0828813063371, 0.0451249451935157, 0.668932091293796,
                                        0.105133076344882, 0.429217395346506, "contGamma<unicode><unicode><unicode>facGender (1)",
                                        1, 78.0608401268388, -0.141898757677572, 0.547547982772011,
                                        0.234904067573921, -0.604071096525045, "contBinom (1)<unicode><unicode><unicode>facGender (1)",
                                        1, 78.5587013790743, -0.528818555157972, 0.0276131223196169,
                                        0.235605435168916, -2.2445091505586, "facExperim (1)<unicode><unicode><unicode>facGender (1)",
                                        3.71159326898742, 79.9801584513936, -0.131006304676436, 0.217497042610497,
                                        0.10539469618696, -1.24300661623469, "contGamma<unicode><unicode><unicode>contBinom (1)<unicode><unicode><unicode>facExperim (1)",
                                        1.10871523403592, 79.5774663338517, 0.0715293555067943, 0.496242054787227,
                                        0.104643232612373, 0.683554528287159, "contGamma<unicode><unicode><unicode>contBinom (1)<unicode><unicode><unicode>facGender (1)",
                                        1, 77.716707582409, 0.217885861493866, 0.0401754692380616, 0.104406332072754,
                                        2.08690274974928, "contGamma<unicode><unicode><unicode>facExperim (1)<unicode><unicode><unicode>facGender (1)",
                                        2.84859893388209, 76.9755838296766, 0.282631968530419, 0.232390689819394,
                                        0.234800875267003, 1.20370917786838, "contBinom (1)<unicode><unicode><unicode>facExperim (1)<unicode><unicode><unicode>facGender (1)",
                                        1.08475509964487, 77.3207322095584, -0.172274430063051, 0.102107363596884,
                                        0.104133197369099, -1.65436608512485, "contGamma<unicode><unicode><unicode>contBinom (1)<unicode><unicode><unicode>facExperim (1)<unicode><unicode><unicode>facGender (1)",
                                        1.57900723484226))
  })

  test_that("facFive.2: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE3"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "contBinom (0)", 0.999999935295903, 1, "contBinom (1)"))
  })

  test_that("facFive.3: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE4"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "facExperim (control)", -1, 1, "facExperim (experimental)"
                                   ))
  })

  test_that("facFive.4: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE5"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "facGender (f)", "NaN", 1, "facGender (m)"))
  })

  test_that("Residual Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_RES5"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1.00184306726037, 1.00368953141768))
  })

  test_that("facFive: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1.72503677196725e-05, 2.97575186463919e-10, "Intercept"))
  })

  test_that("facFive.1: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE2"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0, 0, "contGamma"))
  })

  test_that("facFive.2: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE3"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.106389657188666, 0.0113187591567219, "contBinom (0)", 0.0434587898672653,
                                        0.00188866641672712, "contBinom (1)"))
  })

  test_that("facFive.3: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE4"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.219098314523001, 0.0480040714268197, "facExperim (control)",
                                        0.239259357573019, 0.0572450401862539, "facExperim (experimental)"
                                   ))
  })

  test_that("facFive.4: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE5"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0, 0, "facGender (f)", 0.153830749254555, 0.0236638994162176,
                                        "facGender (m)"))
  })

  test_that("contrasts table results match", {
    table <- results[["results"]][["contrastsMeans"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("Contrast 1", 76.5733854462045, -0.229910267782834, -1.1077648758173,
                                        0.60348464880067, 0.440815879402399, -0.521556229087112, 0.647944340251632,
                                        1, "Contrast 2", 78.340097037507, -0.625606489626483, -2.73832700490179,
                                        0.557237089331172, 1.06128944612703, -0.589477726278642, 1.48711402564883,
                                        1))
  })

  test_that("contrasts table results match", {
    table <- results[["results"]][["contrastsTrends"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("Contrast 1", 60.6540434762595, -0.526021613374765, -1.12956167789185,
                                        0.0864023758112375, 0.301792021302328, -1.74299377135557, 0.0775184511423223,
                                        1.73874998565184))
  })

  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-lmm-2")
  })

  test_that("Estimated Trends table results match", {
    table <- results[["results"]][["trendsSummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(56.753199647102, "control", "f", -0.229658082540996, 1, 1.20140202429229e-45,
                                        0.199878375509929, 0.170629185821831, -44.173717099975, 0.570916454184659,
                                        2.96045667292707e+42, 65.5032342521118, "experimental", "f",
                                        -0.965739613506464, 2, 3.24191668609387e-35, 0.369136701491045,
                                        -0.22863006893278, -25.0005757532529, 0.508479475640903, 1.42891002183272e+32,
                                        16.5955003203805, "control", "m", -0.868479457489792, 3, 1.12594782120149e-17,
                                        0.242738981733067, -0.355392427552934, -38.5409560539426, 0.157694602383924,
                                        837222256255927, 25.2176592425265, "experimental", "m", -0.206784699294447,
                                        4, 4.43549662560343e-28, 0.157228483621893, 0.116891763667921,
                                        -56.4980850269751, 0.440568226630289, 1.3168663306668e+25))
  })
}
### type II, LRT + intercept
{
  options <- jaspTools::analysisOptions("MixedModelsLMM")
  options$contrasts <- list(list(isContrast = FALSE, levels = c("2", "3"), name = "facGender",
                                 values = c("f", "m")), list(isContrast = TRUE, levels = c("2",
                                                                                           "3"), name = "Contrast 1", values = c("0", "0")))
  options$bootstrapSamples <- 500
  options$dependent <- "contNormal"
  options$modelSummary <- FALSE
  options$fixedEffects <- list(list(components = "facGender"))
  options$includeIntercept <- TRUE
  options$factorContrast <- "sum"
  options$fixedVariables <- "facGender"
  options$marginalMeansTerms <- list(list(variable = "facGender"))
  options$testMethod <- "likelihoodRatioTest"
  options$plotTransparency <- 0.7
  options$plotDodge <- 0.3
  options$plotElementWidth <- 1
  options$plotJitterHeight <- 0
  options$plotJitterWidth <- 0.1
  options$plotLegendPosition <- "left"
  options$plotRelativeSizeData <- 1
  options$plotRelativeSizeText <- 1.5
  options$plotBackgroundData <- c("contBinom", "facFive")
  options$plotBackgroundColor <- "blue"
  options$plotCiType <- "model"
  options$plotCiLevel <- 0.95
  options$plotEstimatesTable <- TRUE
  options$plotBackgroundElement <- "boxplot"
  options$plotLevelsByColor <- TRUE
  options$plotLevelsByFill <- FALSE
  options$plotLevelsByLinetype <- TRUE
  options$plotLevelsByShape <- TRUE
  options$plotSeparatePlots <- list()
  options$plotTheme <- "jasp"
  options$plotSeparateLines <- list()
  options$plotHorizontalAxis <- list(list(variable = "facGender"))
  options$vovkSellke <- FALSE
  options$randomEffects <- list(
    list(correlations = TRUE, randomComponents = list(list(randomSlopes = TRUE, value = "facGender")), value = "contBinom"),
    list(correlations = TRUE, randomComponents = list(list(randomSlopes = TRUE, value = "facGender")), value = "facFive"))
  options$randomEffects[[1]]$randomComponents[[length(options$randomEffects[[1]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$randomEffects[[2]]$randomComponents[[length(options$randomEffects[[2]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$randomEffectEstimate <- FALSE
  options$randomVariables <- c("contBinom", "facFive")
  options$seed <- 1
  options$setSeed <- TRUE
  options$fixedEffectEstimate <- TRUE
  options$varianceCorrelationEstimate <- FALSE
  options$interceptTest <- TRUE
  options$trendsContrasts <- list(list(isContrast = TRUE, levels = list(), name = "Contrast 1",
                                       values = list()))
  options$trendsTrendVariable <- list()
  options$type <- "2"
  set.seed(1)
  results <- jaspTools::runAnalysis("MixedModelsLMM", "debug.csv", options)


  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "facGender", 0.0892620294750889, 2.88763209614939))
  })

  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(-0.421706173425421, "f", -0.704496259899192, 0.144283307603805,
                                        -0.13891608695165, 0.0410342976475168, "m", -0.296581004637054,
                                        0.172255870489273, 0.378649599932087))
  })

  test_that("Estimated Means and Confidence Intervals table results match", {
    table <- results[["results"]][["EstimatesTable"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("f", -2.19323331697357, -0.421706173425421, 1.34982097012272,
                                        "m", -0.812059108259057, 0.0410342976475168, 0.894127703554091
                                   ))
  })

  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(10.7325465569702, -0.190335937888952, 0.110892631343371, 0.10955506682194,
                                        -1.73735403948323, "Intercept", 7.33390917066214, -0.231370235536469,
                                        0.0824400392092811, 0.115076349521506, -2.01058024953449, "facGender (1)"
                                   ))
  })

  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-lmm-3")
  })
}
### parametric bootstrap
{
  options <- jaspTools::analysisOptions("MixedModelsLMM")
  options$contrasts <- list(list(isContrast = FALSE, levels = c("2", "3"), name = "facGender",
                                 values = c("f", "m")), list(isContrast = TRUE, levels = c("2",
                                                                                           "3"), name = "Contrast 1", values = c("0", "0")))
  options$bootstrapSamples <- 100
  options$dependent <- "contNormal"
  options$modelSummary <- FALSE
  options$fixedEffects <- list(list(components = "facGender"))
  options$includeIntercept <- TRUE
  options$factorContrast <- "sum"
  options$fixedVariables <- "facGender"
  options$marginalMeansTerms <- list(list(variable = "facGender"))
  options$testMethod <- "parametricBootstrap"
  options$plotTransparency <- 0.7
  options$plotDodge <- 0.3
  options$plotElementWidth <- 1
  options$plotJitterHeight <- 0
  options$plotJitterWidth <- 0.1
  options$plotLegendPosition <- "left"
  options$plotRelativeSizeData <- 1
  options$plotRelativeSizeText <- 1.5
  options$plotBackgroundData <- "facFive"
  options$plotBackgroundColor <- "violet"
  options$plotCiType <- "model"
  options$plotCiLevel <- 0.95
  options$plotEstimatesTable <- FALSE
  options$plotBackgroundElement <- "boxjitter"
  options$plotLevelsByColor <- TRUE
  options$plotLevelsByFill <- FALSE
  options$plotLevelsByLinetype <- FALSE
  options$plotLevelsByShape <- FALSE
  options$plotSeparatePlots <- list()
  options$plotTheme <- "jasp"
  options$plotSeparateLines <- list()
  options$plotHorizontalAxis <- list(list(variable = "facGender"))
  options$vovkSellke <- FALSE
  options$randomEffects <- list(
    list(correlations = TRUE, randomComponents = list(list(randomSlopes = TRUE, value = "facGender")), value = "facFive"))
  options$randomEffects[[1]]$randomComponents[[length(options$randomEffects[[1]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$randomEffectEstimate <- FALSE
  options$randomVariables <- "facFive"
  options$seed <- 1
  options$setSeed <- TRUE
  options$fixedEffectEstimate <- TRUE
  options$varianceCorrelationEstimate <- TRUE
  options$interceptTest <- FALSE
  options$trendsContrasts <- list(list(isContrast = TRUE, levels = list(), name = "Contrast 1",
                                       values = list()))
  options$trendsTrendVariable <- list()
  options$type <- "2"
  set.seed(1)
  results <- jaspTools::runAnalysis("MixedModelsLMM", "debug.csv", options)


  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "facGender", 0.0585272236145518, 0.111111111111111, 3.57863502661178
                                   ))
  })

  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(-0.421706207520219, "f", -0.704496301095866, 0.144283311227277,
                                        -0.138916113944573, 0.0410341526398586, "m", -0.296585024170459,
                                        0.172257847324448, 0.378653329450176))
  })

  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(10.7321152909456, -0.19033602744018, 0.110894939742407, 0.109555523338383,
                                        -1.73734761735647, "Intercept", 7.33364788694894, -0.231370180080039,
                                        0.0824437479104128, 0.115077396728607, -2.01056147129998, "facGender (1)"
                                   ))
  })

  test_that("facFive: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "Intercept", -1, 1, "facGender (1)"))
  })

  test_that("Residual Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_RES1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1.01581460714797, 1.03187931609519))
  })

  test_that("facFive: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.0906377552259416, 0.00821520267239771, "Intercept", 0.120437360968589,
                                        0.0145051579170782, "facGender (1)"))
  })

  test_that("Plot matches", {
    skip("temporarily disabled due to incompatibility with new ggplot2")
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-lmm-4")
  })
}

### fix plot - S + type II
{
  options <- jaspTools::analysisOptions("MixedModelsLMM")
  options$contrasts <- list(list(isContrast = TRUE, levels = list(), name = "Contrast 1",
                                 values = list()))
  options$bootstrapSamples <- 100
  options$dependent <- "contNormal"
  options$modelSummary <- TRUE
  options$fixedEffects <- list(list(components = "facGender"),
                               list(components = "debMiss30"),
                               list(components = c("facGender", "debMiss30")))
  options$includeIntercept <- TRUE
  options$factorContrast <- "sum"
  options$fixedVariables <- c("facGender", "debMiss30")
  options$testMethod <- "satterthwaite"
  options$plotTransparency <- 0.7
  options$plotDodge <- 0.3
  options$plotElementWidth <- 1
  options$plotJitterHeight <- 0
  options$plotJitterWidth <- 0.1
  options$plotLegendPosition <- "left"
  options$plotRelativeSizeData <- 1
  options$plotRelativeSizeText <- 1.5
  options$plotBackgroundData <- c("facFive")
  options$plotBackgroundColor <- "violet"
  options$plotCiType <- "model"
  options$plotCiLevel <- 0.95
  options$plotEstimatesTable <- FALSE
  options$plotBackgroundElement <- "boxjitter"
  options$plotLevelsByColor <- TRUE
  options$plotLevelsByFill <- FALSE
  options$plotLevelsByLinetype <- FALSE
  options$plotLevelsByShape <- FALSE
  options$plotSeparatePlots <- list()
  options$plotTheme <- "jasp"
  options$plotSeparateLines <- list()
  options$plotHorizontalAxis <- list(list(variable = "facGender"))
  options$vovkSellke <- FALSE
  options$randomEffects <- list(list(correlations = TRUE, value = "facFive"))
  options$randomEffects[[1]]$randomComponents[[length(options$randomEffects[[1]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$randomEffectEstimate <- FALSE
  options$randomVariables <- c("facFive")
  options$seed <- 1
  options$setSeed <- TRUE
  options$fixedEffectEstimate <- FALSE
  options$varianceCorrelationEstimate <- FALSE
  options$interceptTest <- FALSE
  options$trendsContrasts <- list(list(isContrast = TRUE, levels = list(), name = "Contrast 1",
                                       values = list()))
  options$trendsTrendVariable <- list()
  options$type <- "2"
  set.seed(1)
  results <- jaspTools::runAnalysis("MixedModelsLMM", "debug.csv", options)

  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("1, 64.20", "facGender", 0.252866174258413, 1.33121654854058,
                                        "1, 65.18", "debMiss30", 0.199639389176648, 1.6789088002452,
                                        "1, 62.40", "facGender<unicode><unicode><unicode>debMiss30",
                                        0.304695104142543, 1.07108241646932))
  })

  test_that("Sample sizes table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitSizes"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(5, 70))
  })

  test_that("Fit statistics table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_modelSummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(245.086327825346, 258.577299277642, 233.086327825346, 6, -116.543163912673
                                   ))
  })

  test_that("Plot matches", {
    skip("temporarily disabled due to incompatibility with new ggplot2")
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-lmm-5")
  })
}

### Test optimizer options
{
  test_that("Optimizer options can be set without errors", {
    options <- jaspTools::analysisOptions("MixedModelsLMM")
    options$dependent <- "Variable4"
    options$fixedEffects <- list(list(components = "Variable1"))
    options$randomEffects <- list(list(
      randomComponents = list(list(randomSlopes = FALSE, value = "Variable2"))
    ))
    
    # Test custom optimizer settings
    options$optimizerMethod <- "nlminb"
    options$optimizerMaxIter <- 5000
    options$optimizerMaxFunEvals <- 50000
    options$optimizerTolerance <- 1e-8
    options$optimizerCheckConv <- TRUE
    
    dataset <- data.frame(
      Variable1 = factor(rep(c("A", "B"), each = 20)),
      Variable2 = factor(rep(1:4, each = 10)),
      Variable4 = rnorm(40)
    )
    
    # Should not error during options processing
    results <- jaspTools::runAnalysis("MixedModelsLMM", dataset = dataset, options)
    
    # Basic check that analysis ran and produced some output
    expect_true(!is.null(results))
    expect_true(length(results$results) > 0)
  })
}

