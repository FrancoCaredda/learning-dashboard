using { CourseService } from '../srv/course-service';

annotate CourseService.Courses with {
    name            @title : '{i18n>application.common.courses.name}';
    description     @title : '{i18n>application.common.courses.description}';
    priority        @title : '{i18n>application.common.courses.priority}';
    validFrom       @title : '{i18n>application.common.courses.validFrom}';
    validTo         @title : '{i18n>application.common.courses.validTo}';
    businessPartner @title : '{i18n>application.common.courses.businessPartner}';
    businessPartner @Common : { 
        Text : businessPartner.FirstName,
        TextArrangement : #TextOnly,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'BusinessPartner',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : businessPartner_BP_key,
                    ValueListProperty : 'BP_key'
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'FirstName',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'LastName',
                }
            ]
        }, 
    }
};

annotate CourseService.Users with {
    uname    @title : '{i18n>application.common.users.uname}';
    name     @title : '{i18n>application.common.users.name}';
    lastName @title : '{i18n>application.common.users.lastName}';
    role     @title : '{i18n>application.common.users.role}';
    role @Common : { 
        Text : role.name,
        TextArrangement : #TextOnly
    }
};

