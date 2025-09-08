sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"spacefarerapp/test/integration/pages/SpacefarersList",
	"spacefarerapp/test/integration/pages/SpacefarersObjectPage"
], function (JourneyRunner, SpacefarersList, SpacefarersObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('spacefarerapp') + '/index.html',
        pages: {
			onTheSpacefarersList: SpacefarersList,
			onTheSpacefarersObjectPage: SpacefarersObjectPage
        },
        async: true
    });

    return runner;
});

