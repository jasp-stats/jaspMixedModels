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

Section
{
	title:			qsTr("Model")

	VariablesForm
	{
		preferredHeight: jaspTheme.smallDefaultVariablesFormHeight

		AvailableVariablesList
		{
			name:	"availableModelComponents"
			title:	qsTr("Model components")
			source:	"fixedVariables"
		}

		AssignedVariablesList
		{
			id:				fixedEffects
			name:			"fixedEffects"
			title:			qsTr("Fixed effects")
			listViewType:	JASP.Interaction
			allowTypeChange:false
		}

		CheckBox
		{
			label:		qsTr("Include intercept")
			name:		"includeIntercept"
			checked:	true
		}
	}

	ComponentsList
	{
		id:					randomEffects
		title:				qsTr("Random effects")
		name:				"randomEffects"
		source:				"randomVariables"
		visible:			count > 0
		property var alwaysAvailable:
		[
			{ label:	"Intercept",		value: "Intercept"}
		]

		rowComponent: Group
		{
			RowLayout
			{
				width:		randomComponentsList.width
				Label		{ text: qsTr("Random components (%1)").arg(rowValue);	width: parent.width / 2 }
				CheckBox	{ label: qsTr("Correlations"); name: "correlations"; checked: true; preferredWidth: parent.width / 2 }
			}

			VariablesList
			{
				id				: randomComponentsList
				name			: "randomComponents"
				source			: [{values: randomEffects.alwaysAvailable}, "fixedEffects"]
				listViewType	: JASP.AssignedVariables
				preferredHeight	: 120 * preferencesModel.uiScale
				preferredWidth	: randomEffects.availableWidth
				draggable		: false
				optionKey		: "value"
				interactionHighOrderCheckBox: "randomSlopes"

				rowComponent: CheckBox { name: "randomSlopes"; checked: true }
			}
		}
	}
}
