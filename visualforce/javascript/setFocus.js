<apex:page >

    <flow:interview name="Uniform_Tracking_Flow" buttonLocation="bottom">
    </flow:interview>



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
            if (focusTag = getApexElementByID("input","Employee_Number\.input")){
                //first page focus
                focusTag.focus();
            } else if(focusTag = getApexElementByID("input",
                             "Lunch_Start_Time_Per_Employee\.input")){
                //second page focus
                focusTag.focus();
            } else if(focusTag = getApexElementByID("input",
                             "Manager_Clock_In_Overide_Code\.input")){
                //additional page focus
                focusTag.focus();
            } else if(focusTag = getApexElementByID("input",
                             "Team_x\.input")){
                //additional page focus
                focusTag.focus();
            }
        }


</script>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js" />

    <script type="text/javascript">


    $(document).keypress(function(e) {
      if(e.which == 13) {
        // enter pressed
        // alert("Test"); //Test Code

        (function ($) {
            $(document).ready(function () {
                    $("input.FlowNextBtn").click();
                    $("input.FlowFinishBtn").click();
            });
        })(jQuery.noConflict(true))
      }
    });

</script>

<script>
// Enter key press upon 5 digits in the barcode field.

function textLength(value){
   var employeeIDLength = 5;
   if(value.length >= employeeIDLength) return false;
   return true;
}

getApexElementByID("input","Employee_Number\.input").onkeyup = function(){
     if(!textLength(this.value))     (function ($) {
        $(document).ready(function () {
                $("input.FlowNextBtn").click();
                $("input.FlowFinishBtn").click();
        });
    })(jQuery.noConflict(true));
}

</script>

</apex:page>
