NProgress.start();
$(document).ready(function () {
    NProgress.done();
});
var page = 'login';
function showIdEntry() {
    $("#replaceWithContainer").replaceWith(`
        <div id="replaceWithContainer" class="logIn">
            <div class="logInSection">
                <h1>Student Relationship Management</h1>
            </div>
            <div class="logInSection">
                <h2>Forgot Password</h2>
                <p>This will send an email to your university email address with instructions to access your account.</p>
            </div>
            <div class="logInSection">
                <input type="text" id="email" name="email" placeholder="University Email" maxlength="70">
                <p class="errorText" id=emailError></p>
            </div>
            <div class="logInSection">
                <input type="text" id="phone" name="phone" placeholder="Term Phone Number" maxlength="15">
                <p class="errorText" id=phoneError></p>
            </div>
            <div class="logInSection">
                <button type="button" class="logIn" onclick="sendForgotEmail()">Reset Password</button>
            </div>
            <div class="logInSection">
                <p id="forgotPass"  class="forgotPass" onclick="showLogIn()">Return to Login</p>
            </div>
        </div>
    `);
    page = 'forgotPass'
}
function showLogIn() {
    $("#replaceWithContainer").replaceWith(`
        <div id="replaceWithContainer" class="logIn">
            <div class="logInSection">
                <h1>Student Relationship Management</h1>
            </div>
            <div class="logInSection">
                <h2>Log In</h2>
                <p>using your MWS account details.</p>
            </div>
            <div class="logInSection">
                <input type="text" id="username" name="username" placeholder="Username" maxlength="80">
                <p class="errorText" id=usernameError></p>
            </div>
            <div class="logInSection">
                <input type="password" id="password" name="password" placeholder="Password" maxlength="70">
                <p class="errorText" id=passwordError></p>
            </div>
            <div class="logInSection">
                <button type="button" class="logIn" onclick="login()">Log In</button>
            </div>
            <div class="logInSection">
                <p id="forgotPass"  class="forgotPass" onclick="showIdEntry()">Forgot password?</p>
            </div>
        </div>
    `);
    page = 'login'
}

function emailError(fail) {
    document.getElementById("email").style.borderColor = "red";
    document.getElementById("emailError").innerHTML = fail;
    
}
function phoneError(fail) {    
    document.getElementById("phone").style.borderColor = "red";
    document.getElementById("phoneError").innerHTML = fail;
}
function passResetSuccess(userType) {
    window.location.replace("index.html");
    success('Password successfully reset, please check your university email');
}
function sendForgotEmail() {
    // console.log("sendforgoremail");
    document.getElementById("email").style.borderColor = "#1e1e1e";
    document.getElementById("emailError").innerHTML = "";
    document.getElementById("phone").style.borderColor = "#1e1e1e";
    document.getElementById("phoneError").innerHTML = "";
    
    var email = document. getElementById("email").value.trim();
    var phone = document.getElementById("phone").value.trim();
    if (email && phone) {
        if (/\S+@\S+\.\S+/.test(email) == false) {
            emailError('Invalid email address');
        } else if(/[^\+{0,1}\d+]/g.test(phone) == true){
            phoneError('Invalid phone number');
        } else {
            var dataToSend = {
                email: email,
                phone: phone,
                page: page
            }
            $.ajax({
                type: 'POST',
                url: 'http://localhost/public_html/php/forgot_password.php',
                data: dataToSend,
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    if (data['resetPass'] == true) {
                        // passResetSuccess();
                        success('Password successfully reset, please check your university email account');
                    } else {
                        error('Unable to reset password');
                        if (data['failType'] == "email") {
                            emailError(data['message']);
                        } else if (data['failType'] == "phone") {
                            phoneError(data['message']);
                        } else if (data['failType'] == "query") {
                            error(data['message']);
                        } else if (data['failType'] == "sending") {
                            error(data['message']);
                        }   
                    }
                },
                error: function (msg) {
                    console.log(msg);
                    error('An error has occured');
                }
            });
        }

    } else {
        error('Unable to reset password');
        if (!email) {
            emailError("Please enter email address");
        }
        if (!phone) {
            phoneError("Please enter phone number");
        }
    }
    
}