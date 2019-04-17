boolean goForUpdate = true;
Integer runSize = 250;
String manufacturerStockNumber = 'K540LS';
String color = 'Navy Blue';
String imsDetail = '';
// String size = '5XL';
String uniformType = 'Shirt';
String feature = 'Long Sleeve';
String style = 'Polo';
String manufacturer = 'Port Authority';
String imsDetailId = '';
String imsMasterName = 'IMS-000000194';

String imsDescription = '%' + manufacturerStockNumber + ' ' + color + '%';

// {'XS','S','M','L','XL','2XL','3XL','4XL'}

List<String> sizes = new List<String>{'S','XL'};

for (Integer s = 0 ; s < sizes.size() ; s++) {
List<IMS_Detail__c> imsDetails = [
    SELECT Id
    FROM IMS_Detail__c
    WHERE Size__c = :sizes.get(s)
        AND Item_Description__c LIKE :imsDescription
        AND IMS_Master__r.Name = :imsMasterName
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
        AND Uniform_Type__c = 'Polo'
        AND Manufacturer_Picklist__c = 'Port Authority'
        AND Manufacturer_Stock_Number_Picklist__c = ''
        AND Description__c LIKE '%apple%navy blue ls%'
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

        update itemsToUpdate;
}
}