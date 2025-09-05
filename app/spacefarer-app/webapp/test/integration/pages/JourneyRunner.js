sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"galactic/spacefarerapp/test/integration/pages/SpacefarersList",
	"galactic/spacefarerapp/test/integration/pages/SpacefarersObjectPage"
], function (JourneyRunner, SpacefarersList, SpacefarersObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('galactic/spacefarerapp') + '/index.html',
        pages: {
			onTheSpacefarersList: SpacefarersList,
			onTheSpacefarersObjectPage: SpacefarersObjectPage
        },
        async: true
    });

    return runner;
});

