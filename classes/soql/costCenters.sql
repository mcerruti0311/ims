SELECT Name
FROM Location_Data__c
WHERE RecordType.Name = 'Parent Location'
  AND Issue_Uniforms__c = false
  AND Void__c = false