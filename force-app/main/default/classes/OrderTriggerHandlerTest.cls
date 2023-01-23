@isTest
public class OrderTriggerHandlerTest {

        @isTest
        static void testUpdateAccounts() {
                // Create test data
                Set<Id> orderIds = new Set<Id>();
                // number of accounts created
                Integer numOfAccounts = 1;
                //  number of products created
                Integer numOfProducts = 1;
                //  number of order created
                Integer numOfOrders = 100;

            // calculate Chiffre d'affaire by multiplying order number * quantity * unit
            Integer totalRevenueExpected = numOfOrders * TestDataFactory.ITEM_QUANTITY * TestDataFactory.UNIT_PRICE;

            // Create one account , one product with 100 orders 
            List<Order> listOrders = TestDataFactory.insertData(numOfAccounts, numOfOrders);

            // Set  order status 
            for (Order order : listOrders) {
                order.Status = TestDataFactory.FINAL_ORDER_STATUS;
            }

            // Start the UpdateAccounts 
            Test.startTest();
            update listOrders;
            Test.stopTest();
        
            // Verify that Total Revenue of each Account corresponds to the expected value
            Account accountUpdated = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE ID =:listOrders[0].AccountId];
            System.assertEquals(totalRevenueExpected, accountUpdated.Chiffre_d_affaire__c);
        }
        @isTest
        static void testUpdateAccountsDraftStatus() {
            // Create test data
            Set<Id> orderIds = new Set<Id>();
            // number of accounts created
            Integer numOfAccounts = 1;
            //  number of products created
            Integer numOfProducts = 1;
            //  number of order created
            Integer numOfOrders = 100;
            Integer totalRevenueExpected =0;


            // Create one account , one product with 100 orders 
            List<Order> listOrders = TestDataFactory.insertData(numOfAccounts, numOfOrders);

            // Start the UpdateAccounts 
            Test.startTest();
            update listOrders;
            Test.stopTest();
        
            // Verify that Total Revenue of each Account corresponds to the expected value
            Account accountUpdated = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE ID =:listOrders[0].AccountId];
            System.assertEquals(totalRevenueExpected, accountUpdated.Chiffre_d_affaire__c);
        }
        @isTest
        static void testcalculAmountForOneOrder() {
            // Create test data
            Set<Id> orderIds = new Set<Id>();
            // number of accounts created
            Integer numOfAccounts = 1;
            //  number of products created
            Integer numOfProducts = 1;
            //  number of order created
            Integer numOfOrders = 1;
            Integer shipmentAmount = 50;

            // calculate Chiffre d'affaire by multiplying order number * quantity * unit
            Integer totalRevenueExpected =  (TestDataFactory.ITEM_QUANTITY * TestDataFactory.UNIT_PRICE) - shipmentAmount;
            // Create one account , one product with 100 orders 
            List<Order> listOrders = TestDataFactory.insertData(numOfAccounts, numOfOrders);
            // Set Order Shipment shipmentAmount
            for (Order order : listOrders) {
                order.ShipmentCost__c = shipmentAmount;
            }
        
            // Start the UpdateAccounts 
            Test.startTest();
            update listOrders;
            Test.stopTest();

            // Verify that Total Revenue of each Account corresponds to the expected value
            Order orderUpdate = [SELECT Id, NetAmount__c FROM order WHERE id =:listOrders[0].id];
            System.assertEquals(totalRevenueExpected, orderUpdate.NetAmount__c);
        }

        @isTest
        static void testcalculAmountFor100Order() {
            // Create test data
            Set<Id> orderIds = new Set<Id>();
            // number of accounts created
            Integer numOfAccounts = 1;
            //  number of products created
            Integer numOfProducts = 1;
            //  number of order created
            Integer numOfOrders = 100;
            // reduction
            Integer shipmentAmount = 50;

            // calculate Chiffre d'affaire by multiplying order number * quantity * unit
            Integer totalRevenueExpected =  (TestDataFactory.ITEM_QUANTITY * TestDataFactory.UNIT_PRICE) - shipmentAmount;

            // Create one account , one product with 100 orders 
            List<Order> listOrders = TestDataFactory.insertData(numOfAccounts, numOfOrders);

            // Set Order Shipment shipmentAmount

            // Set  order status 
            for (Order order : listOrders) {
                order.ShipmentCost__c = shipmentAmount;
            }
        
            // Start the UpdateAccounts 
            Test.startTest();
            update listOrders;
            Test.stopTest();

            // Verify that Total Revenue of each Account corresponds to the expected value
            Order orderUpdate = [SELECT Id, NetAmount__c FROM order WHERE id =:listOrders[0].id];
            System.assertEquals(totalRevenueExpected, orderUpdate.NetAmount__c);
        }
        @isTest
        static void testcalculAmountFor200Order() {
            // Create test data
            Set<Id> orderIds = new Set<Id>();
            // number of accounts created
            Integer numOfAccounts = 1;
            //  number of products created
            Integer numOfProducts = 1;
            //  number of order created
            Integer numOfOrders = 200;
            // reduction
            Integer shipmentAmount = 50;

            // calculate Chiffre d'affaire by multiplying order number * quantity * unit
            Integer totalRevenueExpected =  (TestDataFactory.ITEM_QUANTITY * TestDataFactory.UNIT_PRICE) - shipmentAmount;

            // Create one account , one product with 100 orders 
            List<Order> listOrders = TestDataFactory.insertData(numOfAccounts, numOfOrders);

            // Set Order Shipment shipmentAmount

            // Set  order status 
            for (Order order : listOrders) {
                order.ShipmentCost__c = shipmentAmount;
            }
        
            // Start the UpdateAccounts 
            Test.startTest();
            update listOrders;
            Test.stopTest();

            // Verify that Total Revenue of each Account corresponds to the expected value
            Order orderUpdate = [SELECT Id, NetAmount__c FROM order WHERE id =:listOrders[0].id];
            System.assertEquals(totalRevenueExpected, orderUpdate.NetAmount__c);
        }
}