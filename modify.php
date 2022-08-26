<?php

include( "vars.php" );

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}


$ID = $_REQUEST['ID2'];
$machineId = $_REQUEST['machineId2'];
$type =  $_REQUEST['type2'];
$state = $_REQUEST['state2'];
$description = $_REQUEST['description2'];
$time2 =  $_REQUEST['time22'];

echo $ID.$machineId.$type.$state.$description.$time2;

//Query:Modify "Breakdown" table
$sth = mysqli_query($conn, "UPDATE breakdown SET machineId='$machineId', type='$type', state='$state', description='$description', estimatedDeadline='$time2' WHERE id='$ID';");

//Close connection
mysqli_close($conn);
?>
