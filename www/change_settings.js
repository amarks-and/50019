
function prependZero(i) {
    return (i < 10) ?  ("0" + i.toString()) : i.toString();
}

function formatDate(date) {
    var month = date.getMonth() + 1;
    var day = date.getDate();
    var year = date.getFullYear();
    var hour = date.getHours();
    var minute = date.getMinutes();
    var second = date.getSeconds();
    return prependZero(month) + "/" + prependZero(day) + "/" + year.toString() + " " + prependZero(hour) + ":" + prependZero(minute) + ":" + prependZero(second);
}

function onTimeout() {
    $.ajax({
        url: "get_time",
        success: function (data, textStatus, jqXHR) {
            var txt = $(data).find("Result").first().text();
            $("#remoteTime").text(txt);
        },
        error: function (jqXHR, textStatus, error) {
            $("#remoteTime").text("???");
        }
    });

    var d = new Date();
    $("#localTime").text(formatDate(d));

    setTimeout(onTimeout, 900);
}

function doModal(textOrId) {

    var txt;
    if ('#' == textOrId.toString()[0])
        txt = $(textOrId).text();
    else
        txt = textOrId;
    $("#dialogText").text(txt);

    $("#dialog").dialog({
        modal: true,
        buttons: [
            {
                text: $("#txtOK").text(),
                click: function () {
                    $(this).dialog("close");
                }
            }
        ]
    });
    
}

//function setTime() {
//    var d = new Date();
//    var param = formatDate(d);
//    $.ajax({
//        url: "set_time?time=" + param.toString(),
//        success: function (data, textStatus, jqXHR) {
//            var txt = $(data).find("Result").first().text();
//            var result = ("true" == txt);
//            doModal(result ? "#txtSetTimeSucceeded" : "#txtSetTimeFailed");
//        },
//        error: function () {
//            doModal("#txtSetTimeFailed");
//        }
//    });
//}

function getErrorText(txt) {
    var ret = null;

    try {
        ret = $("#txt" + txt).text();
    }
    catch(err) {
        ret = null;
    }

    if (!ret)
        ret = $("#txtUnknownError").text();

    return ret;
}

function setAddress() {
    $.ajax({
    	url: "set_address?address=" + $("#ipAddress").val() + "&netmask=" + $("#netMask").val() + "&gateway=" + $("#ipGateway").val(),
        success: function (data, textStatus, jqXHR) {
            var txt = $(data).find("Result").first().text();
            var result = ("true" == txt);
            if (result)
                txt = "#txtSetAddressSucceeded";
            else
                txt = getErrorText(txt);
            doModal(txt);
        },
        error: function () {
        }
    });
}

function setLabCentralAddress() {
    $.ajax({
        url: "set_labcentral_address?address=" + $("#labCentralIpAddress").val(),
        success: function (data, textStatus, jqXHR) {
            var txt = $(data).find("Result").first().text();
            var result = ("true" == txt);
            if (result)
                txt = "#txtSetLabCentralAddressSucceeded";
            else
                txt = getErrorText(txt);
            doModal(txt);
        },
        error: function () {
        }
    });
}

function on_document_ready() {

    $.ajaxSetup({ cache: false });

//    $("#setTime").button();
//    $("#setTime").click(setTime);

    $("#setAddress").button();
    $("#setAddress").click(setAddress);

    $.ajax({
        url: "get_address",
        success: function (data, textStatus, jqXHR) {
            var val;
            val = $(data).find("Address").first().text();
            $("#ipAddress").val(val);
            val = $(data).find("Netmask").first().text();
            $("#netMask").val(val);
            val = $(data).find("Gateway").first().text();
            $("#ipGateway").val(val);
        }
    });

	$("#setLabCentral").button();
    $("#setLabCentral").click(setLabCentralAddress);

	$.ajax({
        url: "get_labcentral_address",
        success: function (data, textStatus, jqXHR) {
            var val;
            val = $(data).find("Address").first().text();
            $("#labCentralIpAddress").val(val);
        }
    });

    onTimeout();
}
