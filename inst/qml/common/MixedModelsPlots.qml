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

Section
{
	title:		qsTr("Plots")
	expanded:	false

	property string analysisType:		"frequentist"

	VariablesForm
	{
		preferredHeight:	250 * preferencesModel.uiScale

		AvailableVariablesList
		{
			name:	"availableModelComponentsPlot"
			title:	qsTr("Model factors"); info: qsTr("Categorical or ordinal fixed effects variables that can be used for visualization.")
			source:	[ { name: "fixedEffects", use: "type=ordinal|nominal"} ]
		}

		AssignedVariablesList
		{
			name:	"plotHorizontalAxis"
			title:	qsTr("Horizontal axis"); info: qsTr("Variables that will be plotted on the horizontal axis.")
		}

		AssignedVariablesList
		{
			name:	"plotSeparateLines"
			id:		plotsTrace
			title:	qsTr("Separate lines"); info: qsTr("Variables that will be plotted inside the plot as different traces/lines.")
		}

		AssignedVariablesList
		{
			name:	"plotSeparatePlots"
			title:	qsTr("Separate plots"); info: qsTr("Variables which levels will be split across different plots.")
		}
	}

	VariablesForm
	{
		preferredHeight:	100 * preferencesModel.uiScale

		AvailableVariablesList
		{
			name:	"plotRandomVariables"
			title:	qsTr("Random effects grouping factors"); info: qsTr("Random effect grouping factors that can be used for data aggregation of data shown in the background.")
			source:	"randomVariables"
		}

		AssignedVariablesList
		{
			name:	"plotBackgroundData"
			title:	qsTr("Background data show"); info: qsTr("The level of aggregation for the response variable. I.e., if participants are selected, the individual data points in the background are their averages across the combinations of levels of fixed effect factors selected in the Horizontal axis, Separate lines, and Separate plots.")
			addAvailableVariablesToAssigned: true
		}
	}

	Group
	{
		DropDown
		{
			name:	"plotCiType"
			id:		plotsCImethod
			label:	qsTr("Confidence interval method"); info: qsTr("Type of standard error on which the error bars will be based. Default is 'model', which plots model-based standard errors. The options are:")
			values: if (analysisType == "frequentist"){
				[
					{ label: qsTr("Model"),      	value: "model"},
					{ label: qsTr("None"), 			value: "none"},
					{ label: qsTr("Mean"),			value: "mean"},
					{ label: qsTr("Within"),		value: "within"},
					{ label: qsTr("Between"),		value: "between"}
				]
			} else if (analysisType == "Bayesian"){
				[
					{ label: qsTr("Model"),			value: "model"},
					{ label: qsTr("None"),			value: "none"},
					{ label: qsTr("Mean"),			value: "mean"}
				]
			}
			
		}

		CIField
		{
			enabled:	plotsCImethod.currentValue != "none"
			name:		"plotCiLevel"
			label:		qsTr("Confidence interval"); info: qsTr("Width of the confidence interval. Set at 95% by default which can be changed by the user.")
		}
	}

	Group
	{
		title:		qsTr("Distinguish factor levels"); info: qsTr("How the factor levels should be distinguished. This can be by color, shape, linetype, or fill.")
		columns:	4

		CheckBox
		{
			name:		"plotLevelsByColor"
			label:		qsTr("Color")
			checked:	false
		}

		CheckBox
		{
			name:		"plotLevelsByShape"
			label:		qsTr("Shape")
			checked:	true
		}

		CheckBox
		{
			name:		"plotLevelsByLinetype"
			label:		qsTr("Linetype")
			checked:	true
		}

		CheckBox
		{
			name:		"plotLevelsByFill"
			label:		qsTr("Fill")
			checked:	false
			enabled:	plotsGeom.currentValue != "jitter"
			onEnabledChanged:  checked = false
		}
	}

	Group
	{
		columns:	1

		DropDown
		{
			name:	"plotBackgroundElement"
			label:	qsTr("Background element"); info: qsTr("Type of background element to be used on the plots:")
			id:		plotsGeom
			values:
			[
				{ label: qsTr("Jitter"),			value: "jitter"},
			//	{ label: qsTr("Beeswarm"),			value: "beeswarm"}, # enable once the package loading is changed
				{ label: qsTr("Violin"),			value: "violin"},
				{ label: qsTr("Boxplot"),			value: "boxplot"},
				{ label: qsTr("Boxjitter"),			value: "boxjitter"},
				{ label: qsTr("Count"),				value: "count"}
			]
		}

		DoubleField
		{
			name:			"plotTransparency"
			label:			qsTr("Transparency"); info: qsTr("Transparency of the geom.")
			defaultValue:	.7
			min:			0
			max: 			1
			inclusive:		JASP.None
		}

		DoubleField
		{
			visible:		plotsGeom.currentValue == "jitter" || plotsGeom.currentValue == "boxjitter"
			name:			"plotJitterWidth"
			label:			qsTr("Jitter width"); info: qsTr("Width of the jitter.")
			defaultValue:	0.1
			min:			0
		}

		DoubleField
		{
			visible:		plotsGeom.currentValue == "jitter" | plotsGeom.currentValue == "boxjitter"
			name:			"plotJitterHeight"
			label:			qsTr("Jitter height"); info: qsTr("Height of the jitter.")
			defaultValue:	0
			min:			0
		}

		DoubleField
		{
			visible:		plotsGeom.currentValue == "violin" | plotsGeom.currentValue == "boxplot" | plotsGeom.currentValue == "boxjitter"
			name:			"plotElementWidth"
			label:			qsTr("Element width"); info: qsTr("Width of the element.")
			defaultValue:	1
			min:			0
			inclusive:		JASP.None
		}

		DoubleField
		{
			visible:		plotsTrace.count != 0
			name:			"plotDodge"
			label:			qsTr("Dodge"); info: qsTr("Spacing between the geoms.")
			defaultValue:	0.3
			min:			0
		}
	}

	Group
	{
		columns:	1

		DropDown
		{
			name:	"plotTheme"
			id:		plotsTheme
			label:	qsTr("Theme"); info: qsTr("Color palette to be used on the plot display:")
			values:
			[
				{ label: "JASP",					value: "jasp"},
				{ label: qsTr("White background"),	value: "whiteBackground"},
				{ label: qsTr("Light"),				value: "light"},
				{ label: qsTr("Minimal")	,		value: "minimal"},
				{ label: "APA",						value: "apa"},
				{ label: "pubr",					value: "pubr"}
			]
		}

		DropDown
		{
			name:	"plotLegendPosition"
			label:	qsTr("Legend position"); info: qsTr("Whether and where should the legend be plotted:")
			values:
			[
				{ label: qsTr("None"),			value: "none"},
				{ label: qsTr("Bottom"),		value: "bottom"},
				{ label: qsTr("Right"),			value: "right"},
				{ label: qsTr("Top"),			value: "top"},
				{ label: qsTr("Left"), 			value: "left"}
			]
		}

		DropDown
		{
			name:	"plotBackgroundColor"
			label:	qsTr("Border color"); info: qsTr("Color of the aggregated response variable:")
			enabled:plotsGeom.currentValue != "jitter"
			values:
			[
				{ label: qsTr("Dark grey"),			value: "darkgrey"},
				{ label: qsTr("None"),				value: "none"},
				{ label: qsTr("Black"),				value: "black"},
				{ label: qsTr("Light grey"),		value: "lightgrey"},
				{ label: qsTr("Blue"),				value: "blue"},
				{ label: qsTr("Red"),				value: "red"},
				{ label: qsTr("Violet"),			value: "violet"}
			]
		}

		DoubleField
		{
			enabled:		plotsTheme.currentValue != "jasp"
			name:			"plotRelativeSizeText"
			label:			qsTr("Relative size text"); info: qsTr("Relative size of the plotted text.")
			defaultValue:	1.5
			min:			0
			inclusive:		JASP.None
		}

		DoubleField
		{
			name:			"plotRelativeSizeData"
			label:			qsTr("Relative size foreground data"); info: qsTr("Relative size of the foreground data (confidence interval bars, etc...).")
			defaultValue:	1
			min:			0
			inclusive:		JASP.None
		}

		CheckBox
		{
			name:	"plotEstimatesTable"
			label:	qsTr("Estimates table"); info: qsTr("Display numerical summary of the plotted objects.")
		}
	}
}
