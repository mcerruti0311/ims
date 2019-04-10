SELECT Id,
    Name,
    IMS_Detail__r.Name,
    Item_Description__c,
    IMS_Detail__r.Item_Description__c,
    Location_Data__r.Name,
    LastModifiedBy.Name,
    Format(LastModifiedDate)
FROM Uniform_Stock_Database__c
WHERE LastModifiedDate = Today
    AND LastModifiedBy.Name = 'Mike Cerruti'