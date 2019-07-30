Boolean goForUpdate = true;
Integer runSize = 15;
String vendorItemNumber ='PTR506-B';
String imsMasterName = 'IMS-000000029';
String detailVendorItemNumber = '';
String length = '';
String size = '36';


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
    AND Size__c = :size
  ORDER BY Name     
  LIMIT :runSize  
];

System.assert(detailsToUpdate.Size() > 0, 'No Records To Update');

for(Integer c = 0; c < detailsToUpdate.Size(); c++) {
    if(detailsToUpdate[c].Length__c == 'Unhemmed') {
        length = 'U';
            } 
    else if (detailsToUpdate[c].Length__c == 'Regular') {
        length = 'R';
    }
    else if (detailsToUpdate[c].Length__c == 'Long') {
        length = 'L';
    }
    	else {
                length = detailsToUpdate[c].Length__c;
    	} 

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
      if(detailsToUpdate[i].Length__c == 'Unhemmed') {
        length = 'U';
            } 
        else if (detailsToUpdate[i].Length__c == 'Regular') {
        length = 'R';    
        }
        else if (detailsToUpdate[i].Length__c == 'Long') {
        length = 'L';    
        }
        else {
          length = detailsToUpdate[i].Length__c;
        } 
		  detailsToUpdate[i].Vendor_Item_Number__c = detailVendorItemNumber = vendorItemNumber + detailsToUpdate[i].Size__c + length;       
    }
    
    try {
      update detailsToUpdate;    
    } catch (DMLException e) {
        system.debug('DML Exception: ' + e);
    }
}

