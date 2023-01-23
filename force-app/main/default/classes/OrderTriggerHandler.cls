public with sharing class OrderTriggerHandler {
    public static void updateAccountSales(set<Id> setAccountIds)  {
    // Recup account list with order where status is "ordered" 
    List<Account> accounts =  [
        SELECT
            Id,
            Chiffre_d_affaire__c,
            (SELECT TotalAmount FROM Orders WHERE Status = 'Activated')
        FROM Account
        WHERE Id IN :setAccountIds
    ];

    // for each account 
    for (Account Acc : accounts ){
        Decimal accAmount = 0 ;
        if (Acc.Orders != null && Acc.Orders.size() > 0) {
            for (Order Ord : acc.Orders){
                accAmount = accAmount + ord.TotalAmount;
            }   
        }
        Acc.Chiffre_d_affaire__c = accAmount;
    }
    update accounts;
    }
    public static void calculAmount(List<Order> orders)  {
        for (Order nOrders : orders) {
            nOrders.NetAmount__c = nOrders.ShipmentCost__c == null
            ? nOrders.TotalAmount
            : nOrders.TotalAmount - nOrders.ShipmentCost__c;
        }
    }

}