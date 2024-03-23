import QtQuick 		2.12
import JASP.Module 	1.0

Description
{
    name		: "auto-stats"
    title		: qsTr("Auto-stat T-Tests")
    description	: qsTr("Report to Evaluate the difference between two means")
    version			: "0.18.1"
    author		: "Arne John"
    maintainer	: "Arne John"
	website		: "jasp-stats.org"
	license		: "GPL (>= 2)"
	icon		: "analysis-classical-ttest.svg"
	hasWrappers	: true

	GroupTitle
	{
		title:	qsTr("Classical")
		icon:	"analysis-classical-ttest.svg"
	}
	Analysis
	{
		title:	qsTr("Independent Samples T-Test")
		func:	"TTestIndependentSamples"
	}
	Analysis
	{
		title:	qsTr("Paired Samples T-Test")
		func:	"TTestPairedSamples"
	}
	Analysis
	{
		title:	qsTr("One Sample T-Test")
		func:	"TTestOneSample"
	}
}
