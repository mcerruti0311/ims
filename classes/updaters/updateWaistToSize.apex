// Update Waist to Size
boolean goForUpdate = false;
Integer runSize = 2500;

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
AND Uniform_Type__c= 'Belt'
AND Waist__c != ''
AND Size__c = ''
ORDER BY Size__c


LIMIT :runSize    
];


System.assert(itemsToUpdate.size() > 0, 'No Records to Update');

for (Integer i = 0; i < itemsToUpdate.size(); i++) {
    System.debug(i + ': Item ' + itemsToUpdate[i].Name);
}

if (goForUpdate) {
    for (Integer r = 0; r < itemsToUpdate.size(); r++) {
        itemsToUpdate[r].Size__c = itemsToUpdate[r].Waist__c;
        itemsToUpdate[r].Waist__c = '';
    }

    update itemsToUpdate;
}

