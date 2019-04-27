// IMS Detail Creator for Uniforms with Size variable
// Variables
boolean goForInsert = true;
String imsName = 'IMS-000000200';

/* Sizes
{'XS','S','M','L','XL','2XL','3XL','4XL','5XL','6XL'}
*/

List<String> sizes = new List<String>{'XS','S','M','L','XL','2XL','5XL'};

List<IMS__c> imsMaster = [
  SELECT Id
  FROM IMS__c
  WHERE Name = :imsName
];

System.debug(imsMaster.get(0).Id);

List<IMS_Detail__c> imsDetailsToInsert = new List<IMS_Detail__c>();

if (goForInsert) {
  for (Integer i = 0; i < sizes.size() ; i++) {

        IMS_Detail__c imsDetail = new IMS_Detail__c (
            IMS_Master__c = imsMaster.get(0).Id,
            Size__c = sizes.get(i),
            Length__c = 'N/A', 
            IMS_Detail_Status__c = 'Active',
            Include_In_Catalog__c = true,
            Update_Online_Catalog__c = true
        );
        
      imsDetailsToInsert.add(imsDetail);
    }
     
    insert imsDetailsToInsert;
} 