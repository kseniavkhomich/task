@isTest
public class TestProductTriggerHelper {
    @isTest static void TestCheckAvailable(){
        List <Product__c> testList = new List<Product__c>();
        Product__c testProd1 = new Product__c(Amount__c = 1);
        Product__c testProd2 = new Product__c(Amount__c = 0);
        testList.add(testProd1);
        testList.add(testProd2);
        ProductTriggerHelper.CheckAvailable(testList);
        System.assertEquals(true,testList[0].Available__c);
        System.assertEquals(false, testList[1].Available__c);
    }  
}