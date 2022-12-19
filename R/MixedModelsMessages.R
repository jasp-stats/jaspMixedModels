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

#No need for gettext on next line as they are wider than even my big ass screen anyway
.mmMessageInterpretability          <- function()       gettext("The intercept corresponds to the (unweighted) grand mean; for each factor with k levels, k - 1 parameters are estimated with sum contrast coding. Consequently, the estimates cannot be directly mapped to factor levels. Use estimated marginal means for obtaining estimates for each factor level/design cell or their differences.")
.mmMessageInterpretabilityBayesian  <- function()       gettext("The intercept corresponds to the (unweighted) grand mean; for each factor with k levels, k - 1 parameters are estimated with orthonormal coding proposed by Rouder et al. (2012). Consequently, the estimates cannot be directly mapped to factor levels. Use estimated marginal means for obtaining estimates for each factor level/design cell or their differences.")
.mmMessageSingularFit               <- function()       gettext("Model fit is singular. Specified random effects parameters (random intercepts and random slopes) cannot be estimated from the available data. Carefully reduce the random effects structure, but this practice might inflate the reported p-value, and invalidates the analysis.")
.mmMessageVovkSellke                <- function()       gettextf("Vovk-Sellke Maximum <em>p</em>-Ratio: Based on a two-sided <em>p</em>-value, the maximum possible odds in favor of H%1$s over H%2$s equals 1/(-e <em>p</em> log(<em>p</em>)) for <em>p</em> %3$s .37 (Sellke, Bayarri, & Berger, 2001).","\u2081","\u2080","\u2264")
.mmMessageNumericalProblems         <- function()       gettext("Numerical problems with the maximum-likelihood estimate (e.g., gradients too large). This may indicate that the specified random effects parameters (random intercepts and random slopes) cannot be estimated from the available data. Consider carefully reducing the random effects structure, but be aware this may induce unknown risks of anti-conservative results (i.e., p-values might be lower than nominal).")
.mmMessageDFdisabled                <- function()       gettext("Estimation of degrees of freedom disabled (i.e., asymptotic results shown), because the number of observations is large. To force estimation, check corresponding option.")
.mmMessageResponse                  <- function()       gettext("Results are on the response scale.")
.mmMessageNotResponse               <- function()       gettext("Results are not on the response scale and might be misleading.")
.mmMessageANOVAtype                 <- function(type)   gettextf("Type %s Sum of Squares", type) 
.mmMessageMissingRE                 <- function()       gettext("This analysis requires at least one random effects grouping factor to run.")
.mmMessageMissingAgg                <- function()       gettext("The 'Binomial (aggregated)' family requires the 'Number of trials' to be specified to run.")
.mmMessageTestNull                  <- function(value)  gettextf("P-values correspond to test of null hypothesis against %s.", value) 
.mmMessageAveragedOver              <- function(terms)  gettextf("Results are averaged over the levels of: %s.",paste(terms, collapse = ", ")) 

.mmMessageREgrouping    <- function(RE_grouping_factors) {
  sprintf(
    ngettext(
      length(RE_grouping_factors),
      "The following variable is used as a random effects grouping factor: %s.",
      "The following variables are used as random effects grouping factors: %s."
    ),
    paste0("'", RE_grouping_factors, "'", collapse = ", ")
  )
}
.mmMessageOmmitedTerms1 <- function(terms, grouping) {
  sprintf(
    ngettext(
      length(terms),
      "All random slopes involving ‘%1$s’ have been removed for the random effects grouping factor ‘%2$s’. -- Factor %3$s does not vary within the levels of random effects grouping factor '%4$s'.",
      "All random slopes involving ‘%1$s’ have been removed for the random effects grouping factor ‘%2$s’. -- Factors %3$s do not vary within the levels of random effects grouping factor '%4$s'.",
    ),
    paste0("'", terms, "'", collapse = ", "),
    grouping,
    paste0("'", terms, "'", collapse = ", "),
    grouping
  )
}

