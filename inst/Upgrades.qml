import QtQuick		2.12
import JASP.Module	1.0

Upgrades
{
	Upgrade
	{
		functionName: 	"MixedModelsLMM"
		fromVersion:	"0.14.3"
		toVersion:		"0.15"

		ChangeRename { from: "bootstrap_samples";	to: "bootstrapSamples"; }
		ChangeJS
		{
			name:		"plotsTheme"
			jsFunction:	function(options) 
			{
				switch(options["plotsTheme"])
				{
					case "jtools::theme_apa":	return "theme_apa";
					case "ggpubr::theme_pubr":	return "theme_pubr";
					default:			return options["plotsTheme"]
				}
			}
		}
	}

	Upgrade
	{
		functionName: 	"MixedModelsGLMM"
		fromVersion:	"0.14.3"
		toVersion:		"0.15"

		ChangeSetValue
		{
			name:		"family"
			condition:	function(options) { return options["family"] == "binomial_agg"; }
			jsonValue:	"binomialAgg"
		}
		ChangeRename { from: "bootstrap_samples";	to: "bootstrapSamples"; }
		ChangeJS
		{
			name:		"plotsTheme"
			jsFunction:	function(options) 
			{
				switch(options["plotsTheme"])
				{
					case "jtools::theme_apa":	return "theme_apa";
					case "ggpubr::theme_pubr":	return "theme_pubr";
					default:			return options["plotsTheme"]
				}
			}
		}
	}

	Upgrade
	{
		functionName: 	"MixedModelsBLMM"
		fromVersion:	"0.14.3"
		toVersion:		"0.15"

		ChangeJS
		{
			name:		"plotsTheme"
			jsFunction:	function(options) 
			{
				switch(options["plotsTheme"])
				{
					case "jtools::theme_apa":	return "theme_apa";
					case "ggpubr::theme_pubr":	return "theme_pubr";
					default:			return options["plotsTheme"]
				}
			}
		}
	}

	Upgrade
	{
		functionName: 	"MixedModelsBGLMM"
		fromVersion:	"0.14.3"
		toVersion:		"0.15"

		ChangeSetValue
		{
			name:		"family"
			condition:	function(options) { return options["family"] == "binomial_agg"; }
			jsonValue:	"binomialAgg"
		}
		ChangeJS
		{
			name:		"plotsTheme"
			jsFunction:	function(options) 
			{
				switch(options["plotsTheme"])
				{
					case "jtools::theme_apa":	return "theme_apa";
					case "ggpubr::theme_pubr":	return "theme_pubr";
					default:			return options["plotsTheme"]
				}
			}
		}
	}
}
