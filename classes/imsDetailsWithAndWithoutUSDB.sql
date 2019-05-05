-- With and Without USDB related records
SELECT
  Id,
  Name,
  IMS_Master__r.Name,
  IMS_Detail_Status__c,
  (
    SELECT IMS_Detail__c

  FROM Uniform_Stock_Databases__r
  )
FROM IMS_Detail__c
WHERE IMS_Master__r.Name IN 
  (
    'IMS-000000045', 
    'IMS-000000046'
  )
  AND IMS_Detail_Status__c = 'Active'