public class operationsAccountCreator {
  public static void createOperationsAccount() {

    String accountType = 'Client';

    List<RecordType> recordTypes = new List<RecordType>(
      [
        SELECT Id
        FROM RecordType
        WHERE RecordType.Name = 'Client'
        LIMIT 1
      ]
    );

    System.assertNotEquals(0, recordTypes.size(), 'Size = 0');
    String client = recordTypes[0].Id;

// Account Data Models
    Account acct01 = new Account ();
      acct01.Name = 'Amazon.com';
      acct01.Type = accountType;
      acct01.RecordTypeId = client;
    Insert acct01;

    Account acct02 = new Account ();
      acct02.Name = 'Apple - Cupertino';
      acct02.Type = accountType;
      acct02.RecordTypeId = client;
    Insert acct02;
  }
}
