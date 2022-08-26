<?php

include( "vars.php" );

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}

//Print in json format
function writeAsJson20($sth,$rows){
    while($r = mysqli_fetch_assoc($sth)) {
        $rows[] = $r;
    }
    print json_encode($rows[0]);
}

//Empty array
$rows = array();

//Query:Material and machine status information of state 0 breakdowns
$sth20 = mysqli_query($conn, "SELECT * FROM Breakdown b WHERE b.state!=2");

writeAsJson20($sth20,$rows);

//Close connection
mysqli_close($conn);
?>