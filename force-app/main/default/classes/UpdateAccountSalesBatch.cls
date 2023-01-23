global class  UpdateAccountSalesBatch  implements Database.Batchable<sObject> {


    global Database.QueryLocator start(Database.BatchableContext info) {
        // Execute the query and store the results in a list of sObjects
        return Database.getQueryLocator([
                SELECT Id
                FROM Account
                WHERE
                    Id IN (SELECT AccountId FROM Order WHERE Status = 'Activated')]);
    }
    
    global void execute(Database.BatchableContext info, List<Account> scope){      
                // Create a new set to store the account IDs
                Set<Id> accountIds = new Set<Id>();    
                for (Account a : scope){
                    accountIds.add(a.id);
                }
              //  Set<Id> accountIds = new Set<Id>(scope);
                OrderTriggerHandler.updateAccountSales(accountIds);    
    }

    global void finish(Database.BatchableContext info){     
       
    }     
}