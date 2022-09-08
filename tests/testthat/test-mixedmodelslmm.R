context("Linear Mixed Models")

### default, all selected output using Satterwhite method
{
  options <- jaspTools::analysisOptions("MixedModelsLMM")
  options$Contrasts <- list(list(isContrast = FALSE, levels = c("1", "2", "3", "4",
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
  options$dependentVariable <- "Variable4"
  options$fitStats <- TRUE
  options$fixedEffects <- list(list(components = "Variable1"), list(components = "Variable2"),
                               list(components = c("Variable1", "Variable2"
                               )), list(components = "Variable7"), list(components = c("Variable1",
                                                                                                    "Variable7")), list(components = c("Variable2",
                                                                                                                                                    "Variable7")), list(components = c("Variable1",
                                                                                                                                                                                                    "Variable2", "Variable7")))
  options$fixedVariables <- c("Variable1", "Variable2", "Variable7")
  options$marginalMeans <- list(list(variable = "Variable1"), list(variable = "Variable2"),
                                list(variable = "Variable7"))
  options$marginalMeansCompare <- TRUE
  options$marginalMeansContrast <- TRUE
  options$method <- "S"
  options$plotAlpha <- 0.7
  options$plotDodge <- 0.3
  options$plotGeomWidth <- 1
  options$plotJitterHeight <- 0
  options$plotJitterWidth <- 0.1
  options$plotLegendPosition <- "none"
  options$plotRelativeSize <- 1
  options$plotRelativeSizeText <- 1.5
  options$plotsAgregatedOver <- "Variable0"
  options$plotsBackgroundColor <- "darkgrey"
  options$plotsCImethod <- "model"
  options$plotsCIwidth <- 0.95
  options$plotsEstimatesTable <- TRUE
  options$plotsGeom <- "geom_jitter"
  options$plotsMappingColor <- FALSE
  options$plotsMappingFill <- FALSE
  options$plotsMappingLineType <- TRUE
  options$plotsMappingShape <- TRUE
  options$plotsPanel <- list()
  options$plotsTheme <- "JASP"
  options$plotsTrace <- list(list(variable = "Variable2"))
  options$plotsX <- list(list(variable = "Variable1"))
  options$pvalVS <- FALSE
  options$randomEffects <- list(list(correlations = TRUE, randomComponents = list(list(randomSlopes = TRUE,
                                                                                       value = "Variable1"), list(randomSlopes = FALSE,
                                                                                                                               value = "Variable2"), list(randomSlopes = FALSE,
                                                                                                                                                                       value = c("Variable1", "Variable2"
                                                                                                                                                                       )), list(randomSlopes = FALSE, value = "Variable7"),
                                                                                  list(randomSlopes = FALSE, value = c("Variable1",
                                                                                                                       "Variable7")), list(randomSlopes = FALSE, value = c("Variable2",
                                                                                                                                                                                        "Variable7")), list(randomSlopes = FALSE, value = c("Variable1",
                                                                                                                                                                                                                                                         "Variable2", "Variable7"))), value = "Variable0"))
  options$randomEffects[[1]]$randomComponents[[length(options$randomEffects[[1]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$showREEstimates <- TRUE
  options$randomVariables <- "Variable0"
  options$seed <- 1
  options$setSeed <- FALSE
  options$showFE <- TRUE
  options$showRE <- TRUE
  options$showREEstimates
  options$test_intercept <- FALSE
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
  options$trendsTrend <- list(list(variable = "Variable7"))
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
  results <-  jaspTools::runAnalysis("MixedModelsLMM", dataset, options)


  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("1, 257.99", "Variable1", 0.426414180238378, 0.634576077359649,
                                        "1, 282.23", "Variable2", 0.648104497286089, 0.208744742802555,
                                        "1, 282.92", "Variable7", 0.272159183015596, 1.21054651491042,
                                        "1, 283.64", "Variable1 * Variable2",
                                        0.74472366342099, 0.106225176201557, "1, 284.41", "Variable1 * Variable7",
                                        0.681782706300614, 0.168471669695429, "1, 284.53", "Variable2 * Variable7",
                                        0.633028958518581, 0.22846822915199, "1, 284.96", "Variable1 * Variable2 * Variable7",
                                        0.931744555167491, 0.00734892069033801))
  })

  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, 2, 0.134346556802761, 0.86617521917666, 0.578121119776051,
                                        1, 3.77898300979831e-09, 0.146969077836503, 5.89358817465159,
                                        1.15422931857727, 2, 2, 0.134346556802761, 1.04522972172199,
                                        0.819356095909459, 2, 1.19313221774637e-19, 0.115243763453919,
                                        9.06972915840201, 1.27110334753453, 1, 2, 0.527784183943333,
                                        0.202868270230306, -0.0486639111807904, 3, 0.113930657376259,
                                        0.128335103805554, 1.58076990795659, 0.454400451641402, 2, 2,
                                        0.527784183943333, 0.302728943195176, 0.108298561236786, 4,
                                        0.00227570339959547, 0.0992009973101711, 3.05167237632335, 0.497159325153566,
                                        1, 2, 0.921221811083906, -0.460438678716049, -0.736729381878811,
                                        5, 0.00108969845259244, 0.140967234776816, -3.26628155432736,
                                        -0.184147975553287, 2, 2, 0.921221811083906, -0.439771835331641,
                                        -0.680053672162645, 6, 0.000334258863071123, 0.122595026605752,
                                        -3.58719148327186, -0.199489998500637))
  })

  test_that("Estimated Means and Confidence Intervals table results match", {
    table <- results[["results"]][["EstimatesTable"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, 2, -0.087577849758617, 0.202868270230306, 0.493314390219228,
                                        2, 2, 0.0777669964062764, 0.302728943195176, 0.527690889984076
                                   ))
  })

  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(230.891606556034, 0.608062595749729, 0.372858810192038, 0.681023693258942,
                                        0.89286555191631, "Intercept", 257.98768727024, 0.327632122078992,
                                        0.426414180238378, 0.411286663217132, 0.796602835395185, "Variable1",
                                        282.226948919654, 0.139257176102306, 0.648104497286089, 0.304796384328169,
                                        0.456885918805291, "Variable2", 282.918621512351,
                                        -1.05885353945792, 0.272159183015596, 0.962376815249481, -1.1002483878245,
                                        "Variable7", 283.638799740339, -0.0607677106265602,
                                        0.74472366342099, 0.186448607814412, -0.325922040067187, "Variable1 * Variable2",
                                        284.412910787555, -0.24930037907597, 0.681782706300614, 0.607378617665152,
                                        -0.410453005465217, "Variable1 * Variable7",
                                        284.533506761359, -0.212893078541668, 0.633028958518581, 0.445398381324788,
                                        -0.477983503012384, "Variable2 * Variable7",
                                        284.963881035524, 0.0240067531742241, 0.931744555167491, 0.280041017559053,
                                        0.0857258461045326, "Variable1 * Variable2 * Variable7"
                                   ))
  })

  test_that("Variable0: Random Effect Estimates table results match", {
    table <- results[["results"]][["REEstimatesSummary"]][["collection"]][["REEstimatesSummary_REEstimates1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.827071744019561, -0.284795939395066, 1, -0.0136327854706812,
                                        -0.062313967962907, 2, -0.0223894298315962, -0.037743789007373,
                                        3, -0.034158839546811, 0.0700005964853584, 4, 0.0708883587124632,
                                        -0.0266287214958456, 5, 0.215575273726091, -0.00988200649825494,
                                        6, 0.397714427348485, -0.0998297710876426, 7, -0.688148389720007,
                                        0.134725869681511, 8, -0.634370805607246, 0.266739317029601,
                                        9, -0.118549553630228, 0.0497284122506085, 10))
  })

  test_that("Variable0: Random Effect Estimates table results match", {
    table <- results[["results"]][["REEstimatesSummary"]][["collection"]][["REEstimatesSummary_REEstimates1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.827071744019561, -0.284795939395066, 1, -0.0136327854706812,
                                        -0.062313967962907, 2, -0.0223894298315962, -0.037743789007373,
                                        3, -0.034158839546811, 0.0700005964853584, 4, 0.0708883587124632,
                                        -0.0266287214958456, 5, 0.215575273726091, -0.00988200649825494,
                                        6, 0.397714427348485, -0.0998297710876426, 7, -0.688148389720007,
                                        0.134725869681511, 8, -0.634370805607246, 0.266739317029601,
                                        9, -0.118549553630228, 0.0497284122506085, 10))
  })

  test_that("Variable0: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "Intercept", -0.895416305095377, 1, "Variable1"
                                   ))
  })

  test_that("Residual Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_RES1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.77051634334806, 0.593695435366465))
  })

  test_that("Variable0: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.531845577486718, 0.282859718292181, "Intercept", 0.214294032831598,
                                        0.0459219325072302, "Variable1"))
  })

  test_that("Sample sizes table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitSizes"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(10, 300))
  })

  test_that("Fit statistics table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitStats"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(749.049627510379, 793.495017206253, 725.049627510379, 12, -362.524813755189
                                   ))
  })

  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-lmm-1")
  })

  test_that("Estimated Trends table results match", {
    table <- results[["results"]][["trendsSummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, 2, -2.01129798868656, 1, 0.166008876685621, -1.68592656926879,
                                        -1.36055514985102, 2, 2, -2.21443143728523, 2, 0.166951024544311,
                                        -1.88721344199631, -1.5599954467074))
  })
}

