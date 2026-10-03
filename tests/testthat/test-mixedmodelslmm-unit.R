context("Linear Mixed Models -- Unit tests")

test_that("Test that .mmModelFormula removes correlations for factor random slopes", {
  set.seed(1)
  dataset <- data.frame(
    y = rnorm(240),
    x = rnorm(240),
    f = factor(rep(c("a", "b", "c"), 80)),
    g = factor(rep(1:24, each = 10))
  )
  options <- list(
    dependent        = "y",
    fixedEffects     = list(list(components = "x"), list(components = "f")),
    fixedVariables   = c("x", "f"),
    includeIntercept = TRUE,
    factorContrast   = "sum",
    randomEffects    = list(list(correlations = FALSE, value = "g", randomComponents = list(
      list(randomSlopes = TRUE, value = "Intercept"),
      list(randomSlopes = TRUE, value = "x"),
      list(randomSlopes = TRUE, value = "f")
    )))
  )
  dataset <- jaspMixedModels:::.mmSetContrasts(dataset, options)
  out     <- jaspMixedModels:::.mmModelFormula(options, dataset, expandUncorrelated = TRUE)

  # the factor slope is replaced by its numeric sum-coded columns
  expect_equal(out$modelFormula, "y~1+x+f+(1+.mmRE1_1+.mmRE1_2+.mmRE1_3||g)")
  expect_equal(out$reLabels, c(.mmRE1_1 = "x", .mmRE1_2 = "f1", .mmRE1_3 = "f2"))
  expect_equal(out$dataset[[".mmRE1_1"]], dataset$x)
  expect_equal(out$dataset[[".mmRE1_2"]], unname(contr.sum(3)[as.integer(dataset$f), 1]))
  expect_equal(jaspMixedModels:::.mmRELabel(c("(Intercept)", ".mmRE1_3"), out$reLabels), c("(Intercept)", "f2"))

  # so that every random effect gets its own variance and no correlation is estimated
  fit <- suppressMessages(lme4::lmer(as.formula(out$modelFormula), data = out$dataset))
  expect_true(all(sapply(lme4::VarCorr(fit), nrow) == 1))
})

test_that("Test that .mmModelFormula keeps factor random slopes with correlations", {
  dataset <- data.frame(
    y = rnorm(40),
    f = factor(rep(c("a", "b"), 20)),
    g = factor(rep(1:4, each = 10))
  )
  options <- list(
    dependent        = "y",
    fixedEffects     = list(list(components = "f")),
    fixedVariables   = "f",
    includeIntercept = TRUE,
    factorContrast   = "sum",
    randomEffects    = list(list(correlations = TRUE, value = "g", randomComponents = list(
      list(randomSlopes = TRUE, value = "Intercept"),
      list(randomSlopes = TRUE, value = "f")
    )))
  )
  out <- jaspMixedModels:::.mmModelFormula(options, dataset, expandUncorrelated = TRUE)

  expect_equal(out$modelFormula, "y~1+f+(1+f|g)")
  expect_length(out$reLabels, 0)
  expect_identical(out$dataset, dataset)
})
