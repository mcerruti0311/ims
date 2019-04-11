// Variables
boolean goForInsert = true;
String imsName = 'IMS-000000150';
String size = '??';

/* Sizes
{'Short','Regular','Long','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40'}
*/

List<String> lengths = new List<String>{'25','26','28','29','30','32','33','34'};

List<IMS__c> imsMaster = [
  SELECT Id
  FROM IMS__c
  WHERE Name = :imsName
];

System.debug(imsMaster.get(0).Id);

List<IMS_Detail__c> imsDetailsToInsert = new List<IMS_Detail__c>();

if (goForInsert) {
  for (Integer i = 0; i < lengths.size() ; i++) {

        IMS_Detail__c imsDetail = new IMS_Detail__c (
            IMS_Master__c = imsMaster.get(0).Id,
            Size__c = size,
            Length__c = lengths.get(i),
            IMS_Detail_Status__c = 'Active',
            Include_In_Catalog__c = true,
            Update_Online_Catalog__c = true
        );
        
      imsDetailsToInsert.add(imsDetail);
    }
     
    insert imsDetailsToInsert;
} 