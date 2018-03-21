# Change Set 3/13/2018

* Profiles / System Administrator / Global: Record Types and Page Layout
* Error Handler Manufacturer Name hasn't been set or assigned.
* Account Type / Manufacturer - Uniforms (used?)
* Add Inventory Location checkbox to Accounts
* Update Account Page Layouts: Client, SIS Internal, Sub-contract Vendors,
* Update add form assembly for inventory locations
* Flow: Contact ID Master Lookup, IMS New
Employee Transaction
* Validation Rule Ship to Account required
* Contact > Button > IMS button
* Contact > Page Layouts > SIS Employee



`Notes:  Picklists on visual flow are
always required.  Will need to rethink
best work around with minimum steps`

`Deactivated Validation Rule
'Ship_to_Account_Required.' Re-evaluate
for Transfers`

`Process for issuing items to employee are
either issued from location or shipped to
employee.  Make flow and rules match this
objective.`

1. Find employee contact record
1. Click on the [IMS] Button
1. Determine if Issue or Return
1. Determine issue from what location


| Name | Parent Object | Type |
|------|---------------|------|
|Client|Account|Page Layout|
|Contact_ID_Master_Lookup||Flow Definition|
|IMS|	Contact|	Button or Link|
|IMS_Flow_Controller||		Flow Definition|
|IMS_Issue_to_Employee||		Flow Definition|
|IMS_Landing_Page||		Flow Definition|
|IMS_New_Employee_Transaction||		Flow Definition|
|IMS_Return_from_Employee||		Flow Definition|
|Inventory Location|	Account	|Custom Field|
|SIS Employee|	Contact	|Page Layout|
|SIS Internal|	Account|	Page Layout|
|Ship_to_Account_Required|	IMS Transaction	|Validation Rule|
|Sub-contract Vendors|	Account|	Page Layout|


### Test
Bill To not populating MJC first
Transaction Created successfully
