sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'learning.dashboard.manage',
            componentId: 'CoursesObjectPage',
            contextPath: '/Courses'
        },
        CustomPageDefinitions
    );
});