({
	showToast: function (component, result, helper) {
		var toastEvent = $A.get("e.force:showToast");
		toastEvent.setParams({
			"title": "Success!",
			"message": "The " + result + " has been updated successfully.",
			type: 'success',
		});
		toastEvent.fire();
	},
	callParentMethod: function (component, event, helper) {
		var p = component.get("v.parent");
		p.parentMethod();
	},

})