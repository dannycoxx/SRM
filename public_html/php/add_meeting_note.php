 <?php
    include ('../php/db_config.php');

    $staffNo = $_SESSION['accNo'];
    $data = array();

    if(isset($_POST['studentNo'])){
        $studentNo = $_POST['studentNo'];
        if(isset($_POST['meetingNote'])){
            $meetingNote = $_POST['meetingNote'];
            // $data['addmeetingnote'] = true;    
            addMeetingNote($db_con, $staffNo, $studentNo, $meetingNote);
           
        } else {
            $data['success'] = false;
            $data['message'] = 'Meeting note not found';
        } 
    } else {
        $data['success'] = false;
        $data['message'] = 'Student not found';
    } 
    
    function addMeetingNote($db_con, $staffNo, $studentNo, $meetingNote) {
        $date = date('Y-m-d H:i:s');
        
        $stmt = $db_con->prepare("INSERT INTO meetingnote VALUES (?, ?, ?, ?, DEFAULT)");
        $stmt->bind_param("iiss", $studentNo, $staffNo, $meetingNote, $date);
        $stmt->execute();
        
        
    }
    
    $data['success'] = true;
    $data['message'] = 'Meeting note successfully added to database';
    echo json_encode($data);

    exit();
    
?>