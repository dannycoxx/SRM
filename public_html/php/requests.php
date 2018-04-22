<?php
    include ('../php/db_config.php');

    $requestType = $_POST['requestType'];
    if ($requestType == 'update') {
        $changeArray = $_POST['changeArray'];
    }

    $staffUserType = $_SESSION['userType'];
    $staffAccNo = $_SESSION['accNo'];

    $data = array();
    if ($requestType == 'retrieve') {
        $query = "SELECT * FROM request WHERE status = 0 ORDER BY dateTime";
        $result = mysqli_query($db_con, $query);
        
        if (mysqli_num_rows($result) > 0) {
            while($row = mysqli_fetch_assoc($result)){
                if ($row['description'] == "") {
                    $row['description'] = 'No description provided';
                }
                array_push($data, $row);
            } 
        } else {
            $data = "FALSE";
        }
    } else if ($requestType == 'update') {
        $query = "SELECT email FROM staff WHERE staffNo = '$staffAccNo'";
        $result = mysqli_query($db_con, $query);
        $row = mysqli_fetch_assoc($result);
        $staffEmail = $row['email'];
        
        $timestamp = time();
        $currentTime = date('Y-m-d H:i:s', $timestamp);


        for ($i=0; $i<count($changeArray); $i++) {
            $requestId = $changeArray[$i][0]; 
            $updatedStatus = $changeArray[$i][1]; 
            $query = "UPDATE request SET status = '$updatedStatus', updatedDateTime = '$currentTime', updatedBy = '$staffEmail' WHERE requestId = '$requestId'";
            if (!$result = mysqli_query($db_con, $query)) {
                array_push($data['failed'], $requestId);
                $data['message'] = 'Error submitting changes.';
            }
        }
    }
    
    echo json_encode($data);
    mysqli_close($db_con);
    exit();
?>