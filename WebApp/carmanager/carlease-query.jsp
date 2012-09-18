<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">		
		<title>租赁车辆查询</title>	
		<script type="text/javascript">
			In.add('ctcss',{path:'http://${config.webliburl}/cabletech/ui/css/jquery-ct-ui-custom.css'});		
			In.add('ztreejs',{path:'http://${config.webliburl}/cabletech/ui/js/jquery.ztree.all-3.1.min.js',type:'js',charset:'utf-8',rely:['ztreecss']});
	   	    In.add('ztreecss',{path:'http://${config.webliburl}/cabletech/ui/css/zTreeStyle.css'});
	   	   	In.css('.ui-form-input {width:210px} .ui-form-input-title{width:100px}');		   	   	
	   	   	In.ready('ctcss','ztreejs', function(){	
				initOrgTree_01();				
			});
			
			function cellBackContractorid(id){
				$("#contractorid").val(id);
			}	
		</script>			
	</head>
	<body>	
	<div id="queryDiv" class="ui-form-container" style="display:none;">		
		<form id="myform2" action="${ctx }/carmanager/carLeaseAction!list.action">		
	    	<div class="ui-form-input-box">
		    	<span class="ui-form-input-title">车牌号:</span>		    	
		    	<input id="carno" name="carno" class="ui-form-input-note" maxlength="25" type="text" style="width:210px"/> 
	   	    </div>
			<div class="ui-form-input-box">
	    		<span class="ui-form-input-title">车型:</span>
	    		<baseinfo:dicselector cssClass="ui-form-input" name="cartype" columntype="CARTYPE" type="select" ></baseinfo:dicselector>				
   	   	    </div>
   	   	    <div class="ui-form-input-box">
		    	<span class="ui-form-input-title">司机:</span>
		    	<input id="mentor" name="mentor" class="ui-form-input-note" maxlength="25" type="text" style="width:210px"/> 
	   	    </div>
	   	    <div class="ui-form-input-box">
		    	<span class="ui-form-input-title">所属公司:</span>			    	
		    	<baseinfo:orgtree widgetId="01" callBackId="cellBackContractorid" cls="ui-form-input" ></baseinfo:orgtree>
	    		<input type="hidden" id="contractorid" name="contractorid">
	   	    </div>
	   	    <div class="ui-form-input-box">
	   	    	<span class="ui-form-input-title">使用部门:</span>
	   	    	
	   	    	<input type="hidden" id="deptid" name="deptid">
	   	     </div>
	   	    <div class="ui-form-input-box">
	   	    	 <span class="ui-form-input-title">车辆状态:</span>
	   	    	 <baseinfo:dicselector style="width:155px" cssClass="ui-form-input" name="carstate" columntype="CARSTATE" type="select"></baseinfo:dicselector>
	   	    </div>		   	   	
		</form>
	</div>
	</body>	
</html>