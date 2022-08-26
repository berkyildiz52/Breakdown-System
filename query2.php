<?php

include( "vars.php" );
include("writeAsJson.php");

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}

//Query:Breakdowns that is not on state 2
$sth2 = mysqli_query($conn, "SELECT * FROM Breakdown b WHERE b.state!=2");

writeAsJson($sth2,$rows);

//Close connection
mysqli_close($conn);
?>