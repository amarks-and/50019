<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- Edited with XML Spy v4.2 -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method='html' version='1.0' encoding='UTF-8' indent='yes'/>


<xsl:template match="/AtlasReport/ERROR">
<link rel="stylesheet" type="text/css" href="/iviewbox/atlas-iview.css"></link>
	<HTML>
	<body class="info">
	
	<div class="titlebardiv">ERROR</div>

		<table bgcolor="white" border="1" rules="none" frame="box" style="margin=20;">
			<tr>
				<td><img src="iviewbox/images/error.jpg" style="margin:20;"/></td>
				<td><xsl:value-of select="DESCRIPTION"/></td>
			</tr>
		</table>
	</body>
	</HTML>
</xsl:template>

<!-- ==============================================================
<	template "CalTable"
<
<	Purpose
<		For displaying caltable.csv
<
================================================================ -->
<xsl:template match="AtlasReport/CalTable">
<html>
	<link rel="stylesheet" type="text/css" href="iviewbox/atlas-iview.css"></link>
	<link rel="stylesheet" type="text/css" href="iviewbox/fixedcolumn.css"></link>
    <script language="JavaScript" src="../iviewbox/icentrallib.js"></script>
	<script language="JavaScript" src="../iviewbox/fixedcolumn.js"></script>
	<script language="JavaScript" src="../iviewbox/sorttable.js"></script>
	<script language="JavaScript" src="../iviewbox/dashboard.js"></script>
	<SCRIPT for="window" event="onload">
        <![CDATA[
			{
				// init table makes the table sortable.
				//initTable("CalTable");
			}
		]]>
	</SCRIPT>
	<head>
		<title>Calibration Data</title>
	</head>
	<SCRIPT type="text/javascript">
	<![CDATA[
	{
		function startUp()
		{
			//lockCol("CalTable", 2);
			setReportType("CalTable");
		}
	} ]]>
	</SCRIPT>
	<body>
		<div style="width:100%;table-layout:fixed;word-wrap:break-word;">      
			<table class="layout">
				<tr>
					<th class="TDPageTitle">
						iTest Calibration Data
					</th>
				</tr>
			</table>
		</div>
		<div id="tbl-container">
			<table class="sortable" id="calTable">
				<thead>
					<!-- Show one row that has all the column headings. -->
					<tr class="THheadLink">
						<xsl:for-each select="Headings/Heading">
							<td><xsl:value-of select="Value"/></td>
						</xsl:for-each>
					</tr>
				</thead>
				
				<!-- Show the values for each calibration type (row) -->
				<xsl:for-each select="CalibrationTypes/CalibrationTypeRow">
					<tr>
						<!-- Create the every-other-line coloring that is common to iCental tables. -->
						<xsl:if test ="position() mod 2 = 0"><xsl:attribute name="class">TDFirst</xsl:attribute></xsl:if>
						<xsl:if test ="position() mod 2 = 1"><xsl:attribute name="class">TDSecond</xsl:attribute></xsl:if>
						<!-- Show the value of each cal_type field -->
						<xsl:for-each select="CalTypeFieldsCols/Field">
							<td><xsl:value-of select="Value"/></td>
						</xsl:for-each>
					</tr>
				</xsl:for-each>
			</table>
		</div>			
	</body>
</html>
</xsl:template>

<xsl:template match="/AtlasReport/MESSAGE">
<link rel="stylesheet" type="text/css" href="/iviewbox/atlas-iview.css"></link>
	<HTML>
	<body class="info">
		
		<div class="titlebardiv">Information</div>
		
		<table bgcolor="white" border="1" rules="none" frame="box" style="margin=20;">
			<tr>
				<td><img src="iviewbox/images/info.jpg" style="margin:20;"/></td>
				<td><xsl:value-of select="DESCRIPTION"/></td>
			</tr>
		</table>
	</body> 
	</HTML>
</xsl:template>


<!-- ==============================================================
<
<	return the default html page, equivalent of index.html
<
=============================================================== -->
<xsl:template match="/AtlasReport/Default">
	<html><title>iViewBox</title>
	<frameset id="MainFR" rows="83,*,32" frameborder="no" framespacing="0">
	<frame name="above" src="iviewbox/header.html" scrolling="no" frameborder="no" noresize="noresize"/>
	<frameset name="SecondFR" id="mainFS" cols="205,*" frameborder="no" framespacing="0">
	<frame name="left" src="/NavigationTree" frameborder="no" scrolling="auto" noresize="noresize"/>
	<frame name="right" src="/STATUS" frameborder="no" noresize="noresize"/>
	</frameset>
	<frame src="iviewbox/bottom.html" name="bottom" frameborder="no" scrolling="no" noresize="noresize" id="bottom"/>
	</frameset>
	</html>
</xsl:template>

<!-- ===============================================================
<
<	/AtlasReport/NavigationTree/tree
<
<	This will take the xml and create a tree view with expandable
<	branches. It uses the external files:
<		xmlTree.js	- Javascript for swapping the opened and close images
<		navtree.css	- Style sheet to format the font and background
<
================================================================ -->
<xsl:template match="/AtlasReport/NavigationTree/tree">
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>XML Tree Control</title>
<link rel="stylesheet" type="text/css" href="iviewbox/css/sidebar.css"></link>
</head>
<body>

	<div class="sidebar">
	<div class="header">View</div>
	<div class="links">
		<a href="/Status" target="right">System Status</a>
		<a href="/Health" target="right">System Health</a>
		<a href="/SCREENCAP" target="right">Desktop Image</a>
	</div>
	<div class="header">Explore</div>
	<div class="links">
		<a href="/SolutionDir" target="right">Solution</a>
		<a href="/DataFiles" target="right">Data Files</a>
		<a href="/LogFiles" target="right">Log Files</a>
		<a href="/SystemDir" target="right">System Files</a>
	</div>
	<div class="header">Configure</div>
	<div class="links">
		<a href="update_firmware.html" target="right">Update Firmware</a>
		<a href="change_settings.html" target="right">Change Settings</a>
		<a href="calibration.html" target="right">Calibration</a>
		<a href="update_level2.html" target="right">Configure iView Level2</a>
	</div>
	</div>
			
