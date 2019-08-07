public class ProductTriggerHelper {
	public static void checkAvailable(List<Product__c> newProducts){
        for (Product__c productItem: newProducts){
            if (productItem.Amount__c > 0) {
                   productItem.Available__c = true;    
            } else if(productItem.Amount__c == 0){
                productItem.Available__c = false;
           	}
         }
    }
}