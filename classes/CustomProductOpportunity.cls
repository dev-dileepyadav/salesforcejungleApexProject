public class CustomProductOpportunity {
    public List<Opportunity_Line_Product__c> oppLineProduct{get;set;}
    
    public CustomProductOpportunity(){
        oppLineProduct = new List<Opportunity_Line_Product__c>();
    }
    
    public void saveProducts (){
        insert oppLineProduct;
    }
}