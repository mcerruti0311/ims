SELECT Manufacturer__r.Name, Count(Id)
FROM IMS__c
WHERE Type__c = 'Shirt'
    AND Style__c = 'Polo'
GROUP BY Manufacturer__r.Name