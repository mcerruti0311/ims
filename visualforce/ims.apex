<apex:page lightningStylesheets="true" standardController="Contact" standardStylesheets="true" >
  <apex:slds />
    <head>
      <title>Inventory Management System</title>
      <apex:slds />
    </head>
    <body class="slds-scope">
    <p class="slds-text-heading--label slds-m-bottom--small">
      Inventory Management System
    </p>
    <flow:interview name="IMS_Landing_Page" finishLocation="{!URLFOR('/003/o')}" />
    </body>
</apex:page>
