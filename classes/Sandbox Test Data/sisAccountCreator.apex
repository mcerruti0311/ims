public class sisAccountCreator {
  public static void createSISAccount() {

    String accountType = 'Internal';

    List<RecordType> recordTypes = new List<RecordType>(
      [
        SELECT Id
        FROM RecordType
        WHERE RecordType.Name = 'SIS Internal'
        LIMIT 1
      ]
    );

    System.assertNotEquals(0, recordTypes.size(), 'Size = 0');
    String sisInternal = recordTypes[0].Id;
// Account Data Models

    Account acct01 = new Account ();
      acct01.Name = 'SIS Corporate';
      acct01.Type = accountType;
      acct01.RecordTypeId = sisInternal;
    Insert acct01;

    Id sisCorporateId = acct01.Id;

    Account acct02 = new Account ();
      acct02.Name = 'SIS Culver City Office';
      acct02.ParentId = sisCorporateId;
      acct02.Type = accountType;
      acct02.RecordTypeId = sisInternal;
    Insert acct02;

    Account acct03 = new Account ();
      acct03.Name = 'SIS Seattle Office';
      acct03.ParentId = sisCorporateId;
      acct03.Type = accountType;
      acct03.RecordTypeId = sisInternal;
    Insert acct03;

    Account acct04 = new Account ();
      acct04.Name = 'SIS San Jose Office';
      acct04.ParentId = sisCorporateId;
      acct04.Type = accountType;
      acct04.RecordTypeId = sisInternal;
    Insert acct04;

    Account acct05 = new Account ();
      acct05.Name = 'SIS Oak Street Building';
      acct05.ParentId = sisCorporateId;
      acct05.Type = accountType;
      acct05.RecordTypeId = sisInternal;
    Insert acct05;

    Account acct06 = new Account ();
      acct06.Name = 'SIS Miami Office';
      acct06.ParentId = sisCorporateId;
      acct06.Type = accountType;
      acct06.RecordTypeId = sisInternal;
    Insert acct06;
  }
}
