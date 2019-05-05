// blazerToMatch

// Operation Variables
boolean goForUpdate = true;
Integer runSize = 2500;
String imsDetailId = '';

// Uniform Details
String uniformType = 'Jacket';
String style = 'Blazer';

// Manufacturer Information
String manufacturer = 'LawPro Uni';

// Colors
 String color = 'Black';

// Feature
String feature = 'N/A';

// IMS Master
 String imsMasterName = 'IMS-000000151';  

// Manufacturer Item Number
 String manufacturerStockNumber = 'JA317';

// Sub Group
// String subGroup = '';
// String subGroup = 'Specialist';
// String subGroup = 'Supervisor';
 String subGroup = 'General';

// Description string in WHERE Clasue for imsDetails
String imsDescription = '%' + manufacturerStockNumber + ' ' + color + '%';

// Create Size Array
// {'4','6','8','10','12','14','16','18','20','22','24','26','28','36','38',
//	'40','42','44','46','48','50','52','54','56','60', '62'           
//    }

List<String> sizes = new List<String>{'40','42','46','48'};
    
// Length 

// String length = 'Long';
 String length = 'Regular';
// String length = 'Short';
        

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
    AND Uniform_Type__c = 'Blazer'

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
