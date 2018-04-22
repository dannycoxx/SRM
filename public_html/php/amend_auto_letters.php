<?php
    require_once ('../php/db_config.php');
    if(isset($_POST['subject'])){
            $subject = $_POST['subject'];
        }
    if(isset($_POST['body'])){
        $body = $_POST['body'];
    }
    if(isset($_POST['queue'])){
        $queue = $_POST['queue'];
    }
    if(isset($_POST['commHistId'])){
        $commHistId = $_POST['commHistId'];
    }

    $query = "UPDATE autocomm SET send = '$queue' WHERE commHistId = '$commHistId'";
    mysqli_query($db_con, $query);
    // if (mysqli_affected_rows($db_con) > 0)  {
    //     $data['success'] = true;
    //     $data['autocomm'] = mysqli_affected_rows($db_con);
    // } else {
    //     $data['fail'] = 'autocomm';
    //     $data['success'] = false;
    // }

    $query = "UPDATE commhistory SET subject = '$subject', body = '$body' WHERE commHistId = '$commHistId'";
    mysqli_query($db_con, $query);
    // if (mysqli_affected_rows($db_con) > 0)  {
    //     $data['success'] = true;
    //     $data['commhist'] = mysqli_affected_rows($db_con);
    // } else {
    //     $data['success'] = false;
    //     $data['fail'] = 'commhist';
    // }

    $data['success'] = true;
    echo json_encode($data);
    exit();
?>