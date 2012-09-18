<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ page import="org.springframework.web.context.WebApplicationContext,com.cabletech.core.entity.config.GlobalConfigInfo"  %>	
<%@ taglib uri="http://www.cabletech.com.cn/baseinfo" prefix="baseinfo"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
	if(request.getAttribute("config") == null){
		WebApplicationContext wac = (WebApplicationContext) this
				.getServletConfig().getServletContext()
				.getAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
		GlobalConfigInfo c = (GlobalConfigInfo)wac.getBean("globalConfigInfo");	
		request.setAttribute("config",c);
	}
%>
<script type="text/javascript" src="http://${config.webliburl}/cabletech/WdatePicker/WdatePicker.js"></script>
<link href="http://${config.webliburl}/cabletech/ui/css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css">
<link href="http://${config.webliburl}/cabletech/ui/css/jquery.ui.combogrid.css" rel="stylesheet" type="text/css">
<link href="http://${config.webliburl}/cabletech/ui/css/zTreeStyle.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://${config.webliburl}/cabletech/ui/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="http://${config.webliburl}/cabletech/ui/js/jquery-ui-1.8.19.custom.min.js"></script>
<script type="text/javascript" src="http://${config.webliburl}/cabletech/ui/js/jquery.ui.combogrid-1.6.2.min.js"></script>
<script type="text/javascript" src="http://${config.webliburl}/cabletech/ui/js/jquery.ztree.all-3.1.min.js"></script>
<script type="text/javascript" src="http://${config.webliburl}/cabletech/ui/js/jquery.validate.min.js"></script>

<link href="http://${config.webliburl}/cabletech/autocomplete/jquery.autocomplete.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://${config.webliburl}/cabletech/autocomplete/jquery.autocomplete.min.js"></script>


<script language="JavaScript" type="text/JavaScript">
	var contextPath = "${ctx}";
</script>
