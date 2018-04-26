SELECT Master_Job_Code_for_Time_Keeping__r.Client_Account__r.Name,
  Master_Job_Code_for_Time_Keeping__r.Job_From_Name__c,
  Master_Job_Code_for_Time_Keeping__r.Jobcode_From_Name__c,
  Name, Email,
  ReportsTo.Name,
  ReportsTo.Email
FROM Contact
WHERE
  RecordType.Name = 'SIS Employee'
  AND Employment_Status__c = 'Active'
  AND System_Account__c = false
  AND ReportsTo.Name != null
  AND Master_Job_Code_for_Time_Keeping__r.Name != ''
  AND Title IN (
  'Administrative Manager',
  'Assistant Site Manager',
  'Coordinator',
  'Director',
  'Executive Assistant',
  'Lead Officer',
  'Mexico City Coordinator',
  'Operations Manager',
  'Ops Manager',
  'Owner/President',
  'Sec Op Center Mngr',
  'Senior Director',
  'Shift Supervisor',
  'Sr. Manager',
  'Supervisor',
  'Vice President',
  'Watch Commander'
  )
ORDER BY Master_Job_Code_for_Time_Keeping__r.Name, Name
