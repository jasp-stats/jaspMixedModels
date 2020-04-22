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

MixedModelsLMM   <- function(jaspResults, dataset, options, state = NULL){
  
  if(!options$run)return()
  if(!.mmReady(options))return()
  
  
  # load dataset
  dataset <- .mmReadData(dataset, options)
  .mmCheckData(dataset)
  
  # fit the model
  if(is.null(jaspResults[["mmModel"]])).mmFitModel(jaspResults, dataset, options)
  
  
  # create summary tables
  .mmSummaryAnova(jaspResults, dataset, options)
  if(options$showFE).mmSummaryFE(jaspResults, options)
  if(options$showRE).mmSummaryRE(jaspResults, options)
  
  
  # create plots
  if(length(options$plotsX)).mmPlot(jaspResults, dataset, options)
  
  
  # marginal means
  if(length(options$marginalMeans) > 0).mmMarginalMeans(jaspResults, dataset, options)
  
  
  # trends
  if(length(options$trendsTrend) > 0 & length(options$trendsVariables) > 0).mmTrends(jaspResults, dataset, options)
  
  
  return()
}