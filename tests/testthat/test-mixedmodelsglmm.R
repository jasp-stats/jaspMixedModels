context("Generalized Linear Mixed Models")


### binomial + logit, default, all selected output using LRT method
{
  options <- analysisOptions("MixedModelsGLMM")
  options$Contrasts <- list(list(isContrast = FALSE, levels = c("2", "3", "4", "5", 
                                                                "6", "7"), name = "contNormal", values = c("-1", "0", "1", "-1", 
                                                                                                           "0", "1")), list(isContrast = FALSE, levels = c("2", "3", "4", 
                                                                                                                                                           "5", "6", "7"), name = "facGender", values = c("f", "f", "f", 
                                                                                                                                                                                                          "m", "m", "m")), list(isContrast = TRUE, levels = c("2", "3", 
                                                                                                                                                                                                                                                              "4", "5", "6", "7"), name = "Contrast 1", values = c("1", "-1", 
                                                                                                                                                                                                                                                                                                                   "0", "0", "0", "0")), list(isContrast = TRUE, levels = c("2", 
                                                                                                                                                                                                                                                                                                                                                                            "3", "4", "5", "6", "7"), name = "Contrast 2", values = c("0", 
                                                                                                                                                                                                                                                                                                                                                                                                                                      "1", "-1", "0", "0", "0")))
  options$bootstrap_samples <- 500
  options$dependentVariable <- "contBinom"
  options$fitStats <- TRUE
  options$fixedEffects <- list(list(components = "contNormal"), list(components = "facGender"), 
                               list(components = c("contNormal", "facGender")))
  options$fixedVariables <- c("contNormal", "facGender")
  options$marginalMeans <- list(list(variable = "contNormal"), list(variable = "facGender"))
  options$marginalMeansCompare <- TRUE
  options$marginalMeansContrast <- TRUE
  options$method <- "LRT"
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
  options$plotsPanel <- list()
  options$plotsTheme <- "JASP"
  options$plotsTrace <- list()
  options$plotsX <- list(list(variable = "facGender"))
  options$pvalVS <- FALSE
  options$randomEffects <- list(list(correlations = TRUE, randomComponents = list(list(randomSlopes = TRUE, 
                                                                                       value = "contNormal"), list(randomSlopes = TRUE, value = "facGender"), 
                                                                                  list(randomSlopes = TRUE, value = c("contNormal", "facGender"
                                                                                  ))), value = "facFive"))
  options$randomVariables <- "facFive"
  options$seed <- 1
  options$setSeed <- FALSE
  options$showFE <- TRUE
  options$showRE <- TRUE
  options$test_intercept <- FALSE
  options$trendsCompare <- TRUE
  options$trendsContrasts <- list(list(isContrast = FALSE, levels = c("2", "3"), name = "facGender", 
                                       values = c("f", "m")), list(isContrast = TRUE, levels = c("2", 
                                                                                                 "3"), name = "Contrast 1", values = c("0", "0")))
  options$trendsTrend <- list(list(variable = "contNormal"))
  options$trendsVariables <- list(list(variable = "facGender"))
  options$type <- "3"
  set.seed(1)
  results <- runAnalysis("MixedModelsGLMM", "debug", options)
  
  
  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "contNormal", 0.338192417441406, 0.917271466382658, 1, "facGender",
                                        0.282211189851148, 1.15641063028642, 1, "contNormal * facGender",
                                        0.234356656714998, 1.41422274372206))
  })
  
  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(-1.24716219673316, 0.548980002230091, "f", 0.359266674805453,
                                        1, 0.619182221919005, 0.0979177129958996, 0.497009684592554,
                                        0.725448070897048, -0.18874858754, 0.457645840995902, "f", 0.317162773357282,
                                        2, 0.577173573677129, 0.0756052005918349, -0.557517986317609,
                                        0.605203464795789, 0.869665021653162, 0.369072572161133, "f",
                                        0.172245883885305, 3, 0.309263365357224, 0.122798690344828,
                                        -1.01676893102908, 0.621847666607969, -1.24716219673316, 0.326824366323759,
                                        "m", 0.159666179565096, 4, 0.131135898133824, 0.105307192129248,
                                        -1.50963769193164, 0.55367914707792, -0.18874858754, 0.361230317280148,
                                        "m", 0.220448118954088, 5, 0.106939162958909, 0.0815889967831485,
                                        -1.61210467797629, 0.530711404805015, 0.869665021653162, 0.39712158280474,
                                        "m", 0.197013437306204, 6, 0.407380876646393, 0.120637723373079,
                                        -0.828511514580678, 0.638790847032052))
  })
  
  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(-0.388991227896234, 0.123567020121818, 0.252596192372349, -1.5399726505886,
                                        "Intercept", -0.101009093160074, 0.66130176857207, 0.230552997518184,
                                        -0.438116590317188, "contNormal", 0.153831572502025, 0.513634671798847,
                                        0.235508645851556, 0.653188641740935, "facGender (1)", -0.2451447528175,
                                        0.293160000721356, 0.233201416066435, -1.0512146836521, "contNormal * facGender (1)"
                                   ))
  })
  
  test_that("facFive: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "Intercept", 0.999942822682058, 1, "contNormal", -0.99997620082427,
                                        -0.999898648917715, 1, "facGender (1)", -0.999951851698203,
                                        -0.999928770367823, 0.999929670653158, 1, "contNormal * facGender (1)"
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
                                   list(0.260557712569343, 0.0678903215793681, "Intercept", 0.110637222348517,
                                        0.0122405949689952, "contNormal", 0.157061099321917, 0.024668188920209,
                                        "facGender (1)", 0.114586125611911, 0.0131299801827487, "contNormal * facGender (1)"
                                   ))
  })
  
  test_that("Contrasts table results match", {
    table <- results[["results"]][["contrasts_Means"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("Contrast 1", "<unicode><unicode><unicode>", 0.0913341612341894,
                                        0.547772642394057, 0.0874042219204176, 1.04496280874567, "Contrast 2",
                                        "<unicode><unicode><unicode>", 0.088573268834769, 0.547772642394057,
                                        0.0809511840804271, 1.09415655670668))
  })
  
  test_that("Sample sizes table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitSizes"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(5, 100))
  })
  
  test_that("Fit statistics table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitStats"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(160.894600502742, 197.366983106576, 128.989251841074, 14, -66.4473002513711
                                   ))
  })
  
  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-glmm-1", dir="MixedModelsGLMM")
  })
  
  test_that("Estimated Trends table results match", {
    table <- results[["results"]][["trendsSummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("f", -0.999453542329123, 0.299039232332829, 0.333322296483351,
                                        -0.346153845977573, -1.03849592310385, 0.307145850373978, "m",
                                        -0.487846869039201, 0.654869905635109, 0.322445990682291, 0.144135659657426,
                                        0.44700713862944, 0.776118188354053))
  }) 
}