</body>
</html>
</xsl:template>


<!-- ======================================================================
<
<	branch
<
<	This is a recursive template that will display a branch of the tree
<	/AtlasReport/NavigationTree/tree and all of its leaves.
<
======================================================================== -->
<xsl:template match="branch">
		<span class="trigger" onClick="showBranch('{id}', '{imageOpen}', '{imageClosed}');">
			<img src="{imageClosed}" id="I{id}" class="imgBranch"/><xsl:value-of select="text"/><br/>
		</span>
		<span class="branch" id="{id}">
			<xsl:apply-templates select="branch"></xsl:apply-templates>
			<xsl:for-each select="leaf">
				<img src="{image}" class="imgBullet"/><a href="{link}" target="right"><xsl:value-of select="text"/></a><br/>
			</xsl:for-each>
		</span>
</xsl:template>

<!-- ======================================================================
<
<	StatusChansList Report 
<
========================================================================== -->
<xsl:template match="AtlasReport/StatusChansList">
<html>
<link rel="stylesheet" type="text/css" href="/iviewbox/atlas-iview.css"></link>
<script language="JavaScript" src="../iviewbox/icentrallib.js"></script>
<script language="JavaScript" src="../iviewbox/dacstatuslist.js"></script>
<body onLoad="clock()">
	
		<div class="titlebardiv">
			<!--Test System Channels <a href="{//AtlasReport/TestCell}EditChannelList" class="edit-link">(edit)</a><span id="ARS1"> System not running</span>-->
			Test System Channels <span id="ARS1"> System not running</span>
		</div>
		
		<table width="100%" class="layout styled">
		<TR class="THheadLink">
			<td><div onclick="sort('Name','text','Applics')">Name</div>
			</td>
			<td><div onclick="sort('Detail','text','Applics')">Value</div>
			</td>
		</TR>
    	<xsl:for-each select="Item">
			<tr>
				<xsl:if test ="position() mod 2 = 0"><xsl:attribute name="class">TDFirst</xsl:attribute></xsl:if>
				<xsl:if test ="position() mod 2 = 1"><xsl:attribute name="class">TDSecond</xsl:attribute></xsl:if>
				<td align="left" width="50%" valign="bottom" height="18">
					<xsl:value-of select="Name"/>
				</td>
				<td align="left" width="50%" valign="bottom" height="18">
					<span id="ValueOf{Name}"><xsl:value-of select="Value"/></span>
				</td>
			</tr>
 	    </xsl:for-each>
	</table>
	</body>
</html>
</xsl:template>


<xsl:template match="/AtlasReport/EditChannelList">
    <script language="JavaScript" src="../iviewbox/icentrallib.js"></script>
	<script language="JavaScript" src="../iviewbox/dacEditChannel.js"></script>
	<script language="JavaScript" src="../iviewbox/dacNewReport.js"></script>
