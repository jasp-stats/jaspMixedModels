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
	title: qsTr("Options")

	Group
	{

		IntegerField
		{
			name:			"mcmcBurnin"
			id:				warmup
			label:			qsTr("Burnin"); info: qsTr("Number of iterations reserved for burnin.")
			defaultValue:	2000
			min:			100
		}

		IntegerField
		{
			name:			"mcmcSamples"
			label:			qsTr("Samples"); info: qsTr("Number of MCMC samples.")
			defaultValue:	4000
			min:			parseInt(warmup.value) + 100
		}

		IntegerField
		{
			name:			"mcmcChains"
			label:			qsTr("Chains"); info: qsTr("Number of MCMC chains.")
			defaultValue:	3
			min:			1
		}

		DoubleField
		{
			name:			"mcmcAdaptDelta"
			label:			qsTr("Adapt delta"); info: qsTr("Average target proposal acceptance of each step. Increasing Adapt delta results in better-behaved chains, but also longer fitting times.")
			defaultValue:	0.80
			min:			0.5
			max:			1
		}

		IntegerField
		{
			name:			"mcmcMaxTreedepth"
			label:			qsTr("Maximum treedepth"); info: qsTr("The cap for the number of trees evaluated during each iteration. Prevents excessively long execution times.")
			defaultValue:	10
			min:			5
		}
	}

	Group
	{

		RadioButtonGroup
		{
			name:		"estimateType"
			title:		qsTr("Show"); info: qsTr("Specifies the content of the default output table.")
			RadioButton { value: "deviation";		label: qsTr("Differences from intercept"); info: qsTr("A table for each fixed effects term will be created in the default output and it will show the differences from the grand mean for each of the levels of the terms (or one standard deviation distance for continuous terms). This option is selected by default.") ;checked: true}
			RadioButton { value: "marginalMeans";	label: qsTr("Marginal means"); info: qsTr("A table for each fixed effects term will be created in the default output and it will show the estimated marginal mean for each of the levels of the terms (or one standard deviation distance for continuous terms).") }
		}

		Group
		{
			CheckBox
			{
				name:	"modelSummary"
				label:	qsTr("Model summary"); info: qsTr("Adds an output table including relevant fit statistics.")
			}

			CheckBox
			{
				name:	"fixedEffectEstimate"
				label:	qsTr("Fixed effects estimates"); info: qsTr("Shows the estimated fixed effect coefficients.")
			}

			CheckBox
			{
				name:	"varianceCorrelationEstimate"
				label:	qsTr("Variance/correlation estimates"); info: qsTr("Shows the estimated residual variances and variances/correlations of random effects coefficients.")
			}

			CheckBox
			{
				name:	"randomEffectEstimate"
				label:	qsTr("Random effects estimates"); info: qsTr("Shows the estimated random effects coefficients.")
			}
		}
	}

	SetSeed{}

	CIField
	{
		name:	"ciLevel"
		label:	qsTr("Credible interval"); info: qsTr("Width of the credible interval. Set at 95% by default, which can be changed by the user.")
	}
}
