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
			title:				qsTr("Dependent variable")
			allowedColumns:		["nominal", "scale"]
			allowTypeChange:	true
			singleVariable:		true
		}

		AssignedVariablesList
		{
			visible:			active
			name:				"dependentAggregation"
			title:				qsTr("Number of trials")
			singleVariable:		true
			allowedColumns:		["scale"]

			onEnabledChanged: if (!enabled && count > 0) itemDoubleClicked(0)
			
			property bool active:	family.currentValue == "binomial"
			onActiveChanged:		if (!active && count > 0) itemDoubleClicked(0)
		}

		AssignedVariablesList
		{
			name:				"fixedVariables"
			title:				qsTr("Fixed effects variables")
			allowedColumns:		["nominal", "scale"]
			allowTypeChange:	true
		}
		
		AssignedVariablesList
		{
			name:				"randomVariables"
			title:				qsTr("Random effects grouping factors")
			allowedColumns:		["nominal"]
		}
	}

	Group
	{

		DropDown
		{
			name:				"family"
			label:				qsTr("Family")
			id:					family
			indexDefaultValue:	0
			values:
			[
				{ label: qsTr("Binomial"),				value: "bernoulli"},
				{ label: qsTr("Binomial (aggregated)"),	value: "binomial"},
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
			title:					qsTr("Link")
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
				title:	qsTr("Model variables")
				source: [{ name: "fixedEffects", use: "noInteraction" }]
			}

			AssignedVariablesList
			{
				id:		marginalMeans
				name:	"marginalMeansTerms"
				title:	qsTr("Selected variables")
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
			columns: 2

			CheckBox
			{
				name:	"marginalMeansComparison"
				id:		marginalMeansCompare
				label:	qsTr("Compare marginal means to:")
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
			label: qsTr("Response scale")
			checked: true
		}

		CheckBox
		{
			name:	"marginalMeansContrast"
			id:		marginalMeansContrast
			label:	qsTr("Specify contrasts")
		}

		DropDown
		{
			name:	"marginalMeansPAdjustment"
			label:	qsTr("P-value adjustment")
			values:
			[
				{ label: "Holm",					value: "holm"},
				{ label: qsTr("Multivariate-t"),	value: "mvt"},
				{ label: "Scheffé",					value: "scheffe"},
				{ label: "Tukey",					value: "tukey"},
				{ label: qsTr("None"),				value: "none"},
				{ label: "Bonferroni",				value: "bonferroni"},
				{ label: "Hommel",					value: "hommel"}
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
				title:	qsTr("Continous variables")
				source: [ { name: "fixedEffects", use: "type=scale"} ]
			}

			AssignedVariablesList
			{
				singleVariable:	true
				name:			"trendsTrendVariable"
				title:			qsTr("Trend variable")
			}
		}

		VariablesForm
		{
			preferredHeight: 250 * jaspTheme.uiScale

			AvailableVariablesList
			{
				name:	"availableModelComponentsTrends2"
				title:	qsTr("Model variables")
				source:	[{ name: "fixedEffects", use: "noInteraction" }]
			}

			AssignedVariablesList
			{
				id:		trendsVariables
				name:	"trendsVariables"
				title:	qsTr("Selected variables")
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
			columns: 2

			CheckBox
			{
				name:	"trendsComparison"
				id:		trendsCompare
				label:	qsTr("Compare trends to:")
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
			label:	qsTr("Specify contrasts")
		}

		DropDown
		{
			name:	"trendsPAdjustment"
			label:	qsTr("P-value adjustment")
			values:
			[
				{ label: "Holm",					value: "holm"},
				{ label: qsTr("Multivariate-t"),	value: "mvt"},
				{ label: "Scheffé",					value: "scheffe"},
				{ label: "Tukey",					value: "tukey"},
				{ label: qsTr("None"),				value: "none"},
				{ label: "Bonferroni",				value: "bonferroni"},
				{ label: "Hommel",					value: "hommel"}
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

	MM.Advanced {}

}
