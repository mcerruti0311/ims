![corsair][logo]
[logo]:http://www.rcplanetalk.com/images/hangar9f4usm.jpg "project cosair"
## Inventory Management App
### Fields and Relationships
#### Fields
##### Revision: 1.0
##### Revision Date: 12/20/2017
---
##### Fields

| Field | Type | Description |
| ------ | ------ | ------|
| Billing  Location |  Lookup(Location Data)  | This is the billing location for this item. |
|  Category | Picklist  | This is the top level component for the inventory item.  Select the category that best matches the type of item you want to track. |
|  Class | Picklist  | The class is  controled by the Category and is the next group or set of items with common attributes. |
|  Color |  Picklist  | This is the color attribute of an item.   |
|  Feature |  Picklist  | This is a defined attribute for this item shared by the class of item. |
|  Gender |  Picklist  | If applicable this can be Men's, Ladies or Unisex. |
|  Group |  Picklist  | Group is dependent on the class and defines a common association for this item within the organization structure. |
|  Item Description |  Formula (Text)  | This is a formula field that creates the description from the Location, Color, Sub-Group, Manufacturer, Type and Manufacturer Number. |
|  Manufacturer |  Lookup(Account)  | This is the manufacturer for this item.  This is not the vendor. |
|  Manufacturer Number |  Text(255)  | This is the manufacturer item number. |
|  Qty Standard Issue | Number(18,0)  | This is the quantity issued by position for standard issue items. |
|  Style |  Picklist  | If applicable this is the style for the item and is controlled by the Type field. |
|  Sub Group |  Picklist  | The sub-group is controlled by the group field and further defines the user for this item by position. |
|  Type |  Picklist  | The type field defines the basic grouping of items |
|  Type of Issue |  Picklist  | The type of issue defines if this item is for standard issue or special issue. |
|  Useful Life |  Number(15, 3)  | Useful life provides an indicator in years for when a item should be replaced. |
