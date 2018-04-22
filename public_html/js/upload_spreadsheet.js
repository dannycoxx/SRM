NProgress.start();
$(document).ready(function () {
    NProgress.done();
});
var tableOpen = false;
var rows = 0;
var columns = 0;
var assessIdArray
function uploadSpreadsheet() {
    NProgress.start();
    // https://abandon.ie/notebook/simple-file-uploads-using-jquery-ajax
    if (document.getElementById("spreadsheetFile").value != "") {
        var spreadsheetFile = document.getElementById("spreadsheetFile").files[0];
        var spreadsheetForm = new FormData();
        spreadsheetForm.append("file", spreadsheetFile);
        // console.log(spreadsheetForm);
        $.ajax({
            url: "http://localhost/public_html/php/marks.php",
            dataType: "json",
            cache: false,
            contentType: false,
            processData: false,
            data: spreadsheetForm,
            type: 'post',
            success: function (data) {
                console.log(data);
                NProgress.done();

                if (data['success'] == false) {
                    error(data['message']);
                } else if (data['success'] == true) {
                    // console.log(typeof data);
                    createTable(data);
                    tableOpen = true;
                    // success(data['message']);
                }
            },
            error: function (msg) { 
                console.log(msg);
                NProgress.done();
                error('An error has occured');
            }
        });
    } else {
        NProgress.done();
        error('Please select a valid spreadsheet file');

    }

}
function createTable(data) {
    // console.log(data);
    
    if (tableOpen == true) {
        document.getElementById("uploadSpreadsheetResult").innerHTML = '';
    }
    $("#uploadSpreadsheetResult").append(`
        <br>
        <h3>Student Marks for `+ data['moduleCode'] + `</h3>
        <br>
        <table id="marksTable" class="tableStriped"></table>
    `);

    var rows = data['numStudents'] + 1;
    var columns = data['numColumns'];

    var cellCount = 0;
    var rowCount = 0;
    var fixedHeaders = ['Student ID', 'Programme'];
    assessIdArray = data['assessIdArray'];
    var headers = fixedHeaders.concat(assessIdArray );
    // console.log(headers.length);
    var marksTable = document.getElementById('marksTable');

    for (var r = 0; r < rows; r++) {
        var rowId = "marksTableRow" + rowCount;
        var tr = marksTable.insertRow();
        tr.setAttribute('id', rowId);
        for (var c = 0; c < columns; c++) {
            var cellId = "marksTableCell" + cellCount;
            var td = tr.insertCell();
            if (r != 0) {
                td.setAttribute('contenteditable', 'true');
            }
            td.setAttribute('id', cellId);

            td.innerHTML = data['dataStuff'][cellCount];
            cellCount++;
        }
        rowCount++;
    }
    $("#uploadSpreadsheetResult").append(`
        <br>
        <button type="button" class="uploadSpreadsheet" id="addMarks" onclick="addMarks()">Add Marks to Database</button>
    `);
}

function addMarks() {
    NProgress.start();
    var myTableArray = Array();
    var arrayOfThisRow = Array();

    $("table#marksTable tr").each(function () {
        var arrayOfThisRow = [];
        var tableData = $(this).find('td');
        if (tableData.length > 0) {
            tableData.each(function () { arrayOfThisRow.push($(this).text().trim()); });
            myTableArray.push(arrayOfThisRow);
        }
    });
    if (myTableArray) {
        myTableArray.shift();
        var dataToSend = {
            assessIdArray: assessIdArray,
            myTableArray: myTableArray
        }
        // console.log(dataToSend);
        $.ajax({
            type: 'POST',
            url: 'http://localhost/public_html/php/add_marks_db.php',
            data: dataToSend,
            dataType: "json",
            success: function (data) {
                console.log("SUCCEESSSSS");
                // console.log(data);
                NProgress.done();
                if (data['success'] == false) {
                    error(data['message']);
                } else if (data['success'] == true) {
                    
                    success(data['message']);
                }
            },
            error: function (msg) {
                console.log(msg);
                NProgress.done();
                error('An error has occured');
            }
        });
    } else {
        error('An error has occured, please reload page');
    }
}

