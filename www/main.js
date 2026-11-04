
function FirmwareUpdate(timeoutSeconds) {
	this.timeoutSeconds = 600;
	this.timeoutCallback = null;
	this.completeCallback = null;
	this.reset();
}

FirmwareUpdate.prototype.reset = function() {
	this.startTime = 0;
	this.busy = false;
	this.state = "waitforupload";
}

FirmwareUpdate.prototype.checkTimeout = function() {

	if (0 == this.startTime)
		this.startTime = Date.now();
		
	var elapsed = this.getElapsedTime();
	if (elapsed >= this.timeoutSeconds) {
		this.state = "complete";
		if (this.timeoutCallback) {
			this.timeoutCallback();
			return false;
		}
	}
	return true;
}

FirmwareUpdate.prototype.getElapsedTime = function() {
	return (Date.now() - this.startTime) / 1000;
}

FirmwareUpdate.prototype.getElapsedTimeText = function() {
	var elapsed = this.getElapsedTime();
	var seconds = parseInt(elapsed % 60);
	var minutes = parseInt(elapsed / 60);
	if (seconds < 10)
		seconds = "0" + seconds.toString();
	return minutes.toString() + ":" + seconds.toString();
}

FirmwareUpdate.prototype.update = function () {

	if (!this.checkTimeout())
		return;
		
	if (this.busy)
		return;
	
	if ("waitforupdate" == this.state)
		this.waitForUpdate();
	else if ("waitforreboot" == this.state)
		this.waitForReboot();
}

FirmwareUpdate.prototype.isDone = function() {
	if ("complete" == this.state)
		return true;
	return false;
}

//Waits for beginning of firmware update by polling until we see that the webserver is no longer available
FirmwareUpdate.prototype.waitForUpdate = function() {

	this.busy = true;
	
	$.ajax({
		FirmwareUpdate: this,
		url: "version",
		timeout: 500,
		context: this,
		complete: function(jqXHR) {
			this.busy = false;
		},
		error: function(jqXHR,textStatus,errorThrown) {
			this.state = "waitforreboot";
		}
	});
}

//Waits for firmware install reboot to complete by polling until we see that the webserver has returned
FirmwareUpdate.prototype.waitForReboot = function() {

	this.busy = true;
	
	$.ajax({
		FirmwareUpdate: this,
		url: "version",
		timeout: 500,
		context: this,
		complete: function(jqXHR) {
			this.busy = false;
		},
		success: function(data,textStatus,jqXHR) {
			this.state = "complete";
			if (this.completeCallback)
				this.completeCallback();
		}
	});
	
}

g_FwUpdate = new FirmwareUpdate();

function updateProgress(txt) {
	$("#prgText").text(txt);
}

function onTimeout()
{
	g_FwUpdate.update();
	
	var elapsed = g_FwUpdate.getElapsedTimeText();
	$("#elapsedTime").text(elapsed);
	
	if (!g_FwUpdate.isDone())
		setTimeout(onTimeout, 900);
}

function on_document_ready() {

    $.ajaxSetup({ cache: false });

	$.get("version", function(data) {
		if (data)
			$("#version").text(data.toString());
	});
	
	$("#firmware").change(function() {
		$("#upload").prop("disabled", false);
	});
	
	$("#upload").click(function() {
		updateProgress($("#txtUploading").text());
		$("#waiting").show();
		
		$("#prgDialog").dialog({
			modal: true,
			close: function(event,ui) {
				location.reload(true);
			}
		});
		
		g_FwUpdate.reset();
		g_FwUpdate.completeCallback = function() {
			updateProgress($("#txtComplete").text());
			$("#waiting").hide();
		};
		g_FwUpdate.timeoutCallback = function() {
			updateProgress($("#txtTimeout").text());
			$("#waiting").hide();
		};
		
		onTimeout();
	});
	
	//Selected update has finished uploading, so now web server will start installing it
    $("#hidden_upload").load(function () {

	    updateProgress($("#txtInstalling").text());

	    g_FwUpdate.state = "waitforupdate";
	});
}

