import QtQuick 		2.12
import JASP.Module 	1.0

Description
{
	title		: "Mixed Models"
	icon		: "analysis-descriptives.svg"
	description	: "This module offers the Linear Mixed Models analysis."
	version		: "0.13"
	author		: "JASP Team"
	maintainer	: "JASP Team <info@jasp-stats.org>"
	website		: "jasp-stats.org"
	license		: "GPL (>= 2)"
		

	GroupTitle
	{
		title:	qsTr("Classical")
		icon:	"analysis-classical-crosstabs.svg"
	}

	Analysis
	{
		title:	qsTr("Linear Mixed Models")
		func:	"MixedModelsLMM"
	}

	Analysis
	{
		title:	qsTr("Generalized Linear Mixed Models")
		func:	"MixedModelsGLMM"
	}

	GroupTitle
	{
		title: 	qsTr("Bayesian")
		icon:	"analysis-bayesian-crosstabs.svg"
	}
		
	Analysis
	{
		menu:	qsTr("Linear Mixed Models")
		title:	qsTr("Bayesian Linear Mixed Models")
		func:	"MixedModelsBLMM"
	}

	Analysis
	{
		menu:	qsTr("Generalized Linear Mixed Models")
		title:	qsTr("Bayesian Generalized Linear Mixed Models")
		func:	"MixedModelsBGLMM"
	}
}
