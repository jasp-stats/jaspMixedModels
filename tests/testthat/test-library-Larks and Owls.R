context("Library: Larks and Owls")

# This test file was auto-generated from a JASP example file.
# The JASP file is stored in tests/testthat/jaspfiles/library/.

test_that("MixedModelsGLMM results match", {

  # Run the R syntax of analysis 1 of the JASP example file on the data of the file
  jaspFile <- testthat::test_path("jaspfiles", "library", "Larks and Owls.jasp")
  set.seed(1)
  results <- jaspTools::runAnalysisSyntax(jaspFile = jaspFile, jaspMixedModels::MixedModelsGLMM(
          data = NULL,
          version = "0.96.4",
          formula = MWCount ~ Chronotype * TimeOfDay + Sleep + (1 | Subject),
          contrasts = list(list(isContrast = FALSE, levels = list("1", "2", "3", "4", "5", "6"), name = "Chronotype", values = list("Morning", "Intermediate", "Evening", "Morning", "Intermediate", "Evening")), list(isContrast = FALSE, levels = list("1", "2", "3", "4", "5", "6"), name = "TimeOfDay", values = list("Morning", "Morning", "Morning", "Evening", "Evening", "Evening")), list(isContrast = TRUE, levels = list("1", "2", "3", "4", "5", "6"), name = "Contrast 1", values = list(-1, 0, 0, 1, 0, 0)), list(isContrast = TRUE, levels = list("1", "2", "3", "4", "5", "6"), name = "Contrast 2", values = list(0, -1, 0, 0, 1, 0)), list(isContrast = TRUE, levels = list("1", "2", "3", "4", "5", "6"), name = "Contrast 3", values = list(0, 0, -1, 0, 0, 1)), list(isContrast = TRUE, levels = list("1", "2", "3", "4", "5", "6"), name = "Contrast 4", values = list(0, -1, 1, 0, -1, 1)), list(isContrast = TRUE, levels = list("1", "2", "3", "4", "5", "6"), name = "Contrast 5", values = list(-1, 0, 1, -1, 0, 1)), list(isContrast = TRUE, levels = list("1", "2", "3", "4", "5", "6"), name = "Contrast 6", values = list(1, -1, 0, -1, 1, 0)), list(isContrast = TRUE, levels = list("1", "2", "3", "4", "5", "6"), name = "Contrast 7", values = list(1, 0, -1, -1, 0, 1))),
          family = "poisson",
          link = "log",
          marginalMeansContrast = TRUE,
          marginalMeansPAdjustment = "none",
          marginalMeansTerms = ~ Chronotype + TimeOfDay,
          plotBackgroundData = ~ Subject,
          plotHorizontalAxis = ~ TimeOfDay,
          plotLegendPosition = "right",
          plotLevelsByColor = TRUE,
          plotLevelsByLinetype = FALSE,
          plotSeparateLines = ~ Chronotype,
          trendsContrasts = list(list(isContrast = TRUE, levels = list(), name = "Contrast 1", values = list()))))

  table <- results[["results"]][["ANOVAsummary"]][["data"]]
  jaspTools::expect_equal_tables(table,
    list(1, "Sleep", 0.00023802759312517, 13.5042197686359, 2, "Chronotype",
     0.0287581354046195, 7.09766916234389, 1, "TimeOfDay", 0.101821747648071,
     2.67677493131214, 2, "Chronotype<unicode><unicode><unicode>TimeOfDay",
     8.1516909267373e-08, 32.6449107250928))

  table <- results[["results"]][["EMMsummary"]][["data"]]
  jaspTools::expect_equal_tables(table,
    list("Evening", "Evening", 19.8882521269403, 17.5331271516195, 1, 1.27893086102747,
     22.5597276084437, "Intermediate", "Evening", 17.3976390245511,
     15.34512688625, 2, 1.11432640110528, 19.7246882265796, "Morning",
     "Evening", 19.7010079391303, 16.2034162146547, 3, 1.96458544514276,
     23.9535730413839, "Evening", "Morning", 23.012475460861, 20.2465704023378,
     4, 1.50348271090832, 26.1562336886242, "Intermediate", "Morning",
     17.8562156928807, 15.784356778245, 5, 1.12361658224584, 20.20002736571,
     "Morning", "Morning", 14.0510133008749, 11.4679537816132, 6,
     1.456299560736, 17.2158851126439))

  table <- results[["results"]][["contrastsMeans"]][["data"]]
  jaspTools::expect_equal_tables(table,
    list("Contrast 1", "<unicode>", 3.12422333392068, 1.16573220912141,
     0.00176856669953906, 0.99924852714009, 3.12657286857594, 5.08271445871995,
     "Contrast 2", "<unicode>", 0.458576668329563, -1.10812238124184,
     0.566180112338901, 0.799350938042394, 0.573686282839193, 2.02527571790096,
     "Contrast 3", "<unicode>", -5.64999463825543, -8.21143103842188,
     1.53732076332382e-05, 1.30687932042156, -4.32327189662232, -3.08855823808898,
     "Contrast 4", "<unicode>", -1.5018334774266, -8.97379161915969,
     0.693621747143815, 3.81229359348995, -0.393944863006145, 5.97012466430648,
     "Contrast 5", "<unicode>", -9.14870634779601, -17.2820436460815,
     0.0274788984953063, 4.14973813929246, -2.20464666460999, -1.01536904951053,
     "Contrast 6", "<unicode>", -2.66564666559112, -4.98663913870332,
     0.0243850624758827, 1.18420159320268, -2.25100749812526, -0.344654192478908,
     "Contrast 7", "<unicode>", -8.77421797217611, -11.9418773226514,
     5.66778404449119e-08, 1.61618242756569, -5.4289774610357, -5.60655862170084
    ))

  plotName <- results[["results"]][["plots"]][["data"]]
  testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
  jaspTools::expect_equal_plots(testPlot, "analysis-1_figure-1_plot")

})

