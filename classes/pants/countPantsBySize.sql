SELECT Waist__c, Length__c,
  Count(Id)
FROM Uniform_Stock_Database__c

WHERE Retired_Item__c
= false
    AND IMS_Detail__c = ''
    AND Uniform_Type__c= 'Pants'
    AND Manufacturer_Picklist__c = '5.11'
    AND
(Manufacturer_Stock_Number_Picklist__c = 'TT824' or Manufacturer_Stock_Number_Picklist__c = '74434')
    AND Description__c LIKE '%Khaki%'

GROUP BY Waist__c, Length__c