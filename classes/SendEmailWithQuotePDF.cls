public class SendEmailWithQuotePDF {
    
    public String quoteId{get;set;}
    public Quote_custom__c quote{get;set;}
    public String recordString{get;set;}
    public String fileContent{get;set;}
    
    public SendEmailWithQuotePDF(){
        quoteId = ApexPages.currentPage().getparameters().get('id');
       
        quote = new Quote_custom__c();
        
        quote = [SELECT
                Name, 
                Account__c, 
                Quote_Date__c,
                Valid_Till__c, 
                Payment_terms__c,
                Warranty__c,
                Delivery_Lead_Time__c,
                Remarks__c, 
                Total_Amount__c FROM Quote_custom__c WHERE id =: quoteId];
        
        recordString = 'Quote No. :'+quote.Name+'<br/> Quote Date : '+quote.Quote_Date__c+'<br/> Valid Till : '+quote.Valid_Till__c+'<br/>Payment Terms : '+quote.Payment_terms__c+'<br/> Warranty : '+quote.Warranty__c+'<br/> Remarks : '+quote.Remarks__c+'\n';
         fileContent =  'Quote No. :'+quote.Name+'\n'+'Quote Date : '+quote.Quote_Date__c+'\n'+'Valid Till : '+quote.Valid_Till__c+'\n'+'Payment Terms : '+quote.Payment_terms__c+'\n'+'Warranty : '+quote.Warranty__c+'\n'+'Remarks : '+quote.Remarks__c+'\n';
     
    }
    
    public static void sendEmail(){
    
    String subject = 'Quotion';
    //String body = 'This is testing for Send emails with attachment from your apex class in Salesforce';
         //String finalstr = 'Id, Name, Amount \n';
         String attName = 'quote.pdf'; 
         //string recordString;
        // String fileContent;
         //String quoteId = ApexPages.currentPage().getparameters().get('id');
        
        
         
        //finalstr = fileContent;
        //List<Quote_custom__c> quotes = new List<Quote_custom__c>();
        /*quotes = [SELECT Id,
                Name, 
                Account__c, 
                Quote_Date__c,
                Valid_Till__c, 
                Payment_terms__c,
                Warranty__c,
                Delivery_Lead_Time__c,
                Remarks__c, 
                Total_Amount__c FROM Quote_custom__c WHERE id = 'a035h00000idCDiAAM'];*/
        
     //for (Quote_custom__c quote : quotes){
    
 //}

    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
    
    efa.setFileName(attName);
    //efa.setBody(Blob.valueOf(fileContent));
    email.setSubject( subject );
    
    email.setToAddresses( new String[] {UserInfo.getUserEmail()} );
    //email.setHtmlBody(recordString);
    email.setSenderDisplayName('Support');
    email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
    
    Messaging.SendEmailResult [] r = 
 Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});

}
    }