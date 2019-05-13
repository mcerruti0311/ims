// beltsToMatch

// Operation Variables
boolean goForUpdate = true;
Integer runSize = 2500;
String imsDetailId = '';

// Uniform Details
String uniformType = 'Belt';
String style = 'N/A';

// Manufacturer Information
// String manufacturer = '5.11 Tactical';
// String manufacturer = 'Boston Leather';
// String manufacturer = 'CTM Uniform';
// String manufacturer = 'TRU-SPEC';
// String manufacturer = 'Uncle Mike\'s';

// Colors
 String color = 'Black';

// Feature
String feature = 'N/A';

// IMS Master
// String imsMasterName = 'IMS-000000022';  // CTM Uniform Leather 1 1/4" Basic Dress Belt Belt BT-ET701 Black Supervisor
// String imsMasterName = 'IMS-000000039';  // 5.11 Tactical TDU 1.5" Wide Belt 59551 Black Specialist
// String imsMasterName = 'IMS-000000053';  // Uncle Mike's Ultra Lined Inner Belt Belt H00 2923 Black Specialist
// String imsMasterName = 'IMS-000000065';  // TRU-SPEC Security Friendly Belt NP989 Black General
// String imsMasterName = 'IMS-000000104';  // Boston Leather 1 1/2" Leather Garrison Belt H02 2396 Black General

// Manufacturer Item Number
// String manufacturerStockNumber = '59551';
// String manufacturerStockNumber = 'BT-ET701';
// String manufacturerStockNumber = 'H00 2923';
// String manufacturerStockNumber = 'H02 2396';
// String manufacturerStockNumber = 'NP989';

// Sub Group
// String subGroup = '';
// String subGroup = 'Specialist';
// String subGroup = 'Supervisor';
// String subGroup = 'General';

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
    AND Uniform_Type__c = 'Belt'
AND Manufacturer_Picklist__c = 'Truspec'

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
