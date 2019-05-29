// polosToMatch

// Operation Variables
boolean goForUpdate = true;
Integer runSize = 2500;
String imsDetailId = '';

// Uniform Details
String uniformType = 'Shirt';
String style = 'Polo';

// Manufacturer Information
// String manufacturer = '5.11 Tactical';
// String manufacturer = 'Cornerstone Workwear';
String manufacturer = 'Port Authority';
// String manufacturer = 'Sport-Tek';
// String manufacturer = 'Tri-Mountain Racewear';
// String manufacturer = 'TRU-SPEC';
// String manufacturer = 'West Coast Screen Printing';

// Colors
// String color = 'Black';
// String color = 'Grey';
// String color = 'Navy Blue'
// String color = 'Red';
String color = 'Royal Blue';
// String color = 'White';

// Feature
// String feature = 'Long Sleeve';
String feature = 'Short Sleeve';

// IMS Master
// String imsMasterName = 'IMS-000000000';  // Port Authority Silk Touch Polo Shirt Short Sleeve K500 Black 81000 - Apple Retail Specialist
// String imsMasterName = 'IMS-000000004';  // Port Authority Silk Touch Performance Polo Shirt Short Sleeve K540 Royal Blue 26000 - Amazon SLU Specialist
// String imsMasterName = 'IMS-000000009';  // Port Authority Silk Touch Performance Polo Shirt Long Sleeve K540LS Royal Blue 26000 - Amazon SLU Specialist
// String imsMasterName = 'IMS-000000013';  // Port Authority Silk Touch Performance Polo Shirt Short Sleeve K540 Grey 26000 - Amazon SLU Specialist
String imsMasterName = 'IMS-000000015';  // Port Authority Silk Touch Performance Polo Shirt Short Sleeve K540 Black 26000 - Amazon SLU Specialist
// String imsMasterName = 'IMS-000000033';  // Sport-Tek Micropique Sport-Wick Piped Polo Shirt Long Sleeve ST657 Navy Blue 20000 - Apple Cupertino Specialist
// String imsMasterName = 'IMS-000000058';  // Port Authority Silk Touch Performance Polo Shirt Long Sleeve K540LS White 20700 - Apple Austin Specialist
// String imsMasterName = 'IMS-000000084';  // Port Authority Silk Touch Polo Shirt Short Sleeve K500 Royal Blue 24900 - Pegatron Elk Grove Specialist
// String imsMasterName = 'IMS-000000117';  // Cornerstone Workwear Select Snag-Proof Tactical Polo Shirt Short Sleeve CS410 White 20300 - Apple Maiden Specialist
// String imsMasterName = 'IMS-000000119';  // Cornerstone Workwear Select Snag-Proof Tactical Polo Shirt Short Sleeve CS410 Black 20300 - Apple Maiden Supervisor
// String imsMasterName = 'IMS-000000123';  // Port Authority Silk Touch Performance Polo Shirt Short Sleeve K540 Black 81501 - Retail - Apple - CA - Northern General
// String imsMasterName = 'IMS-000000127';  // Short Sleeve 4326 White 20000 - Apple Cupertino Specialist
// String imsMasterName = 'IMS-000000128';  // Short Sleeve 4326 White 20000 - Apple Cupertino Specialist
// String imsMasterName = 'IMS-000000129';  // Short Sleeve 4328 Black 20000 - Apple Cupertino
// String imsMasterName = 'IMS-000000130';  // Long Sleeve 4357 Black 20000 - Apple Cupertino
// String imsMasterName = 'IMS-000000188';  // Port Authority Silk Touch Performance Polo Shirt Long Sleeve K540LS Black 81501 - Retail - Apple - CA - Northern General
// String imsMasterName = 'IMS-000000189';  // Port Authority Silk Touch Performance Polo Shirt Short Sleeve K540 White 81501 - Retail - Apple - CA - Northern General
// String imsMasterName = 'IMS-000000191';  // Long Sleeve 4357 White 20000 - Apple Cupertino
// String imsMasterName = 'IMS-000000192';  // Short Sleeve 4357 White 20000 - Apple Cupertino
// String imsMasterName = 'IMS-000000193';  // Short Sleeve 4328 White 20000 - Apple Cupertino Specialist
// String imsMasterName = 'IMS-000000198';  // Long Sleeve 4357 Grey 20000 - Apple Cupertino
// String imsMasterName = 'IMS-000000199';  // Short Sleeve 4357 Grey 20000 - Apple Cupertino
// String imsMasterName = 'IMS-000000210';  // Port Authority Silk Touch Performance Polo Shirt Long Sleeve K540LS Grey 33400 - Rakuten Inc. San Mateo, CA Specialist

// Manufacturer Item Number
// String manufacturerStockNumber = '4326';
// String manufacturerStockNumber = '4328';
// String manufacturerStockNumber = '4357';
// String manufacturerStockNumber = '4359';
// String manufacturerStockNumber = 'CS410';
// String manufacturerStockNumber = 'K500';
String manufacturerStockNumber = 'K540';
// String manufacturerStockNumber = 'K540LS';
// String manufacturerStockNumber = 'ST657';

// Sub Group
// String subGroup = '';
// String subGroup = 'General';
String subGroup = 'Specialist';
// String subGroup = 'Supervisor';

// Description string in WHERE Clasue for imsDetails
String imsDescription = '%' + manufacturerStockNumber + ' ' + color + '%';

// Create Size Array
// {'XS','S','M','L','XL','2XL','3XL','4XL','5XL','6XL'}

List<String> sizes = new List<String>{'XL','3XL'};

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
    AND Uniform_Type__c= 'Polo'
    AND Manufacturer_Picklist__c = 'Cornerstone'
    AND Manufacturer_Stock_Number_Picklist__c = ''
    AND Description__c LIKE '%'
    
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
