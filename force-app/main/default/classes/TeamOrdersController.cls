public without sharing class TeamOrdersController {
    public decimal sumOrders{
        get{
			AggregateResult groupedResults = [SELECT Owner.Name Commercial, SUM(TotalAmount) total
            FROM Order
            WHERE Status = 'Activated'
            GROUP BY Owner.Name];
			return (decimal)groupedResults.get('total');

        }
        set;
    }
}