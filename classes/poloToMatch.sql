SELECT Id,
  Name,
  Uniform_Type__c,
  Manufacturer_Picklist__c,
  Manufacturer_xxx__c,
  Description__c,
  Manufacturer_Stock_Number_Picklist__c,
  IMS_Detail__c,
  IMS_Detail__r.Item_Description__c,
  Size__c

FROM Uniform_Stock_Database__c
WHERE Retired_Item__c
= false
AND IMS_Detail__c = ''
    AND Uniform_Type__c = 'Polo'
    AND Size__c != '' 
    AND Manufacturer_Picklist__c LIKE 'Port Authority'
    AND
(Manufacturer_Stock_Number_Picklist__c = '')
    AND Description__c LIKE '%black%long%beats%'

ORDER BY Size__c

ORDER BY Size__c