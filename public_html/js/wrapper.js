// NProgress.start();
var query;
var navOpen = false;
var currentPage;

$(document).ready(function () {
    if (authenticateLogIn()) {
        // console.log(authenticateLogIn());
        $("#main").load("homepage.html");
        currentPage = 'homepage';
        initialiseNavDrawer();
    } else {
        if (currentPage != 'index') {
            window.location.replace("index.html");
        }
    }
});

/* Set the width of the side navigation to 250px and the left margin of the page content to 250px */
function toggleNav(nav) {
    if (navOpen == false) {
        nav.classList.toggle("change");
        $(navDrawer).animate({
            width: '280px'
        }, 40);
        $(mainWrapper).animate({
            margin: '0 0 0 280px'
        }, 400);
        navOpen = true;
    } else {
        nav.classList.toggle("change");
        $(navDrawer).animate({
            width: '0',
        }, 40);
        $(mainWrapper).animate({
            margin: '0 0 0 0'
        }, 400);
        navOpen = false;
    }
}
function error(msg) {
    alertify.error(msg);
}
function success(msg) {
    alertify.success(msg);
}
function authenticateLogIn() {
    var authenticated;
    var dataToSend = {
        action: 'logIn',
    }
    
    $.ajax({
        async: false,
        type: 'POST',
        url: 'http://localhost/public_html/php/authenticate_user.php',
        data: dataToSend,
        dataType: "json",
        success: function (data) {
            if (data['logIn'] == true) {
                authenticated = true;
            } else if (data['logIn'] == false) {
                authenticated = false;
            }
        },
        error: function (msg) {
            error('An error has occured');
        }
    });
    return authenticated;
}
function authenticatePageAccess(page) {
    var authenticated;
    var dataToSend = {
        action: 'accessPage',
        page: page
    }

    $.ajax({
        async: false,
        type: 'POST',
        url: 'http://localhost/public_html/php/authenticate_user.php',
        data: dataToSend,
        dataType: "json",
        success: function (data) {
            // console.log(data);
            if (data['logIn'] == true) {
                if (data['pageAccess'] == true) {
                    authenticated = true;
                } else if (data['pageAccess'] == false){
                    authenticated = false;  
                }
            } else if (data['logIn'] == false) {
                window.location.replace("index.html");
            }
        },
        error: function (msg) {
            error('An error has occured');
        }
    });
    return authenticated;
}
function setCurrentPage(page) {
    currentPage = page;
}
function loadContent(page) {
    NProgress.start();
    if (authenticatePageAccess(page)) {
        setCurrentPage(page);
        $("#main").load(page + ".html"); 
    } else {
        alert("You do not have permission to access that page");
    }
}
// function getCurrentPage() {
//     return currentPage.trim();
// }
function loadExternal(page) {
    window.open(page);
}

function getHelp(page) {
    toggleHelp(currentPage, navOpen);
}

function logOut() {
    $.ajax({
        type: 'POST',
        url: 'http://localhost/public_html/php/log_out.php',
        // data: dataToSend,
        dataType: "json",
        success: function (data) {
            window.location.replace("index.html");
            success('Successfully logged out');
        },
        error: function (msg) {
            // error('An error has occured');
            window.location.replace("index.html");
        }
    });
}

function initialiseNavDrawer() {
    $.ajax({
        type: 'POST',
        url: 'http://localhost/public_html/php/start_data.php',
        // data: dataToSend,
        dataType: "json",
        success: function (data) {
            document.getElementById('mwsUsername').innerHTML = data['mwsUser'];
            document.getElementById('loginType').innerHTML = data['userTypeFull'];
            var userType = data['userType'];
            switch (userType) {
                //On login if student, load student page by default
                case 'OA': 
                    $("#dynamicDivContent").append(
                        `<div class="navCategory" onclick="loadContent('upload_spreadsheet')"> <h3>Upload Marks</h3> </div>
                        <div class="navCategory" onclick="loadContent('manage_requests')"> <h3>Manage Access Requests</h3> </div>
                        <div class="options"> 
                            <div class="navCategory" onclick="loadContent('manage_auto_letters')"> <h3>Manage Auto Comms</h3> </div>
                            <div class="navOption" onclick="loadContent('generate_auto_letters')"> <h4>Generate Automatic Comms</h4> </div>
                        </div>`
                    );
                break;

                case 'SA': 
                    $("#dynamicDivContent").append(
                        `<div class="navCategory" onclick="loadContent('upload_spreadsheet')"> <h3>Upload Marks</h3> </div>
                        <div class="navCategory" onclick="loadContent('manage_requests')"> <h3>Manage Access Requests</h3> </div>
                        <div class="navCategory" onclick="loadContent('manage_auto_letters')"> <h3>Manage Auto Comms</h3> </div>
                        <div class="navOption"> <h4>Run Auto Comms Scripts</h4> </div>
                        <div class="navCategory" onclick="loadContent('edit_auto_letters')"> <h3>Edit Auto Comms</h3> </div>`
                    );
                break;

                case 'L': 
                    $("#dynamicDivContent").append(
                        `<div class="navCategory" onclick="loadContent('upload_spreadsheet')"> <h3>Upload Marks</h3> </div>`
                    );
                break;

                case 'S':
                    break;

                default:
                    console.log('Unable to determine account type');
                    
            }
            
        },
        error: function (msg) {
            error('An error has occured');
        }
    });
}