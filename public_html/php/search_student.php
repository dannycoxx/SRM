<?php
    //ADD PREPARED STATEMENTS
    require_once ('../php/db_config.php');

    $searchTerm = $_POST['searchTerm'];

    $query = "SELECT DISTINCT studentNo, forename, surname, degreeCode, yearStudy, admitYear FROM Student WHERE 
        forename LIKE '%$searchTerm%' OR surname LIKE '%$searchTerm%'";
    $result = mysqli_query($db_con, $query);
    if (mysqli_num_rows($result) > 0) {
        $data[0][] = 'Student No.';
        $data[0][] = 'Forename';
        $data[0][] = 'Surname';
        $data[0][] = 'Degree Code';
        $data[0][] = 'Year of Study';
        $data[0][] = 'Admission Year';
        $i = 1;
        while ($row = mysqli_fetch_array($result)){
            $data[$i][] = $row['studentNo'];
            $data[$i][] = $row['forename'];
            $data[$i][] = $row['surname'];
            $data[$i][] = $row['degreeCode'];
            $data[$i][] = $row['yearStudy'];
            $data[$i][] = $row['admitYear'];
            $i++;
        }
    } else {
        $data = "FALSE";
    }
       
    // Free and close query+connection
    mysqli_free_result($result);
    mysqli_close($db_con);

    echo json_encode($data);
    exit();
?>