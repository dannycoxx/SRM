<?php
    include ('../php/db_config.php');
    
    $studentNo = $_POST['studentNo'];
    $requesterUserType = $_SESSION['userType'];
    $requesterAccNo = $_SESSION['accNo'];
    if ($studentNo == "") {
        $studentNo = $requesterAccNo;
    }

    $data = array();
    $moduleCodes = array();
    $data['userType'] = $requesterUserType;
    $data['personalInfoAccess'] = checkUserAccess($db_con, $requesterUserType, $requesterAccNo, $studentNo);
    // $data['requesterUserType'] = $requesterUserType;
    //Student is accessing their own information
    if ($requesterUserType == "S") {
        $data['personalInfo'] = getPersonalInformation($studentNo, $db_con);
        $data['moduleInfo'] = getModules($studentNo, $db_con);
        // $data['timetable'] = getTimetable($studentNo, $data, $db_con, $data['moduleInfo']);
        $data['attendance'] = getAttendance($studentNo, $db_con);
        
        $data['meetingNotes'] = getMeetingNotes($studentNo, $db_con);
        $data['emails'] = getEmails($studentNo, $db_con, $data['personalInfoAccess'], $requesterUserType, $requesterAccNo);
        //lecturer requesting information
    } else if ($requesterUserType == "L") {
        //check if lecturer has access rights
        $data['personalInfo'] = getPersonalInformation($studentNo, $db_con);
        $data['moduleInfo'] = getModules($studentNo, $db_con);
        // $data['timetable'] = getTimetable($studentNo, $data, $db_con, $data['moduleInfo']);
        $data['attendance'] = getAttendance($studentNo, $db_con);
        if ($data['personalInfoAccess'] == true) {
            $data['meetingNotes'] = getMeetingNotes($studentNo, $db_con);
            $data['emails'] = getEmails($studentNo, $db_con, $data['personalInfoAccess'], $requesterUserType, $requesterAccNo);
        }
        // $data['personalInfo'] = getMarks($studentMws, $db_con);
        //Office Admin requesting information
    } else if ($requesterUserType == "OA") {
        $data['personalInfo'] = getPersonalInformation($studentNo, $db_con);
        $data['moduleInfo'] = getModules($studentNo, $db_con);
        // $data['timetable'] = getTimetable($studentNo, $data, $db_con, $data['moduleInfo']);
        $data['attendance'] = getAttendance($studentNo, $db_con);
        $data['meetingNotes'] = getMeetingNotes($studentNo, $db_con);
        $data['emails'] = getEmails($studentNo, $db_con, $data['personalInfoAccess'], $requesterUserType, $requesterAccNo);

        //System Admin requesting information
    } else if ($requesterUserType == "SA") {
        $data['personalInfo'] = getPersonalInformation($studentNo, $db_con);
        $data['attendance'] = getAttendance($studentNo, $db_con);
        // $data['emails'] = getEmails($studentNo, $db_con, $data['personalInfoAccess'], $requesterUserType, $requesterAccNo);
    } else {
        
    }
    echo json_encode($data);
    mysqli_close($db_con);
    exit();

    function checkUserAccess($db_con, $userType, $accNo, $studentNo) {
        $data['personalInfoAccessReason'] = 'none';
        if ($userType == "S" && $accNo == $studentNo) {
            return true;
        } else if ($userType == "L") {
            $query = "SELECT advisor, email FROM student WHERE
                studentNo = '$studentNo'";
            $result = mysqli_query($db_con, $query); 
            $row = mysqli_fetch_assoc($result);
            $advisor = $row['advisor'];
            $studentEmail = $row['email'];

            $query = "SELECT email FROM staff WHERE
                staffNo = '$accNo'";
            $result = mysqli_query($db_con, $query); 
            $row = mysqli_fetch_assoc($result);
            $lecturerEmail = $row['email'];
            if ($advisor == $lecturerEmail) {
                return true;
            } else {
                //Check if lecturer teaches one module student is on
                $coordinatorArray = array();
                $query = "SELECT Module.coordinator FROM Module 
                    JOIN Registration ON Module.moduleCode = Registration.moduleCode 
                    where Registration.studentNo = '$studentNo' 
                    AND Registration.status = 1";

                $result = mysqli_query($db_con, $query);

                if (mysqli_num_rows($result) > 0) {
                    while($row['coordinator'] = mysqli_fetch_assoc($result)){
                        array_push($coordinatorArray, $row['coordinator']);
                    }
                } 
                if (in_array($lecturerEmail, $coordinatorArray)) {
                    return true;
                } else {
                    $query = "SELECT requester, status FROM request 
                    where student = '$studentEmail'
                    AND requester = '$lecturerEmail' 
                    AND status = 1";

                    $result = mysqli_query($db_con, $query);

                    if (mysqli_num_rows($result) > 0) {
                        return true;
                    } else {
                        return false;
                    }

                    $data['personalInfoAccessReason'] = '1';
                    return true;
                }

            }    
        } else if ($userType == "OA") {
            return true;
        } else if ($userType == "SA") {
            return false;
        }
    }
    
    function getPersonalInformation($studentNo, $db_con) {
        $query = "SELECT studentNo, forename, surname, mwsUser, csdUser, 
            email, prefEmail, permAddress, termAddress, phone, termPhone, 
            advisor, degreeCode, yearStudy, admitYear FROM student WHERE
            studentNo = '$studentNo'";

        $result = mysqli_query($db_con, $query); 

        if (mysqli_num_rows($result) > 0) {
            $data['personalInfo'] = mysqli_fetch_assoc($result);               
        } else {
            $data['personalInfo'] = false;
        }
        return $data['personalInfo'];
        mysqli_free_result($result);
    }
    
    function getModules($studentNo, $db_con) {
        $data['moduleInfo'] = array();
        $query = "SELECT Module.* FROM Module 
            JOIN Registration ON Module.moduleCode = Registration.moduleCode 
                where Registration.studentNo = '$studentNo' 
                AND Registration.status = 1";

        $result = mysqli_query($db_con, $query);

        if (mysqli_num_rows($result) > 0) {
            while($row = mysqli_fetch_assoc($result)){
                array_push($data['moduleInfo'], $row);
                // $data['moduleInfo'] = $row;  
            }
        } else {
            $data['moduleInfo'] = false;
        }
        return $data['moduleInfo'];
        mysqli_free_result($result);
    }
    
    function getAttendance($studentNo, $db_con) {
        $query = "SELECT student.email, 
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
                 WHERE student.studentNo = '$studentNo'
           ";
        $result = mysqli_query($db_con, $query);
        $row = mysqli_fetch_assoc($result);

        return round($row['avg']);
        mysqli_free_result($result);
    }
    function getTimetable($studentNo, $data, $db_con, $moduleInfo) {
        //check current date so timetable only loads for current week
        $timetableArray = array();
        $moduleCodes = array_column($moduleInfo, 'moduleCode');

        $i = 0;
        $moduleCodeQuery = "";
        foreach ($moduleCodes as $value) {
            $moduleCodeQuery = $moduleCodeQuery.'moduleCode = \''.$value.'\'';
            $i++;
            if ($i < count($moduleCodes)) {
                $moduleCodeQuery = $moduleCodeQuery.' OR ';
            }
        }
        $query = "SELECT * FROM session WHERE ".$moduleCodeQuery;
        $result = mysqli_query($db_con, $query);

        if (mysqli_num_rows($result) > 0) {
            while($row = mysqli_fetch_assoc($result)){
                array_push($timetableArray, $row);
            } 
        } else {
            $timetableArray = false;
        }
        
        // array_push($data['timetable'], $moduleCodes);
        return $timetableArray;
        mysqli_free_result($result);
    }

    // function getAttendance($studentNo, $data, $db_con) {
    //     $data['attendance'] = array();
    //     $sessionIds = array_column($data['timetable'], 'sessionId');
    //     $i = 0;
    //     $sessionIdQuery = "";
    //     foreach ($sessionIds as $value) {
    //         $sessionIdQuery = $sessionIdQuery.'sessionId = '.$value;
    //         $i++;
    //         if ($i < count($sessionIds)) {
    //             $sessionIdQuery = $sessionIdQuery.' OR ';
    //         }
    //     }
    //     $query = "SELECT sessionId, status FROM attendance WHERE studentNo = '$studentNo' AND(".$sessionIdQuery.")";
    //     $result = mysqli_query($db_con, $query);

    //     if (mysqli_num_rows($result) > 0) {
    //         while($row = mysqli_fetch_assoc($result)){
    //             array_push($data['attendance'], $row);
    //         } 
    //     } else {
    //         $data['attendance'] = false;
    //     }
    //     return $data['attendance'];
    //     mysqli_free_result($result);
    // }

    function getEmails($studentNo, $db_con, $access, $requesterUserType, $requesterAccNo) {
        $data['emails'] = array();
        $i = 0;
        $query = "SELECT email FROM student WHERE studentNo = '$studentNo'";
        $result = mysqli_query($db_con, $query);
        $row = mysqli_fetch_assoc($result);
        $studentEmail = $row['email'];
        $studentOfficeEmail = 'studentoffice@liverpool.ac.uk';

        if ($requesterUserType == 'S' ) {
            $query = "SELECT sender, recipient, subject, body, dateTime FROM commHistory WHERE recipient = '$studentEmail'";
        } else if ($requesterUserType == 'OA') {
            $query = "SELECT sender, recipient, subject, body, dateTime FROM commHistory WHERE recipient = '$studentEmail' AND sender = '$studentOfficeEmail'";
        } else if ($requesterUserType == 'L' || $requesterUserType == 'SA') {
            $query = "SELECT email FROM staff WHERE staffNo = '$requesterAccNo'";
            $result = mysqli_query($db_con, $query);
            $row = mysqli_fetch_assoc($result);
            $lecturerEmail = $row['email'];

            $query = "SELECT sender, recipient, subject, body, dateTime FROM commHistory WHERE recipient = '$studentEmail' AND sender = '$lecturerEmail'";
        }
        
        $result = mysqli_query($db_con, $query);

        if (mysqli_num_rows($result) > 0) {
            while($row = mysqli_fetch_assoc($result)){
                array_push($data['emails'], $row);
            } 
        } else {
            $data['emails'] = false;
        }
        return $data['emails'];
        mysqli_free_result($result);
    }

    function getMeetingNotes($studentNo, $db_con) {
        $data['meetingNotes'] = array();

        $query = "SELECT staffNo, content, dateTime FROM meetingnote WHERE studentNo = '$studentNo'";
        $result = mysqli_query($db_con, $query);

        if (mysqli_num_rows($result) > 0) {
            while($row = mysqli_fetch_assoc($result)){
                array_push($data['meetingNotes'], $row);
            } 
        } else {
            $data['meetingNotes'] = false;
        }
        return $data['meetingNotes'];
        mysqli_free_result($result);
    }
    /*
    function getMarks() {
        //get modules student registered on
        //get assessments for modules
        //get marks for assessment
        //populate table for modules & assessments
        //populate marks
        $studentData['marks'] = $result;
        mysqli_free_result($result);
    }
*/

?>