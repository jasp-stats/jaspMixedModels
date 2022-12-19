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

MixedModelsBGLMM <- function(
          data = NULL,
          version = "0.17",
          formula = NULL,
          ciLevel = 0.95,
          contrasts = list(),
          dependent = "",
          dependentAggregation = "",
          estimateType = "deviation",
          family = "bernoulli",
          fixedEffectEstimate = FALSE,
          fixedEffects = list(),
          fixedVariables = list(),
          link = "logit",
          marginalMeansCiLevel = 0.95,
          marginalMeansContrast = FALSE,
          marginalMeansResponse = TRUE,
          marginalMeansSd = 1,
          marginalMeansTerms = list(),
          mcmcAdaptDelta = 0.8,
          mcmcBurnin = 2000,
          mcmcChains = 3,
          mcmcDiagnosticsHorizontal = list(),
          mcmcDiagnosticsType = "traceplot",
          mcmcDiagnosticsVertical = list(),
          mcmcMaxTreedepth = 10,
          mcmcSamples = 4000,
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
          trendsCiLevel = 0.95,
          trendsContrast = FALSE,
          trendsContrasts = list(),
          trendsSd = 1,
          trendsTrendVariable = list(),
          trendsVariables = list(),
          varianceCorrelationEstimate = FALSE) {

   defaultArgCalls <- formals(jaspMixedModels::MixedModelsBGLMM)
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

   optionsWithFormula <- c("contrasts", "dependent", "dependentAggregation", "family", "fixedEffects", "fixedVariables", "marginalMeansTerms", "mcmcDiagnosticsHorizontal", "mcmcDiagnosticsType", "mcmcDiagnosticsVertical", "plotBackgroundColor", "plotBackgroundData", "plotBackgroundElement", "plotCiType", "plotHorizontalAxis", "plotLegendPosition", "plotSeparateLines", "plotSeparatePlots", "plotTheme", "randomEffects", "randomVariables", "trendsContrasts", "trendsTrendVariable", "trendsVariables")
   for (name in optionsWithFormula) {
      if ((name %in% optionsWithFormula) && inherits(options[[name]], "formula")) options[[name]] = jaspBase::jaspFormula(options[[name]], data)   }

   return(jaspBase::runWrappedAnalysis("jaspMixedModels::MixedModelsBGLMM", data, options, version))
}