<html>
<link rel="stylesheet" type="text/css" href="/iviewbox/atlas-iview.css"></link>
	<body onload="getRDBChannels();">
	    <xsl:variable name="lblHeight">
			<xsl:if test="count(NAME) &gt; 0">
				<xsl:value-of select="170"/>
			</xsl:if>
			<xsl:if test="count(NAME) = 0">
				<xsl:value-of select="5"/>
			</xsl:if>
	    </xsl:variable>

	    <xsl:variable name="listHeight">
			<xsl:if test="count(NAME) &gt; 0">
				<xsl:value-of select="200"/>
			</xsl:if>
			<xsl:if test="count(NAME) = 0">
				<xsl:value-of select="35"/>
			</xsl:if>
	    </xsl:variable>

	    <xsl:variable name="btnAddHeight">
			<xsl:if test="count(NAME) &gt; 0">
				<xsl:value-of select="256"/>
			</xsl:if>
			<xsl:if test="count(NAME) = 0">
				<xsl:value-of select="111"/>
			</xsl:if>
	    </xsl:variable>

	    <xsl:variable name="btnRemoveHeight">
			<xsl:if test="count(NAME) &gt; 0">
				<xsl:value-of select="300"/>
			</xsl:if>
			<xsl:if test="count(NAME) = 0">
				<xsl:value-of select="156"/>
			</xsl:if>
	    </xsl:variable>
			
			<xsl:variable name="btnSaveHeight">
			<xsl:if test="count(NAME) &gt; 0">
				<xsl:value-of select="530"/>
			</xsl:if>
			<xsl:if test="count(NAME) = 0">
				<xsl:value-of select="370"/>
			</xsl:if>
	    </xsl:variable>
	    
		
		<div class="titlebardiv">Edit Test System Channels List</div>
		
		<div class="wrapper">

		<INPUT id="btnChannelUp" style="Z-INDEX: 104; LEFT: 712px; WIDTH: 123px; POSITION: absolute; TOP: {$btnAddHeight}px; HEIGHT: 34px"
			type="button" value="UP" name="btnChannelUp" onclick="moveChannelUp()" ></INPUT>
		<INPUT id="btnChannelDown" style="Z-INDEX: 105; LEFT: 712px; WIDTH: 123px; POSITION: absolute; TOP: {$btnRemoveHeight}px; HEIGHT: 34px"
			type="button" value="DOWN" name="btnChannelDown" onclick="moveChannelDown()" />

		<FORM METHOD="post" ACTION="url=/QUERY_EDIT_CH_SUBMIT?" ID="EditChans">
			<SELECT id="AvailableChannels" style="Z-INDEX: 101; LEFT: 39px; WIDTH: 249px; POSITION: absolute; TOP: {$listHeight}px; HEIGHT: 313px" size="19" name="AvailableChannels" multiple="true">
			</SELECT>
			<INPUT id="btnRemoveChannel" style="Z-INDEX: 105; LEFT: 312px; WIDTH: 123px; POSITION: absolute; TOP: {$btnRemoveHeight}px; HEIGHT: 34px"
				type="button" value="Remove" name="btnRemoveChannel" onclick="btnMove('ChanTextList', 'AvailableChannels', 'false')" />
			<SELECT id="ChanTextList" style="Z-INDEX: 103; LEFT: 454px; WIDTH: 249px; POSITION: absolute; TOP: {$listHeight}px; HEIGHT: 313px" size="19" name="ChanTextList" multiple="true">
				<xsl:for-each select="SELECTED/CHANNEL">
					<OPTION value="{NAME}"><xsl:value-of select="NAME"/></OPTION>
				</xsl:for-each>
			</SELECT>
			<DIV style="DISPLAY: inline; Z-INDEX: 102; LEFT: 16px; WIDTH: 285px; FONT-FAMILY: Arial; POSITION: absolute; TOP: {$lblHeight}px; HEIGHT: 38px"
				ms_positioning="FlowLayout">Available Channels on the RDB:</DIV>
			<INPUT id="btnAddChannel" style="Z-INDEX: 104; LEFT: 312px; WIDTH: 123px; POSITION: absolute; TOP: {$btnAddHeight}px; HEIGHT: 34px"
				type="button" value="Add" name="btnAddChannel" onclick="btnMove('AvailableChannels', 'ChanTextList', true)" ></INPUT>
			<DIV style="DISPLAY: inline; Z-INDEX: 106; LEFT: 432px; WIDTH: 301px; FONT-FAMILY: Arial; POSITION: absolute; TOP: {$lblHeight}px; HEIGHT: 39px"
				ms_positioning="FlowLayout">Selected Channels:</DIV>
			<INPUT id="SubmitChannels" style="Z-INDEX: 108; LEFT: 564px; WIDTH: 139px; POSITION: absolute; TOP: {$btnSaveHeight}px; HEIGHT: 34px"
				type="submit" value="Save" name="SubmitChannels" onClick="btnSelectDesiredChannels()"></INPUT>
			<xsl:if test="count(NAME) &gt; 0">
				<DIV style="DISPLAY: inline; Z-INDEX: 109; LEFT: 16px; WIDTH: 149px; FONT-FAMILY: Arial; POSITION: absolute; TOP: 38px; HEIGHT: 29px"
					ms_positioning="FlowLayout">Report Name:</DIV>
				<INPUT id="txtReportName" style="Z-INDEX: 110; LEFT: 193px; WIDTH: 264px; POSITION: absolute; TOP: 39px; HEIGHT: 26px"
					type="text" size="38" name="txtReportName" value="{NAME}" readonly="true"/>
				<DIV style="DISPLAY: inline; Z-INDEX: 111; LEFT: 16px; WIDTH: 144px; FONT-FAMILY: Arial; POSITION: absolute; TOP: 89px; HEIGHT: 32px"
					ms_positioning="FlowLayout">Description:</DIV>
				<INPUT id="txtDescription" style="Z-INDEX: 112; LEFT: 193px; OVERFLOW: auto; WIDTH: 504px; POSITION: absolute; TOP: 89px; HEIGHT: 60px"
					type="text" maxLength="100" size="78" name="txtDescription" value="{DESCRIPTION}"/>
			</xsl:if>
			
		</FORM>
		<INPUT id="txtTestCell" type="text" name="txtTestCell" value="{//AtlasReport/TestCell}" style="visibility: hidden;"/>
		
		</div>
		
	</body>
</html>
	
</xsl:template>


<xsl:template match="RDBChannel">
	<xsl:for-each select="CHANNEL">
		<xsl:sort select="NAME"/>
		<OPTION><xsl:value-of select="NAME"></xsl:value-of></OPTION>
	</xsl:for-each>
</xsl:template>


<!-- Task Info Report -->
<xsl:template match="/AtlasReport/TaskInfo">
<html>
<link rel="stylesheet" type="text/css" href="/iviewbox/atlas-iview.css"></link>
<body>
<!-- This line prevents sort click errors --><SCRIPT type="text/javascript"><![CDATA[{   function sort() {} }]]></SCRIPT>
	<div class="titlebardiv">Process Report</div>
	
	<table width="100%" class="layout styled">
		<TR class="THheadLink">
			<td><div onclick="sort('Name','text','Applics')">Task</div>
			</td>
			<td><div onclick="sort('Name','text','Applics')">Memory (kB)</div>
			</td>
		</TR>
	
		<xsl:for-each select="Module">
			<tr>
				<xsl:if test ="position() mod 2 = 0"><xsl:attribute name="class">TDFirst</xsl:attribute></xsl:if>
				<xsl:if test ="position() mod 2 = 1"><xsl:attribute name="class">TDSecond</xsl:attribute></xsl:if>
				<td align="left" valign="bottom" height="18">
					<xsl:value-of select="Name"/>
				</td>
				<td align="left"  valign="bottom" height="18">
					<xsl:value-of select="PrivateBytes"/>
				</td>
			</tr>
 		</xsl:for-each>
	</table>
	<br></br><br></br>
