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
	id: form

	Formula
	{
		lhs: "dependentVariable"
		rhs: ["fixedEffects", {randomEffects: "randomEffects"}]
	}

	VariablesForm
	{
		preferredHeight: 350

		AvailableVariablesList
		{
			name:				"allVariablesList"
		}

		AssignedVariablesList
		{
			name:				"dependentVariable"
			title:				qsTr("Dependent variable")
			allowedColumns:		["scale"]
			singleVariable:		true
		}

		AssignedVariablesList
		{
			name:				"fixedVariables"
			title:				qsTr("Fixed effects variables")
			allowedColumns:		["ordinal", "nominal","scale","nominalText"]
			itemType:			"fixedFactors"
		}
		
		AssignedVariablesList
		{
			name:				"randomVariables"
			title:				qsTr("Random effects grouping factors")
			allowedColumns:		["ordinal", "nominal","nominalText"]
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
			preferredHeight:	250

			AvailableVariablesList
			{
				name:	"availableModelComponentsMeans"
				title:	qsTr("Model variables")
				source: [{ name: "fixedEffects", use: "noInteraction" }]
			}

			AssignedVariablesList
			{
				id:		marginalMeans
				name:	"marginalMeans"
				title:	qsTr("Selected variables")
			}
		}

		CIField
		{
			name:	"marginalMeansCIwidth"
			label:	qsTr("Confidence interval")
		}

		DoubleField
		{
			id:				marginalMeansSD
			name:			"marginalMeansSD"
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
				label:	qsTr("Estimate df")
				values:
				[
					{ label: qsTr("Asymptotic"),		value: "asymptotic"},
					{ label: "Satterthwaite",			value: "satterthwaite"},
					{ label: "Kenward-Roger",			value: "kenward-roger"}
				]
			}

			CheckBox
			{
				enabled:	marginalMeansDf.currentValue == "satterthwaite" | marginalMeansDf.currentValue == "kenward-roger"
				name:		"marginalMeansOverride"
				label:		qsTr("Force df estimation")
			}

		}

		Group
		{
			columns: 2

			CheckBox
			{
				name:	"marginalMeansCompare"
				id:		marginalMeansCompare
				label:	qsTr("Compare marginal means to:")
			}

			DoubleField
			{
				enabled:	marginalMeansCompare.checked
				name:		"marginalMeansCompareTo"
			}
		}
		
		CheckBox
		{
			name:	"marginalMeansContrast"
			id:		marginalMeansContrast
			label:	qsTr("Specify contrasts")
		}

		DropDown
		{
			name:	"marginalMeansAdjustment"
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
			name:				"Contrasts"
			source:				"marginalMeans"
			scaleFactor:		marginalMeansSD.value
		}
	}

	Section
	{
		title:		qsTr("Estimated trends/conditional slopes")
		expanded:	false

		VariablesForm
		{
			preferredHeight: 100

			AvailableVariablesList
			{
				name:	"availableModelComponentsTrends1"
				title:	qsTr("Continous variables")
				source: [ { name: "fixedEffects", use: "type=scale"} ]
			}

			AssignedVariablesList
			{
				singleVariable:	true
				name:			"trendsTrend"
				title:			qsTr("Trend variable")
			}
		}

		VariablesForm
		{
			preferredHeight: 250

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
			name:	"trendsCIwidth"
			label:	qsTr("Confidence interval")
		}

		DoubleField
		{ 
			id:				trendsSD
			name:			"trendsSD"
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
				label:	qsTr("Estimate df")
				values:
				[
					{ label: qsTr("Asymptotic"),		value: "asymptotic"},
					{ label: "Satterthwaite",			value: "satterthwaite"},
					{ label: "Kenward-Roger",			value: "kenward-roger"}
				]
			}

			CheckBox
			{
				enabled:	trendsDf.currentValue == "satterthwaite" | trendsDf.currentValue == "kenward-roger"
				name:		"trendsOverride"
				label:		qsTr("Force df estimation")
			}
		}

		Group
		{
			columns: 2

			CheckBox
			{
				name:	"trendsCompare"
				id:		trendsCompare
				label:	qsTr("Compare trends to:")
			}

			DoubleField
			{
				enabled:	trendsCompare.checked
				name:		"trendsCompareTo"
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
			name:	"trendsAdjustment"
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

}
