NProgress.start();
$(document).ready(function () {
    NProgress.done();
});
var slider = document.getElementById("attendnaceSlider");
var output = document.getElementById("attendnaceThreshold");
output.innerHTML = "Threshold: " + slider.value + "% attendance";

// Update the current slider value (each time you drag the slider handle)
slider.oninput = function () {
    output.innerHTML = "Threshold: "+this.value+"% attendance";
}

function generateAutoLetters() {
    var attendanceThreshold;
    var attendnaceCheck;
    var generateResit;
    if ($('#attendnaceCheck').is(':checked')) {
        attendanceThreshold = slider.value;
        generateAttendance = true;
    } else {
        attendnaceThreshold = -1;
        generateAttendance = false;
    }
    if ($('#resitCheck').is(':checked')) {
        // var attendanceThreshold = document.getElementById("usernameError").innerHTML;
        generateResit = true;
    } else {
        // attendnaceThreshold = -1;
        generateResit = false;
    }
    if (generateResit || generateAttendance) {
        if (confirm("Are you sure you want to generate emails? This action cannot be stopped.") == true) {
            NProgress.start();
            var dataToSend = {
                attendnaceThreshold: attendanceThreshold,
                generateAttendance: generateAttendance,
                generateResit: generateResit
            }
            console.log(dataToSend);
            $.ajax({
                type: 'POST',
                url: 'http://localhost/public_html/php/generate_auto_letters.php',
                data: dataToSend,
                dataType: "json",
                success: function (data) {
                    NProgress.done();
                    // console.log(data);
                    success("Automatic letters successfully generated");
                    if (data['noStudentsPoorAttendance'] > 0) {
                        success(data['noStudentsPoorAttendance']+" student(s) with attendance below threshold added to database");
                    } else if (data['noStudentsPoorAttendance'] == 0) {
                        success("0 students with attendance below threshold ");
                    }
                    if (data['noStudentsResit'] > 0) {
                        success(data['noStudentsResit'] + " student(s) with resits added to database");
                    }    
                    console.log(data);
                      
                },
                error: function (msg) {
                    NProgress.done();
                    console.log(msg);
                    error('An error has occured');
                }
            });
        } else {
            success('No changes have been made');
        }
    } else {
        error('Please select automatic letters to generate');
    }
}
