NProgress.start();
$(document).ready(function () {
    NProgress.done();
});

function addMeetingNote() {
    
    NProgress.start();
    var meetingNote = document.getElementById("meetingNoteContent").value;
    var meetingNote = meetingNote.trim();
    var studentEmail = document.getElementById("meetingNoteStudentEmail").innerHTML;
    var studentEmail = studentEmail.trim();
    var studentNo = document.getElementById("meetingNoteStudentNumber").innerHTML;
    var studentNo = studentNo.trim();
    

    if (meetingNote) {
        var dataToSend = {
            studentEmail: studentEmail,
            studentNo: studentNo,
            meetingNote: meetingNote
        }
        // console.log('Add meetingnote');
        
        console.log(dataToSend);
        
        $.ajax({
            type: 'POST',
            url: 'http://localhost/public_html/php/add_meeting_note.php',
            data: dataToSend,
            dataType: "json",
            success: function (data) {
                console.log(data);
                NProgress.done();
                if (data['success'] == true) {
                    success(data['message']);
                } else if (data['success'] == false) {
                    error(data['message']);
                }
            },
            error: function (msg) {
                NProgress.done();
                console.log(msg);
                error('An error has occured');
            }
        });
    } else {
        error("Meeting note field empty");
        NProgress.done();
    }
}
