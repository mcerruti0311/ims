// Remove all vendor numbers 

// Constants
Boolean goForUpdate = false;
Integer runSize = 500;

// Create List of IMS Detail Records to Update

List<IMS_Detail__c> detailRecordsToUpdate = new List<IMS_Detail__c>();

detailRecordsToUpdate = [
    SELECT Id, 
      Length__c
    FROM IMS_Detail__c
    WHERE Length__c = ''
    LIMIT :runSize  
  ];  

System.assert(!detailRecordsToUpdate.isEmpty(), 'No Records To Update');
System.debug('IMS Details: ' + detailRecordsToUpdate.size());

if(goForUpdate) {
    for (Integer i = 0; i < detailRecordsToUpdate.size(); i++) {
		   detailRecordsToUpdate[i].Length__c = 'N/A';       
    }
    
    try {
      update detailRecordsToUpdate;    
    } catch (DMLException e) {
        system.debug('DML Exception: ' + e);
    }
}