### binomial + probit, type II with LRT, no random slopes, custom options
{
  options <- analysisOptions("MixedModelsGLMM")
  options$Contrasts <- list(list(isContrast = FALSE, levels = c("2", "3", "4", "5", 
                                                                "6", "7"), name = "contNormal", values = c("-1.11", "0", "1.11", 
                                                                                                           "-1.11", "0", "1.11")), list(isContrast = FALSE, levels = c("2", 
                                                                                                                                                                       "3", "4", "5", "6", "7"), name = "facGender", values = c("f", 
                                                                                                                                                                                                                                "f", "f", "m", "m", "m")), list(isContrast = TRUE, levels = c("2", 
                                                                                                                                                                                                                                                                                              "3", "4", "5", "6", "7"), name = "Contrast 1", values = c("1", 
                                                                                                                                                                                                                                                                                                                                                        "-1", "0", "0", "0", "0")), list(isContrast = TRUE, levels = c("2", 
                                                                                                                                                                                                                                                                                                                                                                                                                       "3", "4", "5", "6", "7"), name = "Contrast 2", values = c("0", 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 "1", "-1", "0", "0", "0")))
  options$bootstrap_samples <- 500
  options$dependentVariable <- "contBinom"
  options$fitStats <- TRUE
  options$fixedEffects <- list(list(components = "contNormal"), list(components = "facGender"), 
                               list(components = c("contNormal", "facGender")))
  options$fixedVariables <- c("contNormal", "facGender")
  options$link <- "probit"
  options$marginalMeans <- list(list(variable = "contNormal"), list(variable = "facGender"))
  options$marginalMeansAdjustment <- "mvt"
  options$marginalMeansCompare <- TRUE
  options$marginalMeansContrast <- TRUE
  options$marginalMeansResponse <- FALSE
  options$marginalMeansSD <- 1.11
  options$method <- "LRT"
  options$plotAlpha <- 0.7
  options$plotDodge <- 0.3
  options$plotGeomWidth <- 1
  options$plotJitterHeight <- 0
  options$plotJitterWidth <- 0.1
  options$plotLegendPosition <- "right"
  options$plotRelativeSize <- 1
  options$plotRelativeSizeText <- 1.5
  options$plotsAgregatedOver <- "facFive"
  options$plotsBackgroundColor <- "darkgrey"
  options$plotsCImethod <- "model"
  options$plotsCIwidth <- 0.95
  options$plotsEstimatesTable <- TRUE
  options$plotsGeom <- "geom_violin"
  options$plotsMappingColor <- FALSE
  options$plotsMappingFill <- TRUE
  options$plotsMappingLineType <- TRUE
  options$plotsMappingShape <- TRUE
  options$plotsPanel <- list()
  options$plotsTheme <- "JASP"
  options$plotsTrace <- list()
  options$plotsX <- list(list(variable = "facGender"))
  options$pvalVS <- FALSE
  options$randomEffects <- list(list(correlations = TRUE, randomComponents = list(list(randomSlopes = FALSE, 
                                                                                       value = "contNormal"), list(randomSlopes = FALSE, value = "facGender"), 
                                                                                  list(randomSlopes = FALSE, value = c("contNormal", "facGender"
                                                                                  ))), value = "facFive"))
  options$randomVariables <- "facFive"
  options$seed <- 1
  options$setSeed <- FALSE
  options$showFE <- TRUE
  options$showRE <- TRUE
  options$test_intercept <- FALSE
  options$trendsContrasts <- list(list(isContrast = TRUE, levels = list(), name = "Contrast 1", 
                                       values = list()))
  options$trendsTrend <- list()
  options$type <- "2"
  set.seed(1)
  results <- runAnalysis("MixedModelsGLMM", "debug", options)
  
  
  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "contNormal", 0.609594107923892, 0.260766411860686, 1, "facGender",
                                        0.284327625868667, 1.14628764586072, 1, "contNormal * facGender",
                                        0.334577761935427, 0.931098042304626))
  })
  
  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(-1.36358769374441, 0.149244029378276, "f", -0.359295949541209,
                                        1, 0.565155076572514, 0.259463940628901, 0.575201428824872,
                                        0.657784008297761, -0.18874858754, -0.102631617037894, "f",
                                        -0.467214155012724, 2, 0.581127433486909, 0.186014917034502,
                                        -0.551738638352634, 0.261950920936935, 0.98609051866441, -0.354507263454064,
                                        "f", -1.02655222752204, 3, 0.301186963824939, 0.342886384325926,
                                        -1.03389134027874, 0.31753770061391, -1.36358769374441, -0.407989734747062,
                                        "m", -0.980583087733028, 4, 0.162554222112434, 0.292144834039049,
                                        -1.39653242915988, 0.164603618238905, -0.18874858754, -0.366884673848823,
                                        "m", -0.730935587943824, 5, 0.0482431558411855, 0.185743675376991,
                                        -1.9752202765676, -0.00283375975382183, 0.98609051866441, -0.325779612950584,
                                        "m", -0.787241229561193, 6, 0.166455730892536, 0.235443926648938,
                                        -1.3836823807154, 0.135682003660025))
  })
  
  test_that("Estimated Means and Confidence Intervals table results match", {
    table <- results[["results"]][["EstimatesTable"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("f", 0.320173333674467, 0.459127674282166, 0.603320359683825,
                                        "m", 0.232409248646226, 0.356852521999701, 0.49886949493473
                                   ))
  })
  
  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(-0.251689251201327, 0.0627285967943076, 0.135236071846752, -1.86111033664552,
                                        "Intercept", -0.0897018938188371, 0.491183326203148, 0.130299610105594,
                                        -0.688427952671103, "contNormal", 0.108591520764834, 0.421987737684679,
                                        0.135236068683755, 0.802977503130257, "facGender (1)", -0.124689715284057,
                                        0.338594418466376, 0.130299610691309, -0.956946184432264, "contNormal * facGender (1)"
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
  
  test_that("Contrasts table results match", {
    table <- results[["results"]][["contrasts_Means"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("Contrast 1", "<unicode><unicode><unicode>", 0.25187564641617,
                                        0.294980047829034, 0.24050936605887, 1.04725920051911, "Contrast 2",
                                        "<unicode><unicode><unicode>", 0.25187564641617, 0.294980047829034,
                                        0.24050936605887, 1.04725920051911))
  })
  
  test_that("Sample sizes table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitSizes"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(5, 100))
  })
  
  test_that("Fit statistics table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitStats"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(143.384651734201, 156.410502664141, 133.384651734201, 5, -66.6923258671005
                                   ))
  })
  
  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-glmm-2", dir="MixedModelsGLMM")
  })
}

