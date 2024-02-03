trigger OpportunityAutoNumber on Opportunity_custom__c (before insert,before update) {

    if(Trigger.isInsert && Trigger.isBefore){
        OpportunityAutoNumber.generateAutoNumber(Trigger.new);
    }
    
    if(Trigger.isUpdate && Trigger.isbefore){
        for(Opportunity_custom__c rec : Trigger.new){
            if(rec.Record_Number__c != null){
                rec.addError('You can not change record number');
            }
        }
    }
}