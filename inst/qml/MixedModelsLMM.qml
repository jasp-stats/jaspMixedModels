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
			title:				qsTr("Dependent variable")
			allowedColumns:		["scale"]
			singleVariable:		true
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
			DropDown
			{
				name:	"marginalMeansDf"
				id:		marginalMeansDf
				label:	qsTr("Estimate df")
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
				label:		qsTr("Force df estimation")
			}

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
			DropDown
			{
				name:	"trendsDf"
				id:		trendsDf
				label:	qsTr("Estimate df")
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
				label:		qsTr("Force df estimation")
			}
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
