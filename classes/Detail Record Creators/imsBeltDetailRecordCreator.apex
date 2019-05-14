// Variables
boolean goForInsert = true;
String imsName = 'IMS-000000204';
String size = '??';

/* Sizes
{'Short','Regular','Long','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','42','44','46','48','50','52','54','56','58','60'}
*/

List<String> lengths = new List<String>{'26','28','30','32','34','36','38','40','42','44','46','48','50','52','54','56','58','60','62','64','66','68'};

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
            Size__c = lengths.get(i),
            Length__c = 'N/A',
            IMS_Detail_Status__c = 'Active',
            Include_In_Catalog__c = false,
            Update_Online_Catalog__c = false
        );
        
      imsDetailsToInsert.add(imsDetail);
    }
     
    insert imsDetailsToInsert;
} 