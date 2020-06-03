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

MixedModelsBGLMM   <-
  function(jaspResults, dataset, options, state = NULL) {
    # load dataset
    if (.mmReady(options, "GLMM"))
      dataset <- .mmReadData(dataset, options)
    if (.mmReady(options, "GLMM"))
      .mmCheckData(dataset, options, "GLMM")
    
    # fit the model
    if (.mmReady(options, "GLMM"))
      .mmFitModelB(jaspResults, dataset, options, "BGLMM")
    
    
    # create summary tables
    .mmSummaryStanova(jaspResults, dataset, options, "BGLMM")
    
    if (!is.null(jaspResults[["mmModel"]])) {
      if (options$showFE)
        .mmSummaryFEB(jaspResults, options, "BGLMM")
      if (options$showRE)
        .mmSummaryREB(jaspResults, options, "BGLMM")
      
      # sampling diagnostics
      if (length(options$samplingVariable1) != 0)
        .mmDiagnostics(jaspResults, options, dataset, "BGLMM")
      
      # create plots
      if (length(options$plotsX))
        .mmPlot(jaspResults, dataset, options, "BGLMM")
      
      
      # marginal means
      if (length(options$marginalMeans) > 0)
        .mmMarginalMeans(jaspResults, dataset, options, "BGLMM")
      if (length(options$marginalMeans) > 0 &&
          options$marginalMeansContrast &&
          !is.null(jaspResults[["EMMresults"]]))
        .mmContrasts(jaspResults, options, "BGLMM")
      
      
      # trends
      if (length(options$trendsTrend) > 0 &&
          length(options$trendsVariables) > 0)
        .mmTrends(jaspResults, dataset, options, "BGLMM")
      if (options$trendsContrast &&
          length(options$trendsTrend) > 0 &&
          length(options$trendsVariables) > 0 &&
          !is.null(jaspResults[["EMTresults"]]))
        .mmContrasts(jaspResults, options, "BGLMM", what = "Trends")
      
    }
    
    return()
  }