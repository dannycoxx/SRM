<?php
    require_once ('../php/db_config.php');
    $action = $_POST['action'];
    if ($action == 'accessPage') {
        $page = $_POST['page'];
        $data['page'] = $page;
    }

    if (isset($_SESSION['accNo']) && isset($_SESSION['userType'])) {
        $data['userType'] = $_SESSION['userType'];
        if ($data['userType'] == 'S') {
            $data['studentNo'] = $_SESSION['accNo'];
        }
    }
    //check if user is already logged in 
    if(isset($_SESSION['logIn']) && $_SESSION['logIn'] == "true"){
        $data['logIn'] = true;
        //check if user has permission to access page
        if ($action == 'accessPage') {
            $query = "SELECT page_name
                    FROM page_restrictions
                    WHERE page_name = '$page'";
            $result = mysqli_query($db_con, $query);
            //if page doesn't exist in table, meaning every user has permission
            if (mysqli_num_rows($result) > 0) {
                $userType = $_SESSION['userType'];

    
                $query = "SELECT *
                        FROM page_restrictions
                        WHERE $userType = 1 AND page_name = '$page'";
                $result = mysqli_query($db_con, $query);
                
                if (mysqli_num_rows($result) > 0) {
                    $data['pageAccess'] = true;
                } else {
                    $data['pageAccess'] = false;
                }
            } else {
                $data['pageAccess'] = true;
            }
        }
    } else {
        $data['logIn'] = false;        
    }

    echo json_encode($data);
    
    exit();
?>