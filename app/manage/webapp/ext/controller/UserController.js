sap.ui.define([
    "sap/m/MessageToast",
    "sap/ui/core/Fragment",
    "sap/ui/model/Filter",
    "sap/ui/model/FilterOperator"
], function(MessageToast, Fragment, Filter, FilterOperator) {
    'use strict';

    return {
        AddUser: function(oEvent) {
            console.log(oEvent);
            console.log(this.onUserSearch);

            const oCourse = oEvent.getBinding()
                                  .getBoundContext()
                                  .getObject();

            const onUserSearch = (function(oEvent) {
                console.log(oEvent);
                const sValue = oEvent.getParameters().value;
                const oBinding = oEvent.getParameters().itemsBinding;

                const aFilters = [
                    new Filter({
                        path: 'uname',
                        operator: FilterOperator.Contains,
                        value1: sValue
                    }),
                    new Filter({
                        path: 'name',
                        operator: FilterOperator.Contains,
                        value1: sValue
                    }),
                    new Filter({
                        path: 'lastName',
                        operator: FilterOperator.Contains,
                        value1: sValue
                    })
                ];

                oBinding.filter(new Filter({
                    filters: aFilters,
                    bAnd: false
                }));
            }).bind(this);

            const onUserSelected = (function(oEvent) {
                const oSelectedItem = oEvent.getParameters().selectedItem;
                const oUser = oSelectedItem.getBindingContext().getObject();

                const oModel = this.getModel();
                const oBoundContext = oModel.bindContext("/AddUserToCourse(...)");
                
                oBoundContext.setParameter("user_ID", oUser.uname);
                oBoundContext.setParameter("course_ID", oCourse.ID);

                // TODO(Fix): The view doesn't refresh
                oBoundContext.execute().then(() => {
                    MessageToast.show("The user has been added to the course");
                }).catch((err) => {
                    console.error(err);
                    MessageToast.show(err.message ? err.message : err);
                });

                const oDialog = this.byId("AddUserSelectDialog");
                const oBinding = oDialog.getBinding("items");

                oBinding.filter([]);
            }).bind(this);

            const onUserCancel = (function(oEvent) {
                const oDialog = this.byId("AddUserSelectDialog");
                const oBinding = oDialog.getBinding("items");

                oBinding.filter([]);
            }).bind(this);
            
            if (this.__pUserDialog === undefined) {
                this.__pUserDialog = Fragment.load({
                    name: "learning.dashboard.manage.ext.fragment.AddUserDialog",
                    type: "XML",
                    id: this._view.getId(),
                    controller: this,
                    containingView: this._view
                });

                this.__pUserDialog.then((function (oDialog) {
                    this.addDependent(oDialog);
                    oDialog.attachSearch(onUserSearch);
                    oDialog.attachCancel(onUserCancel);
                    oDialog.attachConfirm(onUserSelected);
                }).bind(this))
            }

            this.__pUserDialog.then(function (oDialog) {
                oDialog.open();
            });
        },
        RemoveUser: function(oBinding, aSelectedContexts) {
            const oCourse = oBinding.getObject();

            const oModel = this.getModel();


            let aPromises = aSelectedContexts.map(user => {
                let oUser = user.getObject()
                const oBoundContext = oModel.bindContext("/RemoveUserFromCourse(...)");
                
                oBoundContext.setParameter("user_ID", oUser.uname);
                oBoundContext.setParameter("course_ID", oCourse.ID);

                return oBoundContext.execute();
            });

            // TODO(Fix): The view doesn't refresh
            Promise.all(aPromises).then((res) => {
                MessageToast.show("The users have been deleted from the course");
            }).catch((err) => {
                console.error(err);
                MessageToast.show(err.message ? err.message : err);
            });
        }
    };
});
