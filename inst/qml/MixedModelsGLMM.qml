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
	info: qsTr("Generalized Linear Mixed Models allow you to model a linear relationship between one or more explanatory variable(s) and a continuous dependent variable in cases where the observations are not independent, but clustered within one or several random effects grouping factors (e.g., repeated measures across participants or items, children within schools). They are generalizations of Linear Mixed Models and allow you to model response variables that are not continuous using different likelihoods and link functions.") + "\n" +
	"## " + qsTr("Assumptions") + "\n" +
	"- " + qsTr("Linearity and additivity: The response variable is related to all predictors according to the link function and the effects of the predictors are additive on the linear scale.") + "\n" +
	"- " + qsTr("Independence of errors: The errors are uncorrelated with each other after taking the model (i.e., fixed effects and random effects structure) into account.") + "\n" +
	"- " + qsTr("Homoscedasticity: The error variance of each predictor is constant across all values of that predictor.") + "\n" +
	"- " + qsTr("Distribution of errors: The errors are distributed according to the distributional family.") + "\n\n" +
	qsTr("The analysis uses sum contrast encoding for categorical (nominal and ordinal) predictors (R uses dummy encoding by default). This scheme is used for better interpretability of models with interactions. However, the fixed and random effects estimates will differ from those obtained from R with default settings. We advise using the 'Estimated marginal means' section for obtaining mean estimates at individual factor levels. For comparing the mean estimates, use the contrasts option. To change the contrast encoding for the analysis use Factor contrast dropdown in the Options section.") + "\n\n" +
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
		removeInvisibles: true

		AvailableVariablesList
		{
			name:				"allVariablesList"
		}

		AssignedVariablesList
		{
			name:				"dependent"
			title:				qsTr("Dependent variable"); info: qsTr("Dependent (response) variable.")
			allowedColumns: 	family.currentValue === "bernoulli" ? "nominal" : "scale"
			allowTypeChange:	true
			singleVariable:		true
		}

		AssignedVariablesList
		{
			visible:			active
			name:				"dependentAggregation"
			title:				qsTr("Number of trials"); info: qsTr("Number of trials, only applicable if the Binomial (aggregated) family is selected.")
			singleVariable:		true
			allowedColumns:		["scale"]

			onEnabledChanged: if (!enabled && count > 0) itemDoubleClicked(0)
			
			property bool active:	family.currentValue == "binomial"
			onActiveChanged:		if (!active && count > 0) itemDoubleClicked(0)
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
			title:				qsTr("Random effects grouping factors"); info: qsTr("Categorical variable(s) specifying clusters of observations (i.e., several observations per level of a random effects grouping factor). These are typically variables, such as participants or items, one wants to generalize over. Factors with very few levels (i.e., fewer than five or six levels) should not be used as random effects grouping factors as the number of levels determines the power of the fixed effects tests (Westfall, Kenny, & Judd, 2014). The random effects structure (i.e., random intercepts, random slopes, and correlations among random effects parameters) can be specified under Model - Random effects. The default random effects structure is the automatically determined 'maximal random effects structure justified by the design' (Barr, Levy, Scheepers, & Tily, 2013).")
			allowedColumns:		["nominal"]
		}
	}

	Group
	{

		DropDown
		{
			name:				"family"
			label:				qsTr("Family"); info: qsTr("Distribution function which likelihood will be used for the dependent variable. Several options are available.")
			id:					family
			indexDefaultValue:	0
			values:
			[
				{ label: qsTr("Bernoulli"),				value: "bernoulli"},
				{ label: qsTr("Binomial"),				value: "binomial"},
				{ label: qsTr("Gaussian"),				value: "gaussian"},
				{ label: qsTr("Gamma"),					value: "gamma"},
				{ label: qsTr("Inverse Gaussian"),		value: "inverseGaussian"},
				{ label: qsTr("Poisson"),				value: "poisson"}
			]

			property var familyMap:
			{
				"bernoulli":			["logit", "probit", "cauchit", "cloglog", "log"],
				"binomial":				["logit", "probit", "cauchit", "cloglog", "log"],
				"gaussian":				["identity", "log", "inverse"],
				"gamma":				["identity", "log", "inverse"],
				"inverseGaussian":		["identity", "log", "inverse"],
				"poisson":				["identity", "log", "sqrt"]
			}

			property var familyDefault:
			{
				"bernoulli":		"logit",
				"binomial":			"logit",
				"gaussian":			"identity",
				"gamma":			"log",
				"inverseGaussian":	"log",
				"poisson":			"log"
			}

			onCurrentValueChanged:
			{
				if (!familyMap[currentValue].includes(link.value))
				{
					for (var i = 0; i < link.buttons.length; i++)
						if (familyMap[currentValue].includes(link.buttons[i].parent.value))
						{
							link.buttons[i].parent.click()
							break;
						}
				}
			}
		}

		RadioButtonGroup
		{
			id:						link
			name:					"link"
			title:					qsTr("Link"); info: qsTr("Link function that will be used to model the mean parameter of the selected distribution function.")
			radioButtonsOnSameRow:	true
			
			RadioButton
			{
				label:		qsTr("Logit")
				value:		"logit"
				visible:	family.familyMap[family.currentValue].includes(value)
				checked:	family.familyDefault[family.currentValue] == "logit"
			}
			
			RadioButton
			{
				label:		qsTr("Probit")
				value:		"probit"
				visible:	family.familyMap[family.currentValue].includes(value)
				checked:	family.familyDefault[family.currentValue] == "probit"
			}

			RadioButton
			{
				label:		qsTr("Cauchit")
				value:		"cauchit"
				visible:	family.familyMap[family.currentValue].includes(value)
				checked:	family.familyDefault[family.currentValue] == "cauchit"
			}

			RadioButton
			{
				label:		qsTr("Complementary LogLog")
				value:		"cloglog"
				visible:	family.familyMap[family.currentValue].includes(value)
				checked:	family.familyDefault[family.currentValue] == "cloglog"
			}

			RadioButton
			{
				label:		qsTr("Identity")
				value:		"identity"
				visible:	family.familyMap[family.currentValue].includes(value)
				checked:	family.familyDefault[family.currentValue] == "identity"
			}

			RadioButton
			{
				label:		qsTr("Log")
				value:		"log"
				visible:	family.familyMap[family.currentValue].includes(value)
				checked:	family.familyDefault[family.currentValue] == "log"
			}

			RadioButton
			{
				label:		qsTr("Sqrt")
				value:		"sqrt"
				visible:	family.familyMap[family.currentValue].includes(value)
				checked:	family.familyDefault[family.currentValue] == "sqrt"
			}

			RadioButton
			{
				label:		qsTr("Inverse")
				value:		"inverse"
				visible:	family.familyMap[family.currentValue].includes(value)
				checked:	family.familyDefault[family.currentValue] == "inverse"
			}
		}
	}

	MM.MixedModelsModel {}

	MM.MixedModelsOptions { allMethodOptions: false }

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
			label:	qsTr("Confidence interval"); info: qsTr("Width of the confidence interval. Set at 95% by default, which can be changed by the user.")
		}

		DoubleField
		{
			id:				marginalMeansSD
			name:			"marginalMeansSd"
			label:			qsTr("SD factor covariates"); info: qsTr("Specifies the 'levels' of continuous variables (expressed in standard deviations) over which the estimated marginal means are computed.")
			defaultValue: 	1
			min:			0
			enabled:		marginalMeans.columnsTypes.includes("scale")
		}

		Group
		{
			columns: 2

			CheckBox
			{
				name:	"marginalMeansComparison"
				id:		marginalMeansCompare
				label:	qsTr("Compare marginal means to:"); info: qsTr("Value to which the estimated marginal means will be compared.")
			}

			DoubleField
			{
				enabled:	marginalMeansCompare.checked
				name:		"marginalMeansComparisonWith"
			}
		}
		
		CheckBox
		{
			name: "marginalMeansResponse"
			label: qsTr("Response scale"); info: qsTr("Whether the estimated marginal means should be computed on the response scale or untransformed linear scale. The response scale is selected by default.")
			checked: true
		}

		CheckBox
		{
			name:	"marginalMeansContrast"
			id:		marginalMeansContrast
			label:	qsTr("Specify contrasts"); info: qsTr("Creates a table for specifying contrasts based on the estimated marginal means. The first column contains row indices corresponding to the estimated marginal means output table. Columns with variable names show the levels of each variable for the respective marginal mean. Columns labeled ‘Contrast x’ are used to define contrasts. To specify a contrast between two marginal means, enter -1 and 1 in the corresponding rows. Interactions can be tested by defining differences in marginal means of one variable across levels of another.")
		}

		DropDown
		{
			name:	"marginalMeansPAdjustment"
			label:	qsTr("P-value adjustment"); info: qsTr("To correct for multiple comparison testing and avoid Type I errors, different methods for correcting the p-value are available.")
			values:
			[
				{ label: "Holm", info: qsTr("This method is also called sequential Bonferroni, and is considered less conservative than the Bonferroni method.")	,				value: "holm"},
				{ label: qsTr("Multivariate-t"), info: qsTr("Correction that takes into account that test results might be correlated. Best suited for multivariate models.")	,value: "mvt"},
				{ label: "Scheffé",	info: qsTr("Adjusting significance levels in a linear regression, to account for multiple comparisons. This method is considered to be quite conservative.")	,			value: "scheffe"},
				{ label: "Tukey", info: qsTr("Compare all possible pairs of group means. This correction can be used when the groups of the independent variable have an equal sample size and variance.")	,				value: "tukey"},
				{ label: qsTr("None"), info: qsTr("No adjustment is conducted.") ,				value: "none"},
				{ label: "Bonferroni", info: qsTr("This correction is considered conservative. The risk of Type I error is reduced, however, the statistical power decreases as well.")	,			value: "bonferroni"},
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
				title:	qsTr("Continuous variables"); info: qsTr("Continuous fixed effects variables that can be used for estimating the conditional slopes.")
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
			label:			qsTr("SD factor covariates"); info: qsTr("Specifies the 'levels' of continuous variables (expressed in standard deviations) over which the conditional slopes are computed.")
			defaultValue:	1
			min:			0
			enabled:		trendsVariables.columnsTypes.includes("scale")
		}

		Group
		{
			columns: 2

			CheckBox
			{
				name:	"trendsComparison"
				id:		trendsCompare
				label:	qsTr("Compare trends to:"); info: qsTr("Value to which the estimated conditional slopes will be compared.")
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
			label:	qsTr("Specify contrasts"); info: qsTr("Creates a table for specifying contrasts based on the estimated conditional slopes. The first column contains row indices corresponding to the estimated conditional slopes output table. Columns with variable names show the levels of each variable for the respective conditional slope. Columns labeled ‘Contrast x’ are used to define contrasts. To specify a contrast between two conditional slopes, enter -1 and 1 in the corresponding rows. Interactions can be tested by defining differences in conditional slopes of one variable across levels of another.")
		}

		DropDown
		{
			name:	"trendsPAdjustment"
			label:	qsTr("P-value adjustment"); info: qsTr("To correct for multiple comparison testing and avoid Type I errors, different methods for correcting the p-value are available.")
			values:
			[
				{ label: "Holm", info: qsTr("This method is also called sequential Bonferroni, and is considered less conservative than the Bonferroni method.")	,				value: "holm"},
				{ label: qsTr("Multivariate-t"), info: qsTr("Correction that takes into account that test results might be correlated. Best suited for multivariate models.")	,value: "mvt"},
				{ label: "Scheffé",	info: qsTr("Adjusting significance levels in a linear regression, to account for multiple comparisons. This method is considered to be quite conservative.")	,			value: "scheffe"},
				{ label: "Tukey", info: qsTr("Compare all possible pairs of group means. This correction can be used when the groups of the independent variable have an equal sample size and variance.")	,				value: "tukey"},
				{ label: qsTr("None"), info: qsTr("No adjustment is conducted.") ,				value: "none"},
				{ label: "Bonferroni", info: qsTr("This correction is considered conservative. The risk of Type I error is reduced, however, the statistical power decreases as well.")	,			value: "bonferroni"},
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
