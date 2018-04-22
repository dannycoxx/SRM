<?php
    require_once ('../php/db_config.php');

    $accNo = $_SESSION['accNo'];
    if(isset($_POST['studentNo'])){
        $studentNo = $_POST['studentNo'];
    }

    $query = "SELECT email FROM student WHERE studentNo = '$studentNo'";
    $result = mysqli_query($db_con, $query);
    $row = mysqli_fetch_array($result);
    if (mysqli_num_rows($result) > 0) {
        $studentEmail = $row['email'];
    }

    $query = "SELECT email FROM staff WHERE staffNo = '$accNo'";
    $result = mysqli_query($db_con, $query);
    $row = mysqli_fetch_array($result);
    if (mysqli_num_rows($result) > 0) {
        $staffEmail = $row['email'];
    }

    $title = "Request to view all student information";
    $desc = "Standard request sent by lecturer with no special requirements.";
    $date = date('Y-m-d H:i:s');
    $status = 0;

    $query = "INSERT INTO request (requester, student, title, description, dateTime)
                VALUES ('$staffEmail', '$studentEmail', '$title', '$desc', '$date')";
    if (mysqli_query($db_con, $query)) {
        $data['success'] = true;
    } else {
        $data['success'] = false;
    }

    // $stmt = $db_con->prepare("INSERT INTO request VALUES (DEFAULT, ?, ?, ?, ?, ?, ?, DEFAULT, DEFAULT, DEFAULT)");
    // $stmt->bind_param("sssssi", $staffEmail, $studentEmail, $title, $desc, $date, $status);
    // $stmt->execute();
    
    echo json_encode($data);
    
    exit();
?>