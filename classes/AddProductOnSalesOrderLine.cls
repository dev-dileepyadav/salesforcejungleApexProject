public class AddProductOnSalesOrderLine {
    String salesOrderLineProductId{get;set;}
    public List<Invoice_Line_Product_custom__c> invoiceLineProducts{get;set;}
    
    public AddProductOnSalesOrderLine(){
        salesOrderLineProductId = ApexPages.currentPage().getparameters().get('id');
        invoiceLineProducts = new List<Invoice_Line_Product_custom__c>();
        
        for(Integer i=0; i<5;i++){
            Invoice_Line_Product_custom__c product = new Invoice_Line_Product_custom__c();
             product.Sales_orderline_item__c = salesOrderLineProductId;
            invoiceLineProducts.add(product);
        }
    }

    public void addProduct(){
        Invoice_Line_Product_custom__c product = new Invoice_Line_Product_custom__c();
        product.Sales_orderline_item__c = salesOrderLineProductId;
        invoiceLineProducts.add(product);
    }
    
    public void saveProduct(){
        insert invoiceLineProducts;
    }
}