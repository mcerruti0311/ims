public class locationDataCreator {
  public static void createLocationData() {
    List<RecordType> recordTypes = new List<RecordType>(
      [
        SELECT Id
        FROM RecordType
        WHERE RecordType.Name = 'Parent Location'
        LIMIT 1
      ]
    );

    System.assertNotEquals(0, recordTypes.size(), 'Size = 0');
    String parentLocation = recordTypes[0].Id;

// Location Data  Data Models
    Location_Data__c location01 = new Location_Data__c ();
      location01.RecordTypeId = parentLocation;
      location01.Name = '71800 - SIS Corp Software Solutions';
      location01.Job_Name__c = 'Software Solutions';
      location01.City__c = 'Culver City';
      location01.State__c = 'CA';
      location01.Division__c = 'Administration';
      location01.Department__c = 'Software Solutions';
      location01.Code_as_it_appears_in_Chronotek__c = '71800 - SIS Corp Software Solutions';
    Insert location01;

    Location_Data__c location02 = new Location_Data__c ();
      location02.RecordTypeId = parentLocation;
      location02.Name = '20000 - Apple Cupertino';
      location02.Code_as_it_appears_in_Chronotek__c = '20000 - Apple Cupertino';
      location02.Job_Name__c = 'Apple, Inc. - Cupertino';
      location02.City__c = 'Cupertino';
      location02.State__c = 'CA';
      location02.Division__c = 'Operations';
      location02.Department__c = 'Standard';

    Insert location02;

    Location_Data__c location03 = new Location_Data__c ();
      location03.RecordTypeId = parentLocation;
      location03.Name = '26000 - Amazon SLU';
      location03.Code_as_it_appears_in_Chronotek__c = '26000 - Amazon SLU';
      location03.Job_Name__c = 'Amazon - Amazon SLU';
      location03.City__c = 'Seattle';
      location03.State__c = 'WA';
      location03.Division__c = 'Operations';
      location03.Department__c = 'Standard';

    Insert location03;

    Location_Data__c location04 = new Location_Data__c ();
      location04.RecordTypeId = parentLocation;
      location04.Name = '71400 - SIS Corp Administration';
      location04.Job_Name__c = 'Internal Services - Administration';
      location04.City__c = 'Culver City';
      location04.State__c = 'CA';
      location04.Division__c = 'Administration';
      location04.Department__c = 'Internal Services';
      location04.Code_as_it_appears_in_Chronotek__c = '71400 - SIS Corp Administration';
    Insert location04;
  }
}
