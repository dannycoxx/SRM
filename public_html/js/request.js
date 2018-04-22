NProgress.start();
var changeArray = [];
var j = 0;
$(document).ready(function () {
    loadRequests();
    NProgress.done();
});

function loadRequests() {
    var dataToSend = {
        requestType: 'retrieve'
    }
    $.ajax({
        type: 'POST',
        url: 'http://localhost/public_html/php/requests.php',
        data: dataToSend,
        dataType: "json",
        success: function (data) {
            // success("Requests successfully updated");
            // console.log(data);
            insertRequests(data);
        },
        error: function (msg) {
            error('An error has occured');
        }
    });
}

function insertRequests(data) {
    //Load recent 10 requests too
    
    for (var i=0; i<data.length; i++) {
        $("#requests").append(`
            <div class="request">
                <div class="requestContent">
                    <h3 class="requestTitle">`+data[i]['title']+`</h3>
                    <select class="requestAction" onChange="updateChangeArray(`+data[i]['requestId']+`, this.value)">
                        <option value="none">No Action</option>
                        <option value="accept">Accept Request</option>
                        <option value="reject">Reject Request</option>
                    </select>
                    <p title="Date and time of request creation">`+data[i]['dateTime']+`</p>
                    <p title="Email address of staff requesting access.">Requester: `+data[i]['requester']+`</p>
                    <p title="Email address of student request is concerned with.">Student: `+data[i]['student']+`</p>
                    <hr>
                    <p>`+data[i]['description']+`</p>
                </div>
                <button type="button" id="requestConfirmButton" class="requestConfirmButton" onclick="confirmChanges()">Confirm</button> 
            </div>
        `);
    }
}

function updateChangeArray(requestId, updatedStatusText) {
    var updatedStatus;
    var addToArray = true;
    if (updatedStatusText == 'accept') {
        updatedStatus = 1;
    } else if (updatedStatusText == 'reject') {
        updatedStatus = 2;
    }
    if (changeArray.length > 0) {
        for (var k=0;k<changeArray.length;k++) {
            //if action has already been selected for request
            if (changeArray[k][0] == requestId) {
                console.log("requestId to be changed("+requestId+") MATCH with ("+changeArray[k][0]+")");
                changeArray[k][1] = updatedStatus;
                addToArray = false;
            }
        }
    } 
    if (addToArray == true) {
        changeArray[j] = [requestId, updatedStatus];
        j++
    }
    // console.log(changeArray);
}

function confirmChanges() {
    if (changeArray.length > 0) {  
        if (confirm("Are you sure you want to submit changes? This action cannot be reversed.") == true) {
             var dataToSend = {
                 requestType: 'update',
                 changeArray: changeArray
                }
                $.ajax({
                    type: 'POST',
                    url: 'http://localhost/public_html/php/requests.php',
                    data: dataToSend,
                    dataType: "json",
                    success: function (data) {
                        success('Changes made successfully');
                        $("#main").load("manage_requests.html");
                        //feedback for successful changes
                    },
                    error: function (msg) {
                        error('An error has occured');
                    }
                });
        } else {
            error('No changes have been made');
        }
    
    } else {
        error('No changes have been made');
    }  
}