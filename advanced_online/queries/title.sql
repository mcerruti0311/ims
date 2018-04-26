SELECT Title, Count(Id)
FROM Contact
WHERE RecordType.Name = 'SIS Employee'
AND Employment_Status__c = 'Active'
AND System_Account__c = false
AND ReportsTo.Name != null
AND Title NOT IN (
'',
'Analyst',
'Assistant',
'BSOC Operator',
'Building Maintenance Clerk',
'Clerk',
'Enviro, Hlth, Safety Mngr',
'Field Training Specialist (FTS)',
'GSOC Operator',
'Help Desk Lead',
'HR Generalist',
'HRIS Analyst',
'Investigator',
'IT Clerk',
'Loss Prevention',
'ODO',
'Off Duty Officer',
'Operator',
'Qualifying Manager',
'Receptionist',
'Recruiter',
'RIOSOC OPERATOR',
'Scheduler',
'Sec Ops Center Operator',
'Senior Systems Administrator',
'Software Engineer',
'Specialist',
'Systems Administrator',
'Technical Writer',
'Trainer',
'Transportation Specialist'
)

GROUP BY Title
