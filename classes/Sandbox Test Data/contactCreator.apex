public class contactCreator {
  public static void createContacts() {

    Integer contactsToCreate = 10;  // Max 10
    Integer x = 0; // List index for Location Data Name  

    List<String> locationDatas = new List<String>{
        '71400 - SIS Corp Administration',
        '26000 - Amazon SLU',
        '20000 - Apple Cupertino',
        '71800 - SIS Corp Software Solutions'
    };

// Get record Id for SIS Corporate
    List<Account> sisAccount = new List<Account> (
     [
     	SELECT Id
        FROM Account
        WHERE Account.Name = 'SIS Corporate'
        LIMIT 1
     ]
    );

    System.assertNotEquals(0, sisAccount.size());
    Id sisAccountId = sisAccount[0].Id;

    List<Location_Data__c> locationData = new List<Location_Data__c> (
        [
            SELECT Id
            FROM Location_Data__c
            WHERE Name = :locationDatas[x] 
            LIMIT 1
        ]
    );

    System.assertNotEquals(0, locationData.size());
    Id locationDataId = locationData[0].Id;


// Create a list of first names

    List<String> firstNames = new List<String>();
      firstNames.add('Robert');
      firstNames.add('John');
      firstNames.add('James');
      firstNames.add('William');
      firstNames.add('Charles');
      firstNames.add('Mary');
      firstNames.add('Dorothy');
      firstNames.add('Helen');
      firstNames.add('Betty');
      firstNames.add('Margaret');


    List<String> lastNames = new List<String>();
      lastNames.add('Abraham');
      lastNames.add('Elliott');
      lastNames.add('Kegley');
      lastNames.add('Raslo');
      lastNames.add('Lehman');
      lastNames.add('Rosenthal');
      lastNames.add('Bentz');
      lastNames.add('Shea');
      lastNames.add('Hartley');
      lastNames.add('Mayfield');

	List<String> fullNames = new List<String>();
    Integer c = 0;
    String employeeNumber = '';
    String paddedEmployeeNumber = '';

    for(Integer i = contactsToCreate; i > 0; i--){
        Double FNI = Math.random() * 9;
        Double LNI = Math.random() * 9;
        Integer firstNameIndex = Math.round(FNI);
        Integer lastNameIndex = Math.round(LNI);
        String firstName = firstNames.get(firstNameIndex);
        String lastName = lastNames.get(lastNameIndex);
        String fullName = firstName + ' ' + lastName;
        System.debug('Name: ' + fullName + ' FNI: ' + firstNameIndex + ' LNI ' + lastNameIndex);
        System.debug(fullNames.contains(fullName));

        c++;
		employeeNumber = String.valueOf(c);
        paddedEmployeeNumber = employeeNumber.leftPad(5,'0');

        if(!fullNames.contains(fullName)){
        	fullNames.add(fullName);
            i = (contactsToCreate + 1) - fullNames.size();

            Contact newContact = new Contact();
            	newContact.FirstName = firstName;
            	newContact.LastName = lastName;
            	newContact.AccountId = sisAccountId;
            	newContact.Employee_Number__c = paddedEmployeeNumber;
            	newContact.Email = firstName + '_' + lastName + '@example.com';
            	newContact.Employment_Status__c = 'Active';
            	newContact.SIS_Relationship__c = 'SIS Employee';
            	newContact.Position__c = 'Specialist';
            	newContact.Title = 'Specialist';
                newContact.Full_or_Part_Time__c = 'Full Time';
            	newContact.Salary_or_Hourly__c = 'Hourly';
            	newContact.Master_Job_Code_For_Time_Keeping__c = locationDataId;
            insert newContact;
        } else {i++;}

        System.debug('I: ' + i + ' C: ' + c);
        if(c>(contactsToCreate * 5)) i=0;
    }
    System.debug('Full Names: ' + fullNames.size() + ' Tries: ' + c);
    System.debug(fullNames);
  }
}
