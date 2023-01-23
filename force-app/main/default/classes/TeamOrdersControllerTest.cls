@isTest
private class TeamOrdersControllerTest {
    @isTest
    static void OrdersControllerTestSum() {

        // Initialize variables
        Integer numAccounts = 3;
        Integer numOrders = 2;
        Test.startTest();

        // Insert data with data factory 
        List<Order> orders = TestDataFactory.insertData(numAccounts, numOrders);

        // Update status 
        for (Order o : orders) {
                o.Status = 'Activated';
        }
        update orders;

        // Instantiation de la classe TeamOrdersController
        TeamOrdersController controller = new TeamOrdersController();
        // Appel de la méthode sumOrders
        decimal total = controller.sumOrders;

        // Vérification que la somme des commandes est correcte
        System.assertEquals(total, numAccounts*(numOrders*(TestDataFactory.UNIT_PRICE * TestDataFactory.ITEM_QUANTITY)));
        Test.stopTest();
    }
}