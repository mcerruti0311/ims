// Remove all vendor numbers 

// Constants
Boolean goForUpdate = true;
Integer runSize = 500;

// Create List of IMS Detail Records to Update

List<IMS_Detail__c> detailRecordsToUpdate = new List<IMS_Detail__c>();

detailRecordsToUpdate = [
    SELECT Id, 
      IMS_Detail_Status__c,
      Name, 
      Vendor_Item_Number__c
    FROM IMS_Detail__c
    WHERE (IMS_Detail_Status__c != 'Retired' or IMS_Detail_Status__c != 'Void')
      AND Vendor_Item_Number__c != ''
    LIMIT :runSize  
  ];  

System.assert(!detailRecordsToUpdate.isEmpty(), 'No Records To Update');
System.debug('IMS Details: ' + detailRecordsToUpdate.size());

if(goForUpdate) {
    for (Integer i = 0; i < detailRecordsToUpdate.size(); i++) {
		   detailRecordsToUpdate[i].Vendor_Item_Number__c = '';       
    }
    
    try {
      update detailRecordsToUpdate;    
    } catch (DMLException e) {
        system.debug('DML Exception: ' + e);
    }
}