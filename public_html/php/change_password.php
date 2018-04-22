<?php
    require_once ('../php/db_config.php');

    if(isset($_POST['pass1'])){
        $pass1 = $_POST['pass1'];
    }
    if(isset($_POST['pass2'])){
        $pass2 = $_POST['pass2'];
    }
    if(isset($_POST['currentPass'])){
        $currentPass = $_POST['currentPass'];
    }

    $userType = $_SESSION['userType'];
    $accNo = $_SESSION['accNo'];

    if ($pass1 == $pass2) {
        if ($userType == 'S') {
            $query = "SELECT mwsPassword FROM student WHERE studentNo = '$accNo'";
        } else {
            $query = "SELECT mwsPassword FROM staff WHERE staffNo = '$accNo'";
        }
        // $stmt = $db_con->prepare($query);
        // $stmt->bind_param("s", $accNo);
        // $stmt->execute();
        $result = mysqli_query($db_con, $query);
        $row = mysqli_fetch_array($result);
        if (mysqli_num_rows($result) > 0) {
            $passHash = $row['mwsPassword'];
            //Correct username, correct password
            if (password_verify($currentPass, $passHash)) {
                $newPassHash = password_hash($pass2, PASSWORD_DEFAULT);
                if ($userType == 'S') {
                    $query = "UPDATE student SET mwsPassword = '$newPassHash' WHERE studentNo = '$accNo'";
                } else {
                    $query = "UPDATE staff SET mwsPassword = '$newPassHash' WHERE staffNo = '$accNo'";
                } 
                mysqli_query($db_con, $query);
                if (mysqli_affected_rows($db_con) > 0)  {
                    $data['success'] = true;
                    $data['message'] = 'Password has been successfully changed';
                } else {
                    $data['success'] = false;
                    $data['message'] = 'Unable to change password, please contact server admin';
                }
                mysqli_free_result($result);
                mysqli_close($db_con);
            } else {
                $data['success'] = false;
                $data['message'] = 'Current password is incorrect';
            }
    
        } else {
            $data['success'] = false;
            $data['message'] = 'Please log out and try again';
    
        }
    } else {
        $data['success'] = false;
        $data['message'] = 'New passwords do not match';
    }
    
    echo json_encode($data);
    
    exit();
?>