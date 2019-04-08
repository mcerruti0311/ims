SELECT
  Email,
  FirstName,
  LastName,
  Phone,
  Title,
  Account.Name,
  Master_Job_Code_For_Time_Keeping__r.Job_From_Name__c,
  Master_Job_Code_For_Time_Keeping__r.Client_Account__r.Name,
  Master_Job_Code_For_Time_Keeping__r.Client_Account__r.ShippingAddress,
  Master_Job_Code_For_Time_Keeping__r.Client_Account__r.ShippingCity,
  Master_Job_Code_For_Time_Keeping__r.Client_Account__r.ShippingState,
  Master_Job_Code_For_Time_Keeping__r.Client_Account__r.ShippingPostalCode,
  Master_Job_Code_For_Time_Keeping__r.Client_Account__r.ShippingCountry,
  Account.ShippingAddress,
  Account.ShippingCity,
  Account.ShippingState,
  Account.ShippingPostalCode,
  Account.ShippingCountry,
  ReportsTo.Name
FROM Contact
WHERE Employment_Status__c = 'Active'
  AND RecordType.Name = 'SIS Employee'