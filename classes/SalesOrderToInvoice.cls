public class SalesOrderToInvoice {

    public Salesorder_custom__c salesOrder{get;set;}
        public List<Salesorder_Line_Product_custom__c> salesOrderLineProducts{get;set;}
    public List<Invoice_Line_Product_custom__c> invoiceLineProducts{get;set;}
        public String salesOrderId{get;set;}
        public Invoice_custom__c invoice{get;set;}
    
    public SalesOrderToInvoice(){
         salesOrderId = ApexPages.currentPage().getparameters().get('id');
        salesOrder = new Salesorder_custom__c();
        salesOrder = [SELECT 
                      Quotes__c,
                      Name, 
                      Account__c,
                      Contact__c,
                      Opportunity_custom__c,
                      Salesorder_Date__c,
                      Valid_Till__c,
                      Payment_terms__c,
                      Warranty__c,
                      Remarks__c,
                      Delivery_Lead_Time__c 
                      FROM Salesorder_custom__c WHERE id =:salesOrderId];
       
        
        salesOrderLineProducts = new List<Salesorder_Line_Product_custom__c>([SELECT Id,
                                 Quote_Name__c,
                                 Name,
                                 Product__c,
                                 Product_Description__c,
                                 Actual_price__c,
                                 Unit_price__c,
                                 Quantity__c,
                                 Balanced_Quantity__c,
                                 Account_Name__c,
                                 Opportunity_Name__c,Salesorder_Name__c 
                                 FROM Salesorder_Line_Product_custom__c WHERE Salesorder_Name__c  =:salesOrderId]);
        
        invoice = new Invoice_custom__c();
        invoice.Account__c = salesOrder.Account__c;
        invoice.Quote__c = salesOrder.Quotes__c;
        invoice.Delivery_Lead_Time__c = salesOrder.Delivery_Lead_Time__c;
        invoice.Remarks__c = salesOrder.Remarks__c;
        invoice.Opportunity__c = salesOrder.Opportunity_custom__c;
        invoice.Contact__c = salesOrder.Contact__c;
        invoice.Valid_Till__c = salesOrder.Valid_Till__c;
        invoice.Warranty__c = salesOrder.Warranty__c;
        invoice.Payment_terms__c = salesOrder.Payment_terms__c;
        
        invoiceLineProducts = new List<Invoice_Line_Product_custom__c>();
    }
    
    public void createInvoice(){
        insert invoice;
        
        for(Salesorder_Line_Product_custom__c salesOrder :salesOrderLineProducts){
            Invoice_Line_Product_custom__c invoiceLineProduct = new Invoice_Line_Product_custom__c();
            
            invoiceLineProduct.Quantity__c = salesOrder.Quantity__c;
            invoiceLineProduct.Unit_price__c = salesOrder.Unit_price__c;
            invoiceLineProduct.Actual_price__c = salesOrder.Actual_price__c;
            invoiceLineProduct.Product_Description__c = salesOrder.Product_Description__c;
            invoiceLineProduct.Quote_Name__c = salesOrder.Quote_Name__c;
            invoiceLineProduct.Invoice_Name__c = invoice.Id;
            invoiceLineProducts.add(invoiceLineProduct);
        }
        insert invoiceLineProducts;
    }
}