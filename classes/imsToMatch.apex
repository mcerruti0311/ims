// Magic Variables
boolean goForUpdate = true;
Integer runSize = 250;
String imsDetail = '';
String uniformType = 'Pants';
String imsDetailId = '';
String usdbDescription = '';

// Manufacturer Stock Number
String manufacturerStockNumber = '74273';

// color
String color = 'Khaki';

// Size
String size = '';

// Waist
String waist = '';
// Length
String length = 'Regular';

// Size setting
String imsSize = waist;

// Manufacturer
String manufacturer = 'Truspec';

String imsDescription = '%' + manufacturerStockNumber + ' ' + color + '%';


List <String> usdbDescriptions = new List<String>();
usdbDescriptions.add('True Spec 24-7 Series Teflon Coated Black Pants');
usdbDescriptions.add('Unassigned Barcode');  
usdbDescriptions.add('Grey Trouser% AMPAS');  
usdbDescriptions.add('ampas dress pants');

System.debug(usdbDescriptions.size());
System.debug(usdbDescriptions.get(0));


for (Integer i = 0; i < usdbDescriptions.size() ; i++) {
    if (i == 0) {
     usdbDescription += usdbDescriptions.get(i); 
    }    
    if (i > 0) {
        usdbDescription += ', ' + usdbDescriptions.get(i);   
    }

}    

System.debug(usdbDescription);

List<IMS_Detail__c> imsDetails = [
    SELECT Id
    FROM IMS_Detail__c
    WHERE Size__c = :imsSize
        AND Length__c = :length
        AND Item_Description__c LIKE :imsDescription
        AND IMS_Master__r.Color__c = :color
        AND IMS_Master__r.Type__c = :uniformType
        AND IMS_Detail_Status__c != 'Void'
	];


system.debug('Size: ' + imsDetails.size());
System.assert(imsDetails.size() == 1, 'IMS Detail Records Returned Not Equal to 1: ' + imsDetails.size());

imsDetailId = imsDetails[0].Id;

System.debug('IMS Detail Id: ' + imsDetailId);

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
    AND (NOT Location_Data__r.Name LIKE '%github%')
    AND Manufacturer_Picklist__c = :manufacturer
    AND Uniform_Type__c = :uniformType
    AND Size__c = :size
    AND Waist__c = :waist
    AND Length__c = :length
    AND (
         Description__c LIKE :usdbDescriptions.get(0) or 
         Description__c LIKE :usdbDescriptions.get(1) or 
         Description__c LIKE :usdbDescriptions.get(2) or 
         Description__c LIKE :usdbDescriptions.get(3) 
    )
 
ORDER BY Waist__c, Length__c
LIMIT :runSize    
];


System.assert(itemsToUpdate.size() > 0, 'No Records to Update');

for (Integer i = 0; i < itemsToUpdate.size(); i++) {
    System.debug(i + ': Item ' + itemsToUpdate[i].Name);
}

if (goForUpdate) {
    for (Integer r = 0; r < itemsToUpdate.size(); r++) {
        itemsToUpdate[r].Manufacturer_Stock_Number_Picklist__c = manufacturerStockNumber;
        itemsToUpdate[r].IMS_Detail__c = imsDetailId;
    }

    update itemsToUpdate;
}

