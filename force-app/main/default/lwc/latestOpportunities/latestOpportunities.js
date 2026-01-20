import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getLatestOpportunities from '@salesforce/apex/OpportunityController.getLatestOpportunities';

export default class LatestOpportunities extends NavigationMixin(LightningElement) {
    
    searchKey = ''; // 1. Variável para guardar o texto da busca

    // 2. Passamos o parâmetro para o Apex. O '$' torna isso dinâmico (reativo).
    @wire(getLatestOpportunities, { searchKey: '$searchKey' })
    opportunities;

    // 3. Função que roda cada vez que você digita uma letra
    handleSearchChange(event) {
        // Atualiza a variável searchKey com o que foi digitado
        this.searchKey = event.target.value;
    }

    handleOpportunityClick(event) {
        event.preventDefault();
        const oppId = event.target.dataset.id;
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