// shoesToMatch

// Operation Variables
boolean goForUpdate = true;
Integer runSize = 2500;
String imsDetailId = '';

// Uniform Type
String uniformType = 'Shoes';

// Uniform Style
// String style = 'N/A';
String style = 'Boot';
// String style = 'Mid Top';
// String style = 'Low Top';

// Manufacturer Information
// String manufacturer = '5.11 Tactical';
String manufacturer = 'Bates Footwear';
// String manufacturer = 'LawPro Uni';
// String manufacturer = 'Original SWAT';
// String manufacturer = 'Port Authority';
// String manufacturer = 'LOWA Boots LLC';
// String manufacturer = 'Nike';
// String manufacturer = 'Galls';

// Colors
String color = 'Black';
// String color = 'Khaki';

// Feature
String feature = 'N/A';

// IMS Master
// String imsMasterName = 'IMS-000000018';  // Monarch IV Low Top Shoes 415445-001 Black General

// String imsMasterName = 'IMS-000000024';  // G-TAC Athletic 8" Side-Zip Waterproof Boot Shoes FX280 Black General

// String imsMasterName = 'IMS-000000048';  // Uni 8" Dispatch 2.0 Side-Zip Boot Shoes FW659 Black General

// String imsMasterName = 'IMS-000000067';  // TaskForce Zephyr Desert GTX 9" High Boot Shoes FW218 Black General

String imsMasterName = 'IMS-000000070';  //  8" GX Side Zip Gore-Tex Boot Shoes H00 2731 Black General

// String imsMasterName = 'IMS-000000071';  //  TaskForce Zephyr Desert GTX 9" High Boot Boot Shoes FW218 Khaki General

// String imsMasterName = 'IMS-000000078';  // 8" Stellar Boot Shoes FX099 Black General

// String imsMasterName = 'IMS-000000100';  // Men's Air Monarch IV Low Top Shoes H03 6830 Black General

// String imsMasterName = 'IMS-000000146';  // SWomen's 9" Side Zip Boot Shoes H00 2362 Black General

// String imsMasterName = 'IMS-000000147';  // CLASSIC 9" SZ SAFETY PLUS Boot Shoes 116001 Black General



// Manufacturer Item Number
// String manufacturerStockNumber = '116001';
// String manufacturerStockNumber = '415445-001';
// String manufacturerStockNumber = 'FW218';
// String manufacturerStockNumber = 'FW659';
// String manufacturerStockNumber = 'FX099';
// String manufacturerStockNumber = 'FX280';
// String manufacturerStockNumber = 'H00 2362';
String manufacturerStockNumber = 'H00 2731';
// String manufacturerStockNumber = 'H03 6830';

// Sub Group
// String subGroup = '';
// String subGroup = 'Specialist';
// String subGroup = 'Supervisor';
String subGroup = 'General';

// Description string in WHERE Clasue for imsDetails
String imsDescription = '%' + manufacturerStockNumber + ' ' + color + '%';

// Create Size Array
// {'4','4.5', '5','5.5','6','6.5','7','7.5','8','8.5','9','9.5','10','10.5','11','11.5','12','13','14','15','16'}

List<String> sizes = new List<String>{'5','5.5','6','7','7.5','8','8.5','9','9.5','10','10.5','11','11.5','12','13','14','15','16'};
    
// Length 
String length = '';
// String length = 'N/A';
        
for (Integer s = 0 ; s < sizes.size() ; s++) {
List<IMS_Detail__c> imsDetails = [
    SELECT Id
    FROM IMS_Detail__c
    WHERE Size__c = :sizes.get(s)
        AND Length__c = :length
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
    Length__c,
    Location_Data__r.Name

FROM Uniform_Stock_Database__c
WHERE Retired_Item__c = false
AND IMS_Detail__c != ''
AND Uniform_Type__c= 'Shoes'
AND Manufacturer_Picklist__c = 'Bates'
AND Manufacturer_Stock_Number_Picklist__c != ''
    AND Size__c = :sizes.get(s)
	ORDER BY Size__c
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
