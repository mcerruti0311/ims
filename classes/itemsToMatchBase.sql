SELECT Id,
    Name,
    Uniform_Type__c,
    Manufacturer_Picklist__c,
    Manufacturer_xxx__c,
    Description__c,
    Manufacturer_Stock_Number_Picklist__c,
    IMS_Detail__c,
    IMS_Detail__r.Item_Description__c,
    Size__c,
    Waist__c,
    Length__c

FROM Uniform_Stock_Database__c
WHERE Retired_Item__c = false
    AND Uniform_Currently_Issued__c = false
    AND Uniform_Type__c = 'Pants'
    AND Manufacturer_Picklist__c = 'LawPro'
    AND Manufacturer_Stock_Number_Picklist__c = 'TU176'
    AND Length__c != ''
    AND Waist__c != ''
    AND IMS_Detail__c = ''
ORDER BY Size__c, Waist__c, Length__c