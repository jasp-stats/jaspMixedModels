test_that("sampling diagnostic producers store plain, editable plot recipes", {
  withr::local_options(lifecycle_verbosity = "quiet")
  withr::local_seed(42)
  samples <- data.frame(
    value = rnorm(160), parameter = factor(rep("Intercept", 160)),
    chain = factor(rep(1:2, each = 80)), mcmcSamples = rep(1:80, 2)
  )
  currentData <- list(samp = samples, nchains = 2, nparams = 1, mcmcBurnin = 0)
  newContainer <- function(...) {
    result <- new.env(parent = emptyenv())
    result$dependOn <- function(...) NULL
    result
  }
  testthat::local_mocked_bindings(
    createJaspContainer = newContainer, createJaspPlot = newContainer,
    .mmGetPlotSamples = function(...) list(Intercept = currentData),
    .package = "jaspMixedModels"
  )
  expectPlain <- function(x) {
    expect_false(is.environment(x) || is.function(x) || is.language(x) || isS4(x))
    if (is.list(x)) invisible(lapply(x, expectPlain))
    if (!is.null(attributes(x))) invisible(lapply(attributes(x), expectPlain))
  }
  for (type in c("traceplot", "scatterplot", "histogram", "density", "autocorrelation")) {
    if (type == "scatterplot") {
      currentData$samp <- rbind(samples, transform(samples, value = value + .5))
      currentData$samp$parameter <- factor(rep(c("Intercept", "Slope"), each = 160))
      currentData$nparams <- 2
    } else {
      currentData$samp <- samples
      currentData$nparams <- 1
    }
    results <- new.env(parent = emptyenv())
    # A fitted-model environment must never be retained by a diagnostic recipe.
    results$mmModel <- list(object = list(model = new.env(parent = emptyenv())))
    options <- list(mcmcDiagnosticsType = type, mcmcDiagnosticsHorizontal = "Intercept",
                    mcmcDiagnosticsVertical = "Slope", fixedVariables = character(),
                    mcmcSamples = 100, mcmcBurnin = 20)
    jaspMixedModels:::.mmDiagnostics(results, options, dataset = NULL)
    recipe <- results$diagnosticPlots$Intercept$plotObject
    expect_true(jaspGraphs::isJaspPlotRecipe(recipe))
    expectPlain(recipe$args)
    restored <- unserialize(serialize(recipe, NULL))
    expect_identical(restored, recipe)
    rng <- .Random.seed
    first <- suppressWarnings(ggplot2::ggplot_build(jaspGraphs::materializeJaspPlotRecipe(restored)))
    second <- suppressWarnings(ggplot2::ggplot_build(jaspGraphs::materializeJaspPlotRecipe(restored)))
    expect_identical(first$data, second$data)
    expect_identical(.Random.seed, rng)
    if (type == "autocorrelation")
      expect_equal(recipe$args$autocorrelation,
                   rstan:::.ac_plot_data(samples, lags = 30, partial = FALSE))
    # Existing rstan renderers emit legacy scale/title warnings; the migration
    # preserves their drawings while checking editing behavior.
    edits <- suppressWarnings(jaspGraphs::plotEditingOptions(recipe))
    edits$xAxis$settings$title <- "Edited diagnostic"
    edits$xAxis$settings$titleType <- "character"
    edited <- suppressWarnings(unserialize(serialize(jaspGraphs::plotEditing(recipe, edits), NULL)))
    expect_identical(suppressWarnings(jaspGraphs::plotEditingOptions(
      jaspGraphs::materializeJaspPlotRecipe(edited)))$xAxis$settings$title,
      "Edited diagnostic")
  }
})

test_that("autocorrelation preparation is not repeated by diagnostic redraw", {
  withr::local_seed(42)
  data <- list(samp = data.frame(value = rnorm(160),
    parameter = factor(rep("Intercept", 160)), chain = factor(rep(1:2, each = 80)),
    mcmcSamples = rep(1:80, 2)), nchains = 2, nparams = 1, mcmcBurnin = 0)
  acData <- rstan:::.ac_plot_data(data$samp, lags = 30, partial = FALSE)
  testthat::local_mocked_bindings(
    .ac_plot_data = function(...) stop("Autocorrelation must already be prepared"),
    .package = "rstan"
  )
  recipe <- jaspGraphs::createJaspPlotRecipe("jaspMixedModels:::.mmDrawDiagnosticPlot",
    list(plotData = data, diagnosticType = "autocorrelation", traceMargin = 0,
         autocorrelation = acData))
  expect_true(ggplot2::is_ggplot(suppressWarnings(jaspGraphs::materializeJaspPlotRecipe(recipe))))
})

test_that("diagnostic labels decode Unicode variable names before drawing", {
  testthat::local_mocked_bindings(
    decodeColNames = function(x, ...) gsub("jaspColumn1", "café", x, fixed = TRUE),
    .package = "jaspBase"
  )
  withr::local_seed(42)
  data <- list(samp = data.frame(value = rnorm(160),
    parameter = factor(rep("jaspColumn1", 160)), chain = factor(rep(1:2, each = 80)),
    mcmcSamples = rep(1:80, 2)), nchains = 2, nparams = 1, mcmcBurnin = 0)
  for (type in c("traceplot", "histogram", "density")) {
    recipe <- jaspGraphs::createJaspPlotRecipe("jaspMixedModels:::.mmDrawDiagnosticPlot",
      list(plotData = data, diagnosticType = type, traceMargin = 0))
    plot <- suppressWarnings(jaspBase:::.materializeDecodedJaspPlotRecipe(recipe))
    axis <- if (type == "traceplot") "y" else "x"
    expect_identical(as.character(plot$labels[[axis]]), "café")
  }
})
