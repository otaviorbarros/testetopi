import { LightningElement, track, wire } from 'lwc';
import getRep from '@salesforce/apex/RepositoryGitController.getRepository';
import insertRep from '@salesforce/apex/RepositoryGitController.getData';

const columns = [
    { label: 'Nome do Repositório', fieldName: 'Name' },
    { label: 'Número de Estrelas', fieldName: 'Stars_Count__c'},
    { label: 'Número de Bifurcações', fieldName: 'Fork_Count__c'},
];

export default class RepositoryGit extends LightningElement {
    columns = columns;
    @wire(getRep)dados;

}