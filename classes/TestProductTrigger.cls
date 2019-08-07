@isTest
public class TestProductTrigger {
    @isTest
    public static void testProductTriggerMethod(){
		Product__c prod = new Product__c(Amount__c=1);
    	insert prod;
    	prod = [SELECT Id,Available__c FROM Product__c WHERE Id = :prod.Id];
    	System.assertEquals(true, prod.Available__c);
    	prod.Amount__c = 0;
        update prod;
        prod = [SELECT Id,Available__c FROM Product__c WHERE Id = :prod.Id];
        System.assertEquals(false, prod.Available__c);
    
    }
}