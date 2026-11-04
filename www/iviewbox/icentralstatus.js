// 

var xmlhttp = getXmlHttp();
var obj     = null;

function getCurrentTime()
{
    var date = new Date();
    var hours;
    var minutes;
    var seconds;
    
    if (date.getHours() < 10)
        hours = "0" + date.getHours();
    else
        hours = date.getHours();
        
    if (date.getMinutes() < 10)
        minutes = "0" + date.getMinutes();
    else 
        minutes = date.getMinutes();
        
    if (date.getSeconds() < 10)
        seconds = "0" + date.getSeconds();
    else
        seconds = date.getSeconds();
    
    time = hours + ":" + minutes + ":" + seconds;
    delete date;
    return time;
}

function refreshTimer()
{
    if (obj == null)
        obj     = document.getElementById("Status");

    if (xmlhttp != null)
    {
        delete xmlhttp;
        xmlhttp = null;
    }
            
	refresh("/QUERYPage", parseStatus);
    setTimeout("refreshTimer()", 10000);
}


//
//  parsereport
//

function parseStatus()
{
    if (!xmlhttp)
    {
        obj.innerHTML = getCurrentTime() + " Script error - Cannot create xmlhttp";
		obj.style.background = "red";
        return;
    }
    
	try
	{
		if (xmlhttp.readyState==4)
		{
			if (xmlhttp.status!=200)
			{
			    obj.innerHTML = getCurrentTime() + " iView connection error " + xmlhttp.status;
				obj.style.background = "red";
			}
			else
			{
				obj.style.background = "";
				obj.innerHTML = "OK";
                return;
			}
		}
	}
	catch (e)
	{
		obj.style.background = "red";
		obj.innerHTML = getCurrentTime() + " Unable to connect to the iView server. Check network connections and ensure iView is running.";
	}
}


//////////////////////////////////////////////////////////////////
//	load_page
//
//	This function asks the server to resend the page information.
//////////////////////////////////////////////////////////////////
function refresh(pagename, callback)
{
	try
	{
	    xmlhttp = new getXmlHttp();
	    
		if (xmlhttp)
		{
			try
			{
				xmlhttp.onreadystatechange=callback;
				xmlhttp.open("GET", pagename, true);
				xmlhttp.send(null);
			}
			catch(errorObject)
			{
				msg = "Could not contact the iView Server. Please make sure the iView service is running.\n\n";
				msg += "Error number: " + errorObject.number + "\n";
				msg += "Description: " + errorObject.description + "\n\n";
				obj.innerHTML = getCurrentTime() + " " + msg;
				obj.style.background = "red";
				//alert(msg);
			}
		} 
		else	
		{
			obj.innerHTML = getCurrentTime() + " Script error contacting the server";
			obj.style.background = "red";
		}
	}
	catch(e)
	{
	    obj.innerHTML = getCurrentTime() + " Script error: " + e.message;
		obj.style.background = "red";
	}
}
