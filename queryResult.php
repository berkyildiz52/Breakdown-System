<?php

//Empty array
$rows = array();

//Return as a string
function queryResult($sth,$rows){
    while($r = mysqli_fetch_assoc($sth)) {
        $rows[] = $r;
    }
    $output= json_encode($rows);
    return $output;
}

?>
