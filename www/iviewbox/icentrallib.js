/////////////////////////////////////////////////////////////////////////
//  icentrallib.js
//
//  this file contains common functions used throughout the iCentral 
//  javascript.
//
//  the functions in this file are:
//      validateAlphaNumeric(str)               = check if a value is alpha numeric or not
//      validateNumeric(str)                    = check if a value is all numbers or not
//      getCheckedItems(formName, separator)    = return a list of check boxes that have been ticked within a form
//	    hide(arrObjectID)                       = This function will hide objects by using the style "display:none"
//	    display(arrObjectID)                    = This function will display objects that were hidden by the "hide" function
//      cacheImages(imgSrc)                     = This function will cache the passed in image list and return an array of the images
//	    disableControls(formID, bDisable)       = This function will either disbale or enable all of the controls that are in the form specified by "formID"
//
/////////////////////////////////////////////////////////////////////////

var alphaNumericCharacters	= "1234567890 _.qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
var numericCharacters = "1234567890"


// Based on code from:
// http://msdn.microsoft.com/en-us/library/ms537509(v=vs.85).aspx
function isIE() {
	var bIsIE = false;
	var xpath = null;

	//AWM: Can't just check the string from the browser anymore
	//because IE 11 lies and says it's Netscape.
	//So at present, IE is the only browser that doesn't implement XPathEvaluator().
	try {
		xpath = new XPathEvaluator();
	}
	catch (e) {
		bIsIE = true;
	}
	xpath = null;


    return bIsIE;
}


function getNodeText(node)
{
    var textValue = "";

    if (typeof node.text != 'undefined' && node.text != null)
    {
      textValue = node.text;
    }
    else if (typeof node.textContent != 'undefined' && node.textContent != null)
    {
      textValue = node.textContent;
    }
    else if (typeof node.innerText != 'undefined' && node.innerText != null) 
    {
      textValue = node.innerText;
    }
    
    return textValue;
}


