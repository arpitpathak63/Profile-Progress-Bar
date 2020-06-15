({
    	doInit : function(component) {
		var action = component.get("c.getQue");
        
        action.setParams({
            "recLimit": component.get("v.limit"),
            "recOffset": component.get("v.offset")
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            
            if (state === "SUCCESS") {
                console.log('Returned Values------>'+response.getReturnValue());
                component.set("v.wrapper", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
    },
    calculateweight : function(component, event, helper)
    {
     var action = component.get("c.getcalculateweightage");
     var action2 = component.get("c.getcalculateactual");   
     action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == "SUCCESS") 
            {
                var tw=response.getReturnValue();
                component.set("v.totalweightage",tw);
                var con=component.get("v.totalweightage");
         action2.setParams({
        "kw" : con  
    }); 
                 $A.enqueueAction(action2);
                var cmpEvnt=component.getEvent("regInChild"); 
        cmpEvnt.setParams({
            storeMessage : component.get("v.totalweightage"),
            storeMessage1 : component.get("v.actualweightage")   
        });
                cmpEvnt.fire();
            }
                
            else {
                console.log("Failed with state: " + state);
            }
        });
         action2.setCallback(this,function(res){
            var state = res.getState();            
            if(state=="SUCCESS"){
              var result = res.getReturnValue();
              component.set("v.actualweightage",result);
                var cmpEvnt=component.getEvent("regInChild"); 
        cmpEvnt.setParams({
           
            storeMessage : component.get("v.totalweightage"),  
            storeMessage1 : component.get("v.actualweightage")     
        });
                cmpEvnt.fire();
            
            }
        });   
          $A.enqueueAction(action2);
          $A.enqueueAction(action);
         
          
    }
})