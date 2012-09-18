<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ page import="org.springframework.web.context.WebApplicationContext,com.cabletech.core.entity.config.GlobalConfigInfo"  %>	
<%@ taglib uri="http://www.cabletech.com.cn/baseinfo" prefix="baseinfo"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
 
<script type="text/javascript"
	src="http://${config.webliburl}/cabletech/ui/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx }/js/in-min.js"></script>
<script language="JavaScript" type="text/JavaScript">
	var contextPath = "${ctx}";
    var jQuery=$;
</script>
 
