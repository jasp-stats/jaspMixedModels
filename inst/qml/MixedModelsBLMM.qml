//
// Copyright (C) 2013-2018 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//
import QtQuick
import QtQuick.Layouts
import JASP
import JASP.Controls
import "./common"		as MM

Form {
	info: qsTr("Bayesian Linear Mixed Models allow you to model a linear relationship between one or more explanatory variable(s) and a continuous dependent variable in cases where the observations are not independent, but clustered within one or several random effects grouping factors (e.g., repeated measures across participants or items, children within schools). An introduction to this model class and the concepts introduced below is provided in Singmann and Kellen (2019).") + "\n" +
	"## " + qsTr("Assumptions") + "\n" +
	"- " + qsTr("Continuous response variable.") + "\n" +
	"- " + qsTr("Linearity and additivity: The response variable is linearly related to all predictors and the effects of the predictors are additive.") + "\n" +
	"- " + qsTr("Independence of errors: The errors are uncorrelated with each other after taking the model (i.e., fixed effects and random effects structure) into account.") + "\n" +
	"- " + qsTr("Homoscedasticity: The error variance of each predictor is constant across all values of that predictor.") + "\n" +
	"- " + qsTr("Normality of errors: The errors are normally distributed with mean zero.") + "\n\n" +
	qsTr("The analysis uses orthonormal contrasts such that the marginal prior on all fixed effects is identical for categorical (nominal and ordinal) predictors (R uses dummy encoding by default). This scheme is used for better interpretability of models with interactions. However, the fixed and random effects estimates will differ from those obtained from R with default settings. We advise using the 'Estimated marginal means' section for obtaining mean estimates at individual factor levels. For comparing the mean estimates, use the contrasts option.") + "\n\n" +
	qsTr("The analysis uses a long data format.") + "\n\n" +
	qsTr("The prior distributions are weakly informative and should be well-behaved in parameter estimation settings. The module uses the default prior distribution settings of the rstanarm R package which defines normal(location = 0, scale = 2.5) prior distributions on scaled and centered model coefficients.")

	id: form

	Formula
	{
		lhs: "dependent"
		rhs: ["fixedEffects", {randomEffects: "randomEffects"}]
	}

	VariablesForm
	{
		preferredHeight: 350 * jaspTheme.uiScale

		AvailableVariablesList
		{
			name:				"allVariablesList"
		}

		AssignedVariablesList
		{
			name:				"dependent"
			title:				qsTr("Dependent variable"); info: qsTr("Dependent (response) variable.")
			allowedColumns:		["scale"]
			singleVariable:		true
		}

		AssignedVariablesList
		{
			name:				"fixedVariables"
			title:				qsTr("Fixed effects variables"); info: qsTr("Variables used as the fixed effects predictors (the model terms can be specified under Model section). These are usually the variables of primary scientific interest.")
			allowedColumns:		["nominal", "scale"]
			allowTypeChange:	true
		}

		AssignedVariablesList
		{
			name:				"randomVariables"
			title:				qsTr("Random effects grouping factors"); info: qsTr("Categorical variable(s) specifying clusters of observations (i.e., several observations per level of a random effects grouping factor). These are typically variables, such as participants or items, one wants to generalize over. Factors with very few levels (i.e., fewer than five or six levels) should not be used as random effects grouping factors as the number of levels determines the power of the test of the fixed effects tests (Westfall, Kenny, & Judd, 2014). The random effects structure (i.e., random intercepts, random slopes, and correlations among random effects parameters) can be specified under Model - Random effects. The default random effects structure is the automatically determined 'maximal random effects structure justified by the design' (Barr, Levy, Scheepers, & Tily, 2013).")
			allowedColumns:		["nominal"]
		}
	}

	MM.MixedModelsModel
	{
		analysisType: "Bayesian"
	}

	MM.MixedModelsBOptions {}

	MM.MixedModelsMCMCDiagnostics {}

	MM.MixedModelsPlots
	{
		analysisType: "Bayesian"
	}

	Section
	{
		title:		qsTr("Estimated marginal means")
		expanded:	false

		VariablesForm
		{
			preferredHeight:	250 * jaspTheme.uiScale

			AvailableVariablesList
			{
				name:	"availableModelComponentsMeans"
				title:	qsTr("Model variables"); info: qsTr("Fixed effects variables that can be used for computing estimated marginal means.")
				source: [{ name: "fixedEffects", use: "noInteraction" }]
			}

			AssignedVariablesList
			{
				id:		marginalMeans
				name:	"marginalMeansTerms"
				title:	qsTr("Selected variables"); info: qsTr("Variables for which the estimated marginal means will be computed.")
			}
		}

		CIField
		{
			name:	"marginalMeansCiLevel"
			label:	qsTr("Confidence interval"); info: qsTr("Width of the confidence interval. Set at 95% by default, which can be changed by the user.")
		}

		DoubleField
		{
			id:				marginalMeansSD
			name:			"marginalMeansSd"
			label:			qsTr("SD factor covariates"); info: qsTr("What should be the 'levels' of continuous variables (expressed in standard deviations) for which the estimated marginal means are computed.")
			defaultValue: 	1
			min:			0
			enabled:		marginalMeans.columnsTypes.includes("scale")
		}
		
		CheckBox
		{
			name:	"marginalMeansContrast"
			id:		marginalMeansContrast
			label:	qsTr("Specify contrasts"); info: qsTr("Creates a table for specifying contrasts based on the estimated marginal means. The first column contains row indices corresponding to the estimated marginal means output table. Columns with variable names show the levels of each variable for the respective marginal mean. Columns labeled ‘Contrast x’ are used to define contrasts. To specify a contrast between two marginal means, enter -1 and 1 in the corresponding rows. Interactions can be tested by defining differences in marginal means of one variable across levels of another.")
		}

		CustomContrastsTableView
		{
			Layout.columnSpan:	2
			visible:			marginalMeansContrast.checked
			name:				"contrasts"
			source:				"marginalMeansTerms"
			scaleFactor:		marginalMeansSD.value
		}
	}

	Section
	{
		title:		qsTr("Estimated trends/conditional slopes")
		expanded:	false

		VariablesForm
		{
			preferredHeight: 100 * jaspTheme.uiScale

			AvailableVariablesList
			{
				name:	"availableModelComponentsTrends1"
				title:	qsTr("Continous variables"); info: qsTr("Continuous fixed effects variables that can be used for estimating the conditional slopes.")
				source: [ { name: "fixedEffects", use: "type=scale"} ]
			}

			AssignedVariablesList
			{
				singleVariable:	true
				name:			"trendsTrendVariable"
				title:			qsTr("Trend variable"); info: qsTr("Variables for which the estimated conditional slopes will be computed.")
			}
		}

		VariablesForm
		{
			preferredHeight: 250 * jaspTheme.uiScale

			AvailableVariablesList
			{
				name:	"availableModelComponentsTrends2"
				title:	qsTr("Model variables"); info: qsTr("Fixed effects variables over which the conditional slopes can be computed.")
				source:	[{ name: "fixedEffects", use: "noInteraction" }]
			}

			AssignedVariablesList
			{
				id:		trendsVariables
				name:	"trendsVariables"
				title:	qsTr("Selected variables"); info: qsTr("Variables over which the conditional slopes will be computed.")
			}
		}

		CIField
		{
			name:	"trendsCiLevel"
			label:	qsTr("Confidence interval"); info: qsTr("Width of the confidence interval. Set at 95% by default, which can be changed by the user.")
		}

		DoubleField
		{ 
			id:				trendsSD
			name:			"trendsSd"
			label:			qsTr("SD factor covariates"); info: qsTr("What should be the 'levels' of continuous variables (expressed in standard deviations) over which the conditional slopes are computed.")
			defaultValue:	1
			min:			0
			enabled:		trendsVariables.columnsTypes.includes("scale")
		}

		CheckBox
		{
			name:	"trendsContrast"
			id:		trendsContrast
			label:	qsTr("Specify contrasts"); info: qsTr("Creates a table for specifying contrasts based on the estimated conditional slopes. The first column contains row indices corresponding to the estimated conditional slopes output table. Columns with variable names show the levels of each variable for the respective conditional slope. Columns labeled ‘Contrast x’ are used to define contrasts. To specify a contrast between two conditional slopes, enter -1 and 1 in the corresponding rows. Interactions can be tested by defining differences in conditional slopes of one variable across levels of another.")
		}

		CustomContrastsTableView
		{
			Layout.columnSpan:	2
			visible:			trendsContrast.checked
			name:				"trendsContrasts"
			source:				"trendsVariables"
			scaleFactor:		trendsSD.value
		}
	}

}
