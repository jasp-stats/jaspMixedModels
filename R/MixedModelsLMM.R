#
# Copyright (C) 2019 University of Amsterdam
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

MixedModelsLMMWrapper <- function(
          data = NULL,
          formula = NULL,
          Contrasts = list(),
          bootstrapSamples = 500,
          dependentVariable = "",
          fitStats = FALSE,
          fixedEffects = list(),
          fixedVariables = list(),
          marginalMeans = list(),
          marginalMeansAdjustment = "holm",
          marginalMeansCIwidth = 0.95,
          marginalMeansCompare = FALSE,
          marginalMeansCompareTo = 0,
          marginalMeansContrast = FALSE,
          marginalMeansDf = "asymptotic",
          marginalMeansOverride = FALSE,
          marginalMeansSD = 1,
          method = "S",
          plotAlpha = 0.7,
          plotDodge = 0.3,
          plotGeomWidth = 1,
          plotHeight = 320,
          plotJitterHeight = 0,
          plotJitterWidth = 0.1,
          plotLegendPosition = "none",
          plotRelativeSize = 1,
          plotRelativeSizeText = 1.5,
          plotWidth = 480,
          plotsAgregatedOver = list(),
          plotsBackgroundColor = "darkgrey",
          plotsCImethod = "model",
          plotsCIwidth = 0.95,
          plotsEstimatesTable = FALSE,
          plotsGeom = "geom_jitter",
          plotsMappingColor = FALSE,
          plotsMappingFill = FALSE,
          plotsMappingLineType = TRUE,
          plotsMappingShape = TRUE,
          plotsPanel = list(),
          plotsTheme = "JASP",
          plotsTrace = list(),
          plotsX = list(),
          pvalVS = FALSE,
          randomEffects = list(),
          randomVariables = list(),
          seed = 1,
          setSeed = FALSE,
          showFE = FALSE,
          showRE = FALSE,
          showREEstimates = FALSE,
          test_intercept = FALSE,
          trendsAdjustment = "holm",
          trendsCIwidth = 0.95,
          trendsCompare = FALSE,
          trendsCompareTo = 0,
          trendsContrast = FALSE,
          trendsContrasts = list(),
          trendsDf = "asymptotic",
          trendsOverride = FALSE,
          trendsSD = 1,
          trendsTrend = list(),
          trendsVariables = list(),
          type = "3") {

   defaultArgCalls <- formals(jaspMixedModels::MixedModelsLMMWrapper)
   defaultArgs <- lapply(defaultArgCalls, eval)
   options <- as.list(match.call())[-1L]
   options <- lapply(options, eval)
   defaults <- setdiff(names(defaultArgs), names(options))
   options[defaults] <- defaultArgs[defaults]
   options[["data"]] <- NULL

   if (!is.null(formula)) {
      if (!inherits(formula, "formula")) {
         formula <- as.formula(formula)
      }
      options$formula <- deparse1(formula)
   }

   optionsWithFormula <- c("Contrasts", "fixedEffects", "marginalMeans", "plotsPanel", "plotsTrace", "plotsX", "trendsContrasts", "trendsTrend", "trendsVariables")
   for (name in optionsWithFormula) {
      if ((name %in% optionsWithFormula) && inherits(options[[name]], "formula")) options[[name]] = deparse1(options[[name]])   }

   if (jaspResultsCalledFromJasp()) {
      result <- list("options" = options, "analysis"="jaspMixedModels::MixedModelsLMM")
      result <- jsonlite::toJSON(result, auto_unbox = TRUE, digits = NA, null="null")
      toString(result)
   } else {
      options <- checkAnalysisOptions("jaspMixedModels::MixedModelsLMM", options)
      jaspTools::runAnalysis("jaspMixedModels::MixedModelsLMM", data, options)
   }

}

MixedModelsLMM   <-
  function(jaspResults, dataset, options, state = NULL) {

    .mmRunAnalysis(jaspResults, dataset, options, "LMM")
    
    return()
  }
