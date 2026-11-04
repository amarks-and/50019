g_CalData = null;
g_modified = false;

function CalChan(obj) {
	$.extend(this, obj);
	if ("AI" == this.T) {
		this.C0 = parseFloat(this.C0);
		this.C1 = parseFloat(this.C1);
		this.NewC0 = NaN;
		this.NewC1 = NaN;
		this.Raw = NaN;
		this.EU = NaN;
		this.NewEU = NaN;
	}
}

CalChan.prototype.updateCoefficients = function() {
	if (!isNaN(this.Raw1) && !isNaN(this.EU1) && !isNaN(this.Raw2) && !isNaN(this.EU2) && (this.Raw1 != this.Raw2)) {
		this.NewC1 = (this.EU2 - this.EU1) / (this.Raw2 - this.Raw1);
		this.NewC0 = this.EU1 - this.NewC1 * this.Raw1;
	}
}

//Computes Raw from EU value and also New EU (using new coefficients
CalChan.prototype.computeLiveData = function(eu) {
	this.EU = parseFloat(eu);
	this.Raw = (this.EU - this.C0) / this.C1;
	this.NewEU = this.Raw * this.NewC1 + this.NewC0;
}

//AWM: Used to save/restore current values so we can revert
//if user selects Cancel from calibration dialog.
CalChan.prototype.save = function() {
	this.hold = {
		NewC1: this.NewC1,
		NewC0: this.NewC0,
		Raw1: this.Raw1,
		EU1: this.EU1,
		Raw2: this.Raw2,
		EU2: this.EU2,
	};
}

CalChan.prototype.useNewCoefficients = function() {
	if ("AI" == this.T && !isNaN(this.NewC0) && !isNaN(this.NewC1)) {
		this.C0 = this.NewC0;
		this.C1 = this.NewC1;
		this.NewC0 = NaN;
		this.NewC1 = NaN;
	}
}

CalChan.prototype.restore = function() {
	if (!this.hold)
		return;
		
	this.NewC0 = this.hold.NewC0;
	this.NewC1 = this.hold.NewC1;
	this.Raw1 = this.hold.Raw1;
	this.EU1 = this.hold.EU1;
	this.Raw2 = this.hold.Raw2;
	this.EU2 = this.hold.EU2;
	
	this.hold = null;
}

function CalData(xmldata) {
    var rpt = $.xml2json(xmldata);
	
    this.chan = [];
	this.mapNameToChan = {};
	
    //add an id for saving changes from edit dialog
	var index;
	for (index = 0; index < rpt.C.length; index+=1) {
		var chan = new CalChan(rpt.C[index]);
        chan.id = "chan" + index;
		this.chan.push(chan);
		this.mapNameToChan[chan.CN] = chan;
    }
}

CalData.prototype.getSaveXml = function () {
    var ret = "<AtlasReport>";
    $.each(this.chan, function (index, e) {
	
		//skip AI that weren't changed
		var ai = ("AI" == e.T);
		if (ai && (isNaN(e.NewC0) || isNaN(e.NewC1)))
			return true;
			
        ret += "<C>";
        ret += "<CN>" + e.CN + "</CN>";
        ret += "<T>" + e.T + "</T>";
		if (ai) {
			ret += "<C0>" + e.NewC0 + "</C0>";
			ret += "<C1>" + e.NewC1 + "</C1>";
		} else {
			ret += "<LR>" + e.LR + "</LR>";
			ret += "<HR>" + e.HR + "</HR>";
			ret += "<LEU>" + e.LEU + "</LEU>";
			ret += "<HEU>" + e.HEU + "</HEU>";
		}
        ret += "</C>\n";
    });
    ret += "</AtlasReport>";
    return ret;
}

function update_row(row, chan) {
    var td = $("td", row);
	if ("AI" == chan.T) {
		$(td[1]).text(numToString(chan.C0));
		$(td[2]).text(numToString(chan.C1));
		$(td[3]).text(numToString(chan.NewC0));
		$(td[4]).text(numToString(chan.NewC1));
	} else {
		$(td[1]).text(chan.LR);
		$(td[2]).text(chan.HR);
		$(td[3]).text(chan.LEU);
		$(td[4]).text(chan.HEU);
	}
}

function get_row(chan, index) {
    var row = $("<tr></tr>")
        .append("<td><a href='z' class='edit-link'>" + chan.CN + "</a></td>")
        .append("<td></td>")
        .append("<td></td>")
        .append("<td></td>")
        .append("<td></td>")
        .attr("id", chan.id)
        .data("chan", chan);

    update_row(row, chan);

    if (0 == index % 2)
        row.addClass("TDfirst");
    else
        row.addClass("TDsecond");

    return row;
}

function clickOKCancel(ok) {
    if (ok) {

        var lr = parseFloat($("#txtLR").val());
        var hr = parseFloat($("#txtHR").val());
        var leu = parseFloat($("#txtLEU").val());
        var heu = parseFloat($("#txtHEU").val());

        var err = "";
        if (isNaN(lr) || isNaN(hr) || isNaN(leu) || isNaN(heu)) {
            err += $("#txtErrNan").text() + "\n";
        } else {
            if (hr < lr)
                err += $("#txtErrHRLTLR").text() + "\n";
            if (heu < leu)
                err += $("#txtErrHEULTLEU").text() + "\n";
        }
        if (0 != err.length) {
            alert(err);
            return;
        }

        var chan = $("#edit").data("chan");
        chan.LR = lr.toString();
        chan.HR = hr.toString();
        chan.LEU = leu.toString();
        chan.HEU = heu.toString();

        update_row($("#" + chan.id), chan);
        updateModified(true);
    }
    $("#edit").dialog("close");
}

