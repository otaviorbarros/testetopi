public with sharing class RepositoryGitControllerMock implements HttpCallOutMock{
 public HttpResponse respond(HttpRequest requisicao){
        HttpResponse resposta = new HttpResponse();

        resposta.setHeader('Content-Type', 'application/json');
        resposta.setBody('{"total_count":11194168,"incomplete_results": false,"items":[{"id": 132464395,"name": "JavaGuide","stargazers_count":118525,"forks_count":40338}]}');
        resposta.setStatusCode(200);
        
        return resposta;
    }
}