</body>
</html>
</xsl:template>

<!-- Status Report  -->
<xsl:template match="/AtlasReport/Status">
<html>
	<link rel="stylesheet" type="text/css" href="/iviewbox/atlas-iview.css"></link>
	<body>
	
	<div class="titlebardiv">Test System Status</div>
	
	<table width="100%" class="layout styled">
		<TR class="THheadLink">
			<td><div onclick="sort('Name','text','Applics')">Name</div>
			</td>
			<td><div onclick="sort('Detail','text','Applics')">Value</div>
			</td>
		</TR>
      	<xsl:for-each select="Item">
			<tr>
				<xsl:if test ="position() mod 2 = 0"><xsl:attribute name="class">TDFirst</xsl:attribute></xsl:if>
				<xsl:if test ="position() mod 2 = 1"><xsl:attribute name="class">TDSecond</xsl:attribute></xsl:if>
				<td align="left" width="50%" valign="bottom" height="18">
					<xsl:value-of select="Name"/>
				</td>
				<td align="left" width="50%" valign="bottom" height="18">
					<span id="ValueOf{Name}"><xsl:value-of select="Value"/></span>
				</td>
			</tr>
		</xsl:for-each>
	</table>
	</body>
</html>
</xsl:template>


<!-- Health Items  -->
<xsl:template match="/AtlasReport/Health/Items">
<html>
<!--
<meta http-equiv="refresh" content="60"></meta>
-->
<head>
<!-- This line prevents sort click errors --><SCRIPT type="text/javascript"><![CDATA[{   function sort() {} }]]></SCRIPT>
</head>
	<link rel="stylesheet" type="text/css" href="/iviewbox/atlas-iview.css"></link>
	<body>
	
	<div class="titlebardiv">Test System Health <span id="ARS1"> </span></div>
	
	<table width="100%" class="layout styled">
		<TR class="THheadLink">
			<td><div onclick="sort('Name','text','Applics')">Name</div>
			</td>
			<td><div onclick="sort('Detail','text','Applics')">Value</div>
			</td>
		</TR>
   		<xsl:for-each select="Item">
		<tr>
			<xsl:if test ="position() mod 2 = 0"><xsl:attribute name="class">TDFirst</xsl:attribute></xsl:if>
			<xsl:if test ="position() mod 2 = 1"><xsl:attribute name="class">TDSecond</xsl:attribute></xsl:if>
			<td align="left" width="50%" valign="bottom" height="18">
				<xsl:value-of select="Name"/>
			</td>
			<td align="left" width="50%" valign="bottom" height="18">
				<span id="ValueOf{Name}"><xsl:value-of select="Value"/></span>
			</td>
		</tr>
		</xsl:for-each>
	</table>
	</body>
	<br></br><br></br>
</html>
</xsl:template>

<!-- LabMinder  -->
<xsl:template match="/AtlasReport/LabMinder">
<html>
<!--
<meta http-equiv="refresh" content="60"></meta>
-->
<head>
<!-- This line prevents sort click errors --><SCRIPT type="text/javascript"><![CDATA[{   function sort() {} }]]></SCRIPT>
</head>
	<link rel="stylesheet" type="text/css" href="/iviewbox/atlas-iview.css"></link>
	<body>
	
	<div class="titlebardiv">Respond to SOH event<span id="ARS1"> </span>s</div>
	
	<table width="100%" class="layout">
		<tr>
			<td >
				<FORM METHOD="get" ACTION="{//AtlasReport/TestCell}LabMinderResponse" ID="setDACParameterMap" name="ParameterMap">
					<DIV style="Z-INDEX: 101; LEFT: 20px; WIDTH: 677px; BACKGROUND-REPEAT: no-repeat; POSITION: absolute; TOP: 40px; HEIGHT: 566px"
						ms_positioning="GridLayout">

					<table>
					<tr>
						<td>
							<center>SOH event on Workstation: <xsl:value-of select="wid" /></center>
							<input type="hidden" name="wid" maxlength="5" readonly="readonly">
							  <xsl:attribute name="value">
								<xsl:value-of select="wid" />
							  </xsl:attribute>
							</input><br/>
							
							<LABEL for="id">Choose one an option below to respond to SOH event ID: <xsl:value-of select="id" /></LABEL>
							<input type="hidden" name="id" maxlength="5" readonly="readonly">
							  <xsl:attribute name="value">
								<xsl:value-of select="id" />
							  </xsl:attribute>
							</input><br/>
							
							<input type="hidden" name="email" maxlength="5" readonly="readonly">
							  <xsl:attribute name="value">
								<xsl:value-of select="email" />
							  </xsl:attribute>
							</input> 
							
							<br />
							<xsl:for-each select="responses">
								<input type="radio" name="command">
									<xsl:attribute name="value">
										<xsl:value-of select="ignore" />
									</xsl:attribute>
									<xsl:attribute name="checked">checked</xsl:attribute>
									<xsl:value-of select="ignore"/>
								</input> <br />
								<input type="radio" name="command">
									<xsl:attribute name="value">
										<xsl:value-of select="stop" />
									</xsl:attribute>
									<xsl:value-of select="stop"/>
								</input> <br />
								<input type="radio" name="command">
									<xsl:attribute name="value">
										<xsl:value-of select="resume" />
									</xsl:attribute>
									<xsl:value-of select="resume"/>
								</input> <br />
								<input type="radio" name="command">
								<xsl:attribute name="value">
									<xsl:value-of select="user1" />
								</xsl:attribute>
								<xsl:value-of select="user1"/>
								</input> <br />
								<input type="radio" name="command">
								<xsl:attribute name="value">
									<xsl:value-of select="user2" />
								</xsl:attribute>
								<xsl:value-of select="user2"/>
								</input> <br />
							</xsl:for-each>
						</td>
					</tr>
					<tr>
						<td><br></br><input type="submit" name="button1" value="Respond" id="Submit1"/></td>
					</tr>
					</table>
					</DIV>
				</FORM>
			</td>
		</tr>
	</table>
	</body>
	<br></br><br></br>
