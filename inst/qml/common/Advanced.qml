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
	title:		qsTr("Advanced Options")
	expanded:	false

	Group
	{
		title: qsTr("Optimizer Settings")

		DropDown
		{
			name:	"optimizerMethod"
			label:	qsTr("Optimizer")
			info:	qsTr("Optimization algorithm used for parameter estimation")
			values:
			[
				{ label: qsTr("Default"),		value: "default"},
				{ label: "nlminb",				value: "nlminb"},
				{ label: "BFGS",				value: "BFGS"},
				{ label: "Nelder-Mead",			value: "Nelder_Mead"},
				{ label: "bobyqa",				value: "bobyqa"}
			]
		}

		IntegerField
		{
			name:			"optimizerMaxIter"
			label:			qsTr("Maximum iterations")
			info:			qsTr("Maximum number of iterations for the optimizer")
			defaultValue:	10000
			min:			100
			max:			1000000
			fieldWidth:		80 * jaspTheme.uiScale
		}

		IntegerField
		{
			name:			"optimizerMaxFunEvals"
			label:			qsTr("Maximum function evaluations")
			info:			qsTr("Maximum number of function evaluations")
			defaultValue:	100000
			min:			1000
			max:			10000000
			fieldWidth:		80 * jaspTheme.uiScale
		}

		DoubleField
		{
			name:			"optimizerTolerance"
			label:			qsTr("Convergence tolerance")
			info:			qsTr("Convergence tolerance for parameter estimates")
			defaultValue:	1e-6
			min:			1e-12
			max:			1e-3
			decimals:		12
			fieldWidth:		100 * jaspTheme.uiScale
		}

		CheckBox
		{
			name:	"optimizerCheckConv"
			label:	qsTr("Check convergence")
			info:	qsTr("Check for convergence warnings and errors")
			checked: true
		}
	}
}