//
// Copyright (C) 2013-2020 University of Amsterdam
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
	info: qsTr("Linear Mixed Models allow you to model a linear relationship between one or more explanatory variable(s) and a continuous dependent variable in cases where the observations are not independent, but clustered given one or several random effects grouping factors (e.g., repeated measures across participants or items, children within schools). An introduction to this model class and the concepts introduced below is provided in Singmann and Kellen (2019).") + "\n" +
	"## " + qsTr(Assumptions) + "\n" +
	"- " + qsTr("Continuous response variable.") + "\n" +
	"- " + qsTr("Linearity and additivity: The response variable is linearly related to all predictors and the effects of the predictors are additive.") + "\n" +
	"- " + qsTr("Independence of errors: The errors are uncorrelated with each other after taking the model (i.e., fixed effects and random effects structure) into account.") + "\n" +
	"- " + qsTr("Homoscedasticity: The error variance of each predictor is constant across all values of that predictor.") + "\n" +
	"- " + qsTr("Normality of errors: The errors are normally distributed with mean zero.") + "\n" +
	qsTr("The analysis uses sum contrast encoding for categorical (nominal and ordinal) predictors (R uses dummy encoding by default). This scheme is used for better interpretability of models with interactions. However, the fixed and random effects estimates will differ from those obtained from R with default settings. We advise using the 'Estimated marginal means' section for obtaining mean estimates at individual factor levels. For comparing the mean estimates, use the contrasts option. To change the contrast enconding for the analysis use Factor contrast dropdown in the Options section.") + "\n" +
	qsTr("The analysis uses a long data format.")

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
			title:				qsTr("Random effects grouping factors"); info: qsTr("Categorical variable(s) specifying clusters of observations (i.e., several observations per level of a random effects grouping factor). These are typically variables, such as participant or item, one wants to generalize over. Factors with very few levels should not be used as random effects grouping factors. Moreover, the number of levels of the random effects grouping factors determines the power of the test of the fixed effects. The random effect structure (i.e., random intercepts, random slopes, and correlations among random effects parameters) can be specified under Model - Random effects. The default random effects structure is the automatically determined maximal random effects structure justified by the design.")
			allowedColumns:		["nominal"]
		}
	}

	MM.MixedModelsModel {}

	MM.MixedModelsOptions {}

	MM.MixedModelsPlots {}

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
			label:	qsTr("Confidence interval")
		}

		DoubleField
		{
			id:				marginalMeansSD
			name:			"marginalMeansSd"
			label:			qsTr("SD factor covariates")
			defaultValue: 	1
			min:			0
			enabled:		marginalMeans.columnsTypes.includes("scale")
		}

		Group
		{
			DropDown
			{
				name:	"marginalMeansDf"
				id:		marginalMeansDf
				label:	qsTr("Estimate df"); info: qsTr("Method of estimating degrees of freedom. Note that Kenward-Roger approximation for degrees of freedom can be very RAM and time consuming with larger datasets.")
				values:
				[
					{ label: qsTr("Asymptotic"),		value: "asymptotic"},
					{ label: "Satterthwaite",			value: "satterthwaite"},
					{ label: "Kenward-Roger",			value: "kenwardRoger"}
				]
			}

			CheckBox
			{
				enabled:	marginalMeansDf.currentValue == "satterthwaite" | marginalMeansDf.currentValue == "kenwardRoger"
				name:		"marginalMeansDfEstimated"
				label:		qsTr("Force df estimation"); info: qsTr("JASP automatically uses Asymptotic degrees of freedom in cases with a large dataset. This can be disabled by ticking this checkbox.")
			}

		}

		Group
		{
			columns: 2

			CheckBox
			{
				name:	"marginalMeansComparison"
				id:		marginalMeansCompare
				label:	qsTr("Compare marginal means to:"); info: qsTr("Value to which will be the estimated marginal means compared.")
			}

			DoubleField
			{
				enabled:	marginalMeansCompare.checked
				name:		"marginalMeansComparisonWith"
			}
		}
		
		CheckBox
		{
			name:	"marginalMeansContrast"
			id:		marginalMeansContrast
			label:	qsTr("Specify contrasts"); info: qsTr("Creates a table for specifying contrasts based on the estimated marginal means. The first column contains indices of rows corresponding to the estimated marginal means output table. Columns with variable names contain the combinations of variables level for each estimated marginal mean. Columns named Contrast x are used for specifying the contrasts. To set a contrast between two marginal means, enter -1 and 1 to the corresponding rows. Interactions can be tested by specifying differences between the changes in marginal means of one variable across levels of another variable.")
		}

		DropDown
		{
			name:	"marginalMeansPAdjustment"
			label:	qsTr("P-value adjustment"); info: qsTr("To correct for multiple comparison testing and avoid Type I errors, different methods for correcting the p-value are available:")
			values:
			[
				{ label: "Holm", info: qsTr(" This method is also called sequential Bonferroni, and considered less conservative than the Bonferroni method.")	,				value: "holm"},
				{ label: qsTr("Multivariate-t"), info: qsTr("Correction that takes into account that test results might be correlated. Best suited then for multivariate models.")	,value: "mvt"},
				{ label: "Scheffé",	info: qsTr(" Adjusting significance levels in a linear regression, to account for multiple comparisons. This method is considered to be quite conservative.")	,			value: "scheffe"},
				{ label: "Tukey", info: qsTr(" Compare all possible pairs of group means. This correction can be used when the groups of the independent variable have an equal sample size and variance.")	,				value: "tukey"},
				{ label: qsTr("None"), info: qsTr(" No adjustment is conducted.") ,				value: "none"},
				{ label: "Bonferroni", info: qsTr("this correction is considered conservative. The risk of Type I error is reduced, however the statistical power decreases as well.")	,			value: "bonferroni"},
				{ label: "Hommel",	info: qsTr("This correction is considered to be more powerful but less conservative than Bonferroni and Holm corrections. Recommended for a small number of tests.")	,			value: "hommel"}
			]
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
				title:	qsTr("Selected variables"); info: qsTr("Variables over which the the conditional slopes will be computed.")
			}
		}

		CIField
		{
			name:	"trendsCiLevel"
			label:	qsTr("Confidence interval")
		}

		DoubleField
		{ 
			id:				trendsSD
			name:			"trendsSd"
			label:			qsTr("SD factor covariates")
			defaultValue:	1
			min:			0
			enabled:		trendsVariables.columnsTypes.includes("scale")
		}

		Group
		{
			DropDown
			{
				name:	"trendsDf"
				id:		trendsDf
				label:	qsTr("Estimate df"); info: qsTr(" Method of estimating degrees of freedom. Note that Kenward-Roger approximation for degrees of freedom can be very RAM and time consuming with larger datasets.")
				values:
				[
					{ label: qsTr("Asymptotic"),		value: "asymptotic"},
					{ label: "Satterthwaite",			value: "satterthwaite"},
					{ label: "Kenward-Roger",			value: "kenwardRoger"}
				]
			}

			CheckBox
			{
				enabled:	trendsDf.currentValue == "satterthwaite" | trendsDf.currentValue == "kenwardRoger"
				name:		"trendsDfEstimated"
				label:		qsTr("Force df estimation"); info: qsTr("JASP automatically uses Asymptotic degrees of freedom in cases with a large dataset. This can be disabled by ticking this checkbox.")
			}
		}

		Group
		{
			columns: 2

			CheckBox
			{
				name:	"trendsComparison"
				id:		trendsCompare
				label:	qsTr("Compare trends to:"); info: qsTr("Value to which will be the estimated conditional slopes compared.")
			}

			DoubleField
			{
				enabled:	trendsCompare.checked
				name:		"trendsComparisonWith"
			}
		}

		CheckBox
		{
			name:	"trendsContrast"
			id:		trendsContrast
			label:	qsTr("Specify contrasts"); info: qsTr("Creates a table for specifying contrasts based on the estimated conditional slopes. The first column contains indices of rows corresponding to the estimated conditional slopes output table. Columns with variable names contain the combinations of variables level for each estimated conditional slope. Columns named Contrast x are used for specifying the contrasts. To set a contrast between two conditional slopes, enter -1 and 1 to the corresponding rows. Interactions can be tested by specifying differences between the changes in conditional slopes of one variable across levels of another variable.")
		}

		DropDown
		{
			name:	"trendsPAdjustment"
			label:	qsTr("P-value adjustment"); info: qsTr("To correct for multiple comparison testing and avoid Type I errors, different methods for correcting the p-value are available:")
			values:
			[
				{ label: "Holm", info: qsTr(" This method is also called sequential Bonferroni, and considered less conservative than the Bonferroni method.")	,				value: "holm"},
				{ label: qsTr("Multivariate-t"), info: qsTr("Correction that takes into account that test results might be correlated. Best suited then for multivariate models.")	,value: "mvt"},
				{ label: "Scheffé",	info: qsTr(" Adjusting significance levels in a linear regression, to account for multiple comparisons. This method is considered to be quite conservative.")	,			value: "scheffe"},
				{ label: "Tukey", info: qsTr(" Compare all possible pairs of group means. This correction can be used when the groups of the independent variable have an equal sample size and variance.")	,				value: "tukey"},
				{ label: qsTr("None"), info: qsTr(" No adjustment is conducted.") ,				value: "none"},
				{ label: "Bonferroni", info: qsTr("this correction is considered conservative. The risk of Type I error is reduced, however the statistical power decreases as well.")	,			value: "bonferroni"},
				{ label: "Hommel",	info: qsTr("This correction is considered to be more powerful but less conservative than Bonferroni and Holm corrections. Recommended for a small number of tests.")	,			value: "hommel"}
			]
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
