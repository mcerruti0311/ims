SELECT Uniform_Type__c, Count(Id)
FROM Uniform_Stock_Database__c
WHERE Retired_Item__c = false
    AND IMS_Detail__c = ''
    AND Uniform_Type__c != ''
    AND (Size__c != '' OR Waist__c != '' OR Length__c != '')
    AND Manufacturer_Picklist__c != ''
    AND Manufacturer_Stock_Number_Picklist__c != ''
GROUP BY Uniform_Type__c