</html>
</xsl:template>


<!-- Client Info Report -->
<xsl:template match="/AtlasReport/ClientsInfo">
<html>
<link rel="stylesheet" type="text/css" href="/iviewbox/atlas-iview.css"></link>
<body>
<!-- <xsl:comment>  -->
<div class="titlebardiv">Client Information<span id="ARS1"></span></div>

<table width="100%" class="layout styled">
	<TR class="THheadLink">
		<td><div onclick="sort('Name','text','Applics')">Client</div>
		</td>
		<td><div onclick="sort('Name','text','Applics')">Reports</div>
		</td>
		<td><div onclick="sort('Name','text','Applics')">Connections</div>
		</td>
		<td><div onclick="sort('Name','text','Applics')">IP Address</div>
		</td>

	</TR>
    <xsl:for-each select="C">
	<tr>
		<xsl:if test ="position() mod 2 = 0"><xsl:attribute name="class">TDFirst</xsl:attribute></xsl:if>
		<xsl:if test ="position() mod 2 = 1"><xsl:attribute name="class">TDSecond</xsl:attribute></xsl:if>
		<td align="left" valign="bottom" height="18">
			<xsl:value-of select="Name"/>
		</td>
		<td align="left" width="25%" valign="bottom" height="18">
			<xsl:value-of select="NumReports"/>
		</td>
		<td align="left" width="25%" valign="bottom" height="18">
			<xsl:value-of select="NumConnections"/>
		</td>
		<td align="left" width="25%" valign="bottom" height="18">
			<xsl:value-of select="IP"/>
		</td>
	</tr>
 	</xsl:for-each>
</table>
</body>
</html>
</xsl:template>


<!--<xsl:template match="/AtlasReport/DirListing | /eLabQueryArchiveResults/DirListing">-->
<xsl:template match="/AtlasReport/NewDirListing | /eLabQueryArchiveResults/NewDirListing">
	<link rel="stylesheet" type="text/css" href="./iviewbox/atlas-iview.css"></link>
	<script language="JavaScript" src="../iviewbox/sorttable.js"></script>
	<SCRIPT for="window" event="onload"><xsl:comment><![CDATA[
	{		
		alert("Sorting ...");
		initTable("dirListing");
		alet("Done");
	}
	]]></xsl:comment></SCRIPT>

	<body>
		<table class="layout">
			<tr >
				<th class="TDPageTitle" colspan="3"><xsl:value-of select="Description" /> </th>				
			</tr>
		</table>

		<table class="layout" id="dirListing" name="dirFileTable">
			<TR class="THheadLink">
				<td width="15%"><div>Name</div></td>
				<td width="10%"><div class="THheadLinkRJ">Size(Bytes)</div></td>
				<td width="15%"><div class="THheadLinkCJ">Date</div></td>
			</TR>
			<xsl:for-each select="File | Dir">
			<xsl:sort select="Date" data-type="text" order="descending"/>
				<tr>
					<xsl:if test ="position() mod 2 > 0">
						<xsl:attribute name="class">TDSecond</xsl:attribute>
					</xsl:if>
					<xsl:if test ="position() mod 2 = 0">
						<xsl:attribute name="class">TDfirst</xsl:attribute>
					</xsl:if>
					
					<td>
						<xsl:if test="name()='Dir'"><img src="/iviewbox/images/folder_closed.gif" alt="" hspace="5"></img></xsl:if>
						<xsl:if test="name()='File'"><img src="/iviewbox/images/file.gif" alt="" hspace="5"></img></xsl:if>
						<a><xsl:attribute name="HREF"><xsl:value-of select="RelPath"/></xsl:attribute><xsl:value-of select="Name" /></a>
					</td>
					<TD class="TDfirstRJ">
						<xsl:call-template name="FormatNumber"><xsl:with-param name="Number" select="Size"/></xsl:call-template>
					</TD>
					<TD class="TDfirstCJ">
						<span id="timelocale"><xsl:value-of select="Date"/></span>
					</TD>
				</tr>
			</xsl:for-each>
		</table>
	</body>
</xsl:template>

