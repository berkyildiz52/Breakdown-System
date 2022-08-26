<?php

include( "vars.php" );
include("writeAsJson.php");

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}

//Query:Reaching descriptions from machine
$sth = mysqli_query($conn, "SELECT h.id, h.breakdownId, h.process FROM history h");

writeAsJson($sth,$rows);

//Close connection
mysqli_close($conn);
?>
