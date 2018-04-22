<?php
    session_start();

    $db_hostname = "localhost";
    $db_database = "srm";
    $db_username = "root";
    $db_password = "";

    $db_con = mysqli_connect($db_hostname, $db_username, $db_password, $db_database);
    mysqli_set_charset($db_con,"utf8");

    if (!$db_con) {
        die("Connection failed: ".mysqli_connect_error);
    } 
?>