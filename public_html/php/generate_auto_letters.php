<?php
    include ('../php/db_config.php');
    $data = array();
    $data['studentNums'] = array();

    if(isset($_POST['generateAttendance'])){
        $generateAttendance = $_POST['generateAttendance'];
        if(isset($_POST['attendnaceThreshold'])){
            $attendnaceThreshold = $_POST['attendnaceThreshold'];
            $studentsLowAttendance = getAttendance($db_con, $attendnaceThreshold);
            $noStudentsPoorAttendance = count($studentsLowAttendance);

            // if ($noStudentsPoorAttendance > 0) {
            //     //UNCOMMENT
            //     addAttendance($db_con, $studentsLowAttendance);
            // }
            $data['noStudentsPoorAttendance'] = $noStudentsPoorAttendance;

        } else {
            $generateAttendance = false;
        }
    } else {
        $generateAttendance = false;
    }
    $generateResit = $_POST['generateResit'];
    if ($generateResit === 'true') {
        $studentsResit = getResit($db_con);
        $data['studentsResit'] = $studentsResit; 
        $data['noStudentsResit'] = count($studentsResit);
    } 
    
    function getAttendance($db_con, $attendnaceThreshold) {
        $query = 'SELECT student.email, 
            (   (COUNT(case when attendance.status = 1 then 1 else null end)
            /
                COUNT(attendance.status)
            ) * 100) as avg
            FROM session 
            JOIN registration 
                ON registration.moduleCode = session.moduleCode
            JOIN student 
                ON registration.studentNo = student.studentNo
            JOIN attendance
                ON attendance.sessionId = session.sessionId
            WHERE registration.status = 1
                AND student.enrolled = 1
            GROUP BY student.email
            ORDER BY student.email DESC';
        $result = mysqli_query($db_con, $query);
        if (mysqli_num_rows($result) > 0) {
            $studentsLowAttendance = array();
            while($row = mysqli_fetch_assoc($result)){
                $avgAttendance = $row['avg'];
                if ($avgAttendance <= $attendnaceThreshold) {
                    $recipient = $row['email'];
                    //Array of students with attendnace below threshold
                    array_push($studentsLowAttendance, $recipient);

                    $query = "SELECT comm.subject, comm.body FROM comm WHERE 
                        comm.subject = 'Poor Engagement with Studies'";
                    $result1 = mysqli_query($db_con, $query);

                    if (mysqli_num_rows($result1) > 0) {
                        $row = mysqli_fetch_assoc($result1);
                        $subject = $row['subject'];
                        $bodyBase = $row['body'];
                    }
                    $sender = 'studentoffice@liverpool.ac.uk';
                    $date = date('Y-m-d H:i:s', strtotime("+7 day"));
                    $data['date'] = $date;
                    $body = "";
                    $body = $bodyBase . "
                    Your attendance is: ".round($avgAttendance)."% which is below the threshold of: ".$attendnaceThreshold."%.";
                    // echo json_encode($body);
                    

                    $query = "INSERT INTO commhistory VALUES (DEFAULT, '$recipient', '$sender', '$subject', '$body', 0, 1, '$date')";
                    $result2 = mysqli_query($db_con, $query);
                    if (mysqli_insert_id($db_con) != 0) {
                        $commHistId = mysqli_insert_id($db_con);
                    } else {
                        exit();
                    }

                    $query = "INSERT INTO autocomm VALUES ('$commHistId', 0, '$date', DEFAULT)";
                    $result3 = mysqli_query($db_con, $query);
                }
            } 
        }
        return $studentsLowAttendance;
    }

    // function addAttendance($db_con, $studentsLowAttendance) {
    //     $query = "SELECT comm.subject, comm.body FROM comm WHERE 
    //         comm.subject = 'Poor Engagement with Studies'";
    //     $result = mysqli_query($db_con, $query);

    //     if (mysqli_num_rows($result) > 0) {
    //         $row = mysqli_fetch_assoc($result);
    //         $subject = $row['subject'];
    //         $body = $row['body'];
    //     }
    //     $sender = 'studentoffice@liverpool.ac.uk';
    //     $date = date('Y-m-d H:i:s', strtotime("+7 day"));
    //     $data['date'] = $date;
    //     foreach ($studentsLowAttendance as $value) {
    //         $query = "INSERT INTO commhistory VALUES (DEFAULT, '$value', '$sender', '$subject', '$body', 0, 1, '$date')";
    //         $result = mysqli_query($db_con, $query);
    //         if (mysqli_insert_id($db_con) != 0) {
    //             $commHistId = mysqli_insert_id($db_con);
    //         } else {
    //             exit();
    //         }

    //         $query = "INSERT INTO autocomm VALUES ('$commHistId', 0, '$date', DEFAULT)";
    //         $result = mysqli_query($db_con, $query);
    //     }
    // }

    function getResit($db_con) {
        $studentsResitting = array();
        // $studentResitArray = array();

        $studentsBelow40 = array();
        $query = 'SELECT student.studentNo, assessment.moduleCode, COUNT(DISTINCT assessment.moduleCode),
            (sum(marks.mark * (assessment.weight/100)) / COUNT(DISTINCT assessment.moduleCode)) as 	averageMark   
            FROM student
            JOIN marks
                ON marks.studentNo = student.studentNo
            JOIN assessment
                ON assessment.assessId = marks.assessId

            WHERE student.enrolled = 1
            GROUP BY student.studentNo';
        $result = mysqli_query($db_con, $query);
        if (mysqli_num_rows($result) > 0) {
            $studentResitData = array();
            $noModules = 0;
            while($row = mysqli_fetch_assoc($result)){
                if ($row['averageMark'] < 40) {
                    //Array of students with attendnace below threshold
                    array_push($studentsBelow40, $row['studentNo']);
                }
            } 

        }
        foreach ($studentsBelow40 as $value) {
            $manModuleArray = array();
            $query = "SELECT manmodule.moduleCode from manmodule join student
	            on student.degreeCode = manmodule.degreeCode
                WHERE student.studentNo = '$value'";
            $result = mysqli_query($db_con, $query);
            //if degree has mandetory modules
            if (mysqli_num_rows($result) > 0) {
                    while($row = mysqli_fetch_assoc($result)){
                    array_push($manModuleArray, $row);
                }
            }
            $moduleDataArray = array();
            $query = "SELECT student.studentNo,assessment.moduleCode, module.credit,
            sum(marks.mark * (assessment.weight/100)) as averageModuleMark   
                FROM student
                JOIN marks
                    ON marks.studentNo = student.studentNo
                JOIN assessment
                    ON assessment.assessId = marks.assessId
                JOIN module 
                    ON assessment.moduleCode = module.moduleCode
                WHERE student.enrolled = 1
                AND student.studentNo = '$value'
                
                GROUP BY assessment.moduleCode";
            $result = mysqli_query($db_con, $query);
            //if degree has mandetory modules
            if (mysqli_num_rows($result) > 0) {
                while($row = mysqli_fetch_assoc($result)){
                    array_push($moduleDataArray, $row);
                }
            }

            $resitting = false;
            $sumMarks = 0;
            $credits = 0;
            $creditsPassed = 0;
            $studentMarksArray = array();

            for ($i=0; $i<count($moduleDataArray); $i++) {
                $studentNo = $moduleDataArray[$i]['studentNo'];
                $avgModuleMark = $moduleDataArray[$i]['averageModuleMark'];
                $moduleCredits = $moduleDataArray[$i]['credit'];
                $moduleCode = $moduleDataArray[$i]['moduleCode'];

                $sumMarks = $sumMarks + $avgModuleMark;
                $credits = $credits + $moduleCredits;

                if (($avgModuleMark < 35) ||(in_array($moduleCode, $manModuleArray) && $avgModuleMark < 40)) {
                    $resitting = true;
                    $studentMarksArray[$moduleCode]['pass'] = "FAILED";
                    $studentMarksArray[$moduleCode]['mark'] = $avgModuleMark;
                } else if ($avgModuleMark > 40) {
                    $creditsPassed = $creditsPassed + $moduleCredits;
                    $resitting = false;
                    $studentMarksArray[$moduleCode]['pass'] = "PASSED";
                    $studentMarksArray[$moduleCode]['mark'] = $avgModuleMark;
                }
                if ($creditsPassed < 90 || $sumMarks / $credits < 40) {
                    $resitting = true;
                }
                
                if ($resitting == true) {
                    array_push($studentsResitting, $studentNo);

                    $query = "SELECT comm.subject, comm.body FROM comm WHERE 
                    comm.commId = 2";
                    $result = mysqli_query($db_con, $query);

                    if (mysqli_num_rows($result) > 0) {
                        $row = mysqli_fetch_assoc($result);
                        $subject = $row['subject'];
                        $bodyBase = $row['body'];
                    }
                    $resitAttachment = "";
                    // echo json_encode($studentMarksArray[$moduleCode]);
                    for ($i=0; $i<count($studentMarksArray); $i++) {
                        $resitAttachment = $resitAttachment . " ". $studentMarksArray[$moduleCode]['pass'].
                        " ".$moduleCode.
                        " with an average mark of: "
                        .round($studentMarksArray[$moduleCode]['mark']."%");
                    }
                    $body = "";
                    $body = $bodyBase . $resitAttachment;
                    $body = $body . ".
                    You will need to resit failed modules.";

                    $sender = 'studentoffice@liverpool.ac.uk';
                    $date = date('Y-m-d H:i:s', strtotime("+7 day"));
                    $data['date'] = $date;
                    $query = "SELECT email FROM student WHERE studentNo = '$studentNo'";
                    $result = mysqli_query($db_con, $query);
                    $row = mysqli_fetch_assoc($result);
                    $studentEmail = $row['email'];

                    $query = "INSERT INTO commhistory VALUES (DEFAULT, '$studentEmail', '$sender', '$subject', '$body', 0, 1, '$date')";
                    $result = mysqli_query($db_con, $query);
                    if (mysqli_insert_id($db_con) != 0) {
                        $commHistId = mysqli_insert_id($db_con);
                    } 

                    $query = "INSERT INTO autocomm VALUES ('$commHistId', 0, '$date', DEFAULT)";
                    $result = mysqli_query($db_con, $query);
                }
            }
    }
    return $studentsResitting;
}
    // function addResit($db_con, $studentsBelow40) {
    //     $query = "SELECT comm.subject, comm.body FROM comm WHERE 
    //         comm.commId = 2";
    //     $result = mysqli_query($db_con, $query);

    //     if (mysqli_num_rows($result) > 0) {
    //         $row = mysqli_fetch_assoc($result);
    //         $subject = $row['subject'];
    //         $body = $row['body'];
    //     }
    //     $sender = 'studentoffice@liverpool.ac.uk';
    //     $date = date('Y-m-d H:i:s', strtotime("+7 day"));
    //     $data['date'] = $date;
    //     foreach ($studentsBelow40 as $value) {
    //         $query = "SELECT email FROM student WHERE studentNo = '$value'";
    //         $result = mysqli_query($db_con, $query);
    //         $row = mysqli_fetch_assoc($result);
    //         $studentEmail = $row['email'];

    //         $query = "INSERT INTO commhistory VALUES (DEFAULT, '$studentEmail', '$sender', '$subject', '$body', 0, 1, '$date')";
    //         $result = mysqli_query($db_con, $query);
    //         if (mysqli_insert_id($db_con) != 0) {
    //             $commHistId = mysqli_insert_id($db_con);
    //         } else {
    //             exit();
    //         }

    //         $query = "INSERT INTO autocomm VALUES ('$commHistId', 0, '$date', DEFAULT)";
    //         $result = mysqli_query($db_con, $query);
    //     }
    // }



    
    
         
    
    echo json_encode($data);
    mysqli_close($db_con);
    exit();
?>