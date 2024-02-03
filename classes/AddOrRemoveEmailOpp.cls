public class AddOrRemoveEmailOpp {
    
    public ApexPages.StandardSetController controllerListId{get;set;}
    public String recordNumber{get;set;}
    public Integer numberOfValueToRemove{get;set;}
    public List<Opportunity_custom__c> opportunityListId{get;set;}
    
    public List<Opportunity_custom__c> queryOpportunity{get;set;}
    
    public set<Opportunity_custom__c> opportunityId{get;set;}
    
    public addOrRemoveEmailOpp(ApexPages.StandardSetController controller) {
        
        this.controllerListId = controller;
        
        opportunityListId = new list<Opportunity_custom__c>();
        
        opportunityListId = controllerListId .getSelected();
        System.debug('Sleected records '+opportunityListId);
        opportunityId = new set<Opportunity_custom__c>();
        
        for(Opportunity_custom__c op : opportunityListId){
            System.debug('op values '+op);
            opportunityId.add(op);
        }
        
        queryOpportunity = new List<Opportunity_custom__c>();
        
        queryOpportunity = [SELECT Name,
                            Account__r.Name,
                            Contact__c,
                            Email__c,
                            Stage__c,
                            Close_Date__c,
                            LastModifiedDate,
                            Total_Amount__c,
                            Remarks__c
                            FROM Opportunity_custom__c
                            WHERE id=: opportunityId];
    }
    
    
    public pageReference deleteopportunity(){
        delete queryOpportunity[numberOfValueToRemove];
        pageReference pf =new pageReference('/apex/addOrRemoveEmailOpp');
        pf.setRedirect(true);
        return pf;
    }
    
    
    public void senEmail(){
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for(Opportunity_custom__c op : queryOpportunity){
            String subject = 'Your Opportunity Name is'+ op.Name+ ' is under process';
            String htmlBody = 'Hello,'+op.Account__r.Name+' '+
                '<br/><br/><b>I would like to share data of Opportunity</b>.<br/><b>Opportunity Name and  Number : </b>'+
                op.Name+ '<br/><b>Last modified : </b> '+
                op.LastModifiedDate+
                '<br/><b> Stage : </b> '+
                op.Stage__c+
                '<br/><b> Close Date : </b> '+
                op.Close_Date__c+
                '<br/><b>Remarks : </b> '+
                op.Remarks__c+
                '<br/><b>Total Amount : </b> '+
                op.Total_Amount__c;
            
            
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{op.Email__c});
            email.setReplyTo('dev.dileepyadava@gmail.com');
            email.setSenderDisplayName('Support');
            email.setSubject(subject);
            email.setHtmlBody(htmlBody);
            emails.add(email);
            
        }
        Messaging.sendEmail(emails);
        
        
    }
    
    
}