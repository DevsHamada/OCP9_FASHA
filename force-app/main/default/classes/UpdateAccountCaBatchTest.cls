@isTest
private class UpdateAccountCaBatchTest {

    @isTest
    static void testBatch() {
        // Insert test data
        Integer numOfAccounts = 2;
        Integer numOfOrders = 2;
        Integer totalRevenueExpected = numOfOrders * TestDataFactory.ITEM_QUANTITY * TestDataFactory.UNIT_PRICE;
        
        List<Order> orders = TestDataFactory.insertData(numOfAccounts, numOfOrders);
        // Update the status of the orders to "Activated"
        for (Order o : orders) {
            o.Status = TestDataFactory.FINAL_ORDER_STATUS;
        }
        update orders;

        // Start the test batch
        Test.startTest();
        updateAccountCaBatch batch = new updateAccountCaBatch();
        Id batchId = Database.executeBatch(batch);
        Test.stopTest();
        
        // Check that the batch was successful
        // Query the accounts and check that their "Chiffre_d_affaire__c" field was updated correctly
        List<Account> accounts = [SELECT Chiffre_d_affaire__c FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Activated')];
        System.assertEquals(
            numOfAccounts,
            accounts.size(),
            'ERROR: A Account not updated correctly'
        );
        for (Account account : accounts ) {
            System.assertEquals(
                totalRevenueExpected,account.Chiffre_d_affaire__c,'CA Incorrect'
            );
        }
    }
    @isTest
    static void testBatchnotok() {
        // Insert test data
        Integer numOfAccounts = 2;
        Integer numOfOrders = 2;
        Integer totalRevenueExpected = numOfOrders * TestDataFactory.ITEM_QUANTITY * TestDataFactory.UNIT_PRICE + 100;
        
        List<Order> orders = TestDataFactory.insertData(numOfAccounts, numOfOrders);
        // Update the status of the orders to "Activated"
        for (Order o : orders) {
            o.Status = TestDataFactory.FINAL_ORDER_STATUS;
        }
        update orders;

        // Start the test batch
        Test.startTest();
        updateAccountCaBatch batch = new updateAccountCaBatch();
        Id batchId = Database.executeBatch(batch);
        Test.stopTest();
        
        // Check that the batch was successful
        // Query the accounts and check that their "Chiffre_d_affaire__c" field was updated correctly
        List<Account> accounts = [SELECT Chiffre_d_affaire__c FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Activated')];
        System.assertEquals(
            numOfAccounts,
            accounts.size(),
            'ERROR: A Account not updated correctly'
        );
        for (Account account : accounts ) {
            System.assertNotEquals(TotalRevenueExpected,account.Chiffre_d_affaire__c);
        }
    }
}