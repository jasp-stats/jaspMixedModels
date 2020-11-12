context("Linear Mixed Models")


### default, all selected output using Satterwhite method
{
  options <- jaspTools::analysisOptions("MixedModelsLMM")
  options$Contrasts <- list(list(isContrast = FALSE, levels = c("2", "3", "4", "5", 
                                                                "6", "7"), name = "contGamma", values = c("-1", "0", "1", "-1", 
                                                                                                          "0", "1")), list(isContrast = FALSE, levels = c("2", "3", "4", 
                                                                                                                                                          "5", "6", "7"), name = "contBinom", values = c("0", "0", "0", 
                                                                                                                                                                                                         "1", "1", "1")), list(isContrast = TRUE, levels = c("2", "3", 
                                                                                                                                                                                                                                                             "4", "5", "6", "7"), name = "Contrast 1", values = c("-1", "1", 
                                                                                                                                                                                                                                                                                                                  "0", "0", "0", "0")), list(isContrast = TRUE, levels = c("2", 
                                                                                                                                                                                                                                                                                                                                                                           "3", "4", "5", "6", "7"), name = "Contrast 2", values = c("0", 
                                                                                                                                                                                                                                                                                                                                                                                                                                     "0", "1", "-1", "0", "0")))
  options$bootstrap_samples <- 500
  options$dependentVariable <- "contNormal"
  options$fitStats <- TRUE
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
  options$plotsAgregatedOver <- "facFive"
  options$plotsBackgroundColor <- "darkgrey"
  options$plotsCImethod <- "model"
  options$plotsCIwidth <- 0.95
  options$plotsEstimatesTable <- FALSE
  options$plotsGeom <- "geom_jitter"
  options$plotsMappingColor <- FALSE
  options$plotsMappingFill <- FALSE
  options$plotsMappingLineType <- TRUE
  options$plotsMappingShape <- TRUE
  options$plotsPanel <- list(list(variable = "facGender"))
  options$plotsTheme <- "JASP"
  options$plotsTrace <- list(list(variable = "facExperim"))
  options$plotsX <- list(list(variable = "contBinom"))
  options$pvalVS <- TRUE
  options$randomEffects <- list(list(correlations = TRUE, randomComponents = list(list(randomSlopes = TRUE, 
                                                                                       value = "contGamma"), list(randomSlopes = TRUE, value = "contBinom"), 
                                                                                  list(randomSlopes = TRUE, value = "facExperim"), list(randomSlopes = TRUE, 
                                                                                                                                        value = "facGender"), list(randomSlopes = FALSE, value = c("contGamma", 
                                                                                                                                                                                                   "contBinom")), list(randomSlopes = FALSE, value = c("contGamma", 
                                                                                                                                                                                                                                                       "facExperim")), list(randomSlopes = FALSE, value = c("contGamma", 
                                                                                                                                                                                                                                                                                                            "facGender")), list(randomSlopes = FALSE, value = c("contBinom", 
                                                                                                                                                                                                                                                                                                                                                                "facExperim")), list(randomSlopes = FALSE, value = c("contBinom", 
                                                                                                                                                                                                                                                                                                                                                                                                                     "facGender")), list(randomSlopes = FALSE, value = c("facExperim", 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                         "facGender")), list(randomSlopes = FALSE, value = c("contGamma", 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             "contBinom", "facExperim")), list(randomSlopes = FALSE, value = c("contGamma", 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               "contBinom", "facGender")), list(randomSlopes = FALSE, value = c("contGamma", 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                "facExperim", "facGender")), list(randomSlopes = FALSE, value = c("contBinom", 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  "facExperim", "facGender")), list(randomSlopes = FALSE, value = c("contGamma", 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    "contBinom", "facExperim", "facGender"))), value = "facFive"))
  options$randomVariables <- "facFive"
  options$seed <- 1
  options$setSeed <- TRUE
  options$showFE <- TRUE
  options$showRE <- TRUE
  options$test_intercept <- FALSE
  options$trendsAdjustment <- "mvt"
  options$trendsContrast <- TRUE
  options$trendsContrasts <- list(list(isContrast = FALSE, levels = c("2", "3", "4", "5"), 
                                       name = "facExperim", values = c("control", "experimental", 
                                                                       "control", "experimental")), list(isContrast = FALSE, levels = c("2", 
                                                                                                                                        "3", "4", "5"), name = "facGender", values = c("f", "f", "m", 
                                                                                                                                                                                       "m")), list(isContrast = TRUE, levels = c("2", "3", "4", "5"), 
                                                                                                                                                                                                   name = "Contrast 1", values = c("-1", "0", "1", "0")))
  options$trendsTrend <- list(list(variable = "contGamma"))
  options$trendsVariables <- list(list(variable = "facExperim"), list(variable = "facGender"))
  options$type <- "3"
  set.seed(1)
  results <- jaspTools::runAnalysis("MixedModelsLMM", "debug", options)
  
  
  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    expect_equal_tables(table,
                        list("1, 3.99", "contGamma", 0.733432779525737, 1, 0.133446135293009,
                             "1, 61.47", "contBinom", 0.768257135731431, 1, 0.0875931016397921,
                             "1, 17.60", "facExperim", 0.140991099280472, 1.33188403467366,
                             2.37612217829835, "1, 25.74", "facGender", 0.133684697216638,
                             1.36753136975391, 2.39816181078014, "1, 75.87", "contGamma * contBinom",
                             0.562583954759993, 1, 0.338217471459305, "1, 56.27", "contGamma * facExperim",
                             0.0359720354642175, 3.07572215343327, 4.61708825808892, "1, 74.95",
                             "contBinom * facExperim", 0.109270351193189, 1.52068498696597,
                             2.6268406888568, "1, 76.98", "contGamma * facGender", 0.238601555473097,
                             1.07596490022641, 1.41064259900825, "1, 77.57", "contBinom * facGender",
                             0.381806042777233, 1, 0.773653013859393, "1, 73.64", "facExperim * facGender",
                             0.229088804343903, 1.08970417035645, 1.47084323198013, "1, 78.19",
                             "contGamma * contBinom * facExperim", 0.0730485837286643, 1.92464800474014,
                             3.30149605025904, "1, 78.12", "contGamma * contBinom * facGender",
                             0.246845311286431, 1.06528292850398, 1.3613949598617, "1, 63.82",
                             "contGamma * facExperim * facGender", 0.62828465350581, 1, 0.236674808108425,
                             "1, 76.32", "contBinom * facExperim * facGender", 0.167137220579382,
                             1.23037227838201, 1.94533157167669, "1, 76.13", "contGamma * contBinom * facExperim * facGender",
                             0.0504344037090304, 2.44192051231226, 3.95118093304616))
  })
  
  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    expect_equal_tables(table,
                        list(0, 0.500549669999563, -0.0262552612430794, -0.556567256678456,
                             1, 0.922697788021305, 1, 0.270572316439695, -0.0970360219720819,
                             0.504056734192297, 0, 2.03296079621, -0.0920382293190803, -0.3867916539565,
                             2, 0.540532103762069, 1, 0.150387163724639, -0.612008545407531,
                             0.20271519531834, 0, 3.56537192242044, -0.157821197395081, -0.534212538664717,
                             3, 0.41118247849245, 1, 0.192039927385688, -0.821814502554551,
                             0.218570143874555, 1, 0.500549669999563, 0.0520042385239482,
                             -0.60711655575755, 4, 0.877105139922623, 1, 0.336292298981287,
                             0.154639992296826, 0.711125032805446, 1, 2.03296079621, -0.192674834488664,
                             -0.530639129092016, 5, 0.263830374404009, 1.04647813949676,
                             0.172433931066679, -1.11738352942936, 0.145289460114688, 1,
                             3.56537192242044, -0.437353907501277, -1.16501737084163, 6,
                             0.238790937252014, 1.07570716445033, 0.371263691108648, -1.17801422001509,
                             0.290309555839077))
  })
  
  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    expect_equal_tables(table,
                        list(4.879830263102, -0.00476778807165816, 0.98877814437916, 1, 0.322160625584879,
                             -0.0147994127556783, "Intercept", 3.98851208294517, -0.0429277541456374,
                             0.733432779525737, 1, 0.117512798174947, -0.365302799459584,
                             "contGamma", 61.4723761566809, 0.136694462003089, 0.768257135731431,
                             1, 0.461865972940677, 0.295961317809933, "contBinom", 17.599536796426,
                             0.397657377731286, 0.140991099280472, 1.33188403467366, 0.257973241273748,
                             1.54146754046212, "facExperim (1)", 25.7441454398096, -0.376043622472492,
                             0.133684697216638, 1.36753136975391, 0.242828124868718, -1.54859995182104,
                             "facGender (1)", 75.8671086094359, -0.116741585777318, 0.562583954759993,
                             1, 0.200737064598914, -0.581564675216184, "contGamma * contBinom",
                             56.2683689039279, -0.186326785830887, 0.0359720354642175, 3.07572215343327,
                             0.086714396153073, -2.14874108679685, "contGamma * facExperim (1)",
                             74.9536215197383, -0.747194108570869, 0.109270351193189, 1.52068498696597,
                             0.461016608588035, -1.62075312396947, "contBinom * facExperim (1)",
                             76.9793621105575, 0.101086278472721, 0.238601555473097, 1.07596490022641,
                             0.0851106114941712, 1.18770476087631, "contGamma * facGender (1)",
                             77.5717143136931, 0.401298376699643, 0.381806042777233, 1, 0.456240980698394,
                             0.87957547365726, "contBinom * facGender (1)", 73.6430433555445,
                             -0.26977251883103, 0.229088804343903, 1.08970417035645, 0.222440833472165,
                             -1.21278325845146, "facExperim (1) * facGender (1)", 78.1873024709906,
                             0.374128923621069, 0.0730485837286643, 1.92464800474014, 0.205904526224302,
                             1.81700194008125, "contGamma * contBinom * facExperim (1)",
                             78.1197797696417, -0.239396449702659, 0.246845311286431, 1.06528292850398,
                             0.205175564148243, -1.16678830978961, "contGamma * contBinom * facGender (1)",
                             63.8191807665898, 0.0421476869510802, 0.62828465350581, 1, 0.0866358675887234,
                             0.486492351541548, "contGamma * facExperim (1) * facGender (1)",
                             76.3184865456089, -0.631780132028148, 0.167137220579382, 1.23037227838201,
                             0.452969694212594, -1.39475143723772, "contBinom * facExperim (1) * facGender (1)",
                             76.1328187360113, 0.399620616228927, 0.0504344037090304, 2.44192051231226,
                             0.201040903086143, 1.98775776518321, "contGamma * contBinom * facExperim (1) * facGender (1)"
                        ))
  })
  
  test_that("facFive: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE1"]][["data"]]
    expect_equal_tables(table,
                        list(1, "Intercept", -0.99904096160064, 1, "contGamma", -0.999422367135209,
                             0.999815525768698, 1, "contBinom", 0.21082505051773, -0.174976830028956,
                             -0.177881767798439, 1, "facExperim (1)", -0.630322708742666,
                             0.60180791641628, 0.603983175341464, -0.891605752745252, 1,
                             "facGender (1)"))
  })
  
  test_that("Residual Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_RES1"]][["data"]]
    expect_equal_tables(table,
                        list(0.95668225055693, 0.915240928530672))
  })
  
  test_that("facFive: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    expect_equal_tables(table,
                        list(0.509288238103004, 0.259374509470062, "Intercept", 0.177101956977593,
                             0.0313651031652932, "contGamma", 0.187084810445687, 0.0350007262994985,
                             "contBinom", 0.304723846432368, 0.0928566225845372, "facExperim (1)",
                             0.233448399798324, 0.0544981553683982, "facGender (1)"))
  })
  
  test_that("Contrasts table results match", {
    table <- results[["results"]][["contrasts_Means"]][["data"]]
    expect_equal_tables(table,
                        list("Contrast 1", "<unicode><unicode><unicode>", -0.065782968076001,
                             1, 1, 0.180077919395411, -0.365302799459584, "Contrast 2", "<unicode><unicode><unicode>",
                             -0.209825435919029, 1, 1, 0.403025861520048, -0.520625240096638
                        ))
  })
  
  test_that("Contrasts table results match", {
    table <- results[["results"]][["contrasts_Trends"]][["data"]]
    expect_equal_tables(table,
                        list("Contrast 1", "<unicode><unicode><unicode>", -0.446692097373872,
                             0.0713514328250483, 1.95288295758168, 0.24771717598931, -1.80323425531522
                        ))
  })
  
  test_that("Sample sizes table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitSizes"]][["data"]]
    expect_equal_tables(table,
                        list(5, 100))
  })
  
  test_that("Fit statistics table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitStats"]][["data"]]
    expect_equal_tables(table,
                        list(368.570585248471, 451.93603120009, 268.686518789578, 304.570585248471,
                             32, -152.285292624235))
  })
  
  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    expect_equal_plots(testPlot, "plot-lmm-1", dir="MixedModelsLMM")
  })
  
  test_that("Estimated Trends table results match", {
    table <- results[["results"]][["trendsSummary"]][["data"]]
    expect_equal_tables(table,
                        list("control", "f", -0.254288816251151, 1, 0.192388225935654, 0.122785177632287,
                             0.499859171515724, "experimental", "f", -0.988757759420514,
                             2, 0.319470969824661, -0.362606164458097, 0.26354543050432,
                             "control", "m", -0.706676459489367, 3, 0.195294170080174, -0.323906919741585,
                             0.0588626200061966, "experimental", "m", -0.118213285900302,
                             4, 0.141200045773012, 0.158533718430209, 0.43528072276072))
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
  options$bootstrap_samples <- 500
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
    expect_equal_tables(table,
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
    expect_equal_tables(table,
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
    expect_equal_tables(table,
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
    expect_equal_tables(table,
                        list(1, "facExperim (control)", "NaN", 1, "facExperim (experimental)"
                        ))
  })
  
  test_that("facFive.4: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE5"]][["data"]]
    expect_equal_tables(table,
                        list(1, "facGender (f)", "NaN", 1, "facGender (m)"))
  })
  
  test_that("Residual Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_RES5"]][["data"]]
    expect_equal_tables(table,
                        list(1.01552953184787, 1.03130023005516))
  })
  
  test_that("facFive: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    expect_equal_tables(table,
                        list(0, 0, "Intercept"))
  })
  
  test_that("facFive.1: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE2"]][["data"]]
    expect_equal_tables(table,
                        list(0, 0, "contGamma"))
  })
  
  test_that("facFive.2: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE3"]][["data"]]
    expect_equal_tables(table,
                        list(0, 0, "contBinom"))
  })
  
  test_that("facFive.3: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE4"]][["data"]]
    expect_equal_tables(table,
                        list(0, 0, "facExperim (control)", 0.237531600307891, 0.0564212611448276,
                             "facExperim (experimental)"))
  })
  
  test_that("facFive.4: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE5"]][["data"]]
    expect_equal_tables(table,
                        list(0, 0, "facGender (f)", 0.156150662299331, 0.0243830293365197,
                             "facGender (m)"))
  })
  
  test_that("Contrasts table results match", {
    table <- results[["results"]][["contrasts_Means"]][["data"]]
    expect_equal_tables(table,
                        list("Contrast 1", 82.2103671303575, -0.231310349492497, 0.60243960877149,
                             1, 0.442347520093316, -0.522915443142307, "Contrast 2", 79.902751067842,
                             -0.642750180031443, 0.548152227927422, 1, 1.06574918195276,
                             -0.603097042827413))
  })
  
  test_that("Contrasts table results match", {
    table <- results[["results"]][["contrasts_Trends"]][["data"]]
    expect_equal_tables(table,
                        list("Contrast 1", 57.0113581457788, -0.560541517971749, 0.0729821205951162,
                             1.92573082206986, 0.306860675388687, -1.82669713954627))
  })
  
  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    expect_equal_plots(testPlot, "plot-lmm-2", dir="MixedModelsLMM")
  })
  
  test_that("Estimated Trends table results match", {
    table <- results[["results"]][["trendsSummary"]][["data"]]
    expect_equal_tables(table,
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
  options$bootstrap_samples <- 500
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
    expect_equal_tables(table,
                        list(1, "facGender", 0.0892620294750889, 2.88763209614939))
  })
  
  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    expect_equal_tables(table,
                        list(-0.421706173425421, "f", -0.704496259899192, 0.144283307603805,
                             -0.13891608695165, 0.0410342976475168, "m", -0.296581004637054,
                             0.172255870489273, 0.378649599932087))
  })
  
  test_that("Estimated Means and Confidence Intervals table results match", {
    table <- results[["results"]][["EstimatesTable"]][["data"]]
    expect_equal_tables(table,
                        list("f", -2.19323331697357, -0.421706173425421, 1.34982097012273,
                             "m", -0.812059108259059, 0.0410342976475168, 0.894127703554092
                        ))
  })
  
  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    expect_equal_tables(table,
                        list(10.7325465569702, -0.190335937888952, 0.110892631343371, 0.10955506682194,
                             -1.73735403948323, "Intercept", 7.33390917066216, -0.231370235536469,
                             0.082440039209281, 0.115076349521506, -2.01058024953449, "facGender (1)"
                        ))
  })
  
  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    expect_equal_plots(testPlot, "plot-lmm-3", dir="MixedModelsLMM")
  })
}
### parametric bootstrap
{
  options <- jaspTools::analysisOptions("MixedModelsLMM")
  options$Contrasts <- list(list(isContrast = FALSE, levels = c("2", "3"), name = "facGender", 
                                 values = c("f", "m")), list(isContrast = TRUE, levels = c("2", 
                                                                                           "3"), name = "Contrast 1", values = c("0", "0")))
  options$bootstrap_samples <- 100
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
    expect_equal_tables(table,
                        list(1, "facGender", 0.0585272236145518, 0.129411764705882, 3.57863502661178
                        ))
  })
  
  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    expect_equal_tables(table,
                        list(-0.421706207520219, "f", -0.704496301095866, 0.144283311227277,
                             -0.138916113944573, 0.0410341526398586, "m", -0.296585024170459,
                             0.172257847324448, 0.378653329450176))
  })
  
  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    expect_equal_tables(table,
                        list(10.7321152909457, -0.19033602744018, 0.110894939742407, 0.109555523338383,
                             -1.73734761735647, "Intercept", 7.33364788694893, -0.231370180080039,
                             0.0824437479104129, 0.115077396728607, -2.01056147129998, "facGender (1)"
                        ))
  })
  
  test_that("facFive: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE1"]][["data"]]
    expect_equal_tables(table,
                        list(1, "Intercept", -1, 1, "facGender (1)"))
  })
  
  test_that("Residual Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_RES1"]][["data"]]
    expect_equal_tables(table,
                        list(1.01581460714797, 1.00787628563627))
  })
  
  test_that("facFive: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    expect_equal_tables(table,
                        list(0.0906377552259416, 0.00821520267239771, "Intercept", 0.120437360968589,
                             0.0145051579170782, "facGender (1)"))
  })
  
  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    expect_equal_plots(testPlot, "plot-lmm-4", dir="MixedModelsLMM")
  })
}