function getXmlHttp()
{
	var xmlhttp = null;

    // Code below based on code from:
    // http://www.opendebug.com/article/434275
	//AWM: It appears that in IE11, window.ActiveXObject doesn't exist anymore.
	//So we just go ahead and try to create the IE http object.
    //if (window.ActiveXObject)
	try {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	catch (e) {
		xmlhttp = null;
	}

    if (xmlhttp == null)
    {
        xmlhttp = new XMLHttpRequest();
        XMLDocument.prototype.selectSingleNode = Element.prototype.selectSingleNode = function (xpath)
        {
            var x = this.selectNodes (xpath)
            if (!x || x.length < 1)
            {
                return null;

            }

            return x [0];
        }

        Document.prototype.selectNodes = Element.prototype.selectNodes = function (xpath)
        {
            var xpe = new XPathEvaluator ();
			
            var nsResolver = xpe.createNSResolver(this.ownerDocument == null ? this.documentElement : this.ownerDocument.documentElement);
			
            var result = xpe.evaluate(xpath, this, nsResolver, 0, null);
			
            var found = [];
            var res;
            while (res = result.iterateNext ())
            {
                found.push (res);
            }

            return found;
        }
    }

	return xmlhttp;
}


function getXmlDoc()
{
	if (!isIE())
	{
		xmlDoc = document.implementation.createDocument("", "", null);
		var objDOMParser = new DOMParser();
		var objDoc = objDOMParser.parseFromString(xmlhttp.responseText, "text/xml");
		while (xmlDoc.hasChildNodes())
			xmlDoc.removeChild(this.lastChild);
		for (var i=0; i < objDoc.childNodes.length; i++) {
			var objImportedNode = xmlDoc.importNode(objDoc.childNodes[i], true);
			xmlDoc.appendChild(objImportedNode);
			}	
	}
	else
	{
		xmlDoc = new ActiveXObject("Msxml2.DOMDocument"); // For IE.
		// Same as: new ActiveXObject("Msxml2.DOMDocument.3.0");
		// Should fall down from 6 to 2.
		// http://forums.devshed.com/xml-programming-19/microsoft-xmldom-vs-msxml2-domdocument-3-0t-565941.html
		// TODO - use a fall-down loop to get newest.
	}
	return xmlDoc;
}


function getXmlResponse(xmlhttp)
{
    if (xmlhttp == null)
    {
        return null;
    }

    var xmlResponse = xmlhttp.responseXML;

    if (xmlResponse == null)
    {
        var parser = new DOMParser();
        xmlResponse = parser.parseFromString(xmlhttp.responseText, "application/xml");
    }

    return xmlResponse;
}




function RedrawPage(xmlfilename, xslfilename, srchname, page, direction) 
{ 
	var xslt = new ActiveXObject("Msxml2.XSLTemplate.3.0");
	var xsldoc = new ActiveXObject("Msxml2.FreeThreadedDOMDocument.3.0");
	var xslproc;
	xsldoc.async = false;
	xsldoc.load(xslfilename); 
	xslt.stylesheet = xsldoc;
	var xmldoc = new ActiveXObject("MSXML2.FreeThreadedDOMDocument");
	xmldoc.async = false;
	xmldoc.load(xmlfilename);
	
	if (xmldoc.parseError.errorCode != 0)
    {
	    var myErr = xmldoc.parseError;
	    alert("You have error " + myErr.reason);
    }
	//var xmldoc = document.getElementById('Projects');
	xslproc = xslt.createProcessor();
	xslproc.input = xmldoc;
	//alert(page);
	xslproc.addParameter("report", srchname); 
	xslproc.addParameter("page", page); 
	xslproc.addParameter("direction", direction); 
	xslproc.transform();
	var obj=document.getElementById("listing");
	if(obj.innerHTML)
	{
		obj.innerHTML = xslproc.output; 
	}
	else
	{
		alert("Error");
	}
}


/////////////////////////////////////////////////////////////////////////
//	validateAlphaNumeric
//
//  Description:
//      This function will make sure that the passed string 
//      only has alpha numeric characters in it.
//
//  Parameters:
//      str = string to validate
//
//  Return:
//      true    = this is a valid alpha numeric strong
//      false   = this is not a valid alpha numeric string
/////////////////////////////////////////////////////////////////////////
function validateAlphaNumeric(str)
{
    var bValid = true;
    
	for (var i = 0; i < str.length; i++)
	{
		for (var j = 0; j < alphaNumericCharacters.length; j++)
		{
			if (str.charAt(i) == alphaNumericCharacters.charAt(j))
				break;
			if (j == alphaNumericCharacters.length-1)
				bValid = false;
		}
	}

    return bValid;	
}

/////////////////////////////////////////////////////////////////////////
//	validateNumeric
//
//  Description:
//      This function will make sure that the passed string 
//      only has numeric characters in it.
//
//  Parameters:
//      str = the string to validate
//
//  Return Code:
//      true    = this is a valid number
//      false   = this is not a valid number
/////////////////////////////////////////////////////////////////////////
function validateNumeric(str)
{
    var bValid = true;
    
	for (var i = 0; i < str.length; i++)
	{
		for (var j = 0; j < numericCharacters.length; j++)
		{
			if (str.charAt(i) == numericCharacters.charAt(j))
				break;
			if (j == numericCharacters.length-1)
				bValid = false;
		}
	}

    return bValid;	
}


/////////////////////////////////////////////////////////////////////////
//	getCheckedItems
//
//  Description:
//      This function will return a string of all of the names of the
//      check box items within a form that have been ticked.
//
//  Parameters:
//      formName    = the name of the form to search for checked items
//      separator   = what character to use to separate the returned
//                      list of selected items.
//
//  Return Code:
//      string  = a string of the name of the checked items separated 
//                  by the "separator" parameter.
/////////////////////////////////////////////////////////////////////////
function getCheckedItems(formName, separator)
{
    var strList = "";

	form		= document.getElementById(formName);
	for (i = 0; i < form.length; i++)
	{
	    if (form[i].checked)
	    {
	        temp = strList;
	        if (strList == "")
	            strList = form[i].value;
	        else
	            strList = temp + separator + form[i].value;
	    }
	}
	
    return strList;
}


function selectComboString(combo, str)
{
    for (var i = 0; i < combo.options.length; i++)
    {
        if (str == combo.options[i].text)
        {
            combo.selectedIndex = i;
            return true;
        }
    }

    combo.selectedIndex = -1;
    return false;
}


/////////////////////////////////////////////////////////////////////////
//	hide
//
//  Description:
//      This function will hide objects by using the style "display:none"
//
//  Parameters:
//      arrObjectID = all of the object ID's to hide
//
//  Return Code:
//      N/A
/////////////////////////////////////////////////////////////////////////
function hide(arrObjectID)
{
	for (i = 0; i < arrObjectID.length; i++)
	{
	    obj = document.getElementById(arrObjectID[i]);
	    if (obj)
	        obj.style.display = "none";
	}
}

/////////////////////////////////////////////////////////////////////////
//	display
//
//  Description:
//      This function will display objects that were hidden by the 
//      "hide" function
//
//  Parameters:
//      arrObjectID = all of the object ID's to show
//
//  Return Code:
//      N/A
/////////////////////////////////////////////////////////////////////////
function display(arrObjectID, displayType)
{
	for (i = 0; i < arrObjectID.length; i++)
	{
	    obj = document.getElementById(arrObjectID[i]);
	    if (obj)
	        obj.style.display = displayType;
	}
}

/////////////////////////////////////////////////////////////////////////
//	cacheImages
//
//  Description:
//      This function will cache the passed in image list and return 
//      an array of the images
//
//  Parameters:
//      imgSrc = all of the image names to cache
//
//  Return Code:
//      Array of images
/////////////////////////////////////////////////////////////////////////
function cacheImages(imgSrc)
{
    var aryImages = [];
    var preloads = imgSrc.split(",");
    
    for (var i = 0; i < preloads.length; i++)
    {
        aryImages[i]        = new Image();
        aryImages[i].src    = preloads[i];
    }
    
    return aryImages;    
}

/////////////////////////////////////////////////////////////////////////
//	disableControls
//
//  Description:
//      This function will either disbale or enable all of the controls
//      that are in the form specified by "formID"
//
//  Parameters:
//      formID      = the ID of the form whose controls need to be disabled/enabled
//      bDisable    = true - disable the controls
//                    false - enable the controls
//  Return Code:
//      N/A
/////////////////////////////////////////////////////////////////////////
function disableControls(formID, bDisable)
{
    var controls = document.getElementById(formID).elements;

    for (var i = 0; i < controls.length; i++)
    {
        if (typeof controls[i].disabled != 'undefined')
            controls[i].disabled = bDisable;
    }
}