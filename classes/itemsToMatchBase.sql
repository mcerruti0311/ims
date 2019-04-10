SELECT Id,
    Name,
    Uniform_Type__c,
    Description__c,
    Manufacturer_Stock_Number_Picklist__c,
    IMS_Detail__c,
    IMS_Detail__r.Item_Description__c,
    Size__c,
    Waist__c,
    Length__c
FROM Uniform_Stock_Database__c
WHERE Retired_Item__c = false
    AND (NOT Location_Data__r.Name LIKE '%github%')
    AND Manufacturer_Picklist__c = '5.11'
    AND Manufacturer_Stock_Number_Picklist__c = ''
    AND Uniform_Type__c = 'Pants'
    AND Size__c = ''
    AND Waist__c != ''
    AND Length__c != ''
    AND IMS_Detail__c = ''
    AND Manufacturer_Stock_Number_Picklist__c = ''
    AND (Description__c LIKE '%')
ORDER BY Waist__c, Length__c
