import QtQuick
import JASP.Module

Description
{
	name		: "jaspMixedModels"
	title		: qsTr("Mixed Models")
	description	: qsTr("Evaluate the difference between multiple means with random effects")
	icon		: "MixedModels_classical.svg"
	version		: "0.19.2"
	author		: "JASP Team"
	maintainer	: "JASP Team <info@jasp-stats.org>"
	website		: "jasp-stats.org"
	license		: "GPL (>= 2)"
	hasWrappers	: true
	preloadData	: true
		

	GroupTitle
	{
		title:	qsTr("Classical")
		icon:	"MixedModels_classical.svg"
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
		icon:	"MixedModels_bayesian.svg"
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
