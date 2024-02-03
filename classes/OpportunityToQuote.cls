public class OpportunityToQuote {
    
    public Opportunity_custom__c opportunity{get;set;}
        public Quote_custom__c quote{get;set;}
    public List<Opportunity_Line_Product__c> opportunityproducts{get;set;}
    public List<Quote_Line_Product__c> quoteLineProducts{get;set;}
    public String oppId{get;set;}
    
    public OpportunityToQuote(){
        oppId = ApexPages.currentPage().getparameters().get('id');
        opportunity = new Opportunity_custom__c();
        opportunity = [SELECT
                       Name,
                       Account__c,
                       Stage__c,
                       Close_Date__c,
                       Total_Amount__c,
                       Remarks__c, 
                       Contact__c 
                       FROM Opportunity_custom__c WHERE id=: oppId];
        
                quote = new Quote_custom__c();
                quote.Opportunity_custom__c = opportunity.id;
                quote.Account__c = opportunity.Account__c;
                quote.Valid_Till__c = opportunity.Close_Date__c;
                quote.Remarks__c = opportunity.Remarks__c;
        
        opportunityproducts = new List<Opportunity_Line_Product__c>();
        opportunityproducts = [SELECT Id,
                                Name,
                                Product_Description__c,
                                Quantity__c, 
                                Total_Price__c,
                                Unit_price__c,
                                Actual_price__c,Opportunity_Name__c
                                FROM Opportunity_Line_Product__c WHERE Opportunity_Name__c  =: oppId];
        
        quoteLineProducts = new List<Quote_Line_Product__c>();
    }
    public void createQuote(){
    
        insert quote;
        
        List<Quote_Line_Product__c> quoteLineItems = new List<Quote_Line_Product__c>();
        for(Opportunity_Line_Product__c opportunityLineProduct :opportunityproducts){
            Quote_Line_Product__c quoteLineItem = new Quote_Line_Product__c();
            quoteLineItem.Product_Description__c = opportunityLineProduct.Product_Description__c;
            quoteLineItem.Quantity__c = opportunityLineProduct.Quantity__c;
            quoteLineItem.Unit_price__c = opportunityLineProduct.Unit_price__c;
            quoteLineItem.Actual_price__c = opportunityLineProduct.Actual_price__c;
            quoteLineItem.Quotes__c = quote.Id;
            quoteLineItems.add(quoteLineItem);
        }
        insert quoteLineItems;
        
    }

}