public class EditAllSalesOrderLine {

    public String salesOrderLineProductId{get;set;}
    public List<Salesorder_Line_Product_custom__c> salesOrderLineProducts{get;set;}
    public EditAllSalesOrderLine(){
        salesOrderLineProductId = ApexPages.currentPage().getparameters().get('id');
        salesOrderLineProducts = new List<Salesorder_Line_Product_custom__c>();
        salesOrderLineProducts = [SELECT 
                                  Name, 
                                  Salesorder_Name__c , 
                                  Product_Description__c,
                                  Actual_price__c,
                                  Unit_price__c,
                                  Quantity__c, 
                                  Discount_Type__c,
                                  Discount_Value__c,
                                  Discounted_Price__c,
                                  IGST_Amount__c,
                                  SGST_Amount__c
                                  FROM Salesorder_Line_Product_custom__c 
                                  WHERE Salesorder_Name__c  =: salesOrderLineProductId];
    }
    
    public void updatesalesOrderLineProducts(){
        update salesOrderLineProducts;
    }
}