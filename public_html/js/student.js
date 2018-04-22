// NProgress.start();
$(document).ready(function () {
    NProgress.done();
});
$(document).on('keydown', function (e) {
    if (e.keyCode == 27 && splitOpen == true) { // ESC
       destorySplit();
        splitOpen = false;
    }
});

var splitOpen = false;
function loadStudent(studentNo) {
    var dataToSend = {
        studentNo : studentNo
    }
    $.ajax({
            type: 'POST',
            url : 'http://localhost/public_html/php/student_info.php',
            data: dataToSend,
            dataType : "json",
            success: function (data) {
                // console.log("STUDENT INFO DATA:")
                console.log(data);
                if (data['personalInfoAccess'] == false) {
                    alertify.warning('You do not have access to this student\'s confidential information');
                } else if (data['personalInfoAccess'] == true){
                    alertify.success('You have access to this student\'s confidential information');
                }
                generateActionBar(data['userType'], data['personalInfoAccess']);
                if (data['personalInfo']) {
                    generatePersonalInfo(data['personalInfo']);
                }
                generateModules(data['moduleInfo']);
                if (data['timetable']) {
                    generateTimetable(data['timetable']);
                } 
                
                generateEmails(data['emails'], data['personalInfoAccess']);
                generateAttendance(data['attendance']);
                if (data['meetingNotes']) {
                    generateMeetingNotes(data['meetingNotes']);

                }
            },
            error : function (msg) {
                console.log("ERROR:");
                console.log(msg);
            }
        });
}
function openSplit(pageToSplit) {
    if (splitOpen == true) {
        destorySplit();
    }
    var mainSplit = document.getElementById("mainSplit");
    mainSplit.style.display = "block";
    $("#mainSplitButton").prepend(`
        <div class="actionButtonContainer" id="actionButtonContainer">
        <button class="actionButton" onclick="destorySplit()">Close (esc)</button>
        </div>
    `); 
    $("#mainSplitContent").load(pageToSplit + ".html");
    
    instance = Split(['#main', '#mainSplit'], {
        direction : 'vertical',
        sizes: [50, 50],
        gutterSize: 10
    });
    splitOpen = true;
    // console.log("Pagetosplit: " + pageToSplit);
    if (pageToSplit == 'email') {
        // console.log('email');
        var studentEmailAddress = $("#emailAddress").text();
        // $("#emailRecipients").text() = studentEmailAddress;
        $.get('email.html', null, function(text){
            $('#emailRecipients').val(studentEmailAddress);
            // console.log("Student Email = "+studentEmailAddress);
        });
        // parent.document.getElementById("emailRecipients").innerHTML = studentEmailAddress;
    } else if (pageToSplit == 'add_meeting_note') {
        // console.log("Meetingnote");
        var studentName = $("#studentName").text();
        var studentEmail = $("#emailAddress").text();
        var studentNo = $("#studentNo").text();
        
        // console.log($("div").find('#meetingNoteContainer'));
        
        $.get('add_meeting_note.html', null, function (text) {
            $('#meetingNoteStudentEmail').text(studentEmail);
            $('#meetingNoteStudentName').text(studentName);
            $('#meetingNoteStudentNumber').text(studentNo);
        });
    }

}

