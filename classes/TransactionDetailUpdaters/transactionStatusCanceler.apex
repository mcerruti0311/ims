// variables
Boolean goForUpdate = true;
Integer runSize = 100;

List <IMS_Transaction_Detail__c> detailsToUpdate = [
    
    SELECT Id,
      Name,
      Transaction_Status__c
   FROM IMS_Transaction_Detail__c
   WHERE Transaction_Status__c = 'Received Complete'
      AND Qty_Issue__c = 0
      AND Qty_Returned__c = 0
      AND IMS_Transaction__r.Employee__r.Employee_Number__c != ''
      ORDER BY Name
   LIMIT :runSize   
];

System.debug('Size: ' + detailsToUpdate.Size());
for (Integer c = 0; c < detailsToUpdate.Size(); c++) {
    System.debug(c+1 + ' Transaction: ' + detailsToUpdate[c].Name);
}

If(goForUpdate) {
    for(Integer i = 0; i < detailsToUpdate.Size(); i++) {
        detailsToUpdate[i].Transaction_Status__c = 'Canceled';
    }
   update detailsToUpdate; 
}