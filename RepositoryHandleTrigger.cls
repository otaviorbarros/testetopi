public with sharing class RepositoryHandleTrigger {
    public static Boolean isFirstTime = true;
    public static void shareRecord(){

        List<Repository__c> lstRep = [SELECT Id, Name, User__c, Id_item__c, fork_count__c, stars_count__c FROM Repository__c LIMIT 200];
        List<User> lstUser = [SELECT Id, Name FROM User WHERE Id = '0055Y00000DfmnLQAR'];
        
        System.debug(lstRep);
        System.debug(lstUser);
        for(Repository__c r : lstRep){
            Repository__c newRep = new Repository__c();
            newRep.User__c = '0055Y00000DfmnLQAR';
            if(newRep.User__c == '0055Y00000DfmnLQAR'){
                newRep.name = r.name;
                newRep.Id_item__c = r.Id_item__c;
                newRep.fork_count__c = r.fork_count__c;
                newRep.stars_count__c = r.stars_count__c;
                insert newRep;
            }         
        }
    }
}