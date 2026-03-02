context("Library: Larks and Owls")

# This test file was auto-generated from a JASP example file.
# The JASP file is stored in tests/testthat/jaspfiles/library/.

test_that("MixedModelsGLMM results match", {

  # Load from JASP example file
  jaspFile <- testthat::test_path("jaspfiles", "library", "Larks and Owls.jasp")
  opts <- jaspTools::analysisOptions(jaspFile)
  dataset <- jaspTools::extractDatasetFromJASPFile(jaspFile)

  # Encode and run analysis
  encoded <- jaspTools:::encodeOptionsAndDataset(opts, dataset)
  set.seed(1)
  results <- jaspTools::runAnalysis("MixedModelsGLMM", encoded$dataset, encoded$options, encodedDataset = TRUE)

  table <- results[["results"]][["ANOVAsummary"]][["data"]]
  jaspTools::expect_equal_tables(table,
    list(1, "jaspColumn4", 0.000238027593144753, 13.5042197684816, 2, "jaspColumn2",
     0.028758135405257, 7.09766916229955, 1, "jaspColumn3", 0.101821747651444,
     2.67677493125939, 2, "jaspColumn2<unicode><unicode><unicode>jaspColumn3",
     8.15169092676881e-08, 32.6449107250851))

  table <- results[["results"]][["EMMsummary"]][["data"]]
  jaspTools::expect_equal_tables(table,
    list(19.8882521278445, "Evening", "Evening", 17.5331275579318, 1, 1.27893062639472,
     22.5597270876964, 17.3976390269052, "Intermediate", "Evening",
     15.3451273367651, 2, 1.11432614185312, 19.7246876528235, 19.7010079409825,
     "Morning", "Evening", 16.2034171644821, 3, 1.96458485705115,
     23.9535716417544, 23.0124754631575, "Evening", "Morning", 20.2465707208649,
     4, 1.50348252751167, 26.1562332823444, 17.8562156960289, "Intermediate",
     "Morning", 15.7843569349806, 5, 1.12361649358491, 20.2000271722506,
     14.0510133023981, "Morning", "Morning", 11.4679543719144, 6,
     1.45629919265325, 17.2158842302064))

  table <- results[["results"]][["contrastsMeans"]][["data"]]
  jaspTools::expect_equal_tables(table,
    list("Contrast 1", "<unicode>", 3.124223335313, 1.16573284357092, 0.00176856061238835,
     0.999248204145793, 3.12657388059431, 5.08271382705509, "Contrast 2",
     "<unicode>", 0.458576669123765, -1.10812209765999, 0.566180041581804,
     0.799350793760331, 0.573686387382584, 2.02527543590752, "Contrast 3",
     "<unicode>", -5.6499946385844, -8.211430807384, 1.53731803924227e-05,
     1.30687920237509, -4.32327228738222, -3.08855846978479, "Contrast 4",
     "<unicode>", -1.50183347955351, -8.97379027884683, 0.693621694475887,
     3.81229290855912, -0.393944934341662, 5.97012331973982, "Contrast 5",
     "<unicode>", -9.14870634762143, -17.2820414412255, 0.0274788565301929,
     4.14973701443431, -2.20464726217562, -1.0153712540174, "Contrast 6",
     "<unicode>", -2.66564666618924, -4.98663902505349, 0.0243850554261238,
     1.18420153491184, -2.25100760943339, -0.34465430732499, "Contrast 7",
     "<unicode>", -8.7742179738974, -11.9418771576626, 5.66777493816107e-08,
     1.61618234250798, -5.42897774782122, -5.60655879013218))

  plotName <- results[["results"]][["plots"]][["data"]]
  testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
  jaspTools::expect_equal_plots(testPlot, "analysis-1_figure-1_plot")

})