### TODO: fix plot - S + type II
if (FALSE) {
  options <- jaspTools::analysisOptions("MixedModelsLMM")
  options$Contrasts <- list(list(isContrast = TRUE, levels = list(), name = "Contrast 1", 
                                 values = list()))
  options$bootstrap_samples <- 100
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
  options$plotsAgregatedOver <- c("facFive", "facExperim")
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
                                                                                       value = "facGender"), list(randomSlopes = TRUE, value = "debMiss30"), 
                                                                                  list(randomSlopes = TRUE, value = c("facGender", "debMiss30"
                                                                                  ))), value = "facFive"), list(correlations = TRUE, randomComponents = list(
                                                                                    list(randomSlopes = TRUE, value = "facGender"), list(randomSlopes = TRUE, 
                                                                                                                                         value = "debMiss30"), list(randomSlopes = TRUE, value = c("facGender", 
                                                                                                                                                                                                   "debMiss30"))), value = "facExperim"))
  options$randomVariables <- c("facFive", "facExperim")
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
    expect_equal_tables(table,
                        list("1, 4.96", "facGender", 0.458135671778287, 0.646596225684635,
                             "1, 3.46", "debMiss30", 0.953993746166839, 0.0038414089226789,
                             "1, 3.26", "facGender * debMiss30", 0.460807960463763, 0.69603148276434
                        ))
  })
  
  test_that("Sample sizes table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitSizes"]][["data"]]
    expect_equal_tables(table,
                        list(2, 5, 70))
  })
  
  test_that("Fit statistics table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitStats"]][["data"]]
    expect_equal_tables(table,
                        list(272.268677200088, 328.481058251322, 204.239673705729, 222.268677200088,
                             25, -111.134338600044))
  })
  
  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    expect_equal_plots(testPlot, "plot-lmm-5", dir="MixedModelsLMM")
  })
}
