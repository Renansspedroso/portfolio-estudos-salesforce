import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation'; // 1. Importamos o navegador
import getLatestOpportunities from '@salesforce/apex/OpportunityController.getLatestOpportunities';

// 2. Adicionamos "NavigationMixin" aqui na definição da classe
export default class LatestOpportunities extends NavigationMixin(LightningElement) {
    
    @wire(getLatestOpportunities)
    opportunities;

    // 3. Criamos a função que recebe o clique
    handleOpportunityClick(event) {
        // Impede o navegador de seguir o link "#" padrão
        event.preventDefault();

        // Pega o ID que vamos esconder no HTML (no passo 2)
        const oppId = event.target.dataset.id;

        // Comando padrão do Salesforce para abrir registro
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: oppId,
                objectApiName: 'Opportunity',
                actionName: 'view'
            }
        });
    }
}