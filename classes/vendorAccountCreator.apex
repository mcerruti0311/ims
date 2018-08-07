public class vendorAccountCreator {
  public static void createAccount() {

    List<RecordType> recordTypes = new List<RecordType>(
      [
        SELECT Id
        FROM RecordType
        WHERE RecordType.Name = 'Sub-Contract Vendor'
        LIMIT 1
      ]
    );

    System.assertNotEquals(0, recordTypes.size(), 'Size = 0');
    String subContractVendor = recordTypes[0].Id;
// Account Data Models

    Account acct01 = new Account ();
      acct01.Name = '5.11 Tactical';
      acct01.Type = 'Vendor - Uniforms';
      acct01.Account_Category__c = 'Uniforms - General';
      acct01.RecordTypeId = subContractVendor;
      acct01.Phone = '(949)800-1511';
    Insert acct01;

    Account acct02 = new Account ();
      acct02.Name = 'Galls';
      acct02.Type = 'Vendor - Uniforms';
      acct02.Account_Category__c = 'Uniforms - General';
      acct02.RecordTypeId = subContractVendor;
      acct02.Phone = '';
    Insert acct02;

    Account acct03 = new Account();
      acct03.Name = 'Port Authority';
      acct03.Type = 'Vendor - Uniforms';
      acct03.Account_Category__c = 'Uniforms - General';
      acct03.RecordTypeId = subContractVendor;
      acct03.Phone = '';
    Insert acct03;

    Account acct04 = new Account();
      acct04.Name = 'Skaggs Public Safety Uniforms & Equipment';
      acct04.Type = 'Vendor - Uniforms';
      acct04.Account_Category__c = 'Uniforms - General';
      acct04.RecordTypeId = subContractVendor;
      acct04.Phone = '810-261-4400';
    Insert acct04;

    Account acct05 = new Account();
      acct05.Name = 'Advanced Online';
      acct05.Type = 'Vendor - Uniforms';
      acct05.Account_Category__c = 'Uniforms - General';
      acct05.RecordTypeId = subContractVendor;
      acct05.Phone = '972-471-5400';
    Insert acct05;

  }
}
