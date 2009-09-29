<#assign pojoNameLower = pojo.shortName.substring(0,1).toLowerCase()+pojo.shortName.substring(1)>
<#assign pojoToLower = pojo.shortName.toLowerCase()>
<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="${pojoNameLower}List.title"/></title>
    <meta name="heading" content="<fmt:message key='${pojoNameLower}List.heading'/>"/>
    <meta name="menu" content="${pojo.shortName}Menu"/>
</head>

<c:set var="buttons">
	<div class="operaciones">
		<ul>
			<li><a href="<c:url value="/${pojoToLower}form.html"/>"><fmt:message key="button.add"/></a></li
			><li><a href="<c:url value="/mainMenu.html"/>"/><fmt:message key="button.done"/></a></li>			
		</ul>
    </div>
</c:set>

<c:out value="${'$'}{buttons}" escapeXml="false"/>

<display:table name="${pojoNameLower}List" class="table" requestURI="" id="${pojoNameLower}List" export="false" pagesize="25">
<#foreach field in pojo.getAllPropertiesIterator()>
<#if field.equals(pojo.identifierProperty)>
    <display:column property="${field.name}" sortable="true" href="${pojoToLower}form.html" media="html"
        paramId="${field.name}" paramProperty="${field.name}" titleKey="${pojoNameLower}.${field.name}"/>
    <display:column property="${field.name}" media="csv excel xml pdf" titleKey="${pojoNameLower}.${field.name}"/>
<#elseif !c2h.isCollection(field) && !c2h.isManyToOne(field) && !c2j.isComponent(field)>
    <#if field.value.typeName == "date" || field.value.typeName == "java.util.Date">
        <#lt/>    <display:column sortProperty="${field.name}" sortable="true" titleKey="${pojoNameLower}.${field.name}">
        <#lt/>         <fmt:formatDate value="${'$'}{${pojoNameLower}List.${field.name}}" pattern="${'$'}{datePattern}"/>
        <#lt/>    </display:column>
    <#elseif field.value.typeName == "boolean" || field.value.typeName == "java.lang.Boolean">
        <#lt/>    <display:column sortProperty="${field.name}" sortable="true" titleKey="${pojoNameLower}.${field.name}">
        <#lt/>        <input type="checkbox" disabled="disabled" <c:if test="${'$'}{${pojoNameLower}List.${field.name}}">checked="checked"</c:if>/>
        <#lt/>    </display:column>
    <#else>
        <#lt/>    <display:column property="${field.name}" sortable="true" titleKey="${pojoNameLower}.${field.name}"/>
    </#if>
<#elseif c2h.isManyToOne(field)>
	<#lt/>    <display:column property="${field.name}.formLabelField" sortable="true" titleKey="${pojoNameLower}.${field.name}"/>
</#if>

</#foreach>

<%--
	<display:setProperty name="paging.banner.item_name"><fmt:message key="${pojoNameLower}List.${pojoNameLower}"/></display:setProperty>
    <display:setProperty name="paging.banner.items_name"><fmt:message key="${pojoNameLower}List.${util.getPluralForWord(pojoNameLower)}"/></display:setProperty>

    <display:setProperty name="export.excel.filename"><fmt:message key="${pojoNameLower}List.title"/>.xls</display:setProperty>
    <display:setProperty name="export.csv.filename"><fmt:message key="${pojoNameLower}List.title"/>.csv</display:setProperty>
    <display:setProperty name="export.pdf.filename"><fmt:message key="${pojoNameLower}List.title"/>.pdf</display:setProperty> 
--%>
</display:table>

<c:out value="${'$'}{buttons}" escapeXml="false"/>

<script type="text/javascript">
    highlightTableRows("${pojoNameLower}List");
</script> 