using CourseService as service from '../../srv/course-service';

annotate CourseService.Courses with {
    ID @UI.Hidden;
};

annotate CourseService.Courses with @(UI : {
    SelectionFields : [
        name,
        priority,
        validFrom,
        validTo,
        businessPartner_BP_key
    ],
    LineItem : [
        { $Type : 'UI.DataField', Value : name },
        { $Type : 'UI.DataField', Value : description },
        { $Type : 'UI.DataField', Value : priority },
        { $Type : 'UI.DataField', Value : validFrom },
        { $Type : 'UI.DataField', Value : validTo },
        { $Type : 'UI.DataField', Value : businessPartner_BP_key }
    ]
});

