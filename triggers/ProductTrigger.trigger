trigger ProductTrigger on Product__c (before insert,before update) {
    if (Trigger.isInsert || Trigger.isUpdate){
        ProductTriggerHelper.checkAvailable(Trigger.new);
    }
}