### gamma + log, parametric bootsrap, no correlation
{
  options <- analysisOptions("MixedModelsGLMM")
  options$Contrasts <- list(list(isContrast = FALSE, levels = c("2", "3"), name = "facGender", 
                                 values = c("f", "m")), list(isContrast = TRUE, levels = c("2", 
                                                                                           "3"), name = "Contrast 1", values = c("1", "0")), list(isContrast = TRUE, 
                                                                                                                                                  levels = c("2", "3"), name = "Contrast 2", values = c("0", 
                                                                                                                                                                                                        "0")))
  options$bootstrap_samples <- 10
  options$dependentVariable <- "contGamma"
  options$family <- "Gamma"
  options$fitStats <- FALSE
  options$fixedEffects <- list(list(components = "facGender"), list(components = "contBinom"), 
                               list(components = c("facGender", "contBinom")))
  options$fixedVariables <- c("facGender", "contBinom")
  options$link <- "log"
  options$marginalMeans <- list(list(variable = "facGender"))
  options$marginalMeansAdjustment <- "mvt"
  options$marginalMeansCompare <- TRUE
  options$marginalMeansContrast <- TRUE
  options$marginalMeansResponse <- FALSE
  options$marginalMeansSD <- 1.11
  options$method <- "PB"
  options$plotAlpha <- 0.7
  options$plotDodge <- 0.3
  options$plotGeomWidth <- 1
  options$plotJitterHeight <- 0
  options$plotJitterWidth <- 0.1
  options$plotLegendPosition <- "right"
  options$plotRelativeSize <- 1
  options$plotRelativeSizeText <- 1.5
  options$plotsAgregatedOver <- "facFive"
  options$plotsBackgroundColor <- "darkgrey"
  options$plotsCImethod <- "model"
  options$plotsCIwidth <- 0.95
  options$plotsEstimatesTable <- TRUE
  options$plotsGeom <- "geom_boxjitter"
  options$plotsMappingColor <- FALSE
  options$plotsMappingFill <- TRUE
  options$plotsMappingLineType <- TRUE
  options$plotsMappingShape <- TRUE
  options$plotsPanel <- list()
  options$plotsTheme <- "JASP"
  options$plotsTrace <- list()
  options$plotsX <- list(list(variable = "facGender"))
  options$pvalVS <- FALSE
  options$randomEffects <- list(list(correlations = FALSE, randomComponents = list(list(
    randomSlopes = TRUE, value = "facGender"), list(randomSlopes = FALSE, 
                                                    value = "contBinom"), list(randomSlopes = FALSE, value = c("facGender", 
                                                                                                               "contBinom"))), value = "facFive"))
  options$randomVariables <- "facFive"
  options$seed <- 1
  options$setSeed <- FALSE
  options$showFE <- TRUE
  options$showRE <- TRUE
  options$test_intercept <- FALSE
  options$trendsContrasts <- list(list(isContrast = TRUE, levels = list(), name = "Contrast 1", 
                                       values = list()))
  options$trendsTrend <- list()
  options$type <- "2"
  set.seed(1)
  results <- runAnalysis("MixedModelsGLMM", "debug", options)
  
  
  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "facGender", 0.447004500865773, 0.272727272727273, 0.578236212658624,
                                        1, "contBinom", 0.37729109301047, 0.636363636363636, 0.779509830347195,
                                        1, "facGender * contBinom", 0.547514203815074, 0.272727272727273,
                                        0.361789256200893))
  })
  
  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.587430349612986, "f", 0.374549906678813, 1, 6.35907081922447e-08,
                                        0.108614466701096, 5.408398783834, 0.800310792547159, 0.746196683562162,
                                        "m", 0.413131329216369, 2, 1.12785900324191e-05, 0.169934425822602,
                                        4.39108603186226, 1.07926203790796))
  })
  
  test_that("Estimated Means and Confidence Intervals table results match", {
    table <- results[["results"]][["EstimatesTable"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("f", 1.45433668005698, 1.79935874673052, 2.22623271752231, "m",
                                        1.51154352272584, 2.1089636876888, 2.94250729080506))
  })
  
  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.728064599434742, 6.69718693318382e-09, 0.125564170667767, 5.79834673826773,
                                        "Intercept", -0.0356589646204568, 0.749571272929608, 0.111711894088311,
                                        -0.319204726689778, "facGender (1)", -0.122502165694335, 0.407153741126262,
                                        0.147786549919433, -0.828912818934593, "contBinom", -0.0874484047082629,
                                        0.547831413604434, 0.145501717060467, -0.601012871015956, "facGender (1) * contBinom"
                                   ))
  })
  
  test_that("facFive.1: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE2"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "facGender (f)", 0.820565738951668, 1, "facGender (m)"))
  })
  
  test_that("Residual Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_RES2"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.698321361072845, 0.835656245757097))
  })
  
  test_that("facFive: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.0625128879590991, 0.00390786116098688, "Intercept"))
  })
  
  test_that("facFive.1: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE2"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.0273978028639619, 0.00075063960177252, "facGender (f)", 0.22325212826067,
                                        0.0498415127729185, "facGender (m)"))
  })
  
  test_that("Contrasts table results match", {
    table <- results[["results"]][["contrasts_Means"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list("Contrast 1", "<unicode><unicode><unicode>", 0.587430349612986,
                                        6.35907081922447e-08, 0.108614466701096, 5.408398783834))
  })
  
  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-glmm-3", dir="MixedModelsGLMM")
  })
}

