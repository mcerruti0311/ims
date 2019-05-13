SELECT Size__c,
  Count(Id)
FROM Uniform_Stock_Database__c

WHERE Retired_Item__c
= false
    AND IMS_Detail__c = ''
    AND Uniform_Type__c= 'Jacket'
AND Manufacturer_Picklist__c = 'Galls'
 
GROUP BY Size__c