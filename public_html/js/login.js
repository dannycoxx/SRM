NProgress.start();
$(document).ready(function () {
    // $("username").focus();
    document.getElementById("username").select();
    setCurrentPage('index');
    //call function in wrapper.js
    if (authenticateLogIn()) {
        window.location.replace("home.html");
        setCurrentPage('home');
    }
    NProgress.done();
});
$(document).on('keydown', function (e) {
    if (e.keyCode == 13 && page == 'login') { // ESC
        login();
    } else if (e.keyCode == 13 && page == 'forgotPass') { // ESC
        sendForgotEmail();
    }
});


function login() {
    NProgress.start();
    document.getElementById("username").style.borderColor = "#1e1e1e";
    document.getElementById("usernameError").innerHTML = "";
    document.getElementById("password").style.borderColor = "#1e1e1e";
    document.getElementById("passwordError").innerHTML = "";

    var username = document.getElementById('username').value.trim();
    var password = document.getElementById('password').value;

    if (username && password) {
        var dataToSend = {
            username: username,
            password: password
        }
        $.ajax({
            type: 'POST',
            url : 'http://localhost/public_html/php/login.php',
            data: dataToSend,
            dataType : "json",
            success: function (data) {
                // console.log(data);
                if (data['login'] == 'true') {
                    loginSuccess(data['userType']);
                } else {
                    NProgress.done();
                    error(data['message']);
                    if (data['failType'] == "username") {
                        usernameError(data['message']);
                    } else if (data['failType'] == "password") {
                        passwordError(data['message']);
                    }
                }
            },
            error : function (msg) {
                // console.log(msg);
                error('An error has occured');
            }
        });
        // NProgress.done();
    } else {
        error('Unable to login');
        if (!username) {
            usernameError("Please enter username");
        }
        if (!password) {
            passwordError("Please enter password");
        }
        NProgress.done();
    }
}

function usernameError(fail) {
    document.getElementById("username").style.borderColor = "red";
    document.getElementById("usernameError").innerHTML = fail;
    
}
function passwordError(fail) {
    document.getElementById("password").style.borderColor = "red";
    document.getElementById("passwordError").innerHTML = fail;
}

function loginSuccess(userType) {
    window.location.replace("home.html");

    // document.getElementById('mwsUser').value = mwsUser;
}