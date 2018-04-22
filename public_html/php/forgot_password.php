<?php
    use PHPMailer\PHPMailer\PHPMailer;
    require_once ('../php/db_config.php');
    require_once ('../php/PHPMailer/src/Exception.php');
    require_once ('../php/PHPMailer/src/PHPMailer.php');
    require_once ('../php/PHPMailer/src/SMTP.php');

    require_once ('../php/db_config.php');
    // require_once ('../php/send_email.php');

    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $page = $_POST['page'];

    $data = array();

    $query = "SELECT staffNo, phone, email FROM Staff WHERE email = ?";
    $stmt = mysqli_stmt_init($db_con);

    for ($i=0; $i <=1; $i++) {
        if(!mysqli_stmt_prepare($stmt, $query)) {
            $data['success'] = false;
            $data['message'] = "Failed to prepare statement";
        } else {
            mysqli_stmt_bind_param($stmt, "s", $email);
            mysqli_stmt_execute($stmt);

            $result = mysqli_stmt_get_result($stmt);
            $row = mysqli_fetch_array($result);
            
            if (!empty($row)) {
                $i++;
            }
            $query = "SELECT studentNo, termPhone, email FROM Student WHERE email = ?";
        }
    }
    //Correct email
    if (!empty($row)) {
        //Correct email, correct phone no
        if ((isset($row['termPhone']) && $phone == $row['termPhone']) || (isset($row['phone']) && $phone == $row['phone'])) {
            $recipient = $row['email'];
            $data['recipient'] = $recipient;
            $randomPass = substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"), 0, 15);
            $randomPass = trim($randomPass);
            $passHash = password_hash($randomPass, PASSWORD_DEFAULT);
            if (isset($row['staffNo'])) {
                $accNo = $row['staffNo'];
                $query = "UPDATE staff SET mwsPassword = '$passHash' WHERE staffNo = '$accNo'";
                // $query = "UPDATE staff SET mwsPassword = '$randomPass' WHERE staffNo = '$accNo'";
            } else if (isset($row['studentNo'])) {
                $accNo = $row['studentNo'];
                $query = "UPDATE student SET mwsPassword = '$passHash' WHERE studentNo = '$accNo'";
                // $query = "UPDATE student SET mwsPassword = '$randomPass' WHERE studentNo = '$accNo'";
            }
            mysqli_query($db_con, $query);
            // $data['affected'] = mysqli_affected_rows($db_con);
            if (mysqli_affected_rows($db_con) > 0)  {
                $subject = 'IMPORTANT: Password Reset';
                $body = <<<EOT
                Your password has been reset for account number: $accNo.

                Your new password is: 
                
                $passHash

                After logging in, please change your password as soon as possible.

                Admin

                University of Liverpool.
EOT;

                sendEmail($recipient, $subject, $body);
                $date = date('Y-m-d H:i:s');
                addCommDatabase($db_con, $recipient, $date, 'admin@liverpool.ac.uk', $subject, $body);
                $data['resetPass'] = true;  
            } else {
                $data['resetPass'] = false;
                $data['message'] = "Unable to reset password, please contact server admin";
                $data['failType'] = "query";
            }
        } else {
                $data['resetPass'] = false;
                $data['message'] = "Phone number incorrect";
                $data['failType'] = "phone";
                // $data['result'] = $row;
            }
            //email doesn't exist in staff table
        } else {
            $data['resetPass'] = false;
            $data['message'] = "Email address not found";
            $data['failType'] = "email";
        }
        mysqli_stmt_close($stmt);
    
function sendEmail($recipient, $subject, $body) {
        $mail = new PHPMailer ();

        try {
            //Server settings
            // $mail->SMTPDebug = 2;                                 // Enable verbose debug output
            // $mail->isSMTP();                                      // Set mailer to use SMTP
            // $mail->Host = 'mail1.liv.ac.uk';  // Specify main and backup SMTP servers
            // $mail->SMTPAuth = true;                               // Enable SMTP authentication
            // $mail->Username = 'sgdcox';                 // SMTP username
            // $mail->Password = 'duckyshine';                           // SMTP password
            // $mail->SMTPSecure = 'ssl';                            // Enable TLS encryption, `ssl` also accepted
            // $mail->Port = 465;                                    // TCP port to connect to

            $mail->isSMTP();                                      // Set mailer to use SMTP
            $mail->Host = 'smtp.mailgun.org';  // Specify main and backup SMTP servers
            $mail->SMTPAuth = true;                               // Enable SMTP authentication
            $mail->Username = 'postmaster@test.srm.com';                 // SMTP username
            $mail->Password = '679f325eba9a990c08e3afbfc171718b-2b4c5a6c-f2df826b';                           // SMTP password
            $mail->SMTPSecure = 'ssl';                            // Enable TLS encryption, `ssl` also accepted
            $mail->Port = 465; 

            $mail->setFrom('admin@liverpool.ac.uk', 'UoL Admin');
            $mail->addReplyTo('admin@liverpool.ac.uk');
            $mail->addAddress('dannyc179@gmail.com');

            $mail->Subject = $subject;
            $mail->Body = $body;
        
            $mail->send();

        } catch (Exception $e) {
            $data['resetPass'] = false;
            $data['failType'] = "sending";
            $data['message'] = 'Email failed to send, contact system admin';
        }
    }

    function addCommDatabase($db_con, $recip, $date, $senderEmail, $subject, $body) {
        $read = 0;
        $confidential = 1;

        $stmt = $db_con->prepare("INSERT INTO commhistory VALUES (DEFAULT, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("ssssiis", $recip, $senderEmail, $subject, $body, $read, $confidential, $date);
        $stmt->execute();
        //commHistId recipient sender subject body read confidential dateTime
        //i = int, s=string
    }
    
    
    mysqli_close($db_con);

    echo json_encode($data);
    
    exit();
?>