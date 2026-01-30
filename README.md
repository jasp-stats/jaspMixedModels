<div align="right">

[![Unit Tests](https://github.com/jasp-stats/jaspMixedModels/actions/workflows/unittests.yml/badge.svg)](https://github.com/jasp-stats/jaspMixedModels/actions/workflows/unittests.yml)
[![codecov](https://codecov.io/gh/jasp-stats/jaspMixedModels/branch/master/graph/badge.svg)](https://codecov.io/gh/jasp-stats/jaspMixedModels)
<br>
<b>Maintainer:</b> <a href="https://github.com/FBartos/">František Bartoš</a>

</div>

# The Mixed Models Module

## Overview

<img src='inst/icons/MixedModels_classical.svg' width='149' height='173' align='right'/>

**JASP Mixed Models module** is an add-on module for JASP that provides tools for fitting and interpreting mixed-effects models with focus on factorial designs. The Mixed Models module offers a wide range of functionalities, including frequentist and Bayesian linear and generalized mixed-effects models, random intercepts and slopes, estimation of marginal means and contrasts.


## R Packages

<img src='https://www.r-project.org/logo/Rlogo.svg' width='100' height='78' align='right'/>

The functionality is served by several R packages

- **afex** — Convenience functions for mixed-model specification and ANOVA-like workflows ([afex on CRAN](https://cran.r-project.org/package=afex))
- **lme4** — Fitting linear and generalized linear mixed-effects models ([lme4 on CRAN](https://cran.r-project.org/package=lme4))
- **stanova** — Convenience functions for Bayesian mixed-model specification and ANOVA-like workflows ([stanova on GitHub](https://github.com/bayesstuff/stanova))
- **rstanarm** — Bayesian regression and mixed-effects models using Stan ([rstanarm on CRAN](https://cran.r-project.org/package=rstanarm))
- **emmeans** — Estimated marginal means and contrasts ([emmeans on CRAN](https://cran.r-project.org/package=emmeans))