### no correlations between random effects, Kernwald Roggers method, custom values
{
  options <- jaspTools::analysisOptions("MixedModelsLMM")
  options$Contrasts <- list(list(isContrast = FALSE, levels = c("2", "3", "4", "5",
                                                                "6", "7"), name = "contGamma", values = c("-3.2", "0", "3.2",
                                                                                                          "-3.2", "0", "3.2")), list(isContrast = FALSE, levels = c("2",
                                                                                                                                                                    "3", "4", "5", "6", "7"), name = "contBinom", values = c("0",
                                                                                                                                                                                                                             "0", "0", "1", "1", "1")), list(isContrast = TRUE, levels = c("2",
                                                                                                                                                                                                                                                                                           "3", "4", "5", "6", "7"), name = "Contrast 1", values = c("-1",
                                                                                                                                                                                                                                                                                                                                                     "1", "0", "0", "0", "0")), list(isContrast = TRUE, levels = c("2",
                                                                                                                                                                                                                                                                                                                                                                                                                   "3", "4", "5", "6", "7"), name = "Contrast 2", values = c("0",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             "0", "1", "-1", "0", "0")))
  options$bootstrapSamples <- 500
  options$dependentVariable <- "contNormal"
  options$fitStats <- FALSE
  options$fixedEffects <- list(list(components = "contGamma"), list(components = "contBinom"),
                               list(components = "facExperim"), list(components = "facGender"),
                               list(components = c("contGamma", "contBinom")), list(components = c("contGamma",
                                                                                                   "facExperim")), list(components = c("contGamma", "facGender"
                                                                                                   )), list(components = c("contBinom", "facExperim")), list(
                                                                                                     components = c("contBinom", "facGender")), list(components = c("facExperim",
                                                                                                                                                                    "facGender")), list(components = c("contGamma", "contBinom",
                                                                                                                                                                                                       "facExperim")), list(components = c("contGamma", "contBinom",
                                                                                                                                                                                                                                           "facGender")), list(components = c("contGamma", "facExperim",
                                                                                                                                                                                                                                                                              "facGender")), list(components = c("contBinom", "facExperim",
                                                                                                                                                                                                                                                                                                                 "facGender")), list(components = c("contGamma", "contBinom",
                                                                                                                                                                                                                                                                                                                                                    "facExperim", "facGender")))
  options$fixedVariables <- c("contGamma", "contBinom", "facExperim", "facGender")
  options$marginalMeans <- list(list(variable = "contGamma"), list(variable = "contBinom"))
  options$marginalMeansAdjustment <- "none"
  options$marginalMeansCompare <- TRUE
  options$marginalMeansCompareTo <- 1
  options$marginalMeansContrast <- TRUE
  options$marginalMeansDf <- "satterthwaite"
  options$marginalMeansSD <- 3.2
  options$method <- "KR"
  options$plotAlpha <- 0.7
  options$plotDodge <- 0.3
  options$plotGeomWidth <- 1
  options$plotJitterHeight <- 0
  options$plotJitterWidth <- 0.1
  options$plotLegendPosition <- "bottom"
  options$plotRelativeSize <- 1
  options$plotRelativeSizeText <- 1.5
  options$plotsAgregatedOver <- "facFive"
  options$plotsBackgroundColor <- "darkgrey"
  options$plotsCImethod <- "model"
  options$plotsCIwidth <- 0.95
  options$plotsEstimatesTable <- FALSE
  options$plotsGeom <- "geom_violin"
  options$plotsMappingColor <- FALSE
  options$plotsMappingFill <- TRUE
  options$plotsMappingLineType <- TRUE
  options$plotsMappingShape <- TRUE
  options$plotsPanel <- list()
  options$plotsTheme <- "theme_bw"
  options$plotsTrace <- list(list(variable = "facExperim"))
  options$plotsX <- list(list(variable = "contBinom"))
  options$pvalVS <- TRUE
  options$randomEffects <- list(list(correlations = FALSE, randomComponents = list(list(
    randomSlopes = TRUE, value = "contGamma"), list(randomSlopes = TRUE,
                                                    value = "contBinom"), list(randomSlopes = TRUE, value = "facExperim"),
    list(randomSlopes = TRUE, value = "facGender"), list(randomSlopes = FALSE,
                                                         value = c("contGamma", "contBinom")), list(randomSlopes = FALSE,
                                                                                                    value = c("contGamma", "facExperim")), list(randomSlopes = FALSE,
                                                                                                                                                value = c("contGamma", "facGender")), list(randomSlopes = FALSE,
                                                                                                                                                                                           value = c("contBinom", "facExperim")), list(randomSlopes = FALSE,
                                                                                                                                                                                                                                       value = c("contBinom", "facGender")), list(randomSlopes = FALSE,
                                                                                                                                                                                                                                                                                  value = c("facExperim", "facGender")), list(randomSlopes = FALSE,
                                                                                                                                                                                                                                                                                                                              value = c("contGamma", "contBinom", "facExperim")), list(
                                                                                                                                                                                                                                                                                                                                randomSlopes = FALSE, value = c("contGamma", "contBinom",
                                                                                                                                                                                                                                                                                                                                                                "facGender")), list(randomSlopes = FALSE, value = c("contGamma",
                                                                                                                                                                                                                                                                                                                                                                                                                    "facExperim", "facGender")), list(randomSlopes = FALSE, value = c("contBinom",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      "facExperim", "facGender")), list(randomSlopes = FALSE, value = c("contGamma",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        "contBinom", "facExperim", "facGender"))), value = "facFive"))
  options$randomEffects[[1]]$randomComponents[[length(options$randomEffects[[1]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$showREEstimates <- FALSE
  options$randomVariables <- "facFive"
  options$seed <- 1
  options$setSeed <- TRUE
  options$showFE <- TRUE
  options$showRE <- TRUE
  options$test_intercept <- FALSE
  options$trendsAdjustment <- "mvt"
  options$trendsCompare <- TRUE
  options$trendsCompareTo <- 9
  options$trendsContrast <- TRUE
  options$trendsContrasts <- list(list(isContrast = FALSE, levels = c("2", "3", "4", "5"),
                                       name = "facExperim", values = c("control", "experimental",
                                                                       "control", "experimental")), list(isContrast = FALSE, levels = c("2",
                                                                                                                                        "3", "4", "5"), name = "facGender", values = c("f", "f", "m",
                                                                                                                                                                                       "m")), list(isContrast = TRUE, levels = c("2", "3", "4", "5"),
                                                                                                                                                                                                   name = "Contrast 1", values = c("-1", "0", "1", "0")))
  options$trendsDf <- "kenward-roger"
  options$trendsTrend <- list(list(variable = "contGamma"))
  options$trendsVariables <- list(list(variable = "facExperim"), list(variable = "facGender"))
  options$type <- "3"
  set.seed(1)
  results <- jaspTools::runAnalysis("MixedModelsLMM", "debug", options)


  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                        list("1, 18.41", "contGamma", 0.653715812700852, 1, 0.207944253049949,
                             "1, 41.32", "contBinom", 0.980965955359944, 1, 0.000576132863050751,
                             "1, 31.67", "facExperim", 0.150390022121331, 1.29117932770481,
                             2.17227248698675, "1, 35.58", "facGender", 0.0893684915608006,
                             1.70453638001982, 3.04996380202582, "1, 70.43", "contGamma * contBinom",
                             0.810447727524037, 1, 0.0579609265254182, "1, 33.07", "contGamma * facExperim",
                             0.164381759735133, 1.23947869189993, 2.0221669964754, "1, 69.88",
                             "contBinom * facExperim", 0.280529553620231, 1.03170446672806,
                             1.1827716246055, "1, 72.17", "contGamma * facGender", 0.248688864505737,
                             1.06303978638395, 1.35240577480053, "1, 76.01", "contBinom * facGender",
                             0.584571198497188, 1, 0.301470766094538, "1, 76.13", "facExperim * facGender",
                             0.322904314874933, 1.00785908148147, 0.989958483556238, "1, 67.54",
                             "contGamma * contBinom * facExperim", 0.293532913259059, 1.02244820685648,
                             1.12073063012002, "1, 77.86", "contGamma * contBinom * facGender",
                             0.59600976539288, 1, 0.283380780706577, "1, 61.91", "contGamma * facExperim * facGender",
                             0.600511422182693, 1, 0.277066276890121, "1, 76.47", "contBinom * facExperim * facGender",
                             0.277160373603747, 1.0344128675967, 1.19798406204581, "1, 75.20",
                             "contGamma * contBinom * facExperim * facGender", 0.148676132254087,
                             1.2982095421261, 2.12924808409802))
  })

  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                        list(0, -2.8707548076634, 71.9900762735203, 0.162066154069144, -0.776927722113553,
                             1, 0.079474455095956, 1.82792948364777, 0.471035277718885, -1.77891951105823,
                             1.10106003025184, 0, 2.03296079621, 6.83551339852499, -0.0692441954233528,
                             -0.430458935145963, 2, 0.000229176926051888, 191.530501338905,
                             0.152013085498114, -7.03389574601208, 0.291970544299257, 0,
                             6.9366764000834, 70.4749790318247, -0.30055454491585, -1.22669794794237,
                             3, 0.00658188117451307, 11.1264013306953, 0.464418324934558,
                             -2.8003945475216, 0.625588858110671, 1, -2.8707548076634, 76.0103536416197,
                             0.342195635115593, -1.56362227186133, 4, 0.493900233473492,
                             1, 0.956895272816407, -0.687436110900942, 2.24801354209252,
                             1, 2.03296079621, 13.395648773507, -0.174532777943299, -0.587157752845552,
                             5, 3.15490120669621e-05, 1125.106616482, 0.191571066548363,
                             -6.13105516978884, 0.238092196958954, 1, 6.9366764000834, 75.9668749827945,
                             -0.691261191002192, -2.6382046591406, 6, 0.0876681586952261,
                             1.72388383172118, 0.977535027346068, -1.73012847999302, 1.25568227713622
                        ))
  })

  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                        list(29.731918444623, 0.0266514294991932, 0.912642659804403, 1, 0.240876860206388,
                             0.110643378016293, "Intercept", 82.2103671303575, -0.0471704250772184,
                             0.60243960877149, 1, 0.0902066016520024, -0.522915443142307,
                             "contGamma", 68.0420477271527, 0.0130387799605219, 0.978448341023034,
                             1, 0.480891048478861, 0.0271137922025494, "contBinom", 19.5295649109263,
                             0.399937000042345, 0.109010894179639, 1.52266936011703, 0.238148957337282,
                             1.67935650239245, "facExperim (1)", 58.4361636099556, -0.441265804273862,
                             0.0625340789907108, 2.12221168930464, 0.232394141170404, -1.89878196606644,
                             "facGender (1)", 63.2915011493182, -0.0582044487532978, 0.784703348218709,
                             1, 0.212148132344444, -0.274357582647944, "contGamma * contBinom",
                             75.4743641519868, -0.158068070457047, 0.0836341871674355, 1.77272714000759,
                             0.0901615963468768, -1.75316406165787, "contGamma * facExperim (1)",
                             80.6828758521473, -0.587981237452524, 0.224751722814565, 1.09651053282451,
                             0.480625000342396, -1.22336798342502, "contBinom * facExperim (1)",
                             73.8727112977714, 0.116963610432613, 0.192696976130626, 1.1593989642258,
                             0.0889699000150756, 1.3146424848493, "contGamma * facGender (1)",
                             69.3270163125925, 0.283197514348137, 0.554210137009061, 1, 0.476479576698649,
                             0.594353941275526, "contBinom * facGender (1)", 75.8559631009883,
                             -0.254977455283747, 0.270957820075519, 1.0397520526904, 0.229928159981303,
                             -1.10894400800877, "facExperim (1) * facGender (1)", 82.0644948806251,
                             0.257010756694346, 0.229537254199903, 1.08902040250822, 0.212306463344999,
                             1.21056491943301, "contGamma * contBinom * facExperim (1)",
                             77.0382448937387, -0.123446376566059, 0.561480368434535, 1,
                             0.211680641963219, -0.583172723878592, "contGamma * contBinom * facGender (1)",
                             74.0782282496845, 0.0545163929311743, 0.542267923379811, 1,
                             0.0890472901294798, 0.612218438673478, "contGamma * facExperim (1) * facGender (1)",
                             68.7562034137428, -0.550625289473946, 0.251264722541625, 1.05999121838667,
                             0.475896063157734, -1.15702846083735, "contBinom * facExperim (1) * facGender (1)",
                             67.4013086728085, 0.341027887810233, 0.111512063347184, 1.50390974606896,
                             0.211481679694976, 1.61256468315413, "contGamma * contBinom * facExperim (1) * facGender (1)"
                        ))
  })

  test_that("facFive.3: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE4"]][["data"]]
    jaspTools::expect_equal_tables(table,
                        list(1, "facExperim (control)", "NaN", 1, "facExperim (experimental)"
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
                        list(1.01552953184787, 1.03130023005516))
  })

  test_that("facFive: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                        list(0, 0, "Intercept"))
  })

  test_that("facFive.1: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE2"]][["data"]]
    jaspTools::expect_equal_tables(table,
                        list(0, 0, "contGamma"))
  })

  test_that("facFive.2: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE3"]][["data"]]
    jaspTools::expect_equal_tables(table,
                        list(0, 0, "contBinom"))
  })

  test_that("facFive.3: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE4"]][["data"]]
    jaspTools::expect_equal_tables(table,
                        list(0, 0, "facExperim (control)", 0.237531600307891, 0.0564212611448276,
                             "facExperim (experimental)"))
  })

  test_that("facFive.4: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE5"]][["data"]]
    jaspTools::expect_equal_tables(table,
                        list(0, 0, "facGender (f)", 0.156150662299331, 0.0243830293365197,
                             "facGender (m)"))
  })

  test_that("Contrasts table results match", {
    table <- results[["results"]][["contrastsTrends"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("Contrast 1", 57.0113581457788, -0.560541517971749, -1.17501676812672,
                                        0.0729821205951162, 1.92573082206986, 0.306860675388687, -1.82669713954626,
                                        0.0539337321832206))
  })

  test_that("Contrasts table results match", {
    table <- results[["results"]][["contrastsTrends"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("Contrast 1", 57.0113581457788, -0.560541517971749, -1.17501676812672,
                                        0.0729821205951162, 1.92573082206986, 0.306860675388687, -1.82669713954626,
                                        0.0539337321832206))
  })


  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-lmm-2")
  })

  test_that("Estimated Trends table results match", {
    table <- results[["results"]][["trendsSummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(54.9443259882744, "control", "f", -0.23167495146059, 1, 2.7550330650536e-44,
                                        1.33130145662102e+41, 0.202640740799574, 0.174435417422133,
                                        -43.5527650942956, 0.580545786304856, 71.3758039065814, "experimental",
                                        "f", -0.942035950037188, 2, 2.12975342580749e-37, 2.04564283019237e+34,
                                        0.363903152386286, -0.216499872030701, -25.3267931634935, 0.509036205975787,
                                        13.0257190149006, "control", "m", -0.919049752737067, 3, 9.75601854618026e-15,
                                        1168843939638.2, 0.246740583092494, -0.386106100549617, -38.040382262658,
                                        0.146837551637834, 27.2196843463106, "experimental", "m", -0.193181947767217,
                                        4, 5.62931397120266e-30, 9.70320596242461e+26, 0.154194675384417,
                                        0.123079957342715, -57.5695627655531, 0.439341862452647))
  })
}
### type II, LRT + intercept
{
  options <- jaspTools::analysisOptions("MixedModelsLMM")
  options$Contrasts <- list(list(isContrast = FALSE, levels = c("2", "3"), name = "facGender",
                                 values = c("f", "m")), list(isContrast = TRUE, levels = c("2",
                                                                                           "3"), name = "Contrast 1", values = c("0", "0")))
  options$bootstrapSamples <- 500
  options$dependentVariable <- "contNormal"
  options$fitStats <- FALSE
  options$fixedEffects <- list(list(components = "facGender"))
  options$fixedVariables <- "facGender"
  options$marginalMeans <- list(list(variable = "facGender"))
  options$method <- "LRT"
  options$plotAlpha <- 0.7
  options$plotDodge <- 0.3
  options$plotGeomWidth <- 1
  options$plotJitterHeight <- 0
  options$plotJitterWidth <- 0.1
  options$plotLegendPosition <- "left"
  options$plotRelativeSize <- 1
  options$plotRelativeSizeText <- 1.5
  options$plotsAgregatedOver <- c("contBinom", "facFive")
  options$plotsBackgroundColor <- "blue"
  options$plotsCImethod <- "model"
  options$plotsCIwidth <- 0.95
  options$plotsEstimatesTable <- TRUE
  options$plotsGeom <- "geom_boxplot"
  options$plotsMappingColor <- TRUE
  options$plotsMappingFill <- FALSE
  options$plotsMappingLineType <- TRUE
  options$plotsMappingShape <- TRUE
  options$plotsPanel <- list()
  options$plotsTheme <- "JASP"
  options$plotsTrace <- list()
  options$plotsX <- list(list(variable = "facGender"))
  options$pvalVS <- FALSE
  options$randomEffects <- list(list(correlations = TRUE, randomComponents = list(list(randomSlopes = TRUE,
                                                                                       value = "facGender")), value = "contBinom"), list(correlations = TRUE,
                                                                                                                                         randomComponents = list(list(randomSlopes = TRUE, value = "facGender")),
                                                                                                                                         value = "facFive"))
  options$randomEffects[[1]]$randomComponents[[length(options$randomEffects[[1]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$randomEffects[[2]]$randomComponents[[length(options$randomEffects[[2]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$showREEstimates <- FALSE
  options$randomVariables <- c("contBinom", "facFive")
  options$seed <- 1
  options$setSeed <- TRUE
  options$showFE <- TRUE
  options$showRE <- FALSE
  options$test_intercept <- TRUE
  options$trendsContrasts <- list(list(isContrast = TRUE, levels = list(), name = "Contrast 1",
                                       values = list()))
  options$trendsTrend <- list()
  options$type <- "2"
  set.seed(1)
  results <- jaspTools::runAnalysis("MixedModelsLMM", "debug", options)


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
                        list("f", -2.19323331697357, -0.421706173425421, 1.34982097012273,
                             "m", -0.812059108259059, 0.0410342976475168, 0.894127703554092
                        ))
  })

  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                        list(10.7325465569702, -0.190335937888952, 0.110892631343371, 0.10955506682194,
                             -1.73735403948323, "Intercept", 7.33390917066216, -0.231370235536469,
                             0.082440039209281, 0.115076349521506, -2.01058024953449, "facGender (1)"
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
  options$Contrasts <- list(list(isContrast = FALSE, levels = c("2", "3"), name = "facGender",
                                 values = c("f", "m")), list(isContrast = TRUE, levels = c("2",
                                                                                           "3"), name = "Contrast 1", values = c("0", "0")))
  options$bootstrapSamples <- 100
  options$dependentVariable <- "contNormal"
  options$fitStats <- FALSE
  options$fixedEffects <- list(list(components = "facGender"))
  options$fixedVariables <- "facGender"
  options$marginalMeans <- list(list(variable = "facGender"))
  options$method <- "PB"
  options$plotAlpha <- 0.7
  options$plotDodge <- 0.3
  options$plotGeomWidth <- 1
  options$plotJitterHeight <- 0
  options$plotJitterWidth <- 0.1
  options$plotLegendPosition <- "left"
  options$plotRelativeSize <- 1
  options$plotRelativeSizeText <- 1.5
  options$plotsAgregatedOver <- "facFive"
  options$plotsBackgroundColor <- "violet"
  options$plotsCImethod <- "model"
  options$plotsCIwidth <- 0.95
  options$plotsEstimatesTable <- FALSE
  options$plotsGeom <- "geom_boxjitter"
  options$plotsMappingColor <- TRUE
  options$plotsMappingFill <- FALSE
  options$plotsMappingLineType <- FALSE
  options$plotsMappingShape <- FALSE
  options$plotsPanel <- list()
  options$plotsTheme <- "JASP"
  options$plotsTrace <- list()
  options$plotsX <- list(list(variable = "facGender"))
  options$pvalVS <- FALSE
  options$randomEffects <- list(list(correlations = TRUE, randomComponents = list(list(randomSlopes = TRUE,
                                                                                       value = "facGender")), value = "facFive"))
  options$randomEffects[[1]]$randomComponents[[length(options$randomEffects[[1]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$showREEstimates <- FALSE
  options$randomVariables <- "facFive"
  options$seed <- 1
  options$setSeed <- TRUE
  options$showFE <- TRUE
  options$showRE <- TRUE
  options$test_intercept <- FALSE
  options$trendsContrasts <- list(list(isContrast = TRUE, levels = list(), name = "Contrast 1",
                                       values = list()))
  options$trendsTrend <- list()
  options$type <- "2"
  set.seed(1)
  results <- jaspTools::runAnalysis("MixedModelsLMM", "debug", options)


  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                        list(1, "facGender", 0.0585272236145518, 0.129411764705882, 3.57863502661178
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
                        list(10.7321152909457, -0.19033602744018, 0.110894939742407, 0.109555523338383,
                             -1.73734761735647, "Intercept", 7.33364788694893, -0.231370180080039,
                             0.0824437479104129, 0.115077396728607, -2.01056147129998, "facGender (1)"
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
                        list(1.01581460714797, 1.00787628563627))
  })

  test_that("facFive: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                        list(0.0906377552259416, 0.00821520267239771, "Intercept", 0.120437360968589,
                             0.0145051579170782, "facGender (1)"))
  })

  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-lmm-4")
  })
}

### fix plot - S + type II
{
  options <- jaspTools::analysisOptions("MixedModelsLMM")
  options$Contrasts <- list(list(isContrast = TRUE, levels = list(), name = "Contrast 1",
                                 values = list()))
  options$bootstrapSamples <- 100
  options$dependentVariable <- "contNormal"
  options$fitStats <- TRUE
  options$fixedEffects <- list(list(components = "facGender"), list(components = "debMiss30"),
                               list(components = c("facGender", "debMiss30")))
  options$fixedVariables <- c("facGender", "debMiss30")
  options$method <- "S"
  options$plotAlpha <- 0.7
  options$plotDodge <- 0.3
  options$plotGeomWidth <- 1
  options$plotJitterHeight <- 0
  options$plotJitterWidth <- 0.1
  options$plotLegendPosition <- "left"
  options$plotRelativeSize <- 1
  options$plotRelativeSizeText <- 1.5
  options$plotsAgregatedOver <- c("facFive")
  options$plotsBackgroundColor <- "violet"
  options$plotsCImethod <- "model"
  options$plotsCIwidth <- 0.95
  options$plotsEstimatesTable <- FALSE
  options$plotsGeom <- "geom_boxjitter"
  options$plotsMappingColor <- TRUE
  options$plotsMappingFill <- FALSE
  options$plotsMappingLineType <- FALSE
  options$plotsMappingShape <- FALSE
  options$plotsPanel <- list()
  options$plotsTheme <- "JASP"
  options$plotsTrace <- list()
  options$plotsX <- list(list(variable = "facGender"))
  options$pvalVS <- FALSE
  options$randomEffects <- list(list(correlations = TRUE, value = "facFive"))
  options$randomEffects[[1]]$randomComponents[[length(options$randomEffects[[1]]$randomComponents) + 1]] <- list(randomSlopes = TRUE, value = "Intercept")
  options$showREEstimates <- FALSE
  options$randomVariables <- c("facFive")
  options$seed <- 1
  options$setSeed <- TRUE
  options$showFE <- FALSE
  options$showRE <- FALSE
  options$test_intercept <- FALSE
  options$trendsContrasts <- list(list(isContrast = TRUE, levels = list(), name = "Contrast 1",
                                       values = list()))
  options$trendsTrend <- list()
  options$type <- "2"
  set.seed(1)
  results <- jaspTools::runAnalysis("MixedModelsLMM", "debug", options)

  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("1, 64.20", "facGender", 0.252866174262488, 1.33121654851917,
                                        "1, 65.18", "debMiss30", 0.199639389175723, 1.67890880025083,
                                        "1, 62.40", "facGender * debMiss30", 0.304695104140844, 1.07108241647693
                                   ))
  })

  test_that("Sample sizes table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitSizes"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(5, 70))
  })

  test_that("Fit statistics table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitStats"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(245.086327825346, 258.577299277642, 233.086327825346, 6, -116.543163912673
                                   ))
  })

  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-lmm-5")
  })
}

