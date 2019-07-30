Boolean goForUpdate = true;
String vendorItemNumber ='JAS535-B';
String imsMasterName = 'IMS-000000226';
String detailVendorItemNumber = '';


Map <String, String> sizeIdentifier = new Map <String, String> {
    'XS' => '01',
    'S' => '02',
    'M' => '03',        
    'L' => '04',
    'XL' => '05',
    '2XL' => '06',
    '3XL' => '07',
    '4XL' => '08',      
    '5XL' => '09',
    '6xL' => '10'
};



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
  ORDER BY Name     
];

System.assert(detailsToUpdate.Size() > 0, 'No Records To Update');

for(Integer c = 0; c < detailsToUpdate.Size(); c++) {
    
  detailVendorItemNumber = vendorItemNumber + sizeIdentifier.get(detailsToUpdate[c].Size__C);  
  System.debug(
      c + 
      ' IMS-Detail: ' + detailsToUpdate[c].Name + 
      ' Size: ' + detailsToUpdate[c].Size__c +
      ' Vendor Item: ' + detailsToUpdate[c].Vendor_Item_Number__c + 
      ' Calculated VIN: ' + detailVendorItemNumber
  );
}



if(goForUpdate) {
    for (Integer i = 0; i < detailsToUpdate.size(); i++) {
		   detailsToUpdate[i].Vendor_Item_Number__c = vendorItemNumber + sizeIdentifier.get(detailsToUpdate[i].Size__C);       
    }
    
    try {
      update detailsToUpdate;    
    } catch (DMLException e) {
        system.debug('DML Exception: ' + e);
    }
}

