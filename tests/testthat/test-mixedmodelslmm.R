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
                                   list("1, 24.95", "contGamma", 0.527100931518472, 0.411415824934018,
                                        1, "1, 36.43", "contBinom", 0.98574532323958, 0.000323625178438065,
                                        1, "1, 26.72", "facExperim", 0.768251434771851, 0.088612177384302,
                                        1, "1, 36.32", "facGender", 0.244857802038136, 1.39729601794193,
                                        1.06775966369609, "1, 78.38", "contGamma<unicode><unicode><unicode>contBinom",
                                        0.825179979100828, 0.0491189142055198, 1, "1, 62.85", "contGamma<unicode><unicode><unicode>facExperim",
                                        0.880307340230056, 0.022859477986458, 1, "1, 71.72", "contBinom<unicode><unicode><unicode>facExperim",
                                        0.275965622554177, 1.20515503855123, 1.03540530812882, "1, 77.35",
                                        "contGamma<unicode><unicode><unicode>facGender", 0.679735447841695,
                                        0.171719093504935, 1, "1, 75.46", "contBinom<unicode><unicode><unicode>facGender",
                                        0.554057735675456, 0.353248607213513, 1, "1, 72.10", "facExperim<unicode><unicode><unicode>facGender",
                                        0.0460674924644154, 4.12010221968345, 2.59472918029558, "1, 70.07",
                                        "contGamma<unicode><unicode><unicode>contBinom<unicode><unicode><unicode>facExperim",
                                        0.279276477118563, 1.18895146215363, 1.03269634921325, "1, 76.77",
                                        "contGamma<unicode><unicode><unicode>contBinom<unicode><unicode><unicode>facGender",
                                        0.515347262135336, 0.427142663941378, 1, "1, 62.07", "contGamma<unicode><unicode><unicode>facExperim<unicode><unicode><unicode>facGender",
                                        0.0747753451225162, 3.28447876885882, 1.89714204225366, "1, 76.56",
                                        "contBinom<unicode><unicode><unicode>facExperim<unicode><unicode><unicode>facGender",
                                        0.244685652316902, 1.37443886762277, 1.0679770781693, "1, 77.58",
                                        "contGamma<unicode><unicode><unicode>contBinom<unicode><unicode><unicode>facExperim<unicode><unicode><unicode>facGender",
                                        0.123483158086117, 2.42500747623673, 1.4243236006837))
  })

  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0, -2.8707548076634, 74.9163062930063, 0.198742520673073, -0.728981056250254,
                                        1, 0.0894564762859935, 0.465692277531644, -1.72057282885152,
                                        1.1264660975964, 1.70355403200964, 0, 2.03296079621, 8.90941853925042,
                                        -0.0639880354026389, -0.380975227755268, 2, 3.5002445972971e-05,
                                        0.139908938134265, -7.60486105885221, 0.25299915694999, 1024.36762255107,
                                        0, 6.9366764000834, 75.7839575146335, -0.326718591478351, -1.23807100986211,
                                        3, 0.00488664541806936, 0.457560343313052, -2.89954890293156,
                                        0.584633826905407, 14.1475452433024, 1, -2.8707548076634, 77.9471084477214,
                                        0.336008134316729, -1.55005927682203, 4, 0.485460533009269,
                                        0.947359183157623, -0.700887137094226, 2.22207554545549, 1,
                                        1, 2.03296079621, 17.6878778908743, -0.177006850780954, -0.557374560441862,
                                        5, 4.4019622754309e-06, 0.180819005745989, -6.50930938329784,
                                        0.203360858879953, 6776.013568979, 1, 6.9366764000834, 77.9167726113751,
                                        -0.690021835878638, -2.62147398870453, 6, 0.0854507341922167,
                                        0.970149685130538, -1.74202173312177, 1.24143031694725, 1.75019816865655
                                        ))
  })

  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(38.9223595181119, 0.0403051401365741, 0.869070694356613, 0.24290397667326,
                                        0.165930342881089, "Intercept", 1, 79.9966325914574, -0.0790977295421294,
                                        0.462739032235846, 0.107194146507331, -0.737892246165886, "contGamma",
                                        1, 77.9677962011386, 0.00462850010740863, 0.984474061709385,
                                        0.237083886121755, 0.0195226262869323, "contBinom (1)", 1, 27.0775042268394,
                                        0.0848885328957462, 0.746622920404962, 0.260066323368414, 0.32641109312524,
                                        "facExperim (1)", 1, 34.557471184256, -0.297536577731769, 0.221399566023406,
                                        0.238927600825048, -1.24530015244926, "facGender (1)", 1.10201874878708,
                                        77.8763131628069, 0.0255198760735914, 0.80813729068343, 0.104736938990672,
                                        0.243656882848794, "contGamma<unicode><unicode><unicode>contBinom (1)",
                                        1, 77.3499162293428, -0.0186048353264092, 0.861520894072381,
                                        0.106300920095798, -0.175020454288096, "contGamma<unicode><unicode><unicode>facExperim (1)",
                                        1, 79.9584740758974, 0.289671059825999, 0.228885126864409, 0.238900699812722,
                                        1.21251658137911, "contBinom (1)<unicode><unicode><unicode>facExperim (1)",
                                        1.09001594440455, 79.002848351316, 0.0465234405064209, 0.660159064415979,
                                        0.10540963276791, 0.441358529432084, "contGamma<unicode><unicode><unicode>facGender (1)",
                                        1, 77.9386004230273, -0.148937150726194, 0.529563485386421,
                                        0.235847777701331, -0.631496943400512, "contBinom (1)<unicode><unicode><unicode>facGender (1)",
                                        1, 77.3357065419251, -0.528653922275206, 0.0282536417943189,
                                        0.236457450896696, -2.23572537160678, "facExperim (1)<unicode><unicode><unicode>facGender (1)",
                                        3.65077314072331, 81.6768629914167, -0.128432134147293, 0.228138958002737,
                                        0.105767891000392, -1.2142828313256, "contGamma<unicode><unicode><unicode>contBinom (1)<unicode><unicode><unicode>facExperim (1)",
                                        1.0911646635785, 79.6854732974108, 0.0733689561028212, 0.487049752003855,
                                        0.105074559693381, 0.6982561365655, "contGamma<unicode><unicode><unicode>contBinom (1)<unicode><unicode><unicode>facGender (1)",
                                        1, 75.2343060985007, 0.218094935511541, 0.0407022008486458,
                                        0.104730647062131, 2.08243662795436, "contGamma<unicode><unicode><unicode>facExperim (1)<unicode><unicode><unicode>facGender (1)",
                                        2.82317478326911, 77.1190706539896, 0.289063273169157, 0.22391200670058,
                                        0.235768684339337, 1.22604608826299, "contBinom (1)<unicode><unicode><unicode>facExperim (1)<unicode><unicode><unicode>facGender (1)",
                                        1.09786969247111, 78.2924248822159, -0.176137077236353, 0.0959135824488616,
                                        0.104514025226244, -1.68529608208147, "contGamma<unicode><unicode><unicode>contBinom (1)<unicode><unicode><unicode>facExperim (1)<unicode><unicode><unicode>facGender (1)",
                                        1.63610358413428))
  })

  test_that("No correlations between random effects are estimated", {
    collection <- results[["results"]][["REsummary"]][["collection"]]
    expect_false(any(startsWith(names(collection), "REsummary_CE")))
  })

  test_that("Residual Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_RES5"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1.00616413589567, 1.01236626836269))
  })

  test_that("facFive: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.0677549614622954, 0.00459073480275714, "Intercept"))
  })

  test_that("facFive.1: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE2"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0, 0, "contGamma"))
  })

  test_that("facFive.2: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE3"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0, 0, "contBinom (1)"))
  })

  test_that("facFive.3: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE4"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.228131769511605, 0.0520441042604962, "facExperim (1)"))
  })

  test_that("facFive.4: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE5"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.0647185533564699, 0.00418849114855424, "facGender (1)"))
  })

  test_that("contrasts table results match", {
    table <- results[["results"]][["contrastsMeans"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("Contrast 1", 83.0044113444804, -0.262730556075712, -1.13773852048114,
                                        0.551995437117692, 0.439932803497109, -0.597206105085179, 0.612277408329713,
                                        1, "Contrast 2", 79.6061111142129, -0.66272672579508, -2.77623194351085,
                                        0.534368068444667, 1.06194840608835, -0.624066783278306, 1.45077849192069,
                                        1))
  })

  test_that("contrasts table results match", {
    table <- results[["results"]][["contrastsTrends"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("Contrast 1", 65.411617255302, -0.529236752035926, -1.10132600580273,
                                        0.069223625868534, 0.286488729096432, -1.84732137178697, 0.0428525017308735,
                                        1.99009006329072))
  })

  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-lmm-2")
  })

  test_that("Estimated Trends table results match", {
    table <- results[["results"]][["trendsSummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(62.1928798155519, "control", "f", -0.222000465198283, 1, 2.1437505300174e-49,
                                        0.194570190660621, 0.166915811149424, -45.39793150667, 0.555832087497131,
                                        1.53131563439988e+46, 80.92772067515, "experimental", "f", -0.921817994156582,
                                        2, 8.42527800446761e-42, 0.346659801612683, -0.232064389220841,
                                        -26.6314823532255, 0.457689215714899, 4.6167270042172e+38, 20.585632189079,
                                        "control", "m", -0.826199265089896, 3, 1.94976677214278e-21,
                                        0.222786462026486, -0.362320940886502, -42.023742626576, 0.101557383316892,
                                        3956641502107865088, 25.6852740568734, "experimental", "m",
                                        -0.194526696448178, 4, 4.15978473832453e-29, 0.148586075263185,
                                        0.111078600789401, -59.8233810501152, 0.416683898026979, 1.35329464330767e+26
                                        ))
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

