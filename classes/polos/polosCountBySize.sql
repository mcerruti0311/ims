SELECT Size__c,
    Count(Id)
FROM Uniform_Stock_Database__c

WHERE Retired_Item__c
= false
  AND IMS_Detail__c = ''
  AND Uniform_Type__c = 'Polo'
  AND Manufacturer_Picklist__c = 'Sport-Tek'
  AND Manufacturer_Stock_Number_Picklist__c != ''
  AND Description__c LIKE '%SS%'
GROUP BY Size__c