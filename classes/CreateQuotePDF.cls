public class CreateQuotePDF {

    String quoteId{get;set;}
    
    public Quote_custom__c quote {get;set;}
    public Decimal totalAmount{get;set;}
    public List<Quote_Line_Product__c> quoteLineProducts {get;set;}
    
    public CreateQuotePDF(){
        
        quoteId = ApexPages.currentPage().getparameters().get('id');
        
        quote = [SELECT 
                 Name, 
                 Valid_Till__c,
                 Payment_terms__c,
                 Warranty__c,
                 Total_Amount__c,
                 contact__r.Name,
                 Account__r.Name 
                 FROM Quote_custom__c WHERE id =: quoteId];
        
        
        quoteLineProducts = [SELECT
                             Name, Actual_price__c,
                             Unit_price__c, Quantity__c, 
                             Discount_Type__c, 
                             Total_Price__c, 
                             Quotes__c, 
                             Product__c,
                             Disounted_Price__c 
                             FROM Quote_Line_Product__c WHERE Quotes__c =:quoteId];
        
        totalAmount = quote.Total_Amount__c;
    }
}