function destorySplit() {
    instance.destroy();
    var mainSplit = document.getElementById("mainSplit");
    mainSplit.style.display = "none";
    document.getElementById("mainSplitButton").innerHTML='';
    document.getElementById("mainSplitContent").innerHTML='';
    splitOpen = false;

}
function generateActionBar(userType, access) {
    //CHECK USERTPYES FOR DIFFERENT ACTIONS
    // console.log("Action bar:");
    // console.log("userType: " +userType);
    // console.log("access: " + access);
    if (userType != 'S') {
        $("#studentInformation").append(`
                <div class="actionButtonContainer" id="actionButtonContainer">
            `); 
    }
    if (userType == 'OA') {
        $("#actionButtonContainer").append(`
            <div class="actionButtonContainer" id="actionButtonContainer">
            <button class="actionButton" onclick="openSplit('email')">Send Email</button>
            <button class="actionButton" onclick="openSplit('add_meeting_note')">Add Meeting Note</button>
        `); 
    } else if (userType == 'L' && access == true) {
        $("#actionButtonContainer").append(`
            <div class="actionButtonContainer" id="actionButtonContainer">
            <button class="actionButton" onclick="openSplit('email')">Send Email</button>
            <button class="actionButton" onclick="openSplit('add_meeting_note')">Add Meeting Note</button>
        `); 
    } else if (userType == 'L' && access == false) {
        $("#actionButtonContainer").append(`
            <div class="actionButtonContainer" id="actionButtonContainer">
            <button class="actionButton" onclick="openSplit('email')">Send Email</button>
            <button class="actionButton" onclick="requestAccess()">Request Access</button>
        `);
    } else if (userType == 'SA') {
        $("#actionButtonContainer").append(`
            <div class="actionButtonContainer" id="actionButtonContainer">
            <button class="actionButton" onclick="openSplit('email')">Send Email</button>
        `); 
    }
    $("#actionButtonContainer").append('</div>');
}
function requestAccess() {
    var studentNo = $("#studentNo").text();

    var dataToSend = {
        studentNo : studentNo
    }
    $.ajax({
            type: 'POST',
            url : 'http://localhost/public_html/php/request_access.php',
            data: dataToSend,
            dataType : "json",
            success: function (data) {
                // console.log("STUDENT INFO DATA:")
                // console.log(data);
                if (data['success'] == true) {
                    success("Successfully requested access");
                } else {
                    error("Unable to request access");
                }
            },
            error : function (msg) {
                console.log("ERROR:");
                console.log(msg);
            }
        });

}
function generatePersonalInfo(data) {
    var termAddress = data['termAddress'].split(',').join(', ');
    $("#studentInformation").append(`
        <div class="studentInfoInner"> 
            <h3>Personal Information</h3>
                <hr>
                <table>
                <tr>
                        <td>Student Number:</td>
                        <td id='studentNo'>`+ data['studentNo'] +`</td>
                    </tr>
                    <tr>
                        <td>Student Name:</td>
                        <td id='studentName'>`+ data['forename'] +` `+ data['surname'] + `</td>
                    </tr>
                    <tr>
                        <td>MWS Username:</td>
                        <td id='mwsUsername'>`+ data['mwsUser'] +`</td>
                    </tr>
                    <tr>
                        <td>Term Contact Number:</td>
                        <td id='termContact'>`+ data['termPhone'] +`</td>
                    </tr>
                    <tr>
                        <td>Term Address:</td>
                        <td id='termAddress'>`+ termAddress +`</td>
                    </tr>
                    <tr>
                        <td>Email Address:</td>
                        <td id='emailAddress'>`+ data['email'] +`</td>
                    </tr>
                </table>
        </div>
    `);
}
function generateModules(data) {
    // console.log("GENERATE MODULES: ");
    // console.log(data);
    
    if (data == false) {
        $("#studentInformation").append(`
            <div class="studentInfoInner"> 
                <h3>Registered Modules</h3>
                <hr>
                <p> Student is not registered on any modules </p>
            </div>
        `);
    } else {
        $("#studentInformation").append(`
            <div class="studentInfoInner"> 
                <h3>Registered Modules</h3>
                    <hr>
                    <div id="moduleTable">
                        `);
                        $("#moduleTable").append(`
                        <table class="tableStriped" id="moduleTable" >
                            <tr>
                                <th>Code</th>
                                <th>Title</th>
                                <th>Credits</th>
                                <th>Co-ordinator</th>
                            </tr>    
                        </table>
                    </div>
            </div>
        `);
        for (var i=0; i<data.length; i++) {
            $("#moduleTable").append(`
                <tr>
                    <td>`+ data[i]['moduleCode'] + `</td>
                    <td>`+ data[i]['title'] + `</td>
                    <td>`+ data[i]['credit'] + `</td>
                    <td>`+ data[i]['coordinator'] + `</td>
                </tr>
            `);
        }
    }
}

