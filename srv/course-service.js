const cds = require("@sap/cds");
const crypto = require("crypto");

module.exports = cds.service.impl((srv) => {
    srv.on("AddUserToCourse", async (req) => {
        const { user_ID, course_ID } = req.data;

        try {
            const db = await cds.connect.to("db");
            const { UserCourse } = db.entities;

            const tx = db.tx(req);
            const users = await tx.run(SELECT.from(UserCourse).where({ user_ID: user_ID, course_ID: course_ID }));

            if (users.length > 0) {
                req.error(400);
            }

            await tx.run(INSERT.into(UserCourse).columns("ID", "user_ID", "course_ID").values(crypto.randomUUID(), user_ID, course_ID));

            req.res.status(200);
        } catch (e) {
            console.error(e);        
            req.error(e);
        }
    });

    srv.on("RemoveUserFromCourse", async (req) => {
        const { user_ID, course_ID } = req.data;

        try {
            const db = await cds.connect.to("db");
            const { UserCourse } = db.entities;

            const tx = db.tx(req);

            await tx.run(DELETE.from(UserCourse).where({ user_ID: user_ID, course_ID: course_ID }));

            req.res.status(200);
        } catch (e) {
            console.error(e);        
            req.error(e);
        }
    });

    srv.on("READ", "BusinessPartner", async (req) => {
        try {
            const bp = await cds.connect.to("OP_API_BUSINESS_PARTNER_SRV");
            return await bp.tx(req).run(req.query);
        } catch (e) {
            console.error(e);
            req.error(e);
        }
    });
});