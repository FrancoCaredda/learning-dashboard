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
    define entity UserCourse as SELECT from db.UserCourse {
        user.ID       as uname,
        user.lastName as lastName,
        user.name     as name,
        user.role     as role,
        course
    };

    @readonly entity BusinessPartner as projection on db.BusinessPartner;

    define entity Courses as projection on db.Courses;
    define action AddUserToCourse(user_ID: String(300), course_ID: UUID);
    define action RemoveUserFromCourse(user_ID: String(300), course_ID: UUID);
}