function generateEmails(data, access) {
    if ((data == false || data == null) && access == true) {
        $("#studentInformation").append(`
            <div class="studentInfoInner"> 
                <h3>Received Emails</h3>
                <hr>
                <p> Student has not received any emails </p>
            </div>
        `);
    } else {
        $("#studentInformation").append(`
            <div class="studentInfoInner"> 
                <h3>Received Emails</h3>
                <hr>
                <div class="studentEmailWrapper" id="studentEmailWrapper">
                </div>
            </div>
        `);

        for (var i = 0; i < data.length; i++) {
            $("#studentEmailWrapper").append(`
                <div class="studentEmail">
                    <div class="">
                        <h3 class="emailSubject">`+ data[i]['subject'] + `</h3>
                        <p title="Date Sent:">`+ data[i]['dateTime'] + `</p>
                        <p title="Sender:">Sender: `+ data[i]['sender'] + `</p>
                        <hr>
                        <p>`+ data[i]['body'] +`</p>
                    </div>
                </div>
            `);
        }
                        
    }
}

function generateTimetable(data){
    if (data == false) {
        $("#studentInformation").append(`
            <div class="studentInfoInner"> 
                <h3>Timetable</h3>
                    <hr>
                <p> Student does not have any sessions </p>
            </div>
        `);
    } else {
        $("#studentInformation").append(`
            <div class="studentInfoInner"> 
                <h3>Timetable</h3>
                    <hr>
                    <table class="timetable" id="timetable"></table>
            </div>
        `);
        var rows = 6;           //days shown
        var columns = 10;       //times shown
        var cellCount = 0;
        var times = ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00'];
        var days = ['Mon', 'Tues', 'Wed', 'Thurs', 'Fri'];
        var timetable = document.getElementById('timetable');
        var i = 0;
        var j = 0;
        var k = 0;
        
        for (var r = 0; r < rows; r++) {
            var tr = timetable.insertRow();
            for (var c = 0; c < columns; c++) {
                var cellId = "timetableCell"+cellCount;
                
                var td = tr.insertCell();
                td.setAttribute('id', cellId);
                if (cellCount<10 && cellCount>0) {
                    td.innerHTML = times[i];
                    i++;
                    //add index[i] from times
                } 
                // console.log(cellCount%10);
                if (cellCount%10 == 0 && cellCount>0)  {
                    //covert to day and compate with days[j]
                    td.innerHTML = days[j];
                    j++;
                }
                //if not first row or first column
                if (!(cellCount%10 == 0) && cellCount>9)  {
                    // console.log(data);
                    //convert time to hh:mm and compare to column 
                    // var time = data[k]['time'].substring(0,5);
                    // td.innerHTML = data[k]['moduleCode'];
                    k++;
                }
                cellCount++;
            }
        }
    }
}

function generateAttendance(data) {
    if (data == false) {
        $("#studentInformation").append(`
            <div class="studentInfoInner"> 
            <h3>Attendance</h3>
                <hr>
                <p> Student does not have any attendance data. </p>
            </div>
        `);
    } else {
        $("#studentInformation").append(`
            <div class="studentInfoInner"> 
                <h3>Attendance</h3>
                <hr>
                <div id="attendanceWrapper">
                    <p>Student has an average of: `+data+`% attendance.</p>
                </div>
            </div>
        `);
    }
}

function generateMeetingNotes(data) {
    if (data == false) {
        $("#studentInformation").append(`
            <div class="studentInfoInner"> 
            <h3>Meeting Notes</h3>
                <hr>
                <p> Student does not have any meeting notes attached. </p>
            </div>
        `);
    } else {
        $("#studentInformation").append(`
            <div class="studentInfoInner"> 
                <h3>Meeting Notes</h3>
                <hr>
                <div class="studentEmailWrapper" id="studentMeetingNoteWrapper">
                </div>
            </div>
        `);

        for (var i = 0; i < data.length; i++) {
            $("#studentMeetingNoteWrapper").append(`
                <div class="studentEmail">
                    <div class="">
                        <h3 class="emailSubject">Staff Number`+ data[i]['staffNo'] + `</h3>
                        <p title="Date Sent:">`+ data[i]['dateTime'] + `</p>
                        <hr>
                        <p>`+ data[i]['content'] +`</p>
                    </div>
                </div>
            `);
        }
                        
    }
    
}