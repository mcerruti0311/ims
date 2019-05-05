// pantsToMatch

// Operation Variables
boolean goForUpdate = true;
Integer runSize = 2500;
String imsDetailId = '';

// Uniform Tye
String uniformType = 'Pants';

// Style
String style = 'Long';
// String style = 'Shorts';

// Manufacturer Information
// String manufacturer = '5.11 Tactical';
// String manufacturer = 'Galls';
String manufacturer = 'TRU-SPEC';

// Colors
String color = 'Black';
// String color = 'Khaki';
// String color = 'Grey';
// String color = 'Red';
// String color = 'White';

// Feature
String feature = 'N/A';


// IMS Master
// String imsMasterName = 'IMS-000000029';  // 5.11 Tactical Taclite Pro Long Pants 74273 Black Specialist
// String imsMasterName = 'IMS-000000038';  // 5.11 Tactical Apex Long Pants 74434 Khaki Specialist
// String imsMasterName = 'IMS-000000061';  // 5.11 Tactical Men's Ripstop TDU Long Pants 74003 Khaki Specialist
// String imsMasterName = 'IMS-000000091';  // 5.11 Tactical TacLite Pro Women's Ripstop Long Pants 64360 Black Specialist
// String imsMasterName = 'IMS-000000111';  // 5.11 Tactical Taclite Pro Long Pants 74273 Khaki Specialist
// String imsMasterName = 'IMS-000000145';  // TRU-SPEC 24/7 Women's Polyester-Cotton Ripstop Pants TR625 Black Specialist
// String imsMasterName = 'IMS-000000171';  // 5.11 Tactical TacLite Pro Women's Ripstop Long Pants 64360 Khaki Specialist
// String imsMasterName = 'IMS-000000174';  // 5.11 Tactical Apex Long Pants 74434 Black Specialist
// String imsMasterName = 'IMS-000000175';  // 5.11 Tactical Bike Patrol Long Pants TT125 Black Specialist
// String imsMasterName = 'IMS-000000185';  // Galls Tac Force Tactical Long Pants TT784 Khaki General
// String imsMasterName = 'IMS-000000186';  // Galls Women's Tac Force Tactical Long Pants TT846 Khaki General
String imsMasterName = 'IMS-000000187';  // TRU-SPEC 24-7 Ripstop Long Pants TR549 Black Specialist

// Manufacturer Item Number
// String manufacturerStockNumber = '64360';
// String manufacturerStockNumber = '74003';
// String manufacturerStockNumber = '74273';
// String manufacturerStockNumber = '74434';
// String manufacturerStockNumber = 'H02 9672';
String manufacturerStockNumber = 'TR549';
// String manufacturerStockNumber = 'TR625';
// String manufacturerStockNumber = 'TT125';
// String manufacturerStockNumber = 'TT784';
// String manufacturerStockNumber = 'TT846';

// Sub Group
// String subGroup = '';
String subGroup = 'Specialist';
// String subGroup = 'Supervisor';
// String subGroup = 'General';

// Description string in WHERE Clasue for imsDetails
String imsDescription = '%' + manufacturerStockNumber + ' ' + color + '%';

// Create Size Array
// {'','XS','S','M','L','XL','2XL','3XL','4XL','5XL','6XL'}
// {'28','30','32','34','36','38','42','44'}

List<String> sizes = new List<String>{'38'};

// Create Length Array
// {'Long','Regular','Short','Unhemmed'}
// {'30','32'}

List<String> lengths = new List<String>{'28'};


for (Integer s = 0 ; s < sizes.size() ; s++) {
for(Integer l = 0 ; l < lengths.size() ; l++) {        
List<IMS_Detail__c> imsDetails = [

    SELECT Id
    FROM IMS_Detail__c
    WHERE Size__c = :sizes.get(s)
        AND Length__c = :lengths.get(l)
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
WHERE Retired_Item__c
= false
    AND IMS_Detail__c = ''
    AND Uniform_Type__c = 'Pants'
    AND Manufacturer_Picklist__c = 'Truspec'
    

    AND Waist__c = :sizes.get(s)
    AND Length__c = :lengths.get(l)

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
}
