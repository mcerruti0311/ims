SELECT Size__c,
  Count(Id)
FROM Uniform_Stock_Database__c

WHERE Retired_Item__c
= false
    AND IMS_Detail__c = ''
    AND Uniform_Type__c= 'Jacket'
    AND Manufacturer_Picklist__c = 'Port Authority'
    AND Manufacturer_Stock_Number_Picklist__c = 'J324'
    AND Size__c != ''
    AND
(Description__c LIKE '%Grey%') 
    AND Location_Data__r.Name LIKE '%Apple%'
 
GROUP BY Size__c