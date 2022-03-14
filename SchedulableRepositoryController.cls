    global class SchedulableRepositoryController implements Schedulable {
        global void execute(SchedulableContext SC) {
            RepositoryGitController rep = new RepositoryGitController();     
            rep.updateData();            
        } 
    }
