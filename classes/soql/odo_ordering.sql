SELECT Id, Name, Title, Department, Division__c, Master_Job_Code_For_Time_Keeping__r.Name
FROM Contact
WHERE Employment_Status__c = 'Active'
  AND May_Order_Uniforms__c = true
  AND Department IN ('Special Operations - Secure Logistics', 
'Cupertino Secure Storage (RC09)',
'Cupertino Secure Destruction',
'Apple Corp. Engineer Escort, Field Engineering Campus',
'SIS Corp SpecOps'

)
  AND Title IN ('Coordinator', 'Operations Manager','Watch Commander','Sr. Manager','Administrative Manager','Scheduler')
  AND May_Order_Uniforms__c = true

ORDER BY Department


/* By Employee Number
SELECT Id, Name, Title, Department, Division__c, Master_Job_Code_For_Time_Keeping__r.Name
FROM Contact
WHERE Employment_Status__c = 'Active'
  AND May_Order_Uniforms__c = true
  AND Employee_Number__c IN ('13898','39008','38991','35830','39092','39354','39477')
ORDER BY Department

**/
