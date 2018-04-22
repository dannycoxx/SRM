NProgress.start();
var recipientCheck;
var recipients;

$(document).ready(function () {
    NProgress.done();
});

function sendEmail() {
    NProgress.start();
    
    if (checkRecipients() == false) {
        error('Please enter a valid recipient(s)');
    } else {
        var subject = document.getElementById("emailSubject").value.trim();
        var subject = subject.trim();
        var body = document.getElementById("emailBody").value.trim();
        var body = body.trim();
        
        // console.log(" ")
        if (checkRecipients()) {
            var dataToSend = {
                recipients: recipients,
                subject: subject, 
                body: body,
                page: currentPage
            }
            // console.log(dataToSend);
            $.ajax({
                type: 'POST',
                url: 'http://localhost/public_html/php/send_email.php',
                data: dataToSend,
                dataType: "json",
                success: function (data) {
                    NProgress.done();
                    if (data['success'] == true) {
                        success('Email successfully sent');
                    } else if (data['success'] == false) {
                        error($data['message']);
                    }
                },
                error: function (msg) {
                    NProgress.done();
                    error('An error has occured');
                }
            });
        }
    }
    
}

function checkRecipients () {
    var recipientsRaw = document.getElementById("emailRecipients").value.trim();

    if (recipientsRaw != "") {
        if (/,/.test(recipientsRaw)) {
            recipients = recipientsRaw.split(",");
            for (var i = 0; i < recipients.length; i++) {
                recipients[i] = recipients[i].trim();
                if (/\S+@\S+\.\S+/.test(recipients[i]) == false) {
                    var recipientCheck = false;
                }
            }
            if (recipientCheck != false) {
                var recipientCheck = true;
            }
        } else if (/,/.test(recipientsRaw) == false){
            recipients = recipientsRaw.trim();
            if (/\S+@\S+\.\S+/.test(recipients) == false) {
                var recipientCheck = false;
            } else {
                var recipientCheck = true;
            }
        }
    } else {
        var recipientCheck = false;
    }
    if (recipientCheck == false) {
        document.getElementById("emailRecipients").style.borderColor = "red";
    } else if (recipientCheck){
        document.getElementById("emailRecipients").style.borderColor = "#1e1e1e";
    }
    return recipientCheck;
}