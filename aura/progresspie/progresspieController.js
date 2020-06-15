({
	doInit: function (component, event, helper) {
		var valueFromEvent = event.getParam("storeMessage");
		var valueFromEvent1 = event.getParam("storeMessage1");
		component.set("v.totalProgress", valueFromEvent);
		component.set("v.actualProgress", valueFromEvent1);
		var dis = (valueFromEvent1 / valueFromEvent) * 100;
        component.set("v.cirDeg",dis);
        component.set("v.perText",dis);
		component.set("v.disappear", dis);
        
		var evt = $A.get("e.c:Result");
		evt.setParams({
			"Pass_Result": dis
		});
		evt.fire();
		helper.computeProgress(component, event, helper);
	},
    
    dohandle: function (component, event, helper) {
        var valueFromEvent = event.getParam("storeMessage");
		var valueFromEvent1 = event.getParam("storeMessage1");
		component.set("v.totalProgress", valueFromEvent);
		component.set("v.actualProgress", valueFromEvent1);
		var dis = (valueFromEvent1 / valueFromEvent) * 100;
        component.set("v.cirDeg",dis);
        component.set("v.perText",dis);
		component.set("v.disappear", dis);
        
		var evt = $A.get("e.c:Result");
		evt.setParams({
			"Pass_Result": dis
		});
		evt.fire();
		helper.computeProgress(component, event, helper);
      
    }
    
})