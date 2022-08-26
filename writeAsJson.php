<?php

//Empty array
$rows = array();

//Print in json format
function writeAsJson($sth,$rows){
    while($r = mysqli_fetch_assoc($sth)) {
        $rows[] = $r;
    }
    print json_encode($rows);
}

?>
