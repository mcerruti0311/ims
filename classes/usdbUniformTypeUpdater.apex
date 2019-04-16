boolean goForUpdate = true;
Integer runSize = 250;

String uniformType = 'Shirt';

List<Uniform_Stock_Database__c> itemsToUpdate = [
SELECT Name,
    Uniform_Type__c,
    Description__c,
    Manufacturer_Stock_Number_Picklist__c,
    IMS_Detail__c,
    Size__c
FROM Uniform_Stock_Database__c
WHERE Retired_Item__c = false
AND IMS_Detail__c = ''
    AND Uniform_Type__c = 'Polo'
    AND Size__c = :size
    AND Manufacturer_Picklist__c LIKE 'Truspec'
    AND (Manufacturer_Stock_Number_Picklist__c LIKE '4357')
    AND (Description__c LIKE '%%')

ORDER BY Size__c
LIMIT :runSize    
];

System.assert(itemsToUpdate.size() > 0, 'No Records to Update');

for (Integer i = 0; i < itemsToUpdate.size(); i++) {
    System.debug(i + ': Item ' + itemsToUpdate[i].Name);
}

if (goForUpdate) {
    for (Integer r = 0; r < itemsToUpdate.size(); r++) {
        itemsToUpdate[r].Uniform_Type__c = uniformType;
    }
    update itemsToUpdate;
}