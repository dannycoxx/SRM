<?php
    require_once ('../php/db_config.php');

    $username = $_POST['username'];
    $passPre = $_POST['password'];

    $data = array();
    
    $query = "SELECT staffNo, mwsPassword, mwsUser, userType FROM Staff WHERE mwsUser = ?";

    $stmt = mysqli_stmt_init($db_con);

    for ($i=0; $i <=1; $i++) {
        if(!mysqli_stmt_prepare($stmt, $query)) {
            $data['success'] = false;
            $data['message'] = "Failed to prepare statement";
        } else {
            mysqli_stmt_bind_param($stmt, "s", $username);
    
            mysqli_stmt_execute($stmt);
            $result = mysqli_stmt_get_result($stmt);
            $row = mysqli_fetch_array($result);
            
            if (!empty($row)) {
                $i++;
            }
            $query = "SELECT studentNo, mwsPassword, mwsUser FROM Student WHERE mwsUser = ?";
        }
    }
    //Correct username
    if (!empty($row)) {
        $passHash = $row['mwsPassword'];
        if ($passPre == $passHash || password_verify($passPre, $passHash)) {
            $data['login'] = "true";
            $_SESSION['logIn'] = "true";  
            $_SESSION['mwsUser'] = $row['mwsUser'];  
            $data['result'] = $row;
            //Staff details
            if (!empty($row['staffNo'])) {
                $_SESSION['accNo'] = $row['staffNo'];
            } else {
                 //Student details
                $data['userType'] = 'S';
                $_SESSION['accNo'] = $row['studentNo'];
            }
            if (!empty($row['userType'])) {
                $_SESSION['userType'] = $row['userType'];
            } else {
                $_SESSION['userType'] = 'S';
            }  
            //correct username, incorrect password
            } else {
                $data['login'] = "false";
                $data['success'] = false;
                $data['message'] = "Password incorrect";
                $data['failType'] = "password";
                $data['result'] = $row;
            }
            //Username doesn't exist in staff table
        } else {
            $data['login'] = "false";
            $data['success'] = false;
            $data['message'] = "Username not found";
            $data['failType'] = "username";
        }
        // session_start($row['userType']);
        mysqli_stmt_close($stmt);
    
    
    
    
    mysqli_close($db_con);

    echo json_encode($data);
    
    exit();
?>