@isTest
private class OpportunityControllerTest {
    
    @testSetup
    static void setup() {
        List<Opportunity> opps = new List<Opportunity>();
        
        // Cria 10 oportunidades genéricas "Opp Teste X"
        for(Integer i=0; i<10; i++) {
            opps.add(new Opportunity(
                Name = 'Opp Teste ' + i,
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(30),
                Amount = 1000 * (i+1)
            ));
        }
        
        // Cria 1 oportunidade "Especial" para testarmos a busca específica
        opps.add(new Opportunity(
            Name = 'Oportunidade Unica e Especial',
            StageName = 'Negotiation/Review',
            CloseDate = Date.today(),
            Amount = 50000
        ));
        
        insert opps;
    }

    @isTest
    static void testSearchEmpty() {
        Test.startTest();
        // Testa passando string vazia (comportamento padrão)
        List<Opportunity> resultado = OpportunityController.getLatestOpportunities('');
        Test.stopTest();
        
        // Deve retornar 5 (limite da query)
        System.assertEquals(5, resultado.size(), 'A busca vazia deve retornar 5 registros');
    }

    @isTest
    static void testSearchSpecific() {
        Test.startTest();
        // Testa passando uma palavra chave
        List<Opportunity> resultado = OpportunityController.getLatestOpportunities('Unica');
        Test.stopTest();
        
        // Deve retornar apenas 1 (a nossa "Especial")
        System.assertEquals(1, resultado.size(), 'A busca específica falhou');
        System.assertEquals('Oportunidade Unica e Especial', resultado[0].Name, 'O nome retornado não confere');
    }
}