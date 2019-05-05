// beltsToMatch

// Operation Variables
boolean goForUpdate = true;
Integer runSize = 2500;
String imsDetailId = '';

// Uniform Details
String uniformType = 'Belt';
String style = 'N/A';

// Manufacturer Information
String manufacturer = 'TRU-SPEC';

// Colors
 String color = 'Black';

// Feature
String feature = 'N/A';

// IMS Master
 String imsMasterName = 'IMS-000000065';  // NP989 Black General

// Manufacturer Item Number
 String manufacturerStockNumber = 'NP989';

// Sub Group
// String subGroup = '';
// String subGroup = 'Specialist';
// String subGroup = 'Supervisor';
 String subGroup = 'General';

// Description string in WHERE Clasue for imsDetails
String imsDescription = '%' + manufacturerStockNumber + ' ' + color + '%';

// Create Size Array
// {'XS','S','M','L','XL','2XL','3XL','4XL','5XL','6XL'}

List<String> sizes = new List<String>{'S','M','L','XL','2XL','3XL','4XL'};

for (Integer s = 0 ; s < sizes.size() ; s++) {
List<IMS_Detail__c> imsDetails = [
    SELECT Id
    FROM IMS_Detail__c
    WHERE Size__c = :sizes.get(s)
        AND Item_Description__c LIKE :imsDescription
        AND IMS_Master__r.Name = :imsMasterName
        AND IMS_Master__r.Sub_Group__c = :subGroup
        AND IMS_Master__r.Color__c = :color
        AND IMS_Master__r.Type__c = :uniformType
        AND IMS_Master__r.Feature__c = :feature
        AND IMS_Master__r.Manufacturer__r.Name = :manufacturer
        AND IMS_Master__r.Manufacturer_Number__c = :manufacturerStockNumber
        AND IMS_Master__r.Style__c = :style
        AND IMS_Master__r.Item_Status__c = 'Active'
        AND IMS_Detail_Status__c != 'Void'
	];

system.debug('Size: ' + imsDetails.size());
System.assert(imsDetails.size() == 1, 'IMS Detail Records Returned Not Equal to 1: ' + imsDetails.size() + ' for ' + sizes.get(s));

imsDetailId = imsDetails[0].Id;

System.debug('IMS Detail Id: ' + imsDetailId);


    List<Uniform_Stock_Database__c> itemsToUpdate = [
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
  Location_Data__r.Name

FROM Uniform_Stock_Database__c
WHERE Retired_Item__c = false
AND IMS_Detail__c = ''
AND Uniform_Type__c= 'Belt'
AND Manufacturer_Picklist__c = ''
AND Size__c != ''

        AND Size__c = :sizes.get(s)

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
        try {
        update itemsToUpdate;

        } catch (DmlException e) {
            System.debug('DML Exception: ' + e);
        }

    }
}
