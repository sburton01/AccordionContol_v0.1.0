<cfsetting enablecfoutputonly="true">

<cfif not thisTag.hasEndTag>
	<cfthrow message="accordion.cfm must contain an end tag">
</cfif>

<cfparam name="attributes.id" type="variableName">
<cfparam name="attributes.scriptSrc" type="string" default="js/SpryAccordion.js">

<cfif not fileExists(expandPath(attributes.scriptSrc))>
	<cfthrow message="scriptSrc file does not exist">
</cfif>

<cfif thisTag.executionMode is "end">

	<!--- If no pages, do nothing. --->
	<cfif not structKeyExists(thisTag, "pages") or not arrayLen(thisTag.pages)>
		<cfexit method="exitTag">
	</cfif>
	<cfif not structKeyExists(request, "cfspry")>
		<cfset request.cfspry = structNew()>
	</cfif>
	
	<cfif not structKeyExists(request.cfspry, "accordionloaded")>
		<cfhtmlhead text="<script src=""#attributes.scriptSrc#""></script>">
		<cfset request.cfspry.accordionloaded = 1>
	</cfif>

	<cfoutput>
<style>
.#attributes.id#_Accordion {
	border-left: solid 1px gray;
	border-right: solid 1px black;
	border-bottom: solid 1px gray;
	overflow: hidden;
	<cfif structKeyExists(attributes, "width")>
	width: #attributes.width#;
	</cfif>
}	

.#attributes.id#_AccordionPanel {
	margin: 0px;
	padding: 0px;
}

.#attributes.id#_AccordionPanelTab {
	background-color: ##CCCCCC;
	border-top: solid 1px black;
	border-bottom: solid 1px gray;
	margin: 0px;
	padding: 2px;
	cursor: pointer;
	-moz-user-select: none;
	-khtml-user-select: none;
}

.#attributes.id#_AccordionPanelContent {
	overflow: auto;
	margin: 0px;
	padding: 0px;
	<cfif structKeyExists(attributes, "panelheight")>
	height: #attributes.height#;
	<cfelse>
	height: 200px;	
	</cfif>	
}

.#attributes.id#_AccordionPanelOpen .#attributes.id#_AccordionPanelTab {
	background-color: ##EEEEEE;
}

.#attributes.id#_AccordionPanelTabHover {
	color: ##555555;
}
.#attributes.id#_AccordionPanelOpen .#attributes.id#_AccordionPanelTabHover {
	color: ##555555;
}

.#attributes.id#_AccordionFocused .#attributes.id#_AccordionPanelTab {
	background-color: ##3399FF;
}

.#attributes.id#_AccordionFocused .#attributes.id#_AccordionPanelOpen .#attributes.id#_AccordionPanelTab {
	background-color: ##33CCFF;
}
</style>

<div class="#attributes.id#_Accordion" id="#attributes.id#">
	</cfoutput>
	
	<cfloop index="x" from="1" to="#arrayLen(thisTag.pages)#">
		<cfoutput>
<div class="#attributes.id#_AccordionPanel">
<div class="#attributes.id#_AccordionPanelTab">#thisTag.pages[x].title#</div>
<div class="#attributes.id#_AccordionPanelContent">#thisTag.pages[x].content#</div>
</div>
		</cfoutput>
	</cfloop>
	
	<cfoutput>
</div>
<script language="JavaScript" type="text/javascript">
var #attributes.id# = new Spry.Widget.Accordion("#attributes.id#");
</script>
	</cfoutput>

</cfif>

<cfsetting enablecfoutputonly="false">
