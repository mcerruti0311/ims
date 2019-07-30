// Pants IMS Detail Creator for Uniforms with Size variable

// Variables
boolean goForInsert = true;
String imsName = 'IMS-000000029';

/* Sizes
{'28','29','30','32','34','36','38','40','42','44','46','48','50','52','54','56'}
*/
List<String> sizes = new List<String>{'32'};

/* Lengths
   {'25','26','27','28','30','32','33','34','36','Unhemmed'}
*/
List<String> lengths = new List<String>{'27','29','29.5','33','38','40','Unhemmed'};

List<IMS__c> imsMaster = [
  SELECT Id
  FROM IMS__c
  WHERE Name = :imsName
];

System.debug(imsMaster.get(0).Id);

List<IMS_Detail__c> imsDetailsToInsert = new List<IMS_Detail__c>();

if (goForInsert) {
  for (Integer s = 0; s < sizes.size() ; s++) {
    for (Integer l = 0; l < lengths.size() ; l++) {
        IMS_Detail__c imsDetail = new IMS_Detail__c (
            IMS_Master__c = imsMaster.get(0).Id,
            Size__c = sizes.get(s),
            Length__c = lengths.get(l), 
            IMS_Detail_Status__c = 'Active',
            Include_In_Catalog__c = true,
            Update_Online_Catalog__c = true
        );
        
      imsDetailsToInsert.add(imsDetail);
    }  
  }

  try {
        insert imsDetailsToInsert;

        } catch (DmlException e) {
            System.debug('DML Exception: ' + e);
        }
    
} 