<!-- Files Listing eLabQueryArchiveResults -->
<xsl:template match="/AtlasReport/DirListing | /eLabQueryArchiveResults/DirListing">
<!--<xsl:template match="/AtlasReport/OldDirListing | /eLabQueryArchiveResults/OldDirListing">-->
<link rel="stylesheet" type="text/css" href="/iviewbox/atlas-iview.css"></link>
	<!--<script language="JavaScript" src="./iviewbox/sorttable.js"></script>-->
	<!--<script language="JavaScript" src='<%=ResolveUrl("./iviewbox/sorttable.js")%>'></script>-->
    <script language="JavaScript" src="/iviewbox/sorttable.js"></script>

	<SCRIPT for="window" event="onload"><xsl:comment><![CDATA[
	{		
		//initTable("dirListing");
	}
	]]></xsl:comment></SCRIPT>

	<body>
		
		<div class="titlebardiv"><xsl:value-of select="/AtlasReport/DirListing/Description | /eLabQueryArchiveResults/DirListing/Description" /></div>

		<table class="layout sortable styled" id="dirListing">
			<TR class="THheadLink">
				<td width="40%">Name</td>
				<td width="20%">Size(Bytes)</td>
				<td width="40%">Date</td>
			</TR>
			<xsl:for-each select="File | Dir">
				<xsl:sort select="name()" data-type="text" order="ascending"/>
				<tr ROWSPAN="1">
					<xsl:if test ="position() mod 2 > 0">
						<xsl:attribute name="class">TDSecond</xsl:attribute>
					</xsl:if>
					<xsl:if test ="position() mod 2 = 0">
						<xsl:attribute name="class">TDfirst</xsl:attribute>
					</xsl:if>
					<td>
						<xsl:if test="name()='Dir'"><img src="/iviewbox/images/folder_closed.gif" alt="" hspace="5"></img></xsl:if>
						<xsl:if test="name()='File'"><img src="/iviewbox/images/file.gif" alt="" hspace="5"></img></xsl:if>
						<a>
							<xsl:attribute name="HREF"><xsl:value-of select="RelPath"/></xsl:attribute><xsl:value-of select="Name" />
						</a>
					</td>
					<TD class="TDfirstRJ">
						<xsl:call-template name="FormatNumber"><xsl:with-param name="Number" select="Size"/></xsl:call-template>
					</TD>
					<TD class="TDfirstCJ">
						<span id="timelocale"><xsl:value-of select="Date"/></span>
					</TD>
				</tr>
			</xsl:for-each>
		</table>
	</body>
</xsl:template>

<xsl:template name="FormatNumber">
<xsl:param name="Number"/>
	<xsl:choose>
	<xsl:when test="$Number = 0">
	<xsl:value-of select="$Number"/>
	</xsl:when>
	<xsl:when test="not($Number)">
	<xsl:value-of select="'0'"/>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="format-number($Number, '###,###,###')"/>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<!-- Change Parameter Mapping page -->
<xsl:template match="/AtlasReport/ParameterMappings">
<html>
<head>
</head>
<link rel="stylesheet" type="text/css" href="/iviewbox/atlas-iview.css"></link>
<body>
	
	<div class="titlebardiv">Default Channel Name Map</div>
	
	<div class="wrapper">

	<FORM METHOD="get" ACTION="{//AtlasReport/TestCell}SaveConfigMap" ID="setDACParameterMap" name="ParameterMap">
		<DIV style="Z-INDEX: 101; LEFT: 10px; WIDTH: 677px; BACKGROUND-REPEAT: no-repeat; POSITION: absolute; TOP: 10px; HEIGHT: 566px;" ms_positioning="GridLayout">

		<table style="font-size:12px;">
		<xsl:apply-templates/>
		<tr>
			<td></td>
			<td><br></br><input type="submit" name="button1" value="Save" id="Submit1" class="styled-button"/></td>
		</tr>
		</table>
		</DIV>
	</FORM>
	
	</div>

</body>
</html>
</xsl:template>

<!-- Display the A&D Parameter name and the user defined Parameter name in an text edit field -->
<xsl:template match="/AtlasReport/ParameterMappings/ParameterMap">
<tr>
	<td><xsl:value-of select="eLabName"/></td>
	<td>(<xsl:value-of select="Description"/>)</td>
	<td><input type="text" name="{eLabName}" value="{UserName}" size="20" maxlength="256"/></td>
</tr>
</xsl:template>


<xsl:template match="/AtlasReport/TestCell">
</xsl:template>

<!-- 
	ListChannelReports
	Create the page to display all of the user defined reports that hold channels and their values.
