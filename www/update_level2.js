function updateProgress(txt) {
	$("#prgText").text(txt);
}


function on_document_ready() {

    $.ajaxSetup({ cache: false });

	
	$("#level2").change(function() {
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
	});

	// Selected update has finished uploading
	$("#hidden_upload").load(function () {
		$("#waiting").hide();
		updateProgress($("#txtComplete").text());
	});
}

