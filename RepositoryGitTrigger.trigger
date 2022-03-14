trigger RepositoryGitTrigger on Repository__c (before insert) {
    if(Trigger.isInsert){
        System.debug('1');
        if(Trigger.isBefore){
                /* for(Repository__c r : Trigger.new){
                    if(RepositoryHandleTrigger.isFirstTime){
                        RepositoryHandleTrigger.shareRecord();
                        System.debug('4');

                    }
                }    */
            
        }else if(Trigger.isAfter){

        }
    }else if(Trigger.isDelete){

    }
    }