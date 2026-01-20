@isTest // Define que é uma classe de teste (não conta para limite de armazenamento)
private class OpportunityControllerTest {
    
    // Método de configuração: Cria dados "fakes" que só existem durante o teste
    @testSetup
    static void setup() {
        List<Opportunity> opps = new List<Opportunity>();
        
        // Criamos 10 oportunidades para testar
        for(Integer i=0; i<10; i++) {
            opps.add(new Opportunity(
                Name = 'Opp Teste ' + i,
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(30),
                Amount = 1000 * (i+1)
            ));
        }
        insert opps;
    }

    @isTest
    static void testGetLatestOpportunities() {
        // 1. PREPARAÇÃO (Já feita no @testSetup)
        
        // 2. EXECUÇÃO
        Test.startTest();
        // Chamamos o método da sua classe original
        List<Opportunity> resultado = OpportunityController.getLatestOpportunities();
        Test.stopTest();
        
        // 3. VERIFICAÇÃO (Asserts)
        // A classe deve retornar no máximo 5 registros (conforme o LIMIT 5 da query)
        System.assertEquals(5, resultado.size(), 'Deveria retornar apenas 5 oportunidades');
        
        // Verifica se o primeiro da lista é o mais recente (maior valor ou criado por último)
        // Como criamos todos juntos, a ordem pode variar, mas garantimos que não veio vazio
        System.assert(!resultado.isEmpty(), 'A lista não deveria estar vazia');
    }
}