If(TEXT(Billing_Location__r.Division__c)='Retail','Retail',
If(TEXT(Billing_Location__r.Division__c) = 'Special Operations','Special Operations',
If(TEXT(Billing_Location__r.Division__c) = 'Operations', Billing_Location__r.Client_Account__r.Name,
If(Billing_Location__r.Job_From_Name__c ='SIS Corp GSOC','Corp GSOC',
'No Group'
)))
)

// New Code

If(TEXT(Billing_Location__r.Division__c)='Retail','Retail',
  If(TEXT(Billing_Location__r.Division__c) = 'Special Operations','Special Operations',
    If(
        (Billing_Location__r.Client_Account__r.Name = 'Apple iCloud Data Center - Prineville' || 
         Billing_Location__r.Client_Account__r.Name = 'Apple iCloud Data Center - Reno'), 'Apple iCloud Data Center', 
      If(Billing_Location__r.Client_Account__r.Name = 'Apple, Inc./Beats', 'Apple, Inc.',     
        If(Billing_Location__r.Job_From_Name__c ='SIS Corp GSOC','Corp GSOC',
          If(Billing_Location__c = '', 'No Group',
          Billing_Location__r.Client_Account__r.Name
          )
        )
      )
    )
  )
)



// Jitterbit Group 3
case(
Master_Job_Code_For_Time_Keeping__r_Division__c == 'Retail', 'Retail',
Master_Job_Code_For_Time_Keeping__r_Division__c == 'Special Operations', 'Special Operation',
Master_Job_Code_For_Time_Keeping__r_Division__c == 'Operations', root$transaction.response$body$queryResponse$result$records.Contact$Master_Job_Code_For_Time_Keeping__r$Client_Account__r$Name$,
true,'No Group'
);

// new Jitterbit

if(
Master_Job_Code_For_Time_Keeping__r_Division__c == 'Retail','Retail',
  if(
    Master_Job_Code_For_Time_Keeping__r_Division__c == 'Special Operations', 'Special Operations',
    if(
      root$transaction.response$body$queryResponse$result$records.Contact$Master_Job_Code_For_Time_Keeping__r$Name$ == '20400 - Apple Prineville', 'Apple iCloud Data Center',
      if(
        root$transaction.response$body$queryResponse$result$records.Contact$Master_Job_Code_For_Time_Keeping__r$Name$ == '25150 - Beats CC', 'Apple, Inc.',
        if(
                root$transaction.response$body$queryResponse$result$records.Contact$Master_Job_Code_For_Time_Keeping__r$Name$ == '20900 - Apple Reno', 'Apple iCloud Data Center',              root$transaction.response$body$queryResponse$result$records.Contact$Master_Job_Code_For_Time_Keeping__r$Name$
        )
      )  
    )
  )
);

// History Changes
if(
Master_Job_Code_For_Time_Keeping__r_Division__c == 'Retail','Retail',
  if(
    Master_Job_Code_For_Time_Keeping__r_Division__c == 'Special Operations', 'Special Operations',
    if(
      Job_Code_Name == '20400 - Apple Prineville', 'Apple iCloud Data Center',
      if(
        Job_Code_Name == '25150 - Beats CC', 'Apple, Inc.',
        if(
          Job_Code_Name == '20900 - Apple Reno', 'Apple iCloud Data Center',    Job_Code_Name
        )
      )  
    )
  )
);



