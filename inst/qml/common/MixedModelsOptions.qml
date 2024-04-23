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
	title: qsTr("Options")

	property bool allMethodOptions: true


	RadioButtonGroup
	{
		columns:				2
		name:					"type"
		title:					qsTr("Type")
		radioButtonsOnSameRow:	true
		RadioButton { value: "2"; label: qsTr("II") }
		RadioButton { value: "3"; label: qsTr("III"); checked: true }
	}

	CheckBox
	{
		enabled:	testMethod.currentValue == "parametricBootstrap" | testMethod.currentValue == "likelihoodRatioTest"
		name:		"interceptTest"
		label:		qsTr("Test intercept")
	}

	Group
	{
		DropDown
		{
			name:	"testMethod"
			label:	qsTr("Test method")
			id:		testMethod
			values: allMethodOptions ?
			[
				{ label: "Satterthwaite",					value: "satterthwaite"},
				{ label: "Kenward-Roger",					value: "kenwardRoger"},
				{ label: qsTr("Likelihood ratio tests"),	value: "likelihoodRatioTest"},
				{ label: qsTr("Parametric bootstrap"),		value: "parametricBootstrap"}
			] :
			[
				{ label: qsTr("Likelihood ratio tests"),	value: "likelihoodRatioTest"},
				{ label: qsTr("Parametric bootstrap"),		value: "parametricBootstrap"}
			]
		}

		DropDown
		{
			name:	"factorContrast"
			label:	qsTr("Factor contrast")
			values: 
			[
				{ label: qsTr("Sum"),		value: "sum"},
				{ label: qsTr("Treatment"),	value: "treatment"}
			]
		}

		IntegerField
		{
			enabled:		testMethod.currentValue == "parametricBootstrap"
			name:			"bootstrapSamples"
			label:			qsTr("No. samples")
			defaultValue:	500
			min:			100
			fieldWidth:		60
		}
	}

	Group
	{
		CheckBox
		{
			name:	"modelSummary"
			label:	qsTr("Model summary")
		}

		CheckBox
		{
			name:	"fixedEffectEstimate"
			label:	qsTr("Fixed effects estimates")
		}

		CheckBox
		{
			name:	"varianceCorrelationEstimate"
			label:	qsTr("Variance/correlation estimates")
		}

		CheckBox
		{
			name:	"randomEffectEstimate"
			label:	qsTr("Random effects estimates")
		}
	}

	SetSeed{}

	CheckBox
	{
		name:	"vovkSellke"
		label:	qsTr("Vovk-Sellke maximum p-ratio")
	}

}
