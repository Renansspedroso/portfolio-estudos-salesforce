public with sharing class OpportunityController {
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getLatestOpportunities(String searchKey) {
        
        String key = '%' + searchKey + '%'; // Prepara para o LIKE do SQL (contém o texto)
        
        return [
            SELECT Id, Name, StageName, Amount, CloseDate 
            FROM Opportunity 
            WHERE Name LIKE :key 
            WITH SECURITY_ENFORCED 
            ORDER BY CreatedDate DESC 
            LIMIT 5
        ];
    }
}