.mmMessageOmmitedTerms2 <- function(terms, grouping) {
  sprintf(
    ngettext(
      length(terms),
      "Random slope of ‘%1$s’ for the random effects grouping factor ‘%2$s’ removed -- Too few observations to estimate random slope of '%3$s' for random effects grouping factor '%4$s'.",
      "Random slopes of ‘%1$s’ for the random effects grouping factor ‘%2$s’ removed -- Too few observations to estimate random slopes of '%3$s' for random effects grouping factor '%4$s'."
    ),
    paste0("'", terms, "'", collapse = ", "),
    grouping,
    paste0("'", terms, "'", collapse = ", "),
    grouping
  )
}

.mmMessageAddedTerms    <- function(terms, grouping) {
  sprintf(
    ngettext(
      length(terms),
      "Lower order random effects terms need to be specified in presence of the higher order random effects terms. Therefore, the following random effects term was added to the '%1$s' random effects grouping factor: '%s2$.'",
      "Lower order random effects terms need to be specified in presence of the higher order random effects terms. Therefore, the following random effects terms were added to the '%1$s' random effects grouping factor: '%2$s.'"
    ),
    grouping,
    paste0("'", terms, "'", collapse = ", ")
  )
}

.mmMessageMissingRows   <- function(value) {
  sprintf(
    ngettext(
      value,
      "%i observation was removed due to missing values.",
      "%i observations were removed due to missing values."
    ),
    value
  )
}

.mmMessageGLMMtype      <- function(family, link) {
  family <- switch(family,
                   "bernoulli"         = gettext("binomial"),
                   "binomial"          = gettext("binomial"),
                   "gaussian"          = gettext("gaussian"),
                   "gamma"             = gettext("gamma"),
                   "inverseGaussian"   = gettext("inverseGaussian"),
                   "poisson"           = gettext("poisson"),
                   "negativeBinomial"  = gettext("negative binomial"),
                   "beta"              = gettext("beta"),
  )
  gettextf("Generalized linear mixed model with %1$s family and %2$s link function.",
           family,
           link)
}

.mmMessageTermTest      <- function(testMethod) {
  testMethod <- switch(testMethod,
                   "satterthwaite"   = gettext("Satterthwaite"),
                   "kenwardRoger"  = gettext("Kenward-Roger"),
                   "likelihoodRatioTest" = gettext("likelihood ratio tests"),
                   "parametricBootstrap"  = gettext("parametric bootstrap")
  )
  gettextf("Model terms tested with %s testMethod.",testMethod)
}

.messagePvalAdjustment  <- function(adjustment) {
  if (adjustment == "none") {
    return(gettext("P-values are not adjusted."))
  }
  adjustment <- switch(adjustment,
                       "holm"       = gettext("Holm"),
                       "hommel"     = gettext("Homel"),
                       "hochberg"   = gettext("Hochberg"),
                       "mvt"        = gettext("Multivariate-t"),
                       "tukey"      = gettext("Tukey"),
                       "BH"         = gettext("Benjamini-Hochberg"),
                       "BY"         = gettext("Benjamini-Yekutieli"),
                       "scheffe"    = gettext("Scheffé"),
                       "sidak"      = gettext("Sidak"),
                       "dunnettx"   = gettext("Dunnett"),
                       "bonferroni" = gettext("Bonferroni")
  )
  return(gettextf("P-values are adjusted using %s adjustment.",adjustment))
}

.mmMessageDivergentIter <- function(iterations) {
  sprintf(
    ngettext(
      iterations,
      "The Hamiltonian Monte Carlo procedure might be invalid -- There was %i divergent transition after warmup. This can be solved by carefully increasing 'Adapt delta' until there are no divergent transitions.",
      "The Hamiltonian Monte Carlo procedure might be invalid -- There were %i divergent transitions after warmup. This can be solved by carefully increasing 'Adapt delta' until there are no divergent transitions."
    ),
    iterations
  )
}

