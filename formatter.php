<?php

include( "vars.php" );
include("queryResult.php");

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}

//Query:Breakdowns that is not on state 2
$sth2 = mysqli_query($conn, "SELECT * FROM Breakdown b WHERE b.state!=2");

$recordsTotal = mysqli_query($conn, "SELECT COUNT(*)recordsTotal FROM Breakdown");
$recordsFiltered = mysqli_query($conn, "SELECT COUNT(*)recordsFiltered FROM Breakdown WHERE state!=2");

//Empty array
$rows = array();

$string=queryResult($sth2,$rows);

//Return number of occurences
function counter($sth,$rows){
    while($r = mysqli_fetch_assoc($sth)) {
        $rows[] = $r;
    }
    $temp=json_encode($rows);
    return preg_replace('~\D~', '', $temp);
    //print substr(json_encode($rows), 16, 1); 
    //print substr(json_encode($rows), 21,1); 

}

$count1=counter($recordsTotal,$rows);
$count2=counter($recordsFiltered,$rows);

//$pre='{"draw": 0,"recordsTotal": 6,"recordsFiltered": 5,"data":';

$pre1='{"draw": 1,"recordsTotal": ';
$pre2=',"recordsFiltered": ';
$pre3=',"data":';

$after='}';

echo $pre1.$count1.$pre2.$count2.$pre3.$string.$after;

//$text2 = '{"draw": 1,"recordsTotal": 6,"recordsFiltered": 6,"data":[{"id":"67","creationTime":"2022-07-29 11:30:20","machineId":"1000","type":"unknown","state":"2","description":"mystery","estimatedDeadline":"2022-07-30 12:29:06","remainingTime":"-242:21:01"},{"id":"74","creationTime":"2022-07-29 15:08:11","machineId":"1000","type":"Mechanic","state":"0","description":"Pump failure","estimatedDeadline":"2022-07-30 15:08:05","remainingTime":"-239:42:02"},{"id":"73","creationTime":"2022-07-29 14:56:01","machineId":"1000","type":"Mechanic","state":"0","description":"Pump failure","estimatedDeadline":"2022-07-29 14:56:09","remainingTime":"-263:53:58"},{"id":"71","creationTime":"2022-07-29 14:11:31","machineId":"1000","type":"Mechanic","state":"1","description":"Pump failure","estimatedDeadline":"2022-08-06 14:11:25","remainingTime":"-72:38:42"},{"id":"72","creationTime":"2022-07-29 14:29:41","machineId":"1000","type":"Mechanic","state":"0","description":"Pump failure","estimatedDeadline":"2022-07-31 19:32:50","remainingTime":"-211:17:17"},{"id":"75","creationTime":"2022-07-29 15:32:06","machineId":"1000","type":"Mechanic","state":"0","description":"epic fail","estimatedDeadline":"2022-07-29 18:35:03","remainingTime":"-260:15:04"}]}';
//echo $text2;

//Close connection
mysqli_close($conn);