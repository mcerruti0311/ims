SELECT 
  Id, 
  Name, 
  Contact__r.LastName, Contact__r.FirstName, Contact__r.Master_Job_Code_For_Time_Keeping__r.Name, 
  Employee_Number__c, 
  Employee__r.Employment_Status__c, 
  Uniform_Number__r.Name, 
  Uniform_Number__r.IMS_Detail__r.Name, Uniform_Number__r.IMS_Detail__r.SIS_Barcode__c, Qty_Issued_Removed_From_Stock__c, 
  Qty_Returned_Added_To_Stock__c, 
  Uniform_Balance__c
FROM Uniform_Issuance__c
WHERE Uniform_Balance__c != 0
  AND Contact__c != ''
  AND Uniform_Number__r.IMS_Detail__c != ''
ORDER BY Contact__r.LastName, Employee_Number__c