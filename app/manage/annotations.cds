using CourseService as service from '../../srv/course-service';

annotate CourseService.Courses with {
    ID @UI.Hidden;
};

annotate CourseService.Courses with @(UI : {
    // List Report
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
    ],
    // Object Page
    HeaderInfo  : {
        $Type : 'UI.HeaderInfoType',
        TypeName : '{@i18n>application.objectpage.headerinfo.title.singular}',
        TypeNamePlural : '{@i18n>application.objectpage.headerinfo.title.plural}',
        Title : {
            $Type : 'UI.DataField',
            Value : name
        }
    },
    Facets : [
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : '{@i18n>application.objectpage.section1}',
            Target : ![@UI.FieldGroup#GeneralInformation]
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : '{@i18n>application.objectpage.section2}',
            Target : 'users/@UI.LineItem#UserList'
        }
    ],
    FieldGroup #GeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { $Type : 'UI.DataField', Value : name },
            { $Type : 'UI.DataField', Value : description },
            { $Type : 'UI.DataField', Value : priority },
            { $Type : 'UI.DataField', Value : validFrom },
            { $Type : 'UI.DataField', Value : validTo },
            { $Type : 'UI.DataField', Value : businessPartner_BP_key }
        ]
    }
});

annotate CourseService.UserCourse with @(UI : {
    LineItem #UserList : [
        { $Type : 'UI.DataField', Value : user.ID },
        { $Type : 'UI.DataField', Value : user.name },
        { $Type : 'UI.DataField', Value : user.lastName },
        { $Type : 'UI.DataField', Value : user.role_ID }
    ],
});

