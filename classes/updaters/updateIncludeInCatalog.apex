Boolean goForUpdate = true;
String imsMasterName = 'IMS-000000247';
Boolean includeInCatalog = false;
Boolean updateOnLineCatog = false;

List <IMS_Detail__c> detailsToUpdate = [
  SELECT Id,
    Name,
    IMS_Master__r.Name,
    Size__c,
    Length__c,
    Vendor_Item_Number__c,
    Include_In_Catalog__c,
    Update_Online_Catalog__c
    
  FROM IMS_Detail__c
  WHERE IMS_Master__r.Name = :imsMasterName
  	AND IMS_Detail_Status__c != 'Void'
  ORDER BY Name     
];

System.assert(detailsToUpdate.Size() > 0, 'No Records To Update');

for(Integer c = 0; c < detailsToUpdate.Size(); c++) { 
  System.debug(
      c + 
      ' IMS-Detail: ' + detailsToUpdate[c].Name 
  );
}


if(goForUpdate) {
    for (Integer i = 0; i < detailsToUpdate.size(); i++) {
		   detailsToUpdate[i].Include_In_Catalog__c = includeInCatalog;
       detailsToUpdate[i].Update_Online_Catalog__c = updateOnLineCatog;                  
    }
    
    try {
      update detailsToUpdate;    
    } catch (DMLException e) {
        system.debug('DML Exception: ' + e);
    }
}

