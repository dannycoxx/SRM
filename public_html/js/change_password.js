$(document).ready(function () {
    NProgress.done();
});
function changePassword() {
    var pass1 = document.getElementById("pass1").value.trim();
    var pass2 = document.getElementById("pass2").value.trim();
    var currentPass = document.getElementById("currentPass").value.trim();
    var dataToSend = {
        pass1: pass1,
        pass2: pass2,
        currentPass: currentPass
    }
    if (pass1 && pass2 && currentPass) {
        $.ajax({
            type: 'POST',
            url: 'http://localhost/public_html/php/change_password.php',
            data: dataToSend,
            dataType: "json",
            success: function (data) {
                if (data['success'] == true) {
                    success("Password successfully changed");
                } else  if (data['success'] == false) {
                    error(data['message']);
                }
            },
            error: function (msg) {
                error('An error has occured');
                console.log(msg);
            }
        });
    } else {
        error('One or more fields empty');
    }
}