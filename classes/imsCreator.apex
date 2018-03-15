public class imsCreator {
  public static void createIMS() {

    String category = 'Clothing';
    String imsClass = 'Uniform';
    String imsGroup = 'Administration';
    String subgroup = 'Receptionist';
    String imsType = 'Shirt';
    String style = 'Polo';
    // String style = 'Button Down';
    String imsFeature = 'Short Sleeve';

    String gender = 'Men\'s';
   // String gender = 'Ladies';
    String typeOfIssue = 'Standard';
    Decimal processing = 30.0;
    Integer qtyStandardIssue = 4;
    Decimal usefulLife = .5;
    String imsRecordTypeName = 'Clothing';
    String detailRecordTypeName = 'Clothing';
    String itemStatus = 'Active';

    // Item variables
    String manufacturerName = 'Port Authority';
    String color = 'Black';
    String vendorName = 'West Coast Screen Printing';
    String mfgNumber = 'K497';



    List<Account> imsManufacturers = new List<Account>(
      [
        SELECT Id
        FROM Account
        WHERE Name = :manufacturerName
        LIMIT 1
      ]
      );

    System.assertNotEquals(0, imsManufacturers.size(), 'Size = 0');
    String imsManufacturerId = imsManufacturers[0].Id;

    List<Account> imsVendors = new List<Account>(
      [
        SELECT Id
        FROM Account
        WHERE Name = :vendorName
        LIMIT 1
      ]
      );

    System.assertNotEquals(0, imsVendors.size(), 'Size = 0');
    String imsVendorId = imsVendors[0].Id;

    List<RecordType> imsRecordTypes = new List<RecordType>(
      [
        SELECT Id
        FROM RecordType
        WHERE RecordType.Name = :imsRecordTypeName
        AND SObjectType = 'IMS__c'
        LIMIT 1
      ]
    );

    System.assertNotEquals(0, imsRecordTypes.size(), 'Size = 0');
    String imsRecordTypeId = imsRecordTypes[0].Id;

    List<RecordType> imsDetailRecordTypes = new List<RecordType>(
      [
        SELECT Id
        FROM RecordType
        WHERE RecordType.Name = :detailRecordTypeName
        AND SObjectType = 'IMS_Detail__c'
        LIMIT 1
      ]
    );
    System.assertNotEquals(0, imsDetailRecordTypes.size(), 'Size = 0');
    String imsDetailRecordTypeId = imsDetailRecordTypes[0].Id;
    System.debug('RecordType Id: ' + imsDetailRecordTypeId);

// Create a list of clothing sizes

    List<String> clothingSizes = new List<String>();
      clothingSizes.add('S');
      clothingSizes.add('M');
      clothingSizes.add('L');
      clothingSizes.add('XL');
      clothingSizes.add('2XL');
      clothingSizes.add('3XL');
      clothingSizes.add('4XL');

// Account Data Models

    IMS__c ims01 = new IMS__c();
      ims01.Category__c =  category;
      ims01.Class__c = imsClass;
      ims01.Group__c = imsGroup;
      ims01.Sub_Group__c = subgroup;
      ims01.Type__c = imsType;
      ims01.Style__c = style;
      ims01.Feature__c = imsFeature;
      ims01.Gender__c = gender;
      ims01.Type_of_Issue__c = typeOfIssue;
      ims01.Processing__c = processing;
      ims01.Qty_Standard_Issue__c = qtyStandardIssue;
      ims01.Useful_Life__c = usefulLife;
      ims01.Color__c = color;
      ims01.Manufacturer_Number__c = mfgNumber;
      ims01.Item_Status__c = itemStatus;
      ims01.Manufacturer__c = imsManufacturerId;
      ims01.Vendor__c = imsVendorId;
      ims01.RecordTypeId = imsRecordTypeId;
    Insert ims01;

    Id ims01Id = ims01.Id;

    for(Integer i = 0; i < 7; i++) {
      IMS_Detail__c imsDetails = new IMS_Detail__c();
        imsDetails.IMS_Master__c = ims01Id;
        imsDetails.Size__c = clothingSizes.get(i);
        imsDetails.IMS_Detail_Status__c = 'Active';
        imsDetails.RecordTypeId = imsDetailRecordTypeId;
      insert imsDetails;
    }
  }
}
