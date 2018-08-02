<script>
function compareSSN (mySSN, enteredSSN) {

  var message = 'The Last 4 of your SSN did\'t match what we have on file.';
  message += '\n' + 'Please try again.';

  if(enteredSSN != '' &&
     mySSN == enteredSSN) {
       isAMatch = 'Match';
  } else if(enteredSSN != '' &&
            mySSN != enteredSSN) {

      alert(message);
      isAMatch = 'Not A Match';
      enteredSSN = '';
    } else {
      isAMatch = '';
    }
    return isAMatch;
}

</script>
