SELECT Id,
  IMS_Transaction__r.Employee__r.Name,
  IMS_Transaction__r.Name,
  Name,
  Stocking_Facility__r.Name,
  IMS_Transaction__r.Employee__r.Employee_Number__c,
  Item_Description__c,
  Transaction_Status__c,
  Issued_Date__c,
  Return_Date__c,
  Qty_Issue__c,
  Qty_Returned__c,
  Qty_Balance__c,
  LastModifiedDate
FROM IMS_Transaction_Detail__c
WHERE Transaction_Status__c != 'Canceled'
  AND IMS_Transaction__r.Employee__r.Employee_Number__c = '37176'
ORDER BY Name
