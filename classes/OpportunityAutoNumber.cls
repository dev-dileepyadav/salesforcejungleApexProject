public class OpportunityAutoNumber {

    public static void generateAutoNumber(List<Opportunity_custom__c> records){
        
        for(Opportunity_custom__c rec : records){
            Date now = System.today();
            System.debug('Day ==>'+now);
            Integer year = now.year();
            System.debug('Year==>'+year);
            Integer month = now.month();
            System.debug('Year==>'+month);
            Integer day = now.day();
            System.debug('Year==>'+day);
            rec.Record_Number__c = day+'-'+month+'-'+year;
            System.debug('Record Number '+rec.Record_Number__c);
        }
    }
}