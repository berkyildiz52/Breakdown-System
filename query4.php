<?php

include( "vars.php" );
include("writeAsJson.php");


// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}

//Query:Material and machine status information of state 0 breakdowns
$sth3 = mysqli_query($conn, "SELECT m.name,m.amount FROM Material m");

writeAsJson($sth3,$rows);

//Close connection
mysqli_close($conn);
?>