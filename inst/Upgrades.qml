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

	// Option renaming
	Upgrade
	{
		functionName:	"MixedModelsLMM"
		fromVersion:	"0.16.4"
		toVersion:		"0.17.0"

		ChangeRename { from: "dependentVariable";	to: "dependent"	}
		
		// MixedModelOptions.qml
		ChangeRename { from: "test_intercept";	to: "interceptTest"	}
		ChangeRename { from: "method";			to: "testMethod"	}
		ChangeJS
		{
			name:	"testMethod"
			jsFunction:	function(options)
			{
				switch(options["testMethod"])
				{
					case "S":						return "satterthwaite";
					case "Kenward-Roger":			return "kenwardRoger";
					case "Likelihood ratio tests":	return "likelihoodRatioTest";
					case "Parametric bootstrap": 	return "parametricBootstrap";
					default:						return options["testMethod"];
				}
			}
		}

		ChangeRename { from: "fitStats";			to: "modelSummary"					}
		ChangeRename { from: "showFE";				to: "fixedEffectEstimate"			}
		ChangeRename { from: "showRE";				to: "varianceCorrelationEstimate"	}
		ChangeRename { from: "showREEstimates";		to: "randomEffectEstimate"			}
		ChangeRename { from: "pvalVS";				to: "vovkSellke"					}

		// MixedModelsPlots.qml
		ChangeRename { from: "plotsX";					to: "plotHorizontalAxis"	}
		ChangeRename { from: "plotsTrace";				to: "plotSeparateLines"		}
		ChangeRename { from: "plotsPanel";				to: "plotSeparatePlots"		}
		ChangeRename { from: "plotsAgregatedOver";		to: "plotBackgroundData"	}
		ChangeRename { from: "plotsCImethod";			to: "plotCiType"			}
		ChangeRename { from: "plotsCIwidth";			to: "plotCiLevel"			}
		ChangeRename { from: "plotsMappingColor";		to: "plotLevelsByColor"		}
		ChangeRename { from: "plotsMappingShape";		to: "plotLevelsByShape"		}
		ChangeRename { from: "plotsMappingLineType";	to: "plotLevelsByLinetype"	}
		ChangeRename { from: "plotsMappingFill";		to: "plotLevelsByFill"		}

		ChangeRename { from: "plotsGeom";	to: "plotBackgroundElement"	}
		ChangeJS
		{
			name: "plotBackgroundElement"
			jsFunction: function(options)
			{
				// previously all things were prepended with "geom_", so we strip that out
				options["plotBackgroundElement"].replace("geom_", "");
			}
		}
		ChangeRename { from: "plotAlpha";		to: "plotTransparency"	}
		ChangeRename { from: "plotGeomWidth";	to: "plotElementWidth"	}
		ChangeRename { from: "plotsTheme";		to: "plotTheme"			}
		ChangeJS
		{
			name: "plotTheme"
			jsFunction: function(options)
			{
				case "JASP":		return "jasp";
				case "theme_bw":	return "whiteBackground";
				// From the others we just strip "theme_"
				default:			return options["plotTheme"].replace("theme_", "");
			}
		}
		ChangeRename { from: "plotsBackgroundColor";	to: "plotBackgroundColor"	}
		ChangeRename { from: "plotRelativeSize";		to: "plotRelativeSizeData"	}
		ChangeRename { from: "plotsEstimatesTable";		to: "plotEstimatesTable"	}

		// Marginal means
		ChangeRename { from: "marginalMeans";			to: "marginalMeansTerms"	}
		ChangeRename { from: "marginalMeansCIwidth";	to: "marginalMeansCiLevel"	}
		ChangeRename { from: "marginalMeansSD";			to: "marginalMeansSd"	}
		ChangeSetValue
		{
			name:		"marginalMeansDf"
			jsonValue:	"kenwardRoger"
			condition:	function(options) return (options["marginalMeansDf"] === "kenward-roger");
		}

		ChangeRename { from: "marginalMeansOverride";	to: "marginalMeansDfEstimated"		}
		ChangeRename { from: "marginalMeansCompare";	to: "marginalMeansComparison"		}
		ChangeRename { from: "marginalMeansCompareTo";	to: "marginalMeansComparisonWith"	}
		ChangeRename { from: "marginalMeansAdjustment";	to: "marginalMeansPAdjustment"		}
		ChangeRename { from: "Contrasts";				to: "contrasts"						}

		// Estimated trends/conditional slopes
		ChangeRename { from: "trendsTrend";				to: "trendsTrendVariable"	}
		ChangeRename { from: "trendsCIwidth";			to: "trendsCiLevel"			}
		ChangeRename { from: "trendsSD";				to: "trendsSd"				}
		ChangeSetValue
		{
			name:		"trendsDf"
			jsonValue:	"kenwardRoger"
			condition:	function(options) return (options["marginalMeansDf"] === "kenward-roger");
		}
		ChangeRename { from: "trendsOverride";		to: "trendsDfEstimated"		}
		ChangeRename { from: "trendsCompare";		to: "trendsComparison"		}
		ChangeRename { from: "trendsCompareTo";		to: "trendsComparisonWith"	}
		ChangeRename { from: "trendsAdjustment";	to: "trendsPAdjustment"		}


	}

	Upgrade
	{
		functionName:	"MixedModelsGLMM"
		fromVersion:	"0.16.4"
		toVersion:		"0.17.0"


	}

	Upgrade
	{
		functionName:	"MixedModelsBLMM"
		fromVersion:	"0.16.4"
		toVersion:		"0.17.0"


	}

	Upgrade
	{
		functionName:	"MixedModelsBGLMM"
		fromVersion:	"0.16.4"
		toVersion:		"0.17.0"


	}
}
