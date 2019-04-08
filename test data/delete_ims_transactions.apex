// variables to set
// instance to delete records 
String expectedInstance = 'cs23';
// change okToDelete to true to delete records
boolean goForDelete = false;

// create an array of records to delete
IMS_Transaction__c[] doomedTransactions = 
    [
      SELECT 
        Id, 
        Name
      FROM IMS_Transaction__c 
      ORDER BY Name
      LIMIT 10   
    ];

// variables
String stringURL = String.valueOf(URL.getSalesforceBaseUrl());
Integer doomedTransactionsSize = doomedTransactions.size();
boolean safeInstance = stringURL.contains(expectedInstance);

System.debug(stringURL);

System.assert(safeInstance, 'Expected Instance not equal to Current Instance');
System.assert(doomedTransactionsSize > 0, 'No records to delete.');

// Display a list of records to delete
  for (Integer i=0 ; i < doomedTransactionsSize; i++) {
    System.debug('Doomed Details ' + doomedTransactions[i].Name);  
  }
 
// Delete detail records
if(goForDelete) {
	delete doomedTransactions;    
  System.debug(doomedTransactionsSize + ' Records Deleted');
} else {
    System.debug('Not Safe to Delete');
    System.debug('Go for Delete: ' + goForDelete);
}