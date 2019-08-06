// Pants IMS Detail Creator for Uniforms with Size variable

// Variables
boolean goForInsert = false;
String imsName = 'IMS-000000225';

/* Sizes
{'7','7.5','8','8.5','9','9.5','10','10.5','11','11.5','12','14','15'}
*/
List<String> sizes = new List<String>{'7','7.5','8','8.5','9','9.5','10','10.5','11','11.5','12','14'};

/* Lengths
   {'N/A','EW','M','W'}
*/
List<String> lengths = new List<String>{'EW'};

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