-->
<xsl:template match="/AtlasReport/ListChannelReports">
<link rel="stylesheet" type="text/css" href="/iviewbox/atlas-iview.css"></link>
<script language="JavaScript" src="../iviewbox/customView.js"></script>
<body>
	<INPUT id="txtTestCell" type="text" name="txtTestCell" value="{//AtlasReport/TestCell}" style="display:none;"/>
	
	<div class="titlebardiv">Custom Views</div>

	<TABLE id="Table1" class="layout styled">
		<!-- insert the table field names ... -->
		<TR class="THheadLink">
			<td><!-- Radio Button --></td>
			<td><div>Name</div></td>
			<td><div>Description</div></td>
		</TR>
		<!-- Add the test request values -->
		<xsl:for-each select="REPORT">
			<xsl:sort select="NAME"/>
			<TR>
				<xsl:if test ="position() mod 2 = 0"><xsl:attribute name="class">TDFirst</xsl:attribute></xsl:if>
				<xsl:if test ="position() mod 2 = 1"><xsl:attribute name="class">TDSecond</xsl:attribute></xsl:if>
				<!-- add a radio box column to allow the user to select a TR to view or edit -->
				<TD width="20px">
					<INPUT style="Z-INDEX: 101; LEFT: 4px;" type="radio" value="{ID}" name="SelectTR">
						<xsl:attribute name="onclick">setViewName('<xsl:value-of select="NAME" />')</xsl:attribute>
					</INPUT>
				</TD>
				<td align="left" width="25%" valign="bottom" height="18">
					<xsl:value-of select="NAME"/>
				</td>
				<td align="left" valign="bottom" height="18">
					<xsl:value-of select="DESCRIPTION"/>
				</td>
			</TR>
		</xsl:for-each>
		<TR>
		</TR>
	</TABLE>
	
	<TABLE border="0">
		<TR>
			<TD>
				<FORM method="get" id="frmNew" name="frmNew" >
					<INPUT id="btnNewReport" type="button" value="New" name="btnNewReport" onclick="newReport()" style="width:80px" class="styled-button"/>
				</FORM>
			</TD>
			<TD>
				<FORM method="get" id="frmEdit" name="frmEdit" >
					<INPUT id="btnEditTR" type="button" value="Edit" name="btnEditTR" onClick="edit()" style="width:80px" class="styled-button"/>
				</FORM>
			</TD>
			<TD>
				<FORM method="get" id="frmView" name="frmView">
					<INPUT id="btnViewTR" type="button" value="View" name="btnViewTR" onClick="viewReport()" style="width:80px" class="styled-button"/>
				</FORM>
			</TD>
			<TD>
				<FORM method="get" id="frmDelete" name="frmDelete">
					<INPUT id="btnDelTR" type="button" value="Delete" name="btnDelTR" onClick="deleteReport()" style="width:80px" class="styled-button"/>
				</FORM>
			</TD>
		</TR>
		<TR></TR>
	</TABLE>
	
</body>
</xsl:template>


<xsl:template match="/AtlasReport/NewChannelReport"><head>
<!--<object id="WBControl" width="0" height="0" CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></object>-->
<OBJECT ID="WebBrowser1" CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" style="display:none;"></OBJECT>
    <script language="JavaScript" src="../iviewbox/icentrallib.js"></script>
	<script language="JavaScript" src="../iviewbox/dacNewReport.js"></script>
	
</head>	

<link rel="stylesheet" type="text/css" href="/iviewbox/atlas-iview.css"></link>
	<!--<body ms_positioning="GridLayout">-->
	<body onload="getRDBChannels();">
		
		<div class="titlebardiv">Create New Report</div>
		
		<div class="wrapper">

		<FORM METHOD="post" ACTION="{//AtlasReport/TestCell}QUERY_NEW_CH_REPORT_SUBMIT?" ID="EditChans">
			<SELECT id="AvailableChannels" style="Z-INDEX: 101; LEFT: 39px; WIDTH: 249px; POSITION: absolute; TOP: 200px; HEIGHT: 313px" size="19" name="AvailableChannels" multiple="true">
			
			<!--
				<xsl:for-each select="AVAILABLE/CHANNEL">
					<xsl:sort select="NAME"/>
					<OPTION value="{NAME}"><xsl:value-of select="NAME"/></OPTION>
				</xsl:for-each>
			-->
			
			</SELECT>
			<INPUT id="btnRemoveChannel" style="Z-INDEX: 105; LEFT: 311px; WIDTH: 123px; POSITION: absolute; TOP: 300px; HEIGHT: 34px"
				type="button" value="Remove" name="btnRemoveChannel" onclick="btnMove('ChanTextList', 'AvailableChannels', 'false')" />
			<SELECT id="ChanTextList" multiple="true" style="Z-INDEX: 103; LEFT: 454px; WIDTH: 249px; POSITION: absolute; TOP: 200px; HEIGHT: 313px" size="19" name="ChanTextList">
			</SELECT>
			<DIV style="DISPLAY: inline; Z-INDEX: 102; LEFT: 16px; WIDTH: 285px; FONT-FAMILY: Arial; POSITION: absolute; TOP: 170px; HEIGHT: 38px"
				ms_positioning="FlowLayout">Available Channels on the RDB:</DIV>
			<INPUT id="btnAddChannel" style="Z-INDEX: 104; LEFT: 312px; WIDTH: 123px; POSITION: absolute; TOP: 256px; HEIGHT: 34px"
				type="button" value="Add" name="btnAddChannel" onclick="btnMove('AvailableChannels', 'ChanTextList', true)" ></INPUT>
			<DIV style="DISPLAY: inline; Z-INDEX: 106; LEFT: 432px; WIDTH: 301px; FONT-FAMILY: Arial; POSITION: absolute; TOP: 170px; HEIGHT: 39px"
				ms_positioning="FlowLayout">Selected Channels:</DIV>
			<INPUT id="SubmitChannels" style="Z-INDEX: 108; LEFT: 564px; WIDTH: 139px; POSITION: absolute; TOP: 540px; HEIGHT: 34px"
				type="submit" value="Save" name="SubmitChannels" onClick="SaveReport()"></INPUT>
			<DIV style="DISPLAY: inline; Z-INDEX: 109; LEFT: 16px; WIDTH: 149px; FONT-FAMILY: Arial; POSITION: absolute; TOP: 38px; HEIGHT: 29px"
				ms_positioning="FlowLayout">Report Name:</DIV>
			<INPUT id="txtReportName" style="Z-INDEX: 110; LEFT: 193px; WIDTH: 264px; POSITION: absolute; TOP: 39px; HEIGHT: 26px"
				type="text" size="38" name="txtReportName" onBlur="reportNameValidation()"/>
			<DIV style="DISPLAY: inline; Z-INDEX: 111; LEFT: 16px; WIDTH: 144px; FONT-FAMILY: Arial; POSITION: absolute; TOP: 89px; HEIGHT: 32px"
				ms_positioning="FlowLayout">Description:</DIV>
			<INPUT id="txtDescription" style="Z-INDEX: 112; LEFT: 193px; OVERFLOW: auto; WIDTH: 504px; POSITION: absolute; TOP: 89px; HEIGHT: 60px"
				type="text" maxLength="100" size="78" name="txtDescription" value="{DESCRIPTION}"/>
		</FORM>
		<INPUT id="txtTestCell" type="text" name="txtTestCell" value="{//AtlasReport/TestCell}" style="display:none;"/>
		
		</div>
		
	</body>
	
