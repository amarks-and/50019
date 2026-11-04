# TASK: Convert iViewBox iviewbox\cellstatusformat.xsl to html files with embedded css and javascript

## Objective
iViewBox currently uses an .xsl file named `iviewbox\cellstatusformat.xsl` to format cell status information. The goal is to convert this XSL file into standalone HTML files that include embedded CSS and JavaScript, allowing for easier deployment and usage without relying on external stylesheets or scripts.

## Context & Environment
_ **Target Files/Directories: *** `..\iViewBox\InstallFiles\iview\www`

## Step-by-Step Instructions
1. **Locate the XSL File**: Navigate to the directory where `cellstatusformat.xsl` is located. This file contains the XSLT transformations that define how the XML data is presented.
2. **Analyze the XSL Structure**: Open `cellstatusformat.xsl` in a text editor or an IDE that supports XML/XSLT. Review the templates, match patterns, and any included CSS or JavaScript references.
3. **Extract CSS and JavaScript**: Identify any `<style>` or `<script>` tags within the XSL file. If the XSL references external HTML, CSS, or JS files, include those in the newly created HTML files. Also be sure that created HTML files use same classes for HTML elements that are in the xsl.
4. **Create HTML file for the `AtlasReport/StatusChansList` and `AtlasReport/Status` templates**
	- Create a new HTML file named `Status.html` in the target www directory
	- Copy the relevant XSLT template content for the `AtlasReport/StatusChansList` and `AtlasReport/Status` into the body of the HTML file, adding javascript code that performs the same functionality as the XSLT transformations.
	- Query the server asynchronously to obtain the data items using the query `/Status`
5. **Create HTML file for the `AtlasReport/Health/Items` and `AtlasReport/TaskInfo` templates**
	- Create a new HTML file named `Health.html` in the target www directory
	- Copy the relevant XSLT template content for the `AtlasReport/Health/Items` and `AtlasReport/TaskInfo` into the body of the HTML file, adding javascript code that performs the same functionality as the XSLT transformations.
	- Query the server asynchronously to obtain the data items using the query `/Health`
6. **Create HTML file for the `AtlasReport\DirListing` template**
	- Create a new HTML file named `files.html` in the target www directory
	- Copy the relevant XSLT template content for the `AtlasReport\DirListing` into the body of the HTML file, adding javascript code that performs the same functionality as the XSLT transformations.
	- `files.html` should accept a query parameter `path` to specify the query for obtaining file data. The JavaScript code should read this parameter, query the server asynchronously, and display the results in a table format.
	- replace the `FormatNumber` template with a javascript function that formats numbers in the same way as the XSLT template and use that instead of the XSLT template as needed.
	- Any links generated for folders should point to `files.html` with the appropriate `path` query parameter to allow navigation through the directory structure.
7. **Create HTML file for the `AtlasReport/NavigationTree/tree` template**
	- Create a new HTML file named `NavTree.html` in the target www directory
	- Copy the relevant XSLT template content for the `AtlasReport/NavigationTree/tree` into the body of the HTML file, adding javascript code that performs the same functionality as the XSLT transformations.
	- Replace the `/Status` with a reference to the `Status.html`
	- Replace the `/Health` with a reference to the `Health.html`
	- Leave the `/SCREENCAP` reference as is.
	- Leave any .html file references as is.
	- Replace the `/SolutionDir`,`/DataFiles`,`/LogFiles`, and `/SystemDir` references with a reference to the `files.html` and pass the appropriate query parameter for each directory.
8. **Create HTML file for the `AtlasReport/Default` template**
	- Create a new HTML file named `Default.html` in the target www directory
	- Copy the relevant XSLT template content for the `AtlasReport/Default` into the body of the HTML file, adding javascript code that performs the same functionality as the XSLT transformations.
	- Replace any references to `/Status/` and `/NavigationTree` with references to their respective HTML files created in previous steps.
	- Ensure that all navigation links point to the correct HTML files instead of XSL templates.

## Constraints & Guardrails (Negative Prompting)
- **DO NOT** refactor any existing .html, .css, or .js files. Only create new .html files for the templates specified in the instructions
- **DO NOT** install any new libraries or frameworks. Use vanilla JavaScript and CSS for the embedded code.

## Expected Output Artifacts
- **Code:** : New HTML files with embedded CSS and JavaScript for each of the specified templates, located in the www folder.
- **Documentation:** Inline comments explaining complex logic added during the run.