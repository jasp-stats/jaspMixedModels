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
		ChangeSetValue
		{
			name:		"plotsTheme"
			condition:	function(options) { return options["plotsTheme"] == "jtools::theme_apa"; }
			jsonValue:	"theme_apa"
		}
		ChangeSetValue
		{
			name:		"plotsTheme"
			condition:	function(options) { return options["plotsTheme"] == "ggpubr::theme_pubr"; }
			jsonValue:	"theme_pubr"
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
		ChangeSetValue
		{
			name:		"plotsTheme"
			condition:	function(options) { return options["plotsTheme"] == "jtools::theme_apa"; }
			jsonValue:	"theme_apa"
		}
		ChangeSetValue
		{
			name:		"plotsTheme"
			condition:	function(options) { return options["plotsTheme"] == "ggpubr::theme_pubr"; }
			jsonValue:	"theme_pubr"
		}
	}

	Upgrade
	{
		functionName: 	"MixedModelsBLMM"
		fromVersion:	"0.14.3"
		toVersion:		"0.15"

		ChangeSetValue
		{
			name:		"plotsTheme"
			condition:	function(options) { return options["plotsTheme"] == "jtools::theme_apa"; }
			jsonValue:	"theme_apa"
		}
		ChangeSetValue
		{
			name:		"plotsTheme"
			condition:	function(options) { return options["plotsTheme"] == "ggpubr::theme_pubr"; }
			jsonValue:	"theme_pubr"
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
		ChangeSetValue
		{
			name:		"plotsTheme"
			condition:	function(options) { return options["plotsTheme"] == "jtools::theme_apa"; }
			jsonValue:	"theme_apa"
		}
		ChangeSetValue
		{
			name:		"plotsTheme"
			condition:	function(options) { return options["plotsTheme"] == "ggpubr::theme_pubr"; }
			jsonValue:	"theme_pubr"
		}
	}
}
