helpOpen = false;
var closeButton = ` <div id="helpDrawerClose" class="helpDrawerClose">
					    <button type="button" class="closeHelp" onclick="toggleHelp()">Close (ESC)</button>
                    </div>`;

$(document).on('keydown', function (e) {
    if (e.keyCode == 27 && helpOpen == true) { // ESC
        closeHelp();
    }
});
function closeHelp(params) {
    $(helpDrawer).animate({
        height: '0px'
    }, 160);
    $("#helpDrawer").html('');

    helpOpen = false;
}

function toggleHelp(page, navStatus) {
    // console.log("PAGE: " + page);
    // if (navOpen == true) {
    //     $("helpDrawer").css("left", "280px");
    // } else if (navOpen == false) {
    //     $("helpDrawer").css("left", "0px");
    // }
    //if help currently closed
    if (helpOpen == false) {
        $(helpDrawer).animate({
            height: '100%'
        }, 160);
        addHelpCloseButton()
        helpOpen = true;


        switch (page) {
        case 'about':
            
            break;
        case 'add_meeting_note':
            
            break;
        case 'bug_report':
            
            break;
        case 'change_password':
            
            break;
        case 'edit_auto_letters':
            
            break;
        case 'email':
            helpEmail('load');
            break;
        case 'generate_auto_letters':
            
            break;
        case 'home':
            
            break;
        case 'homepage':
            
            break;
        case 'manage_auto_letters':
            
            break;
        case 'manage_requests':
            
            break;
        case 'send_comm':
            
            break;
        case 'student':
            
            break;
        case 'upload_spreadsheet':
            
            break;
        default:
            break;
    }
    //if help currently open
    } else if (helpOpen == true) {
        closeHelp();
    }   
}
function addHelpCloseButton() {
    $("#helpDrawer").html(` 
        <div id="helpDrawerClose" class="helpDrawerClose">
		    <button type="button" id="closeHelpButton" onclick="toggleHelp()">Close (ESC)</button>
            <h2>

                To get help for <b>`+currentPage+`.html</b>, please click on the specific element you need
                help with.
            </h2>
        </div>
        <div id="helpDrawerContent" class="helpDrawerContent">
        </div>
        `);
}
function helpEmail(area) {
    if (area == 'recipients')  {
        alert(`Recipients:
        The recipient field contains one, or many email addresses to send an email to.
        If multiple recipients are to be entered, they should be separated by a comma followed by space.

        If the recipient field contains an invalid character or string of characters, the box will be surrounded by 
        a red border.
        
        `);
    } else if (area == 'load') {
        $("#helpDrawerContent").append(`
            <div id="helpDrawerImg" class="helpDrawerContent">
                <img src="img/help/email.jpg" usemap="#image-map">
    
                <map name="image-map">
                    <area href="javascript:void(0);" onclick="helpEmail('recipients');" alt="recipients" title="recipients" coords="99,68,1080,156" shape="rect">
                    <area href="javascript:void(0);" onclick="helpEmail('subject');" alt="subject" title="subject" href="" coords="99,164,1080,244" shape="rect">
                    <area href="javascript:void(0);" onclick="helpEmail('body');" alt="body" title="body" href="" coords="99,249,1078,785" shape="rect">
                    <area target="" alt="sendEmail" title="sendEmail" href="" coords="98,790,719,856" shape="rect">
                </map>		
            </div>
      
        `)
    } else if (area == 'subject') {
        alert(`Subject:
        The subject field contains the subject of the email you wish to send.

        Any characters can be entered here, up to a maximum length of 70 characters including spaces.
        
        `);
    } else if (area == 'body') {
        alert(`Body:
        The body field contains the body of the email you wish to send.

        Any characters can be entered here and there is no maximum length.
        
        `);
    } else if (area == 'sendEmail') {
        alert(`Send Email:
        The send email button will send an email to the recipients with the subject and body you have entered.

        Feedback will be given as to whether an email has sent successfully.
        
        `);
    }
}