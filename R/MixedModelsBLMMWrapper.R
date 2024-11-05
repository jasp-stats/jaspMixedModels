#
# Copyright (C) 2013-2024 University of Amsterdam
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

MixedModelsBLMM <- function(
          data = NULL,
          version = "0.19.2",
          formula = NULL,
          ciLevel = 0.95,
          contrasts = list(),
          dependent = list(types = list(), value = ""),
          estimateType = "deviation",
          fixedEffectEstimate = FALSE,
          fixedEffects = list(optionKey = "components", types = list(), value = list()),
          fixedVariables = list(types = list(), value = NULL),
          includeIntercept = TRUE,
          marginalMeansCiLevel = 0.95,
          marginalMeansContrast = FALSE,
          marginalMeansSd = 1,
          marginalMeansTerms = list(optionKey = "variable", types = list(), value = list()),
          mcmcAdaptDelta = 0.8,
          mcmcBurnin = 2000,
          mcmcChains = 3,
          mcmcDiagnosticsHorizontal = list(optionKey = "variable", types = list(), value = list()),
          mcmcDiagnosticsType = "traceplot",
          mcmcDiagnosticsVertical = list(optionKey = "variable", types = list(), value = list()),
          mcmcMaxTreedepth = 10,
          mcmcSamples = 4000,
          modelSummary = FALSE,
          plotBackgroundColor = "darkgrey",
          plotBackgroundData = list(types = list(), value = NULL),
          plotBackgroundElement = "jitter",
          plotCiLevel = 0.95,
          plotCiType = "model",
          plotDodge = 0.3,
          plotElementWidth = 1,
          plotEstimatesTable = FALSE,
          plotHeight = 320,
          plotHorizontalAxis = list(optionKey = "variable", types = list(), value = list()),
          plotJitterHeight = 0,
          plotJitterWidth = 0.1,
          plotLegendPosition = "none",
          plotLevelsByColor = FALSE,
          plotLevelsByFill = FALSE,
          plotLevelsByLinetype = TRUE,
          plotLevelsByShape = TRUE,
          plotRelativeSizeData = 1,
          plotRelativeSizeText = 1.5,
          plotSeparateLines = list(optionKey = "variable", types = list(), value = list()),
          plotSeparatePlots = list(optionKey = "variable", types = list(), value = list()),
          plotTheme = "jasp",
          plotTransparency = 0.7,
          plotWidth = 480,
          randomEffectEstimate = FALSE,
          randomEffects = list(),
          randomVariables = list(types = list(), value = NULL),
          seed = 1,
          setSeed = FALSE,
          trendsCiLevel = 0.95,
          trendsContrast = FALSE,
          trendsContrasts = list(),
          trendsSd = 1,
          trendsTrendVariable = list(optionKey = "variable", types = list(), value = list()),
          trendsVariables = list(optionKey = "variable", types = list(), value = list()),
          varianceCorrelationEstimate = FALSE) {

   defaultArgCalls <- formals(jaspMixedModels::MixedModelsBLMM)
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

   optionsWithFormula <- c("contrasts", "dependent", "fixedEffects", "fixedVariables", "marginalMeansTerms", "mcmcDiagnosticsHorizontal", "mcmcDiagnosticsType", "mcmcDiagnosticsVertical", "plotBackgroundColor", "plotBackgroundData", "plotBackgroundElement", "plotCiType", "plotHorizontalAxis", "plotLegendPosition", "plotSeparateLines", "plotSeparatePlots", "plotTheme", "randomEffects", "randomVariables", "trendsContrasts", "trendsTrendVariable", "trendsVariables")
   for (name in optionsWithFormula) {
      if ((name %in% optionsWithFormula) && inherits(options[[name]], "formula")) options[[name]] = jaspBase::jaspFormula(options[[name]], data)   }

   return(jaspBase::runWrappedAnalysis("jaspMixedModels::MixedModelsBLMM", data, options, version))
}
