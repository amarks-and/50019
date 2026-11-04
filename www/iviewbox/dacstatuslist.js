
//////////////////////////////////////////////////////////////////////
//
//  This holds all of the functions for the StatusChansList 
//  template in the dacwebserver.
//
//////////////////////////////////////////////////////////////////////

var RunState = -1, NewRunState = false;

function sort() {}

function load_page(pagename)
{
	try
	{
		xmlhttp = new getXmlHttp();
		if (xmlhttp)
		{
			xmlhttp.onreadystatechange=parsereport;
			xmlhttp.open("GET", pagename, true);
			xmlhttp.send();
		} else	{
			alert("Error");
		}
	}
	catch(err)
	{
		alert("An error occurred while contacting the server.\n\nERROR: " + err.description);
	}
}

function parsereport()
{
    var RunText;
	if (xmlhttp.readyState==4)
	{
		if (xmlhttp.status!=200)
		{
			// cellname.innerHTML = "Error = " + xmlhttp.status;
		}
		else
		{
			xmlResponse = getXmlResponse(xmlhttp);
			items = xmlResponse.selectNodes("/AtlasReport/StatusChansList/Item");

            if (typeof items.nextNode != 'function')
            {
                for (var i = 0; i < items.length; i++)
                {
                    var item = items[i];
				    Channame = getNodeText(item.selectSingleNode("Name"));
				    if (document.getElementById("ValueOf" + Channame) != null)
					    document.getElementById("ValueOf" + Channame).innerHTML = getNodeText(item.selectSingleNode("Value"));
			    }
            }
            else
            {
			    for (var item = items.nextNode(); item; item = items.nextNode()) {
				    Channame = getNodeText(item.selectSingleNode("Name"));
				    if (document.getElementById("ValueOf" + Channame) != null)
					    document.getElementById("ValueOf" + Channame).innerHTML = getNodeText(item.selectSingleNode("Value"));
			    }
            }
            xmlResponse = getXmlResponse(xmlhttp);
			items = xmlResponse.selectNodes("/AtlasReport/Status/Item");

            if (typeof items.nextNode != 'function')
            {
                for (var i = 0; i < items.length; i++)
                {
                    var item = items[i];
                    Channame = getNodeText(item.selectSingleNode("Name"));
                    if (document.getElementById("ValueOf" + Channame) != null)
                        document.getElementById("ValueOf" + Channame).innerHTML = getNodeText(item.selectSingleNode("Value"));
                }
            }
            else
            {
                for (var item = items.nextNode(); item; item = items.nextNode()) {
                    Channame = getNodeText(item.selectSingleNode("Name"));
                    if (document.getElementById("ValueOf" + Channame) != null)
                        document.getElementById("ValueOf" + Channame).innerHTML = getNodeText(item.selectSingleNode("Value"));
                }
            }
			spanid = document.getElementById("ARS1");
			//RunText = xmlResponse.selectSingleNode("/AtlasReport/Status/AtlasRunState").text;
			stateNode = xmlResponse.selectSingleNode("/AtlasReport/Status/AtlasRunState");
			if (stateNode != null)
				RunText = getNodeText(stateNode);
			
			if (spanid != null)
			{
				//spanid.innerHTML = "<div align=\"right\">" +  RunText + "</div>";
				//if (RunText == "Testing Software not running")
				if (RunText != null)
				{
				    if (RunText.search("not running") != -1)
				    {
					    spanid.innerHTML = "<div align=\"right\" style=\"COLOR:#FF2222\">" +  RunText + "</div>";
				    }
				    else
					    spanid.innerHTML = "<div align=\"right\" style=\"COLOR:white\">" +  RunText + "</div>";
			    }
			}
		}
	}
}

function clock() 
{
	load_page("STATUS");

	if (document.layers) 
	{
		document.layers.pendule.document.write(dispTime);
		document.layers.pendule.document.close();
	}

    setTimeout("clock()", 10000);
}
