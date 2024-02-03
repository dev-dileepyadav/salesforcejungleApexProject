public class SalesOrderLineItem {
    
   public  List<Salesorder_Line_Product_custom__c> salesOrderLineProducts{get;set;}
    public String saleOrderId{get;set;}
    
    public SalesOrderLineItem(){
        saleOrderId = ApexPages.currentPage().getparameters().get('id');
        salesOrderLineProducts = new List<Salesorder_Line_Product_custom__c>();
        salesOrderLineProducts = [SELECT Name, 
                                  Salesorder_Name__c,
                                  Quote_Name__c,
                                  Opportunity_Name__c,
                                  Account_Name__c, 
                                  Product__c,
                                  Actual_price__c,
                                  Unit_price__c,
                                  Quantity__c, 
                                  Balanced_Quantity__c 
                                  FROM Salesorder_Line_Product_custom__c 
                                  WHERE Salesorder_Name__c =: saleOrderId];
        
    }
    
    public void updateSalesOrderLineItems(){
        update salesOrderLineProducts;
    }

}