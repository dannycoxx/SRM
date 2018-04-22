 <?php
    include ('../php/db_config.php');
    $assessIdArray = $_POST['assessIdArray'];
    $myTableArray = $_POST['myTableArray'];
  
//  $stmt = $db_con->prepare("INSERT INTO marks VALUES (DEFAULT, ?, ?, ?, ?)");
//                 $stmt->bind_param("idis", $studentNo, $assessId, $attempt, $mark);
//                 $stmt->execute();
    $attempt = 0;
    for ($i=0; $i<count($myTableArray); $i++) {
        $studentNo = $myTableArray[$i][0];
        $data['test1'] = $studentNo;
        $k = 0;
        for ($j=0; $j<count($myTableArray[$i]); $j++) {
            //if not studentNo or prog
            if ($j > 1) {
                $assessId = $assessIdArray[$k];
                if ($myTableArray[$i][$j] == "")  {
                    $mark = 0;
                } else {
                    $mark = $myTableArray[$i][$j];
                }
                $types = "idis";
                $stmt = $db_con->prepare("INSERT INTO marks VALUES (?, ?, ?, ?, DEFAULT)");
                $stmt->bind_param("idis", $studentNo, $assessId, $attempt, $mark);
                $stmt->execute();
                $k++;
            }
        }
    }
    $data['success'] = true;
    $data['message'] = "Module marks added to database";
    
    mysqli_close($db_con);
    
    echo json_encode($data);
    exit();
?>