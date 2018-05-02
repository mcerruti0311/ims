SELECT IMS_Master__r.Billing_Location__r.Client_from_Parent__c,
  IMS_Master__r.Billing_Location__r.Job_From_Name__c,
  IMS_Master__r.Product_Name__c,
  IMS_Master__r.Manufacturer__r.Name,
  IMS_Master__r.Manufacturer_Number__c,
  IMS_Master__r.Feature__c,
  IMS_Master__r.Color__c,
  IMS_Master__r.IMS_Build__r.Logo_1__c,
  IMS_Master__r.IMS_Build__r.Logo_Location_1__c,
  IMS_Master__r.IMS_Build__r.Logo_2__c,
  IMS_Master__r.IMS_Build__r.Logo_Location_2__c,
  IMS_Master__r.IMS_Build__r.Logo_3__c,
  IMS_Master__r.IMS_Build__r.Logo_Location_3__c,
  Size__c,
  IMS_Master__r.Class__c,
  IMS_Master__r.Category__c,
  IMS_Master__r.Group__c,
  IMS_Master__r.Sub_Group__c
FROM IMS_Detail__c
WHERE RecordType.Name = 'Clothing'
  AND IMS_Detail_Status__c != 'Retired'