### poisson + log, type II parametric bootsrap
{
  options <- analysisOptions("MixedModelsGLMM")
  options$Contrasts <- list(list(isContrast = FALSE, levels = c("2", "3"), name = "facGender", 
                                 values = c("f", "m")), list(isContrast = TRUE, levels = c("2", 
                                                                                           "3"), name = "Contrast 1", values = c("0", "0")))
  options$bootstrap_samples <- 10
  options$dependentVariable <- "facFifty"
  options$family <- "poisson"
  options$fitStats <- FALSE
  options$fixedEffects <- list(list(components = "facGender"))
  options$fixedVariables <- "facGender"
  options$link <- "log"
  options$marginalMeans <- list(list(variable = "facGender"))
  options$method <- "PB"
  options$plotAlpha <- 0.7
  options$plotDodge <- 0.3
  options$plotGeomWidth <- 1
  options$plotJitterHeight <- 0
  options$plotJitterWidth <- 0.1
  options$plotLegendPosition <- "top"
  options$plotRelativeSize <- 1
  options$plotRelativeSizeText <- 1.5
  options$plotsAgregatedOver <- "facFive"
  options$plotsBackgroundColor <- "darkgrey"
  options$plotsCImethod <- "model"
  options$plotsCIwidth <- 0.95
  options$plotsEstimatesTable <- FALSE
  options$plotsGeom <- "geom_boxplot"
  options$plotsMappingColor <- FALSE
  options$plotsMappingFill <- FALSE
  options$plotsMappingLineType <- TRUE
  options$plotsMappingShape <- TRUE
  options$plotsPanel <- list()
  options$plotsTheme <- "JASP"
  options$plotsTrace <- list()
  options$plotsX <- list(list(variable = "facGender"))
  options$pvalVS <- FALSE
  options$randomEffects <- list(list(correlations = TRUE, randomComponents = list(list(randomSlopes = TRUE, 
                                                                                       value = "facGender")), value = "facFive"))
  options$randomVariables <- "facFive"
  options$seed <- 1
  options$setSeed <- FALSE
  options$showFE <- TRUE
  options$showRE <- TRUE
  options$test_intercept <- FALSE
  options$trendsContrasts <- list()
  options$trendsTrend <- list()
  options$type <- "2"
  set.seed(1)
  results <- runAnalysis("MixedModelsGLMM", "debug", options)
  
  
  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "facGender", 0.323811589802939, 0.363636363636364, 0.973488924968706
                                   ))
  })
  
  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(26.9632681754783, "f", 23.4528371326651, 1.91888487591472, 30.9991420905817,
                                        23.882309468471, "m", 21.3136490705777, 1.38654373724911, 26.7605375156136
                                   ))
  })
  
  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(3.23380674854069, 0, 0.0282089155369933, 114.637755014009, "Intercept",
                                        0.0606687532825319, 0.299679366705061, 0.0584972634725293, 1.0371212203973,
                                        "facGender (1)"))
  })
  
  test_that("facFive: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, "Intercept", 0.413199610716051, 1, "facGender (1)"))
  })
  
  test_that("Residual Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_RES1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(1, 1))
  })
  
  test_that("facFive: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    jaspTools::expect_equal_tables(table,
                                   list(0.0442623696713281, 0.00195915736892131, "Intercept", 0.122872211562862,
                                        0.0150975803743487, "facGender (1)"))
  })
  
  
  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    jaspTools::expect_equal_plots(testPlot, "plot-glmm-4", dir="MixedModelsGLMM")
  })
}

