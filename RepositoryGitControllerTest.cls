@isTest
public with sharing class RepositoryGitControllerTest {
    
    @TestSetup
    static void setup(){
        Repository__c repTest = new Repository__c();
        repTest.name = 'JavaGuide';
        repTest.Fork_Count__c = 40338;
        repTest.Stars_Count__c = 118525;
        repTest.Id_item__c = 121111;
        Database.insert(repTest);
    }
    
@isTest
public static void getDataTest(){
    List<Repository__c> lstRepTst = [SELECT ID, name, Id_item__c, Fork_Count__c, Stars_Count__c FROM Repository__c LIMIT 1];
    Boolean flagId = false;
    Decimal itemId = 121111;

    for(Repository__c r : lstRepTst){
        if(itemId == r.Id_item__c){
            flagId = true;
            System.debug('trueeee'+flagId);
        }
    }  
    Test.startTest();
    Test.setMock(HttpCallOutMock.class, new RepositoryGitControllerMock());
    RepositoryGitController.getData();
    Test.stopTest();
}
    @isTest
    public static void getRepositoryTest(){		             
        Test.startTest();
        List<Repository__c> lstRep = [SELECT Id, Fork_Count__c, Stars_Count__c FROM Repository__c LIMIT 1];
        System.debug('teste' + lstRep);
        RepositoryGitController.getRepository();
        Test.stopTest();
        system.assert(!lstRep.isEmpty(), 'retornou uma consulta');
    }
}