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
	title:		qsTr("Advanced")
	expanded:	false

	Group
	{
		title: qsTr("Optimizer Settings")

		DropDown
		{
			id:		optimizerDropdown
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

		// Nelder-Mead specific options
		IntegerField
		{
			name:			"nelderMeadMaxfun"
			label:			qsTr("Maximum function evaluations")
			info:			qsTr("Maximum number of function evaluations allowed")
			defaultValue:	10000
			min:			100
			max:			1000000
			fieldWidth:		80 * jaspTheme.uiScale
			visible:		optimizerDropdown.currentValue === "Nelder_Mead"
		}

		DoubleField
		{
			name:			"nelderMeadFtolAbs"
			label:			qsTr("Absolute function tolerance")
			info:			qsTr("Absolute tolerance on change in function values")
			defaultValue:	1e-5
			min:			1e-12
			max:			1e-1
			decimals:		12
			fieldWidth:		80 * jaspTheme.uiScale
			visible:		optimizerDropdown.currentValue === "Nelder_Mead"
		}

		DoubleField
		{
			name:			"nelderMeadFtolRel"
			label:			qsTr("Relative function tolerance")
			info:			qsTr("Relative tolerance on change in function values")
			defaultValue:	1e-15
			min:			1e-20
			max:			1e-5
			decimals:		20
			fieldWidth:		80 * jaspTheme.uiScale
			visible:		optimizerDropdown.currentValue === "Nelder_Mead"
		}

		DoubleField
		{
			name:			"nelderMeadXtolRel"
			label:			qsTr("Relative parameter tolerance")
			info:			qsTr("Relative tolerance on change in parameter values")
			defaultValue:	1e-7
			min:			1e-15
			max:			1e-3
			decimals:		15
			fieldWidth:		80 * jaspTheme.uiScale
			visible:		optimizerDropdown.currentValue === "Nelder_Mead"
		}

		// bobyqa specific options
		IntegerField
		{
			name:			"bobyqaNpt"
			label:			qsTr("Number of interpolation points")
			info:			qsTr("Number of points used to approximate the objective function")
			defaultValue:	0
			min:			0
			max:			100
			fieldWidth:		80 * jaspTheme.uiScale
			visible:		optimizerDropdown.currentValue === "bobyqa"
		}

		DoubleField
		{
			name:			"bobyqaRhobeg"
			label:			qsTr("Initial trust region radius")
			info:			qsTr("Initial value of the trust region radius")
			defaultValue:	0
			min:			0
			max:			10
			decimals:		6
			fieldWidth:		80 * jaspTheme.uiScale
			visible:		optimizerDropdown.currentValue === "bobyqa"
		}

		DoubleField
		{
			name:			"bobyqaRhoend"
			label:			qsTr("Final trust region radius")
			info:			qsTr("Final value of the trust region radius")
			defaultValue:	0
			min:			0
			max:			1
			decimals:		10
			fieldWidth:		80 * jaspTheme.uiScale
			visible:		optimizerDropdown.currentValue === "bobyqa"
		}

		IntegerField
		{
			name:			"bobyqaMaxfun"
			label:			qsTr("Maximum function evaluations")
			info:			qsTr("Maximum number of function evaluations allowed")
			defaultValue:	10000
			min:			100
			max:			1000000
			fieldWidth:		80 * jaspTheme.uiScale
			visible:		optimizerDropdown.currentValue === "bobyqa"
		}

		// nlminb specific options
		DoubleField
		{
			name:			"nlminbTol"
			label:			qsTr("Tolerance")
			info:			qsTr("Convergence tolerance")
			defaultValue:	1e-6
			min:			1e-12
			max:			1e-3
			decimals:		12
			fieldWidth:		80 * jaspTheme.uiScale
			visible:		optimizerDropdown.currentValue === "nlminb"
		}

		DoubleField
		{
			name:			"nlminbRelTol"
			label:			qsTr("Relative tolerance")
			info:			qsTr("Relative convergence tolerance")
			defaultValue:	1e-10
			min:			1e-20
			max:			1e-5
			decimals:		20
			fieldWidth:		80 * jaspTheme.uiScale
			visible:		optimizerDropdown.currentValue === "nlminb"
		}

		IntegerField
		{
			name:			"nlminbMaxit"
			label:			qsTr("Maximum iterations")
			info:			qsTr("Maximum number of iterations")
			defaultValue:	10000
			min:			100
			max:			1000000
			fieldWidth:		80 * jaspTheme.uiScale
			visible:		optimizerDropdown.currentValue === "nlminb"
		}

		// Default and BFGS options (generic fallback)
		IntegerField
		{
			name:			"optimizerMaxIter"
			label:			qsTr("Maximum iterations")
			info:			qsTr("Maximum number of iterations for the optimizer")
			defaultValue:	10000
			min:			100
			max:			1000000
			fieldWidth:		80 * jaspTheme.uiScale
			visible:		optimizerDropdown.currentValue === "default" || optimizerDropdown.currentValue === "BFGS"
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
			fieldWidth:		80 * jaspTheme.uiScale
			visible:		optimizerDropdown.currentValue === "default" || optimizerDropdown.currentValue === "BFGS"
		}
	}
}