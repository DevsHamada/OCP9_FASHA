trigger UpdateAccountSales on Order (after update) {
    
	// declare Account Set of ID - pour récupérer la liste des ID à jour 
    set<Id> setAccountIds = new set<Id>();
    
    for(Order newOrder : Trigger.new){
     //   Order newOrder= trigger.new[i];
        setAccountIds.add(newOrder.AccountId);
    }

    // Call class service
       if (setAccountIds.size() > 0) {
         OrderTriggerHandler.updateAccountSales(setAccountIds);
      }
}