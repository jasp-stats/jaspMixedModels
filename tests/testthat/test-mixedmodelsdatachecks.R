context("Mixed Models -- Data checks")

# The checks of the data get the factors of the model too: the variance and the collinearity are checked on its
# numeric variables only.

runLMMWithFixedVariables <- function(scaleVariables) {
  options <- jaspTools::analysisOptions("MixedModelsLMM")
  options$dependent <- "contNormal"
  options$fixedVariables <- c("facGender", scaleVariables)
  options$fixedVariables.types <- c("nominal", rep("scale", length(scaleVariables)))
  options$fixedEffects <- lapply(c("facGender", scaleVariables), function(v) list(components = v))
  options$randomVariables <- "facFive"
  options$randomVariables.types <- "nominal"
  options$randomEffects <- list(list(correlations = TRUE, value = "facFive",
                                     randomComponents = list(list(randomSlopes = TRUE, value = "Intercept"))))
  jaspTools::runAnalysis("MixedModelsLMM", "debug.csv", options)
}

test_that("A scale variable without variance is reported", {
  results <- runLMMWithFixedVariables("debSame")
  expect_identical(results[["status"]], "validationError")
  expect_match(results[["results"]][["errorMessage"]], "The variance in debSame is equal to 0", fixed = TRUE)
})

test_that("Collinear scale variables are reported", {
  results <- runLMMWithFixedVariables(c("debCollin1", "debCollin2"))
  expect_identical(results[["status"]], "validationError")
  expect_match(results[["results"]][["errorMessage"]], "'debCollin1' and 'debCollin2'", fixed = TRUE)
})

test_that("The collinearity check skips the factors", {
  dataset <- data.frame(x = c(1, 2, 3, 5), y = c(2, 1, 4, 3), g = factor(c("a", "b", "a", "b")))
  expect_null(jaspMixedModels:::.mmCustomChecks$collinCheck(dataset))

  dataset$z <- 2 * dataset$x
  expect_match(jaspMixedModels:::.mmCustomChecks$collinCheck(dataset), "'x' and 'z'", fixed = TRUE)

  # a variable without variance is left to the variance check
  dataset$constant <- 1
  expect_match(jaspMixedModels:::.mmCustomChecks$collinCheck(dataset), "'x' and 'z'", fixed = TRUE)
})
