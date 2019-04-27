SELECT Waist__c,
  Count(Id)
FROM Uniform_Stock_Database__c

WHERE Retired_Item__c
= false
    AND IMS_Detail__c = ''
    AND Uniform_Type__c = 'Pants'
    AND Manufacturer_Picklist__c LIKE '5.11'
    AND
(Description__c LIKE '%apex%')

GROUP BY Waist__c