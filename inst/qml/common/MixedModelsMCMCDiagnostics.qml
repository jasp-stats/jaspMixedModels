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
	title:		qsTr("MCMC diagnostics")

	VariablesForm
	{
		preferredHeight: 200 * preferencesModel.uiScale

		AvailableVariablesList
		{
			name:	"mcmcDiagnosticsAvailableTerms"
			title:	qsTr("Model terms"); info: qsTr("Fixed effects model terms whose MCMC chains can be diagnosed.")
			source:	"fixedEffects"
		}

		AssignedVariablesList
		{
			singleVariable:	true
			name:			"mcmcDiagnosticsHorizontal"
			title:			mcmcDiagnosticsType.currentValue == "scatterplot" ? qsTr("Horizontal axis") : qsTr("Plotted term"); info: qsTr("Fixed effects model term whose chain will be diagnosed.")
		}

		AssignedVariablesList
		{
			singleVariable:	true
			name:			"mcmcDiagnosticsVertical"
			title:			qsTr("Vertical axis"); info: qsTr("Fixed effects model term whose chain will be diagnosed. Only available if the Plot type is Scatterplot.")
			visible:		active
			
			property bool active:	mcmcDiagnosticsType.currentValue == "scatterplot"
			onActiveChanged:		if (!active && count > 0) itemDoubleClicked(0)
		}
	}

	DropDown
	{
		name:	"mcmcDiagnosticsType"
		id:		mcmcDiagnosticsType
		label:	qsTr("Plot type"); info: qsTr("Different types of MCMC diagnostic plots. The plotted values correspond to the fixed effect terms displayed in the default output. Those are the deviations from the estimated grand mean by default, but can be changed to estimated marginal means in the Options section.")
		values:
		[
			{ label: qsTr("Traceplot"),	info: qsTr("Traceplot of the individual chains.")	,	value: "traceplot"},
			{ label: qsTr("Scatterplot"), info: qsTr("Scatterplot of two model terms.")	,	value: "scatterplot"},
			{ label: qsTr("Histogram"),	info: qsTr("Histogram of the posterior samples.")	,	value: "histogram"},
			{ label: qsTr("Density"),	info: qsTr("Overlaid density plots of samples from each chain.")	,	value: "density"},
			{ label: qsTr("Autocorrelations"), info: qsTr("Average autocorrelation plots across all chains.")	,value: "autocorrelation"}
		]
	}
}

