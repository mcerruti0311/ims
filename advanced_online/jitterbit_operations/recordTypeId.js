<trans>
transactionType = TransactionType;
sObject = 'IMS_Transaction__c';
developerName = case(transactionType=='Employee Order','Employee_Orders',transactionType == 'Inventory Order','IMS_Orders','Vendor_Orders');

recordTypeId = SfLookup("<TAG>Salesforce Orgs/mcerruti@sis.us.ims2 (Sandbox)</TAG>",
 "SELECT id
  FROM RecordType
  WHERE sObjectType = '" + sObject + "'
  AND DeveloperName = '" + developerName + "'
 "
);

</trans>
