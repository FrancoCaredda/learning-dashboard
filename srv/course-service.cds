using { learning.dashboard.db as db } from '../db/schema';

define service CourseService {
    @readonly 
    define entity Roles as projection on db.Roles;
    
    @readonly
    define entity Users as projection on db.Users {
        ID as uname,
        *
    };

    @readonly
    define entity UserCourse as SELECT from db.UserCourse;

    @readonly 
    define entity BusinessPartner as projection on db.BusinessPartner;

    @odata.draft.enabled
    define entity Courses as projection on db.Courses;
    
    define action AddUserToCourse(user_ID: String(300), course_ID: UUID);
    define action RemoveUserFromCourse(user_ID: String(300), course_ID: UUID);
}