namespace learning.dashboard.db;

using { OP_API_BUSINESS_PARTNER_SRV as external } from '../srv/external/OP_API_BUSINESS_PARTNER_SRV';

using { cuid } from '@sap/cds/common';

define aspect expirable {
    validFrom   : Date  not null;
    validTo     : Date  not null;
}

define type Priority : Integer enum {
    LOW_PRIO=0;
    MEDIUM_PRIO=1;
    HIGH_PRIO=2;
}

define entity Roles : cuid {
    name    : String(50) not null;
}

define entity Users {
    key ID   : String(300) not null;
    name     : String(50)  not null;
    lastName : String(50)  not null;
    role     : Association to one Roles @Core.AutoExpand;
}

define entity UserCourse : cuid {
    user    : Association to one Users;
    course  : Association to one Courses;
}

define entity Courses : cuid, expirable {
    name        : String(300) not null;
    description : String;
    priority    : Priority;

    businessPartner  : Association to one BusinessPartner;
    users            : Composition of many UserCourse on users.course = $self;
}

define entity BusinessPartner as projection on external.A_BusinessPartner {
    BusinessPartner as BP_key,
    FirstName,
    LastName
};