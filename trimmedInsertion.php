<?php

include( "vars.php" );

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}

//$time =  $_REQUEST['time'];
$machineId = $_REQUEST['machineId'];
$type =  $_REQUEST['type'];
$state = $_REQUEST['state'];
$description = $_REQUEST['description'];
$time2 =  $_REQUEST['time2'];

//Delete spaces from both right and left sides of the string
$machineIdNew = trim($machineId);
$typeNew= trim($type);
$descriptionNew = trim($description);

//Query:Inserting values into "Breakdown" table
$sth = mysqli_query($conn, "INSERT INTO Breakdown (machineId, type,state,description,estimatedDeadline) 
VALUES ('$machineIdNew','$typeNew','$state','$descriptionNew','$time2')");


/*
//Query:Inserting values into "Breakdown" table
$sth = "INSERT INTO Breakdown (creationTime, machineId, type,state,description) 
VALUES ('$time','$machineIdNew','$typeNew','$state','$descriptionNew')";

if(mysqli_query($conn, $sth)){
    echo "The transaction was done successfully.";

    echo nl2br("\n$time\n $machineIdNew\n "
        . "$typeNew\n $state\n $descriptionNew");
} else{
    echo "ERROR: $sth. ". mysqli_error($conn);
}
*/


//Close connection
mysqli_close($conn);
?>
