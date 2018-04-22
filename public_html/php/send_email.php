<?php
    use PHPMailer\PHPMailer\PHPMailer;
    require_once ('../php/db_config.php');
    require_once ('../php/PHPMailer/src/Exception.php');
    require_once ('../php/PHPMailer/src/PHPMailer.php');
    require_once ('../php/PHPMailer/src/SMTP.php');
    $recipients = $_POST['recipients'];
    if(isset($_POST['subject'])) { 
        $subject = $_POST['subject'];
    } else {
        $subject = "";
    }
    if(isset($_POST['body'])) { 
        $body = $_POST['body'];   
    } else {
        $body = "";
    }
 
    if (isset($_POST['forgotPass'])) {
        //query DB, get
    }
    $data = Array();
    $senderDetails = getSenderDetails($db_con);
    $senderName = $senderDetails['name'];
    $senderEmail = $senderDetails['email'];

    
    $date = date('Y-m-d H:i:s');
    if (is_array($recipients)) {
        foreach ($recipients as $emailAddress) {
            sendEmail($senderEmail, $senderName, $emailAddress, $subject, $body); 
            addCommDatabase($db_con, $emailAddress, $date, $senderEmail, $subject, $body);
        }
    } else {
        sendEmail($senderEmail, $senderName, $recipients, $subject, $body); 
        addCommDatabase($db_con, $recipients, $date, $senderEmail, $subject, $body);
    }

    
    mysqli_close($db_con);
    exit(); 

    function getSenderDetails($db_con) {
        $accNo = $_SESSION['accNo'];
        $userType = $_SESSION['userType'];
        if ($userType == 'OA') {
            $sender['name'] = 'Student Office';
            $sender['email'] = 'studentoffice@liverpool.ac.uk';
        } else {
            if ($userType == 'S') {
                $query = "SELECT forename, surname, email from student where studentNo = $accNo";
            } else if ($userType == 'SA' || $userType == 'L') {
                $query = "SELECT forename, surname, email from staff where staffNo = $accNo";
            } 

            $result = mysqli_query($db_con, $query);
            if (mysqli_num_rows($result) > 0) {
                $row = mysqli_fetch_array($result);

                $sender['name'] = $row['forename'] . $row['surname'];
                $sender['email'] = $row['email'];
            } else {
                //couldn't find mwsUser in DB
                $data['valid'] = 'false';
                $data['message'] = 'Error getting email';
                echo json_encode($data);
                mysqli_close($db_con);
                exit();  
            }
        // Free and close query+connection
        mysqli_free_result($result);
        }
        return $sender;
    }

    function sendEmail($senderEmail, $senderName, $recipients, $subject, $body) {
        $mail = new PHPMailer ();

        try {
            //Server settings
            // $mail->SMTPDebug = 2;                                 // Enable verbose debug output
            /*$mail->isSMTP();                                      // Set mailer to use SMTP
            $mail->Host = 'mail1.liv.ac.uk';  // Specify main and backup SMTP servers
            $mail->SMTPAuth = true;                               // Enable SMTP authentication
            $mail->Username = 'sgdcox';                 // SMTP username
            $mail->Password = 'duckyshine';                           // SMTP password
            $mail->SMTPSecure = 'ssl';                            // Enable TLS encryption, `ssl` also accepted
            $mail->Port = 465;                                    // TCP port to connect to
*/
            $mail->isSMTP();                                      // Set mailer to use SMTP
            $mail->Host = 'smtp.mailgun.org';  // Specify main and backup SMTP servers
            $mail->SMTPAuth = true;                               // Enable SMTP authentication
            $mail->Username = 'postmaster@test.srm.com';                 // SMTP username
            $mail->Password = '679f325eba9a990c08e3afbfc171718b-2b4c5a6c-f2df826b';                           // SMTP password
            $mail->SMTPSecure = 'ssl';                            // Enable TLS encryption, `ssl` also accepted
            $mail->Port = 465; 
            
            $mail->setFrom($senderEmail, $senderName);
            $mail->addReplyTo($senderEmail);
            if (is_array($recipients)) {
                foreach ($recipients as $emailAddress) {
                    $mail->addAddress($emailAddress);
                }
            } else {
                $mail->addAddress($recipients);
            }
            $mail->Subject = $subject;
            $mail->Body = $body;
        
            $mail->send();
            $data['success'] = true;
            $data['message'] = 'Email successfully sent';

        } catch (Exception $e) {
            $data['success'] = false;
            $data['message'] = 'Message could not be sent. Mailer Error: ' . $mail->ErrorInfo;
        }
        echo json_encode($data);
    }

    function addCommDatabase($db_con, $recip, $date, $senderEmail, $subject, $body) {
        $read = 0;
        $confidential = 1;

        $stmt = $db_con->prepare("INSERT INTO commhistory VALUES (DEFAULT, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("ssssiis", $recip, $senderEmail, $subject, $body, $read, $confidential, $date);
        $stmt->execute();
    }
?>