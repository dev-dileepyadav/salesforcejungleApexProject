public class AddOpportunityCustomProducts {

    public String opportunityId;
    public List<Opportunity_Line_Product__c> opportunityLineProducts{get;set;}
    
    
    
    public AddOpportunityCustomProducts(){
        opportunityLineProducts = new List<Opportunity_Line_Product__c>();
        opportunityId = ApexPages.currentPage().getparameters().get('id');
    }
    
    public void addProduct(){
        Opportunity_Line_Product__c productLine = new Opportunity_Line_Product__c();
        productLine.Opportunity_name__c = opportunityId;
        opportunityLineProducts.add(productLine);
    }
    
    public void saveProduct(){
        insert opportunityLineProducts;
    }
    
}