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
		info: qsTr(" There are different types of the sum of squares. The choice of the type is important when there are multiple factors and when the data are unbalanced. In an unbalanced design, the different levels of the independent variable do not contain an equal number of observations (e.g., one group contains more observations than another group). In this scenario, the sum of squares type can influence the results.")
		radioButtonsOnSameRow:	true
		RadioButton { value: "2"; label: qsTr("II"); info: qsTr("Hierarchical/partially sequential sum of squares. It is the reduction of error when each factor is added to the model that includes all the other factors, except the factors where the added factor is a part of, such as interactions containing that factor. Langsrud (2003) advises to apply this type for an ANOVA with unbalanced data.") }
		RadioButton { value: "3"; label: qsTr("III"); info: qsTr("Partial sum of squares. It is the reduction of error when each factor is added to the model that includes all the other factors, including interactions with this factor. This type is often selected, because it takes interactions into account (Langsrud, 2003). This type is selected by default and recommended for designs in which the imbalance is not a consequence of imbalance in the population, but random.") ;checked: true }
	}

	CheckBox
	{
		enabled:	testMethod.currentValue == "parametricBootstrap" | testMethod.currentValue == "likelihoodRatioTest"
		name:		"interceptTest"
		label:		qsTr("Test intercept"); info: qsTr("Whether the model intercept should be tested. Available only if the likelihood ratio test or parametric bootstrap is selected in the Model terms test.")
	}

	Group
	{
		DropDown
		{
			name:	"testMethod"
			label:	qsTr("Test method")
			info: qsTr("Methods for obtaining p-values for the ANOVA summary. Note that Kenward-Roger approximation for degrees of freedom can be very RAM and time consuming with larger datasets and complicated random effects structures.")
			id:		testMethod
			values: allMethodOptions ?
			[
				{ label: "Satterthwaite",				    value: "satterthwaite"},
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
			info: qsTr("Specifies factor encoding for categorical variables.")
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
			fieldWidth:		60 * jaspTheme.uiScale
		}
	}

	Group
	{
		CheckBox
		{
			name:	"modelSummary"
			label:	qsTr("Model summary"); info: qsTr("Output table containing relevant statistics for the model.")
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

	SetSeed{}

	CheckBox
	{
		name:	"vovkSellke"
		label:	qsTr("Vovk-Sellke maximum p-ratio"); info: qsTr("Shows the maximum ratio of the likelihood of the obtained p value under H1 vs the likelihood of the obtained p value under H0. For example, if the two-sided p-value equals .05, the Vovk-Sellke MPR equals 2.46, indicating that this p-value is at most 2.46 times more likely to occur under H1 than under H0")
	}

}