.mmMessageLowBMFI       <- function(nChains) {
  sprintf(
    ngettext(
      nChains,
      "Bayesian Fraction of Missing Information (BFMI) that was too low in %i chain indicating that the posterior distribution was not explored efficiently. Try increasing number of 'Burnin' and 'Iterations'.",
      "Bayesian Fraction of Missing Information (BFMI) that was too low in %i chains indicating that the posterior distribution was not explored efficiently. Try increasing number of 'Burnin' and 'Iterations'."
    ),
    nChains
  )
}

.mmMessageMaxTreedepth  <- function(iterations) {
  sprintf(
    ngettext(
      iterations,
      "The Hamiltonian Monte Carlo procedure might be inefficient -- %i transition exceeded the maximum tree depth. This can be solved by carefully increasing 'Maximum tree depth'.",
      "The Hamiltonian Monte Carlo procedure might be inefficient -- %i transitions exceeded the maximum tree depth. This can be solved by carefully increasing 'Maximum tree depth'."
    ),
    iterations
  )
}

.mmMessageMaxRhat       <- function(Rhat) {
  gettextf(
    "Inference possibly unreliable -- MCMC chains might not have converged; The largest R-hat is %.3f > 1.01. To lower R-hat please increase 'Iterations', or 'Adapt delta' in the Options section.",
    Rhat
  )
}

.mmMessageMinESS        <- function(ESS, treshold) {
  gettextf(
    "Low estimation accuracy -- The smallest Effective Sample Size (ESS) is %.2f < %1.0f. To increase accuracy please increase 'Iterations', or 'Adapt delta' in the Options section.",
    ESS,
    treshold
  )
}

.mmMessageBadWAIC       <- function(n_bad) {
  sprintf(
    ngettext(
      n_bad,
      "WAIC estimate unreliable -- There was %1.0f p_waic estimate larger than 0.4. We recommend using LOO instead.",
      "WAIC estimate unreliable -- There were %1.0f p_waic estimates larger than 0.4. We recommend using LOO instead."
    ),
    n_bad
  )
}

.mmMessageBadLOO        <- function(n_bad) {
  sprintf(
    ngettext(
      n_bad,
      "LOO estimate unreliable -- There was %1.0f observation with the shape parameter (k) of the generalized Pareto distribution higher than 0.5.",
      "LOO estimate unreliable -- There were %1.0f observations with the shape parameter (k) of the generalized Pareto distribution higher than 0.5."
    ),
    n_bad
  )
}

.mmMessageFitType       <- function(REML) {
  if (REML) {
    return(gettext("The model was fitted using restricted maximum likelihood. Please note that models with different fixed effects cannot be compared when REML is used. To use ML, switch 'Test model terms' to 'Likelihood ratio tests'."))
  } else {
    return(gettext("The model was fitted using maximum likelihood."))
  }
}

.mmErrorOnFit           <- function(error) {
  if (grepl("(maxstephalfit) PIRLS step-halvings failed to reduce deviance in pwrssUpdate", error))
    return(gettext("The optimizer failed to find a solution. Probably due to quasi-separation in the data. Try removing some of the predictors."))
  else if (grepl("PIRLS loop resulted in NaN value", error))
    return(gettext("The optimizer failed to find a solution. Probably due to quasi-separation in the data or an overly complex model structure. Try removing some of the predictors."))
  else if (grepl( "cannot find valid starting values: please specify some", error))
    return(gettext("The optimizer failed to find a solution due to invalid starting values. (JASP currently does not support specifying different starting values.)"))
  else if (grepl("Downdated VtV is not positive definite", error))
    return(gettext("The optimizer failed to find a solution. Probably due to scaling issues quasi-separation in the data. Try rescaling or removing some of the predictors."))
  else
    return(error)
}
