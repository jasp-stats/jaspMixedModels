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
			title:	qsTr("Model terms")
			source:	"fixedEffects"
		}

		AssignedVariablesList
		{
			singleVariable:	true
			name:			"mcmcDiagnosticsHorizontal"
			title:			mcmcDiagnosticsType.currentValue == "scatterplot" ? qsTr("Horizontal axis") : qsTr("Plotted term")
		}

		AssignedVariablesList
		{
			singleVariable:	true
			name:			"mcmcDiagnosticsVertical"
			title:			qsTr("Vertical axis")
			visible:		active
			
			property bool active:	mcmcDiagnosticsType.currentValue == "scatterplot"
			onActiveChanged:		if (!active && count > 0) itemDoubleClicked(0)
		}
	}

	DropDown
	{
		name:	"mcmcDiagnosticsType"
		id:		mcmcDiagnosticsType
		label:	qsTr("Plot type")
		values:
		[
			{ label: qsTr("Traceplot"),			value: "traceplot"},
			{ label: qsTr("Scatterplot"),		value: "scatterplot"},
			{ label: qsTr("Histogram"),			value: "histogram"},
			{ label: qsTr("Density"),			value: "density"},
			{ label: qsTr("Autocorrelations"),	value: "autocorrelation"}
		]
	}
}

