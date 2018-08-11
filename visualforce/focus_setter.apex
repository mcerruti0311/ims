<apex:page lightningStylesheets="true"
  standardController="IMS_Shift_Transaction__c"
>



<html>
    <head>
        <apex:includeLightning />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script>

          $(document).ready(function(){

           $("#tbx_Item_SKU\.input").hide;

        });
        </script>
    </head>
    <body>
     <h3>Inventory Management System - Shift Item Issue</h3>
    </body>

</html>
<flow:interview name="IMS_Shift_Item_Issuer" />
</apex:page>
