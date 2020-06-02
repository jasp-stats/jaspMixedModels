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

MixedModelsBLMM   <-
  function(jaspResults, dataset, options, state = NULL) {
    # load dataset
    if (.mmReady(options))
      dataset <- .mmReadData(dataset, options)
    if (.mmReady(options))
      .mmCheckData(dataset, options)
    
    # fit the model
    if (is.null(jaspResults[["mmModel"]]) &
        .mmReady(options))
      .mmFitModelB(jaspResults, dataset, options)
    
    
    # create summary tables
    .mmSummaryStanova(jaspResults, dataset, options)
    
    if (!is.null(jaspResults[["mmModel"]])) {
      if (options$showFE)
        .mmSummaryFEB(jaspResults, options)
      if (options$showRE)
        .mmSummaryREB(jaspResults, options)
      
      # sampling diagnostics
      if (length(options$samplingVariable1) != 0)
        .mmDiagnostics(jaspResults, options, dataset)
      
      # create plots
      if (length(options$plotsX))
        .mmPlot(jaspResults, dataset, options)
      
      
      # marginal means
      if (length(options$marginalMeans) > 0)
        .mmMarginalMeans(jaspResults, dataset, options, "BLMM")
      if (length(options$marginalMeans) > 0 &
          options$marginalMeansContrast &
          !is.null(jaspResults[["EMMresults"]]))
        .mmContrasts(jaspResults, options, "BLMM")
      
      
      # trends
      if (length(options$trendsTrend) > 0 &
          length(options$trendsVariables) > 0)
        .mmTrends(jaspResults, dataset, options, "BLMM")
      if (options$trendsContrast &
          length(options$trendsTrend) > 0 &
          length(options$trendsVariables) > 0 &
          !is.null(jaspResults[["EMTresults"]]))
        .mmContrasts(jaspResults, options, "BLMM", what = "Trends")
    }
    
    return()
  }