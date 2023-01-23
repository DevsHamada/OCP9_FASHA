trigger calculAmount on Order (before update) {
	
  OrderTriggerHandler.calculAmount(Trigger.new);
    
}