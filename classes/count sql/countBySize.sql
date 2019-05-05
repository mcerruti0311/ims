SELECT Size__c,
  Count(Id)
FROM Uniform_Stock_Database__c

WHERE Retired_Item__c
= false
AND IMS_Detail__c = ''
    AND Uniform_Type__c = 'Polo'
    AND Manufacturer_Picklist__c = 'Port Authority'
    AND Description__c LIKE '%Black%LS%'
    AND Size__c != ''    
 
GROUP BY Size__c