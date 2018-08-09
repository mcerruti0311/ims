<apex:page lightningStylesheets="true" standardController="IMS_Shift_Transaction__c">
<html>
 <h3>Inventory Management System - Shift Item Return</h3>
</html>
<flow:interview name="IMS_Shift_Item_Returner" />
 <script>
    // Set focus
        setFocus();
        function getApexElementByID(tagname, eid) {
            var tags = document.getElementsByTagName(tagname); //get a bunch of tags.
            var regex = new RegExp(":" + eid + "$");
            for (var i=0; i < tags.length; i++) {
                if (tags[i].getAttribute("id") != null) {
                    var idVal = tags[i].getAttribute("id");
                    var pos = idVal.search(regex);
                    if (pos != -1) return tags[i];
                }
            }
            return null;
        }

        function setFocus() {
            var focusTag;
            if (focusTag = getApexElementByID("input","tbx_Employee\.input")){
                //first page focus
                focusTag.focus();
            } else if(focusTag = getApexElementByID("input",
                             "tbx_Item_SKU\.input")){
                //second page focus
                focusTag.focus();
           }
        }
</script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script>
// Enter key press upon 5 digits in the barcode field.

function textLength(value){
   var employeeIDLength = 5;
   if(value.length >= employeeIDLength) return false;
   return true;
}

getApexElementByID("input","tbx_Employee\.input").onkeyup = function(){

     if(!textLength(this.value))(function ($) {
        $(document).ready(function () {
                $("input.FlowNextBtn").click();
                $("input.FlowFinishBtn").click();
        });
    })(jQuery.noConflict(true));
}
</script>

<script>
// Enter key press upon 8 digits in the barcode field.

function testBarcodeLength(value){
   var barcodeLength = 8;
   if(value.length >= barcodeLength) return false;
   return true;
}

getApexElementByID("input","tbx_Item_SKU\.input").onkeyup = function(){
     if(!testBarcodeLength(this.value))     (function ($) {
        $(document).ready(function () {
                $("input.FlowNextBtn").click();
                $("input.FlowFinishBtn").click();
        });
    })(jQuery.noConflict(true));
}
</script>


</apex:page>
