sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'learning/dashboard/manage/test/integration/FirstJourney',
		'learning/dashboard/manage/test/integration/pages/CoursesList',
		'learning/dashboard/manage/test/integration/pages/CoursesObjectPage'
    ],
    function(JourneyRunner, opaJourney, CoursesList, CoursesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('learning/dashboard/manage') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheCoursesList: CoursesList,
					onTheCoursesObjectPage: CoursesObjectPage
                }
            },
            opaJourney.run
        );
    }
);