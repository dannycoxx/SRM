NProgress.start();
var changeArray = [];
var j = 0;
$(document).ready(function () {
    loadAutoLetters();
    NProgress.done();
});

function loadAutoLetters() {
    console.log("letters");
    var dataToSend = {
        requestType: 'retrieve'
    }
    $.ajax({
        type: 'POST',
        url: 'http://localhost/public_html/php/manage_auto_letters.php',
        data: dataToSend,
        dataType: "json",
        success: function (data) {
            console.log(data);
            if (data == false) {
                console.log("none found");
                
                success("No pending automatic emails found");
            } else {
            }
            insertAutoLetters(data);
        },
        error: function (msg) {
            error('An error has occured');
        }
    });
}
{/* <table class="autoLetterTable" id="autoLetterTable"> */}
function insertAutoLetters(data) {
    $("#letters").append(`
        <div> 
            <table class="tableStriped" id="autoLetterTable">
                <tr>
                    <th>Comm ID</th>
                    <th>Date/Time</th>
                    <th colspan="2">Student</th>
                    <th>Subject</th>
                    <th>Body</th>
                    <th>Queue</th>
                    <th>Edit</th>
                </tr>
            </table>
        </div>
        </div>
    `);
    for (var i = 0; i < data.length; i++) {
        // var body = data[i]['body'];
        // var bodySubstring = body.substring(0, 30);
        // bodySubstring = bodySubstring + '...';
        
        $('#autoLetterTable').append(`
            <tr>
                <td>`+data[i]['commHistId']+`</td>
                <td>`+data[i]['dateTime']+`</td>
                <td>`+data[i]['studentNo']+`</td>
                <td>`+data[i]['forename'] +' '+data[i]['surname']+`</td>
                <td contenteditable="true">`+data[i]['subject']+`</td>
                <td contenteditable="true">`+data[i]['body']+`</td>
                <td><input type="checkbox" checked="checked"></td>
                <td onclick="saveChanges(this)"><button type="button" class="editCommButton" >Save</button></td>
            </tr>
        `);
    }
}

function saveChanges(cell) {
    // console.log(cell);
    var commHistId = cell.parentNode.cells[0].innerHTML;
    var subject = cell.parentNode.cells[4].innerHTML;
    var body = cell.parentNode.cells[5].innerHTML;
    var checkbox = $(cell.parentNode).find(":checkbox").is(':checked');
    
    
    
    if (checkbox == true) {
        var queue = 1;
    } else {
        var queue = 0;
    }

    var dataToSend = {
        commHistId: commHistId,
        subject: subject,
        body: body,
        queue: queue
    }

    $.ajax({
        type: 'POST',
        url: 'http://localhost/public_html/php/amend_auto_letters.php',
        data: dataToSend,
        dataType: "json",
        success: function (data) {
            success("Letter successfully edited");
            // console.log(data);
            
        },
        error: function (msg) {
                        console.log(msg);
            error('An error has occured');
        }
    });

    
}