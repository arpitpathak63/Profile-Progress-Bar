({
	doInit: function (component, event, helper) {
		var obj = component.get("v.objects");
		var fld = component.get("v.fields");
		var action = component.get("c.updateProfile");
		action.setParams({
			"obj": obj,
			"flds": fld,
		});
		action.setCallback(this, function (res) {
			var state = res.getState();
			if (state == "SUCCESS") {
				var result = res.getReturnValue();
				component.set("v.isType", result);
			}
		});
		$A.enqueueAction(action);
	},
	doClose: function (component, event, helper) {
		component.set("v.istruthy", false);
	},
	saveRecord: function (component, event, helper) {
		var inputValues = '';
		var obj = component.get("v.objects");
		var fld = component.get("v.fields");
		var inputs = component.get("v.values");
		var inputType = component.get("v.isType");
		var phoneRegexFormat = /^\d{5,11}$/;
		var urlRegexFormate = new RegExp('^[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(/\S*)?$');
		if (inputType == 'PHONE') {
			if (inputs.match(phoneRegexFormat)) {
				inputValues = inputs;
			} else {
				component.set('v.messages', 'You have entered an invalid format.');
			}
		} else if (inputType == 'URL') {
			if (inputs.match(urlRegexFormate)) {
				inputValues = inputs;
			}
		} else {
			inputValues = inputs;
		}
		if (inputValues != '') {
			var action = component.get("c.updateRecord");
			action.setParams({
				"obj": obj,
				"flds": fld,
				"inputValues": inputValues,
			});
			action.setCallback(this, function (res) {
				var state = res.getState();
				if (state == "SUCCESS") {
					var result = res.getReturnValue();
					var action = component.get('c.doClose');
					$A.enqueueAction(action);
					helper.showToast(component, result);
					helper.callParentMethod(component, event, helper);
				}
			});
			$A.enqueueAction(action);
		}
	},
	onchange: function (component, event, helper) {
		var dataValue = component.find("inputData").get("v.value");
		component.set('v.messages', '');
		component.set("v.values", dataValue);
	},
})