function updateModified(modified) {
    g_modified = modified;
    $("#btnSave").prop("disabled", !g_modified);
}

function afterSave(ret) {

    var txt;
    if (ret && ("OK" == ret)) {
        txt = $("#txtSaveSuccess").text();
        updateModified(false);
		$.each(g_CalData.chan, function(index,chan) {
			chan.useNewCoefficients();
			update_row($("#" + chan.id), chan);
		});
    } else {
        txt = $("#txtSaveFail").text();
    }

    alert(txt);
}

function onSave() {
    var xmldata = g_CalData.getSaveXml();

    $.ajax({
        cache: false,
        type: "POST",
        url: "/set_calibration",
        data: xmldata,
        contentType: "application/xml",
        success: function (xml, textStatus, jqXHR) {

            var ret = $(xml).find("Return").first().text();
            afterSave(ret);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            afterSave(null);
        }
    });

}

function editAO(chan) {
	$("#txtLEU").val(chan.LEU);
	$("#txtHEU").val(chan.HEU);
	$("#txtLR").val(chan.LR);
	$("#txtHR").val(chan.HR);

	$("#edit")
		.data("chan", chan)
		.dialog({
			width: 400,
			title: $("#txtEditTitle").text().replace("{0}", chan.CN),
			buttons: [
				{
					text: $("#txtOK").text(),
					click: function () {
						clickOKCancel(true);
					}
				},
				{
					text: $("#txtCancel").text(),
					click: function () {
						clickOKCancel(false);
					}
				}
			]
		});
}

var g_bQueryRead = false;
function onInterval() {
	if (g_bQueryRead)
		return;
	
	var chan = $("#cal").data("chan");
	if (!chan)
		return;
		
	g_bQueryRead = true;
	$.ajax({
		cache: true,
		url: "QUERY_READ?name=" + chan.CN,
		success: onQueryRead,
		complete: function() {
			g_bQueryRead = false;
		}
	});
}

function numToString(num) {
	if (isNaN(num))
		return "???";
	else
		return num.toFixed(2).toString();
}

function onQueryRead(data,textStatus,jqxhr) {
	var xmlChan = $(data).find("Chan").first();
	if (1 == xmlChan.length) {
		var name = xmlChan.find("Name").first().text();
		var eu = xmlChan.find("Value").first().text();
		var chan = $("#cal").data("chan");
		if (chan && chan.CN == name) {
		
			chan.computeLiveData(eu);
			
			$("#txtEU").val(numToString(chan.EU));
			$("#txtRaw").val(numToString(chan.Raw));
			$("#txtNewEU").val(numToString(chan.NewEU));
		}
	}
}

function updateControls(chan) {
	$("#txtC0").val(numToString(chan.C0));
	$("#txtC1").val(numToString(chan.C1));
	$("#txtNewC0").val(numToString(chan.NewC0));
	$("#txtNewC1").val(numToString(chan.NewC1));
	$("#txtRaw1").val(numToString(chan.Raw1));
	$("#txtEU1").val(numToString(chan.EU1));
	$("#txtRaw2").val(numToString(chan.Raw2));
	$("#txtEU2").val(numToString(chan.EU2));
}

function onValueChanged(elem,name) {
	var chan = $("#cal").data("chan");
	if (!chan)
		return;
		
	var val = parseFloat($(elem).val());
	chan[name] = val;
	
	chan.updateCoefficients();
	updateControls(chan);
}

function onRecord(sel,name) {
	var elem = $(sel);
	elem.val($("#txtRaw").val());
	onValueChanged(elem[0], name);
}

function editAI(chan) {
	chan.save();
	updateControls(chan);
	$("#cal")
		.data("chan",chan)
		.dialog({
			width: 450,
			title: $("#txtEditTitle").text().replace("{0}", chan.CN),
			buttons: [
				{
					text: $("#txtOK").text(),
					click: function () {
						calOKCancel(true);
					}
				},
				{
					text: $("#txtCancel").text(),
					click: function () {
						calOKCancel(false);
					}
				}
			]
		});
}

function calOKCancel(ok) {
	var cal = $("#cal");
	var chan = cal.data("chan");
    if (ok) {
		updateModified(true);
	} else {
		chan.restore();
	}
    update_row($("#" + chan.id), chan);
    cal.data("chan", null).dialog("close");
}

function on_document_ready() {

    $.ajaxSetup({ cache: false });

    updateModified(false);

    $.ajax({
        url: "get_calibration",
        timeout: 1000,
        complete: function (jqXHR) {
        },
        success: function (xmldata, textStatus, jqXHR) {
            g_CalData = new CalData(xmldata);

            $("#btnSave").click(onSave);
			$("#txtRaw1").change(function() {
				onValueChanged(this, "Raw1");
			});
			$("#txtEU1").change(function() {
				onValueChanged(this, "EU1");
			});
			$("#txtRaw2").change(function() {
				onValueChanged(this, "Raw2");
			});
			$("#txtEU2").change(function() {
				onValueChanged(this, "EU2");
			});
			
			$("#btnRecord1").click(function() {
				onRecord("#txtRaw1", "Raw1");
				});
			$("#btnRecord2").click(function() {
				onRecord("#txtRaw2", "Raw2");
			});
			
            $.each(g_CalData.chan, function (index, e) {
				if ("AI" == e.T) {
					$("#tbl2").append(get_row(e, index));
				} else {
					$("#tbl").append(get_row(e, index));
				}
            });

			setInterval(onInterval, 1000);
			
            $(".edit-link").click(function (e) {
                e.preventDefault();

                var chan = $(e.target).closest("tr").data("chan");
				if ("AI" == chan.T) {
					editAI(chan);
				} else {
					editAO(chan);
				}

            });
        }
    });

}