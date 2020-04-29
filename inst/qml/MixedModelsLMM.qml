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
import QtQuick			2.12
import JASP.Controls	1.0
import JASP.Widgets		1.0
import JASP				1.0
import QtQuick.Layouts  1.3

Form {
	id: form

	VariablesForm
	{
		preferredHeight: 350
		AvailableVariablesList		{ name: "allVariablesList" }
		AssignedVariablesList
		{
			name:				"dependentVariable"
			title:				qsTr("Dependent variable")
			suggestedColumns:	["scale"]
			singleVariable:     true
		}
		AssignedVariablesList
		{
			name:				"fixedVariables"
			title:				qsTr("Fixed effects variables")
			suggestedColumns:	["ordinal", "nominal","scale"]
		}
		AssignedVariablesList
		{
			name:				"randomVariables"
			title:				qsTr("Random effects grouping factors")
			suggestedColumns:	["ordinal", "nominal"]
		}
	}

	// for testing
	CheckBox{
		name: "run"
		label: "Run"
	}

	Section
	{
		title: qsTr("Model")
		expanded: false

		VariablesForm
		{
			preferredHeight: 250
			AvailableVariablesList
			{
				name: "availableModelComponents"
				title: qsTr("Model components")
				source: "fixedVariables"
			}

			AssignedVariablesList
			{
				id			: fixedEffects
				name		: "fixedEffects"
				title		: qsTr("Fixed effects")
				listViewType: JASP.Interaction
			}
		}

		ComponentsList
		{
			id:					randomEffetcs
			title:				qsTr("Random effects")
			name:				"randomEffects"
			source:				"randomVariables"
			cellHeight:			fixedEffects.count * 30 * preferencesModel.uiScale + 40 * preferencesModel.uiScale
			preferredHeight: 	count * cellHeight + 25 * preferencesModel.uiScale

			rowComponents:
			[
				Component
				{
					Group
					{
						RowLayout
						{
							Layout.preferredWidth: randomEffetcs.width
							Label { text: qsTr("Random slopes by %1").arg(rowValue); Layout.preferredWidth: parent.width / 2 }
							CheckBox { label: qsTr("Correlations"); name: "correlations"; checked: true; Layout.preferredWidth: parent.width / 2 }
						}
						ComponentsList
						{
							name:   "randomComponents"
							source: "fixedEffects"
							cellHeight: 30 * preferencesModel.uiScale
							preferredHeight: count * cellHeight + 10 * preferencesModel.uiScale
							preferredWidth: randomEffetcs.width - 8 * preferencesModel.uiScale

							rowComponents:
							[
								Component { CheckBox { name: "randomSlopes"; label: rowValue; checked: true } }
							]
						}						
					}
				}
			]
		}
		

	}

	Section
	{
		title: qsTr("Options")
		expanded: false
	
		RadioButtonGroup
		{
			columns: 2
  			name: "type"
  			title: qsTr("Type")
			radioButtonsOnSameRow: true
  			RadioButton { value: "2"; label: qsTr("II") }
  			RadioButton { value: "3"; label: qsTr("III"); checked: true }
		}

		CheckBox
		{
			enabled: method.currentText == "parametric bootstrap" | method.currentText == "likelihood ratio tests"
			name: "test_intercept"
			label: qsTr("Test intercept")
		}

		Group
		{
			DropDown
			{
				name:	"method"
				label:	qsTr("Test model terms")
				id:		method
				values:
				[
					{ label: "Satterthwaite",			value: "S"},
    				{ label: "Kenward-Roger",			value: "KR"},
					{ label: "likelihood ratio tests",	value: "LRT"},
    				{ label: "parametric bootstrap",	value: "PB"}
  				]
			}

			IntegerField
			{
				enabled: method.currentText == "parametric bootstrap"
 				name: "bootstrap_samples"
				label: qsTr("No. samples")
				defaultValue: 10
				fieldWidth: 60
			}
		}

		Group
		{
			CheckBox
			{
				name: "showFE"
				label: qsTr("Fixed effects estimates")
			}

			CheckBox
			{
				name: "showRE"
				label: qsTr("Variance/correlation estimates")
			}
		}

		SetSeed{}
		
		CheckBox
		{
			name: "pvalVS"
			label: qsTr("Vovk-Sellke maximum p-ratio")
		}

	}

	Section
	{
		title: qsTr("Plots")
		expanded: false

		VariablesForm
		{
			preferredHeight: 250
			AvailableVariablesList
			{
				name: "availableModelComponentsPlot"	// TODO: filter only factors from the data
				title: qsTr("Model factors")
				source: "fixedVariables" 				// TODO: don't use the variables itself but assigned model terms (and ignore interactions)
			}

			AssignedVariablesList
			{
				name: "plotsX"
				title: qsTr("Horizontal Axis")
			}

			AssignedVariablesList
			{
				name: "plotsTrace"
				id:	  plotsTrace
				title: qsTr("Separate Lines")
			}

			AssignedVariablesList
			{
				name: "plotsPanel"
				title: qsTr("Separate Plots")
			}
		}

		VariablesForm
		{
			preferredHeight: 100
			AvailableVariablesList
			{
				name: "plotsRandom" 
				title: qsTr("Random effects grouping factors")
				source: "randomVariables"
			}

			AssignedVariablesList // TODO: make assigned by default and link to id
			{
				name: "plotsAgregatedOver"
				title: qsTr("Background data show")
			}
		}

		Group
		{
			DropDown
			{
				name:	"plotsCImethod"
				id:		plotsCImethod
				label:	qsTr("Confidence interval method")
				values:
				[
					{ label: "Model",			value: "model"},
    				{ label: "None",			value: "none"},
    				{ label: "Mean",			value: "mean"},
					{ label: "Within",			value: "within"},
					{ label: "Between",			value: "between"}
  				]
			}

			CIField
			{
				enabled: plotsCImethod.currentText != "None"
				name: "plotsCIwidth"
				label: "Confidence interval"
			}
		}

		Group
		{
			title: qsTr("Distinguish factor levels")
			columns: 4
			CheckBox
			{
				name: "plotsMappingColor"
				label: qsTr("Color")
			}
			CheckBox
			{
				name: "plotsMappingShape"
				label: qsTr("Shape")
				checked: true
			}
			CheckBox
			{
				name: "plotsMappingLineType"
				label: qsTr("Linetype")
				checked: true
			}
			CheckBox
			{
				name: "plotsMappingFill"
				label: qsTr("Fill")
			}
		}

		Group
		{
			columns: 1
			DropDown
			{
				name:	"plotsGeom"
				label:	qsTr("Background geom")
				id:		plotsGeom
				values:
				[
					{ label: "Jitter",				value: "geom_jitter"},
					{ label: "Beeswarm",			value: "geom_beeswarm"},
					{ label: "Violin",				value: "geom_violin"},
					{ label: "Boxplot",				value: "geom_boxplot"},
					{ label: "Boxjitter",			value: "geom_boxjitter"},
					{ label: "Count",				value: "geom_count"}
				]
			}

//			Group
//			{

				DoubleField
				{
					name: "plotAlpha"
					label: qsTr("Transparency")
					defaultValue: .7
					min: 0
					max: 1
					inclusive: JASP.None
				}

				DoubleField
				{
					visible: plotsGeom.currentText == "Jitter" | plotsGeom.currentText == "Boxjitter"
					name: "plotJitterWidth"
					label: qsTr("Jitter width")
					defaultValue: 0
					min: 0
				}

				DoubleField
				{
					visible: plotsGeom.currentText == "Jitter" | plotsGeom.currentText == "Boxjitter"
					name: "plotJitterHeight"
					label: qsTr("Jitter height")
					defaultValue: 0
					min: 0
				}

				DoubleField
				{
					visible: plotsGeom.currentText == "Violin" | plotsGeom.currentText == "Boxplot" | plotsGeom.currentText == "Boxjitter"
					name: "plotGeomWidth"
					label: qsTr("Geom width")
					defaultValue: 1
					min: 0
				}

				DoubleField
				{
					visible: plotsTrace.lenght != 0 // TODO: make this work
					name: "plotDodge"
					label: qsTr("Dodge")
					defaultValue: 0.3
					min: 0
				}
			//}
		}
		Group
		{
			columns: 1
			DropDown
			{
				name:	"plotsTheme"
				id:     plotsTheme
				label:	qsTr("Theme")
				values:
				[
					{ label: "JASP",			value: "JASP"},
					{ label: "Black White",		value: "theme_bw"},
    				{ label: "Light",			value: "theme_light"},
					{ label: "Minimal",			value: "theme_minimal"},
					{ label: "APA", 			value: "jtools::theme_apa"},
					{ label: "pubr",			value: "ggpubr::theme_pubr"}
  				]
			}

			DoubleField
			{
				enabled: plotsTheme.currentText != "JASP"
				name: "plotRelativeSizeText"
				label: qsTr("Relative size text")
				defaultValue: 1.5
				min: 0
			}

			DropDown
			{
				name:	"plotLegendPosition"
				label:	qsTr("Legend position")
				values:
				[
					{ label: "None",			value: "none"},
					{ label: "Bottom",			value: "bottom"},
    				{ label: "Right",			value: "right"},
					{ label: "Top",				value: "top"},
					{ label: "Left", 			value: "left"}
  				]
			}


			DropDown
			{
				name:	"plotsBackgroundColor"
				label:	qsTr("Color background data")
				values:
				[
					{ label: "Dark grey",			value: "darkgrey"},
					{ label: "None",				value: "none"},
					{ label: "Black",				value: "black"},
					{ label: "Light grey",			value: "lightgrey"},
   		 			{ label: "Blue",				value: "blue"},
					{ label: "Red",					value: "red"},
					{ label: "Violet",				value: "violet"}
  				]
			}

			DoubleField
			{
				name: "plotRelativeSize"
				label: qsTr("Relative size foreground data")
				defaultValue: 1
				min: 0
			}

			CheckBox
			{
				name: "plotsEstimatesTable"
				label: qsTr("Estimates table")
			}
		}
	}

	Section
	{
		title: qsTr("Estimated marginal means")
		expanded: false

		VariablesForm
		{
			preferredHeight: 250
			AvailableVariablesList
			{
				name: "availableModelComponentsMeans"
				title: qsTr("Model variables")
				source: "fixedEffects"
			}

			AssignedVariablesList
			{
				name: "marginalMeans"
				title: qsTr("Selected variables")
			}
		}

		CIField
		{
			name: "marginalMeansCIwidth"
			label: "Confidence interval"
		}

		DoubleField
		{ // TODO: grayed out unless continous variable is selected
			id:	marginalMeansSD
			name: "marginalMeansSD"
			label: "SD factor covariates"
			defaultValue: 1
			min: 0
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
					{ label: "Asymptotic",				value: "asymptotic"},
					{ label: "Satterthwaite",			value: "satterthwaite"},
   	 				{ label: "Kenward-Roger",			value: "kenward-roger"}
  				]
			}

			CheckBox
			{
				enabled: marginalMeansDf.currentText == "Satterthwaite" | marginalMeansDf.currentText == "Kenward-Roger"
				name: "marginalMeansOverride"
				label: qsTr("Force df estimation")
			}

		}


		Group
		{
			columns: 2
			CheckBox
			{
				name: "marginalMeansCompare"
				id: marginalMeansCompare
				label: qsTr("Compare marginal means to:")
			}

			IntegerField
			{
				enabled: marginalMeansCompare.checked
				name: "marginalMeansCompareTo"
			}
		}
		

		CheckBox
		{
			name: "marginalMeansContrast"
			id: marginalMeansContrast
			label: qsTr("Specify contrasts")
		}


		DropDown
		{
			name:	"marginalMeansAdjustment"
			label:	qsTr("P-value adjustment")
			values:
			[
				{ label: "Holm",				value: "holm"},
				{ label: "Multivariate-t",		value: "mvt"},
				{ label: "Scheffe",				value: "scheffe"},
				{ label: "Tukey",				value: "tukey"},
				{ label: "None",				value: "none"},
				{ label: "Bonferroni",			value: "bonferroni"},
				{ label: "Hommel",				value: "hommel"}
			]
		}

		MarginalMeansContrastsTableView
		{
			Layout.columnSpan: 2
			visible: marginalMeansContrast.checked
			name: "Contrasts"
			source:	"marginalMeans"
			scaleFactor: marginalMeansSD.value
		}
	}

	Section
	{
		title: qsTr("Estimated trends/condtional slopes")
		expanded: false

		VariablesForm
		{
			preferredHeight: 100
			AvailableVariablesList
			{
				name: "availableModelComponentsTrends1"
				title: qsTr("Continous variables")
				source: "fixedEffects"
			}

			AssignedVariablesList
			{
				singleVariable: true
				name: "trendsTrend"
				title: qsTr("Trend variable")
			}
		}


		VariablesForm
		{
			preferredHeight: 250
			AvailableVariablesList
			{
				name: "availableModelComponentsTrends2"
				title: qsTr("Model variables")
				source: "fixedEffects"
			}

			AssignedVariablesList
			{
				name: "trendsVariables"
				title: qsTr("Selected variables")
			}
		}

		CIField
		{
			name: "trendsCIwidth"
			label: "Confidence interval"
		}

		DoubleField
		{ // TODO: grayed out unless continous variable is selected
			id:	trendsSD
			name: "trendsSD"
			label: "SD factor covariates"
			defaultValue: 1
			min: 0
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
					{ label: "Asymptotic",				value: "asymptotic"},
					{ label: "Satterthwaite",			value: "satterthwaite"},
   	 				{ label: "Kenward-Roger",			value: "kenward-roger"}
  				]
			}

			CheckBox
			{
				enabled: trendsDf.currentText == "Satterthwaite" | trendsDf.currentText == "Kenward-Roger"
				name: "trendsOverride"
				label: qsTr("Force df estimation")
			}

		}


		Group
		{
			columns: 2
			CheckBox
			{
				name: "trendsCompare"
				id: trendsCompare
				label: qsTr("Compare marginal means to:")
			}

			IntegerField
			{
				enabled: trendsCompare.checked
				name: "trendsCompareTo"
			}
		}
		

		CheckBox
		{
			name: "trendsContrast"
			id: trendsContrast
			label: qsTr("Specify contrasts")
		}


		DropDown
		{
			name:	"trendsAdjustment"
			label:	qsTr("P-value adjustment")
			values:
			[
				{ label: "Holm",				value: "holm"},
				{ label: "Multivariate-t",		value: "mvt"},
				{ label: "Scheffe",				value: "scheffe"},
				{ label: "Tukey",				value: "tukey"},
				{ label: "None",				value: "none"},
				{ label: "Bonferroni",			value: "bonferroni"},
				{ label: "Hommel",				value: "hommel"}
			]
		}

		MarginalMeansContrastsTableView
		{
			Layout.columnSpan: 2
			visible: trendsContrast.checked
			name: "trendsContrasts"
			source:	"trendsVariables"
			scaleFactor: trendsSD.value
		}
	}

}
