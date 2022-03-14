public class RepositoryGitController {
    @AuraEnabled
    @future(callout=true)
        public static void getData() {
        //inicia-se o procedimento para busca de dados webservice    
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setTimeout(15000);

        HttpResponse response = http.send(request);

        //Faz a validação se a request foi sucesso
        if(response.getStatusCode() == 200) {
            try{
                JSON2Apex json = JSON2Apex.parse(response.getBody());
                List<Object> obj = new List<Object>();

                List<JSON2Apex.Items> lstIt = json.items;
                List<Repository__c> lstRep = [SELECT Id_item__c FROM Repository__c LIMIT 200];
                Boolean flagId = false;
                //validação para não incluir registros com duplos com referencia pelo id do item
                for(Repository__c r : lstRep){
                    Decimal idItem = r.Id_item__c;
                    for(JSON2Apex.Items i : lstIt){
                        if(idItem == i.id){
                            flagId = true;
                        }
                    }
                }
                //iteração da classe JSON2apex para mapear os campos do objeto personalizado
                for(JSON2Apex.Items it : lstIt){
                    System.debug('flag'+ flagId);
                        if(!flagId){
                            Repository__c rep = new Repository__c();
                            if(rep.get('Id') == null){
                                rep.Id_item__c = it.id;
                                rep.name = it.name;
                                rep.fork_count__c = it.forks_count;
                                rep.stars_count__c = it.stargazers_count;
                                insert rep;
                            }else{  
                                update rep;
                            }
                        }                
                    }
            }
            catch(DmlException e){
                System.debug('error' + e.getMessage());
            }
        }

    }
    //metodo de consulta dos registros do objeto personalizado
    @AuraEnabled(cacheable=true)
    public static List<Repository__c> getRepository(){
        List<Repository__c> lstRep = new List<Repository__c>();
        try {
            lstRep.addAll([SELECT Id, Name, Fork_count__c, Stars_count__c FROM Repository__c LIMIT 200]);
        } catch (DmlException e) {
            System.debug('error===>'+ e.getMessage());
        }
        return lstRep;
    }

    public void updateData(){
        RepositoryGitController.getData();
    }
}