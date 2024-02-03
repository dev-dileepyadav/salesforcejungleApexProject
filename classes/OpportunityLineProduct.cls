public class OpportunityLineProduct {
    
    public String recordId{get;set;}
    public List<Opportunity_Line_Product__c> opportunityLineProducts{get;set;}
    
    
    public opportunityLineProduct(){
        recordId = ApexPages.currentPage().getparameters().get('id');
        opportunityLineProducts = new List<Opportunity_Line_Product__c>();
        opportunityLineProducts = [SELECT 
                                   Opportunity_name__c,
                                   Name, 
                                   Product_custom__c,
                                   Account_Name__c,
                                   Unit_price__c,
                                   Total_Price__c,
                                   Quantity__c
                                   FROM Opportunity_Line_Product__c 
                                   WHERE Opportunity_name__c =: recordId];    
    }

    public void updateOpportunityProducts(){
      update opportunityLineProducts;
    }
}