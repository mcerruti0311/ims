// Update Waist to Size Using a Map
boolean goForUpdate = false;
Integer runSize = 2500;

Map<String, String> waistSize = new Map<String, String>{
  '24' => 'XS',
  '26' => 'XS',
  '28' => 'S',
  '30' => 'S',
  '32' => 'M',
  '34' => 'M', 
  '36' => 'L',
  '38' => 'L',
  '40' => 'XL',
  '42' => 'XL',
  '44' => '2XL',
  '46' => '2XL',
  '48' => '3XL',
  '50' => '3XL',
  '52' => '4XL',
  '54' => '4XL'
};

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
AND Uniform_Type__c = 'Belt'
AND Manufacturer_Picklist__c = 'LawPro'
AND Size__c = '32'
ORDER BY Size__c 


LIMIT :runSize    
];


System.assert(itemsToUpdate.size() > 0, 'No Records to Update');

for (Integer i = 0; i < itemsToUpdate.size(); i++) {
    System.debug(i + ': Item ' + itemsToUpdate[i].Name);
}

if (goForUpdate) {
    for (Integer r = 0; r < itemsToUpdate.size(); r++) {
        itemsToUpdate[r].Size__c = waistSize.get(itemsToUpdate[r].Size__c);
        itemsToUpdate[r].Waist__c = '';
    }

    update itemsToUpdate;
}

