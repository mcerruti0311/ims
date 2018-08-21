<trans>
	itemArray = Array(); // Instantiante the array.  The array will be re-instantiated for each record
	Set(itemArray, Vendor_Item_Number, -1); // Append the item details
	Set(itemArray, Notes, -1);
	Set(itemArray, Qty, -1);
	Set(itemArray, Vendor_Detail_Id, -1);
	Set(itemArray, Item_Detail_Id, -1);

	rolesArray = Array();
	Set(rolesArray, itemArray, -1);
	SetInstances('Transaction_Details',rolesArray);
	true;
</trans>