### aggregated binomial
{
  options <- jaspTools::analysisOptions("MixedModelsGLMM")
  options$Contrasts <- list(list(isContrast = FALSE, levels = c("2", "3"), name = "cA", 
                                 values = c("1", "2")), list(isContrast = TRUE, levels = c("2", 
                                                                                           "3"), name = "Contrast 1", values = c("-1", "1")))
  options$bootstrap_samples <- 500
  options$dependentVariable <- "binom_mean"
  options$dependentVariableAggregation <- "rep"
  options$family <- "binomial_agg"
  options$fitStats <- TRUE
  options$fixedEffects <- list(list(components = "cA"), list(components = "cB"), list(components = c("cA", 
                                                                                                     "cB")))
  options$fixedVariables <- c("cA", "cB")
  options$marginalMeans <- list(list(variable = "cA"))
  options$marginalMeansContrast <- TRUE
  options$method <- "LRT"
  options$plotAlpha <- 0.7
  options$plotDodge <- 0.3
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
  options$plotsTrace <- list(list(variable = "cB"))
  options$plotsX <- list(list(variable = "cA"))
  options$pvalVS <- FALSE
  options$randomEffects <- list(list(correlations = TRUE, randomComponents = list(list(randomSlopes = TRUE, 
                                                                                       value = "cA"), list(randomSlopes = TRUE, value = "cB"), list(
                                                                                         randomSlopes = FALSE, value = c("cA", "cB"))), value = "id"))
  options$randomVariables <- "id"
  options$seed <- 1
  options$setSeed <- FALSE
  options$showFE <- TRUE
  options$showRE <- TRUE
  options$test_intercept <- FALSE
  options$trendsContrasts <- list(list(isContrast = TRUE, levels = list(), name = "Contrast 1", 
                                       values = list()))
  options$trendsTrend <- list()
  options$type <- "3"
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
  results <- jaspTools::runAnalysis("MixedModelsGLMM", dataset, options)
  
  
  test_that("ANOVA Summary table results match", {
    table <- results[["results"]][["ANOVAsummary"]][["data"]]
    expect_equal_tables(table,
                        list(1, "cA", 0.775469995475994, 0.0813546207214131, 1, "cB", 0.475222288883663,
                             0.509807294113187, 1, "cA * cB", 0.861901188932592, 0.0302601821298367
                        ))
  })
  
  test_that("Estimated Marginal Means table results match", {
    table <- results[["results"]][["EMMsummary"]][["data"]]
    expect_equal_tables(table,
                        list(1, 0.523756402115895, 0.410939148366063, 1, 0.0579288705525519,
                             0.634200264927269, 2, 0.54535112381432, 0.425658093029585, 2,
                             0.0609107733693462, 0.660023133984336))
  })
  
  test_that("Fixed Effects Estimates table results match", {
    table <- results[["results"]][["FEsummary"]][["data"]]
    expect_equal_tables(table,
                        list(0.683818529774939, 0.527042810495982, 1.08109049206304, 0.632526633797337,
                             "Intercept", 0.19194195549093, 0.774274594753848, 0.669281509848211,
                             0.286788074474763, "cA", -0.337764269077037, 0.476885064606318,
                             0.474840553134897, -0.711321446424737, "cB", -0.0525673679636885,
                             0.860852113713692, 0.299888753182801, -0.175289561231546, "cA * cB"
                        ))
  })
  
  test_that("id: Correlation Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_CE1"]][["data"]]
    expect_equal_tables(table,
                        list(1, "Intercept", -0.620946323177002, 1, "cA", -0.926996928210894,
                             0.281616857895837, 1, "cB"))
  })
  
  test_that("Residual Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_RES1"]][["data"]]
    expect_equal_tables(table,
                        list(1, 1))
  })
  
  test_that("id: Variance Estimates table results match", {
    table <- results[["results"]][["REsummary"]][["collection"]][["REsummary_VE1"]][["data"]]
    expect_equal_tables(table,
                        list(0.993117385554222, 0.986282141490053, "Intercept", 0.400510948460864,
                             0.160409019837021, "cA", 0.155185110016968, 0.0240824183709784,
                             "cB"))
  })
  
  test_that("Contrasts table results match", {
    table <- results[["results"]][["contrasts_Means"]][["data"]]
    expect_equal_tables(table,
                        list("Contrast 1", "<unicode><unicode><unicode>", 0.0215947216984254,
                             0.750968660540585, 0.0680443684226599, 0.317362365159876))
  })
  
  test_that("Sample sizes table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitSizes"]][["data"]]
    expect_equal_tables(table,
                        list(10, 60))
  })
  
  test_that("Fit statistics table results match", {
    table <- results[["results"]][["fitSummary"]][["collection"]][["fitSummary_fitStats"]][["data"]]
    expect_equal_tables(table,
                        list(208.197476236153, 229.140921858374, 62.4632059669477, 10, -94.0987381180764
                        ))
  })
  
  test_that("Plot matches", {
    plotName <- results[["results"]][["plots"]][["data"]]
    testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
    expect_equal_plots(testPlot, "plot-glmm-5", dir="MixedModelsGLMM")
  })
}
