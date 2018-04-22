NProgress.start();
$(document).ready(function () {  
    document.getElementById("studentSearch").select();
    NProgress.done();
});

function sendSearch(textBox){
    NProgress.start();
    var searchTerm = textBox.value.trim();
    if (searchTerm != "") {
        var dataToSend = {
            searchTerm: searchTerm
        }

        $.ajax({
            type: 'POST',
            url : 'http://localhost//public_html/php/search_student.php',
            data: dataToSend,
            dataType : "json",
            success: function (data) {
                NProgress.done();
                searchResultsTable(data);
            },
            error : function (msg) {
                NProgress.done();
                error('An error has occured');
            }
        });
    } else {
        NProgress.done();
        searchResultsTable('');
    }
}

function searchResultsTable(studentData) {
    var table = "<table  class=\"studentResultTable\">";
    if (studentData == "FALSE") {

    } else {
        table += "<tr class=\"studentResultTableHead\">";
        for (var i = 0; i < studentData.length; i++) {
            if (i<1) {
                

            } else {
                table += "<tr onclick=\"getStudent(this.cells[0].innerHTML)\" class=\"studentResultTable\">";
            }
            
            for (var j = 0; j < studentData[i].length; j++) {            
                table += "<td>" + studentData[i][j] + "</td>";
            }
            table += "</tr>";
        }
    }
    document.getElementById('searchResults').innerHTML = table;
}

function getStudent(studentNo) {
    $("#main").load("student.html");
    loadStudent(studentNo);
}































