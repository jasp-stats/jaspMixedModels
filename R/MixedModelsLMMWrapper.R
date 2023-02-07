#
# Copyright (C) 2013-2022 University of Amsterdam
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# This is a generated file. Don't change it

MixedModelsLMM <- function(
          data = NULL,
          version = "0.17.1",
          formula = NULL,
          bootstrapSamples = 500,
          contrasts = list(),
          dependent = "",
          fixedEffectEstimate = FALSE,
          fixedEffects = list(),
          fixedVariables = list(),
          interceptTest = FALSE,
          marginalMeansCiLevel = 0.95,
          marginalMeansComparison = FALSE,
          marginalMeansComparisonWith = 0,
          marginalMeansContrast = FALSE,
          marginalMeansDf = "asymptotic",
          marginalMeansDfEstimated = FALSE,
          marginalMeansPAdjustment = "holm",
          marginalMeansSd = 1,
          marginalMeansTerms = list(),
          modelSummary = FALSE,
          plotBackgroundColor = "darkgrey",
          plotBackgroundData = list(),
          plotBackgroundElement = "jitter",
          plotCiLevel = 0.95,
          plotCiType = "model",
          plotDodge = 0.3,
          plotElementWidth = 1,
          plotEstimatesTable = FALSE,
          plotHeight = 320,
          plotHorizontalAxis = list(),
          plotJitterHeight = 0,
          plotJitterWidth = 0.1,
          plotLegendPosition = "none",
          plotLevelsByColor = FALSE,
          plotLevelsByFill = FALSE,
          plotLevelsByLinetype = TRUE,
          plotLevelsByShape = TRUE,
          plotRelativeSizeData = 1,
          plotRelativeSizeText = 1.5,
          plotSeparateLines = list(),
          plotSeparatePlots = list(),
          plotTheme = "jasp",
          plotTransparency = 0.7,
          plotWidth = 480,
          randomEffectEstimate = FALSE,
          randomEffects = list(),
          randomVariables = list(),
          seed = 1,
          setSeed = FALSE,
          testMethod = "satterthwaite",
          trendsCiLevel = 0.95,
          trendsComparison = FALSE,
          trendsComparisonWith = 0,
          trendsContrast = FALSE,
          trendsContrasts = list(),
          trendsDf = "asymptotic",
          trendsDfEstimated = FALSE,
          trendsPAdjustment = "holm",
          trendsSd = 1,
          trendsTrendVariable = list(),
          trendsVariables = list(),
          type = "3",
          varianceCorrelationEstimate = FALSE,
          vovkSellke = FALSE) {

   defaultArgCalls <- formals(jaspMixedModels::MixedModelsLMM)
   defaultArgs <- lapply(defaultArgCalls, eval)
   options <- as.list(match.call())[-1L]
   options <- lapply(options, eval)
   defaults <- setdiff(names(defaultArgs), names(options))
   options[defaults] <- defaultArgs[defaults]
   options[["data"]] <- NULL
   options[["version"]] <- NULL

   if (!is.null(formula)) {
      if (!inherits(formula, "formula")) {
         formula <- as.formula(formula)
      }
      options$formula <- jaspBase::jaspFormula(formula, data)
   }

   optionsWithFormula <- c("contrasts", "dependent", "fixedEffects", "fixedVariables", "marginalMeansDf", "marginalMeansPAdjustment", "marginalMeansTerms", "plotBackgroundColor", "plotBackgroundData", "plotBackgroundElement", "plotCiType", "plotHorizontalAxis", "plotLegendPosition", "plotSeparateLines", "plotSeparatePlots", "plotTheme", "randomEffects", "randomVariables", "testMethod", "trendsContrasts", "trendsDf", "trendsPAdjustment", "trendsTrendVariable", "trendsVariables")
   for (name in optionsWithFormula) {
      if ((name %in% optionsWithFormula) && inherits(options[[name]], "formula")) options[[name]] = jaspBase::jaspFormula(options[[name]], data)   }

   return(jaspBase::runWrappedAnalysis("jaspMixedModels::MixedModelsLMM", data, options, version))
}