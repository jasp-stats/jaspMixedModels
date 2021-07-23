import QtQuick		2.12
import JASP.Module	1.0

Upgrades
{
	Upgrade
	{
		functionName: 	"MixedModelsLMM"
		fromVersion:	"0.14"
		toVersion:		"0.15"

		ChangeRename { from: "bootstrap_samples";	to: "bootstrapSamples" }
		
	}

	Upgrade
	{
		functionName: 	"MixedModelsGLMM"
		fromVersion:	"0.14"
		toVersion:		"0.15"

		ChangeRename { from: "binomial_agg";		to: "binomialAgg" }
		ChangeRename { from: "bootstrap_samples";	to: "bootstrapSamples" }
	}

	Upgrade
	{
		functionName: 	"MixedModelsBGLMM"
		fromVersion:	"0.14"
		toVersion:		"0.15"

		ChangeRename { from: "binomial_agg";		to: "binomialAgg" }
	}
}
