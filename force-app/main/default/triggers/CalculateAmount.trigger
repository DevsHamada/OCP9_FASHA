trigger CalculateAmount on Order (before update) {
	
  OrderTriggerHandler.calculAmount(Trigger.new);
    
}