</xsl:template>

<!-- 
	CHANNEL_REPORTS
	Create the page to display all of the user defined reports that hold channels and their values.
-->
<xsl:template match="/AtlasReport/ViewChannelReport">
<link rel="stylesheet" type="text/css" href="/iviewbox/atlas-iview.css"></link>
<body onload="refreshStatus()">
    <script language="JavaScript" src="../iviewbox/icentrallib.js"></script>
	<script language="JavaScript" src="../iviewbox/dacViewReport.js"></script>
	
	<INPUT id="txtTestCell" type="text" name="txtTestCell" value="{//AtlasReport/TestCell}" style="display:none;"/>
	
	<div class="titlebardiv">Report: <span id="ReportName"><xsl:value-of select="NAME"></xsl:value-of></span></div>
	
	<table width="100%" class="styled">
		<TR class="THheadLink">
			<td><div>Name</div></td>
			<td><div>Value</div></td>
		</TR>
    	<xsl:for-each select="CHANNELS/CHANNEL">
			<tr>
	     		<xsl:variable name="pos"		select="position()"/>
				<xsl:variable name="Channel"	select="concat('Channel', $pos)"/>
				<xsl:if test ="position() mod 2 = 0"><xsl:attribute name="class">TDFirst</xsl:attribute></xsl:if>
				<xsl:if test ="position() mod 2 = 1"><xsl:attribute name="class">TDSecond</xsl:attribute></xsl:if>
				<td align="left" width="50%" valign="bottom" height="18">
					<xsl:value-of select="NAME"/>
				</td>
				<td align="left" width="50%" valign="bottom" height="18">
					<span id="{$Channel}"></span>
				</td>
			</tr>
 	    </xsl:for-each>
	</table>
	
	<div style="float:left;min-width:500px;">
		<form method="get" action="{//AtlasReport/TestCell}ViewChannelReport {NAME}" id="ViewAlias">
		<div style="display:inline-block;margin-right:20px;font-size:12px;"><input id="Radio3" type="radio" value="Name" name="ShowUser"/> Show Names</div>
		<div style="display:inline-block;margin-right:20px;font-size:12px;"><input id="Radio2" type="radio" value="Description" name="ShowUser"/> Show Descriptions</div>
		<div style="display:inline-block;margin-right:20px;font-size:12px;"><input id="Radio1" type="radio" value="Alias" name="ShowUser"/> Show Aliases</div>
		<div style="display:inline-block;"><input id="btnViewAlias" type="submit" value="View" name="btnViewAlias" class="styled-button"></input></div>
		</form>
	</div>
	
	<!-- Add the navigation bar to scroll through the previous and next reports -->
	<div style="float:right;font-size:13px;font-weight:bold;">
		<div style="display:inline-block;margin-right:10px;"><a href="{//AtlasReport/TestCell}/ScrollChannelReport 0 {NAME}" style="color:#2D6A9F;text-decoration:none;">previous</a></div>
		<div style="display:inline-block;"><a href="{//AtlasReport/TestCell}/ScrollChannelReport 1 {NAME}" style="color:#2D6A9F;text-decoration:none;">next</a></div>
	</div>
	
	<div class="clear"></div>

</body>
</xsl:template>



<xsl:template match="/AtlasReport/DQ">
<link rel="stylesheet" type="text/css" href="/iviewbox/atlas-iview.css"></link>
	<HTML>
	<body>
		
		<div class="titlebardiv">Data Quality</div>
		
		<div style="margin:5px 0px 0px;font-size:12px;"><xsl:value-of select="DQStatus"/></div>
		
		<table width="100%" class="layout styled">
			<tr class="THheadLink">
				<td>Name</td>
				<td>Current Value</td>
				<td>DQ Low</td>
				<td>DQ High</td>
				<td>DQ Status</td>
			</tr>
			<xsl:for-each select="DQChannel">
			<tr>
				<xsl:if test="position() mod 2 = 0"><xsl:attribute name="class">TDFirst</xsl:attribute></xsl:if>
				<xsl:if test="position() mod 2 = 1"><xsl:attribute name="class">TDSecond</xsl:attribute></xsl:if>
				<td><xsl:value-of select="Name"/></td>
				<td><xsl:value-of select="CurrentValue"/></td>
				<td><xsl:value-of select="DQLow"/></td>
				<td><xsl:value-of select="DQHigh"/></td>
				<td><xsl:value-of select="DQStatus"/></td>
			</tr>
			</xsl:for-each>
		</table>
	</body>
	</HTML>
</xsl:template>


</xsl:stylesheet>
