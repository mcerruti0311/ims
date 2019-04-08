// variables to set 
// delete records in this instance
String expectedInstance = 'cs23';
// change okToDelete to true to delete records
boolean goForDelete = false;

// create array of records to delete
IMS_Transaction_Detail__c[] doomedDetails = 
    [
      SELECT 
        Id, 
        Name
      FROM IMS_Transaction_Detail__c
      ORDER BY Name
    ];

// variables
String stringURL = String.valueOf(URL.getSalesforceBaseUrl());
Integer doomedDetailsSize = doomedDetails.size();
boolean safeInstance = stringURL.contains(expectedInstance);

System.debug(stringURL);

System.assert(safeInstance = stringURL.contains(expectedInstance), 'Expected Instance not equal to Current Instance');
System.assert(doomedDetailsSize > 0, 'No records to delete.');

// Display a list of records to delete
  for (Integer i=0 ; i < doomedDetailsSize; i++) {
    System.debug(i + ': Doomed Details ' + doomedDetails[i].Name);  
  }

// Delete detail records
if (goForDelete) {
	delete doomedDetails;    
  System.debug(doomedDetailsSize + ' Records Deleted');
} else {
  System.debug('Not Safe to Delete');
  System.debug('Go for Delete: ' + goForDelete);
}