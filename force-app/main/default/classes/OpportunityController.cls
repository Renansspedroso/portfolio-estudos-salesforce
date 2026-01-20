public with sharing class OpportunityController {
    // @AuraEnabled(cacheable=true) -> Permite que o LWC leia os dados e guarde em cache (mais rápido)
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getLatestOpportunities() {
        // Busca ID, Nome, Fase e Valor das 5 últimas oportunidades criadas
        return [
            SELECT Id, Name, StageName, Amount, CloseDate 
            FROM Opportunity 
            WITH SECURITY_ENFORCED // Boa prática de segurança (cai na prova!)
            ORDER BY CreatedDate DESC 
            LIMIT 5
        ];
    }
}