// jacketToMatch

// Operation Variables
boolean goForUpdate = true;
Integer runSize = 2500;
String imsDetailId = '';

// Uniform Details
String uniformType = 'Jacket';

// Style
// String style = 'Blazer';
// String style = 'Other';
// String style = 'Parka';
// String style = 'Rain';
String style = 'Soft Shell';
// String style = 'Windbreaker';

// Manufacturer Information
// String manufacturer = '5.11 Tactical';
// String manufacturer = 'Galls';
// String manufacturer = 'LawPro Uni';
String manufacturer = 'Port Authority';
// String manufacturer = 'TRU-SPEC';

// Colors
String color = 'Black';
// String color = 'Battleship Grey';
// String color = 'Estate Blue';

// Feature
String feature = 'N/A';

// IMS Master
// String imsMasterName = 'IMS-000000020';  // Galls 3 in 1 System Parka Jacket JA787 Black 26000 - Amazon SLU General
// String imsMasterName = 'IMS-000000049';  // Port Authority Herringbone 3-in-1 Parka SIS LOGO Black/Gold Other Jacket J302 Black General
// String imsMasterName = 'IMS-000000059';  // Port Authority Textured Soft Shell Windbreaker Jacket J705 Black 20000 - Apple Cupertino General
// String imsMasterName = 'IMS-000000075';  // 5.11 Tactical Tactical 5 in 1 Jacket Other Jacket JA432 Black 20900 - Apple Reno General
// String imsMasterName = 'IMS-000000086';  // Port Authority Welded Soft Shell Jacket Jacket J324 Battleship Grey 24900 - Pegatron Elk Grove Supervisor
// String imsMasterName = 'IMS-000000087';  // Port Authority Welded Soft Shell Jacket Jacket J324 Battleship Grey 24900 - Pegatron Elk Grove Supervisor
// String imsMasterName = 'IMS-000000098';  // Port Authority Unisex Adult Textured Soft Shell Jacket J705 Black 25150 - Beats CC General
// String imsMasterName = 'IMS-000000151';  // LawPro Uni Edwards Men's Value Polyester Blazer Jacket JA317 Black 59800 - AMPAS Master General
// String imsMasterName = 'IMS-000000152';  // LawPro Uni Security Windbreaker Jacket JC644 Black 59800 - AMPAS Master General
// String imsMasterName = 'IMS-000000153';  // LawPro Uni Centurion Duty Rain Jacket 10-104 Black 59800 - AMPAS Master
// String imsMasterName = 'IMS-000000200';  // TRU-SPEC H2O Proof 3-in-1 Rain Jacket JX304 Black General
// String imsMasterName = 'IMS-000000201';  // TRU-SPEC H2O Proof All Season Rain Jacket 2402003 Black General
// String imsMasterName = 'IMS-000000206';  // Port Authority Textured Soft Shell Jacket J705 Black 20600 - Apple Elk Grove General
String imsMasterName = 'IMS-000000207';  // Port Authority Textured Soft Shell Jacket J705 Black ODO

// Manufacturer Item Number
// String manufacturerStockNumber = '10-104';
// String manufacturerStockNumber = '2402003';
// String manufacturerStockNumber = 'J302';
// String manufacturerStockNumber = 'J302';
// String manufacturerStockNumber = 'J324';
String manufacturerStockNumber = 'J705';
// String manufacturerStockNumber = 'JA317';
// String manufacturerStockNumber = 'JA787';
// String manufacturerStockNumber = 'JC644';
// String manufacturerStockNumber = 'JX304';


// Sub Group
// String subGroup = '';
// String subGroup = 'General';
String subGroup = 'ODO';
// String subGroup = 'Specialist';
// String subGroup = 'Supervisor';

// Length 
// String length = '';
// String length = 'Long';
String length = 'N/A';
// String length = 'Regular';
// String length = 'Short';

// Description string in WHERE Clasue for imsDetails
String imsDescription = '%' + manufacturerStockNumber + ' ' + color + '%';

// Create Size Array
// {'XS','S','M','L','XL','2XL','3XL','4XL','5XL','6XL'}
// {'4','6','20','36','38','40','42','50','62'}

List<String> sizes = new List<String>{'L','XL','2XL'};
    
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
    AND IMS_Detail__c = ''
    AND Uniform_Type__c= 'Jacket'
    AND Manufacturer_Picklist__c = 'Port Authority'
    AND Manufacturer_Stock_Number_Picklist__c = 'J705'
    
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
