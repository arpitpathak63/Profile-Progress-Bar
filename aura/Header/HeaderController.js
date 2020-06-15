({
    getValueFromApplicationEvent : function(component, event, helper) {
        var ShowResultValue = event.getParam("Pass_Result");
        var action=component.get("c.converttointeger");
        action.setParams({
            "result": ShowResultValue
        });
         action.setCallback(this, function(response){
            var state = response.getState();
            
            if (state === "SUCCESS") {
                console.log('Returned Values------>'+response.getReturnValue());
                component.set("v.Get_Result", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
    }
})