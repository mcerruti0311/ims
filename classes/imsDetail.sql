SELECT Id,
  IMS_Master__r.Manufacturer__r.Name,
  IMS_Master__r.Manufacturer_Number__c,
  IMS_Master__r.Name,
  Name,
  IMS_Master__r.Color__c,
  IMS_Master__r.Style__c,
  IMS_Master__r.Feature__c,
  Size__c,
  Length__c,
  Item_Description__c
FROM IMS_Detail__c
WHERE IMS_Master__r.Name = 'IMS-000000039'
ORDER BY Size__c, Length__c
