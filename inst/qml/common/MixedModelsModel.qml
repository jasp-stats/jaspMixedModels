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

	property string analysisType:		"frequentist"

	VariablesForm
	{
		preferredHeight: jaspTheme.smallDefaultVariablesFormHeight

		AvailableVariablesList
		{
			name:	"availableModelComponents"
			title:	qsTr("Model components")
			info: qsTr("All the fixed effects variables that can be included in the model.")
			source:	"fixedVariables"
		}

		AssignedVariablesList
		{
			id:				fixedEffects
			name:			"fixedEffects"
			title:			qsTr("Fixed effects")
			info: qsTr(" The independent variables in the model. By default, all the main effects of the specified independent variables and their interactions are included in the model. To include interactions, click multiple variables (e.g., by holding the ctrl/cmd button on your keyboard while clicking) and drag those into the Fixed effects box.")
			listViewType:	JASP.Interaction
			allowTypeChange:false
			addInteractionsByDefault: false
		}

		CheckBox
		{
			label:		qsTr("Include intercept")
			info: qsTr("Include the interecpt in the model")
			name:		"includeIntercept"
			checked:	true
			visible:	analysisType == "frequentist" // stanova cannot summarize no-intercept models
		}
	}

	ComponentsList
	{
		id:					randomEffects
		title:				qsTr("Random effects")
		info: qsTr("The random effects organized by random effects grouping factors. By default, all of the random effects corresponding to the fixed effects are included and JASP internally checks and removes non-estimable random effects. That is, the default corresponds to the maximal random effects structure justified by the design. Unticking the boxes on the left of the variable names removes the random effect from corresponding random effects grouping factor.")
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
				CheckBox	{ label: qsTr("Correlations"); info: qsTr("Whether the correlations between the random effects parameters within each random effects grouping factor should be estimated.") ;name: "correlations"; checked: true; preferredWidth: parent.width / 2 }
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
