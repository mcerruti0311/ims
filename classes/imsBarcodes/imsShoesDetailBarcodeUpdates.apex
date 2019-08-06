Boolean goForUpdate = true;
Integer runSize = 25;
String vendorItemNumber ='FSP620-B';
String imsMasterName = 'IMS-000000225';
String detailVendorItemNumber = '';
String length = '';

List <IMS_Detail__c> detailsToUpdate = [
  SELECT Id,
    Name,
    IMS_Master__r.Name,
    Size__c,
    Length__c,
    Vendor_Item_Number__c
  FROM IMS_Detail__c
  WHERE IMS_Master__r.Name = :imsMasterName
  	AND IMS_Detail_Status__c != 'Void'
    AND Vendor_Item_Number__c = ''
  ORDER BY Name     
  LIMIT :runSize  
];

System.assert(detailsToUpdate.Size() > 0, 'No Records To Update');

for(Integer c = 0; c < detailsToUpdate.Size(); c++) {

    length = detailsToUpdate[c].Length__c;

    detailVendorItemNumber = vendorItemNumber + detailsToUpdate[c].Size__c + length;  

  System.debug(
      c + 
      ' IMS-Detail: ' + detailsToUpdate[c].Name + 
      ' Size: ' + detailsToUpdate[c].Size__c +
      ' Length: ' + detailsToUpdate[c].Length__c +
      ' Vendor Item: ' + detailsToUpdate[c].Vendor_Item_Number__c + 
      ' Calculated VIN: ' + detailVendorItemNumber
  );
}

if(goForUpdate) {
    for (Integer i = 0; i < detailsToUpdate.size(); i++) {
    
      length = detailsToUpdate[i].Length__c;
       
		  detailsToUpdate[i].Vendor_Item_Number__c = detailVendorItemNumber = vendorItemNumber + detailsToUpdate[i].Size__c + length;       
    }
    
    try {
      update detailsToUpdate;    
    } catch (DMLException e) {
        system.debug('DML Exception: ' + e);
    }
}

