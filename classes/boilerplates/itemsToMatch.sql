SELECT Id, 
Name, 
Uniform_Type__c,
Manufacturer_Picklist__c,
Description__c,
Manufacturer_Stock_Number_Picklist__c,
IMS_Detail__c,
IMS_Detail__r.Item_Description__c,
Size__c,
Waist__c,
Length__c
FROM Uniform_Stock_Database__c
WHERE Retired_Item__c = false
    AND IMS_Detail__c = ''
    AND Uniform_Type__c= 'Belts'
    AND Manufacturer_Picklist__c != ''
    AND Manufacturer_Stock_Number_Picklist__c = ''
    AND Size__c != ''
    AND Waist__c != ''
    AND Length__c != ''
    AND
(Description__c LIKE '%') 
