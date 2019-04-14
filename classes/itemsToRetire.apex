boolean goForUpdate = true;
Integer runSize = 250;

List<Uniform_Stock_Database__c> itemsToUpdate = [
SELECT Name,
    Uniform_Type__c,
    Description__c,
    Manufacturer_Stock_Number_Picklist__c,
    IMS_Detail__c,
    Size__c,
    Waist__c,
    Length__c
FROM Uniform_Stock_Database__c
WHERE Retired_Item__c = false
    AND IMS_Detail__c = ''
    AND Uniform_Type__c = 'Pants'
    AND (Description__c LIKE '%Straight High Rise Khaki Pants%')


ORDER BY Waist__c, Length__c
LIMIT :runSize    
];


System.assert(itemsToUpdate.size() > 0, 'No Records to Update');

for (Integer i = 0; i < itemsToUpdate.size(); i++) {
    System.debug(i + ': Item ' + itemsToUpdate[i].Name);
}

if (goForUpdate) {
    for (Integer r = 0; r < itemsToUpdate.size(); r++) {
        itemsToUpdate[r].Retired_Item__c = true;
        itemsToUpdate[r].Retired_Reason__c = 'Active - Not Retired';
    }

    update itemsToUpdate;
}

