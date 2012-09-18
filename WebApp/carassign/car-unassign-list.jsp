<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>车辆列表</title>
		<script type="text/javascript">
		In.add('ct-ui',{path:'http://${config.webliburl}/cabletech/ui/css/jquery-ct-ui-custom.css'});
		In.add('lhgdialog',{path:'http://${config.webliburl}/cabletech/ui/lhgdialog/lhgdialog.min.js',type:'js',charset:'utf-8'});
		In.add('button',{path : 'http://${config.webliburl}/cabletech/ui/js/jquery.ct.ui.linkbutton.js',type : 'js',charset : 'utf-8'});
		In.add('unassign-list',{path:'${ctx}/carassign/car-unassign-list.js',type:'js',charset:'utf-8',rely:['lhgdialog']});
		In.add('ztreejs',{path:'http://${config.webliburl}/cabletech/ui/js/jquery.ztree.all-3.1.min.js',type:'js',charset:'utf-8',rely:['ztreecss']});
   	    In.add('ztreecss',{path:'http://${config.webliburl}/cabletech/ui/css/zTreeStyle.css'});
		In.css('.ui-form-input {width:200px}');		
		In.ready('ct-ui','button','ztreejs','unassign-list',function(){
			initDeptTree_assign_dept();//初始化部门选择树
			initOrgTree_query_org();//初始化组织选择树
			tipMessage('${assignCarsMessage}');
		});
		</script>
	</head>
	<body>
	<div class="ui-title-banner-bg">
    	<div class="ui-title-banner-text">车辆分配- 未分配列表</div>
    </div>

    	    <form id="queryForm" action="${ctx}/carassign/carUnAssignAction!unAssignCars.action">
			<table cellspacing="0" cellpadding="0" border="0" class="search_table" style="width: 100%;">
				<tr>
					<td>
					    <div class="ui-form-input-box">
					        <baseinfo:depttree cls="ui-form-input" widgetId="assign_dept" orgId="${USER.orgId}" callBackObj="assignDeptTreeCallBack"  callBackClean="assignDeptTreeClean" strict="false"></baseinfo:depttree>
    						<a href="javascript:assign('${USER.orgId}');" class="l-btn" icon="ui-icon-search">分配</a>
    					</div>
					</td>
					<td></td>	
					<td></td>
				</tr>
				<tr>
					<td>
					  <div class="ui-form-input-box">
					    <span class="ui-form-input-title">车牌号：</span>
						<input name="carNo" class="ui-form-input" type="text" value="${condition['carNo'] }">
						</div>
					</td>
					<td>
					   <div class="ui-form-input-box">
					    <span class="ui-form-input-title">车型：</span>
						<baseinfo:dicselector name="carType" cssClass="ui-form-input" columntype="CARTYPE" type="select" isQuery="query" keyValue="${condition['carType'] }"></baseinfo:dicselector>
					   </div>
					</td>	
					<td>
					  <div class="ui-form-input-box">
					    <span class="ui-form-input-title">司机：</span>
						<input name="mentor" class="ui-form-input" type="text" value="${condition['mentor'] }">
					  </div>
					</td>		
				</tr>
				<tr>
					<td>
					  <div class="ui-form-input-box">
					    <span class="ui-form-input-title">所属公司：</span>
						<baseinfo:orgtree widgetId="query_org" cls="ui-form-input" callBackId="queryOrgTreeCallBack" callBackClean="queryOrgTreeClean" defaultValue="${condition['contractorId'] }" regionId="${USER.regionId }" orgType="2"></baseinfo:orgtree>
						<input name="contractorId" id="query_org_id" type="hidden" value="${condition['contractorId'] }" />
					  </div>
					</td>	
					<td></td>	
					<td>
					    <div class="ui-form-input-box">
    						<a href="javascript:simplSearch();" class="l-btn" icon="ui-icon-search">查询</a>
    					</div>
					</td>
							
				</tr>
				
			</table>
			</form>

		<div id="tableContainner" class="ui-table-list">	
		    <form id="assignForm" action="${ctx }/carassign/carUnAssignAction!assignCars.action">
		    <input name="assign_org_id" id="assign_org_id" type="hidden">
    		<input name="assign_dept_id" id="assign_dept_id" type="hidden" >
			<table width="100%"  border="0" cellpadding="0" cellspacing="0" >
			<tr >	
			    <th>
			    	<input id="checkbox_car_all" type="checkbox" onclick="checkboxAll(this);">
			    </th>
			    <th>车牌号</th>					
				<th>车型</th>				
				<th>司机</th>
				<th>司机电话</th>
				<th>车载SIM卡</th>
				<th>标准油耗</th>
				<th>所属公司</th>
			</tr>
				<c:forEach items="${map['rows']}" var="item">
					<tr class="tr_hover">
					    <td><input name="checkbox_car_id" type="checkbox" value="${item.ID }" onclick="unCheckboxAll();"></td>
						<td>${item.CARNO }</td>
						<td>
						<baseinfo:dic displayProperty="LABLE" codevalue="${item.CARTYPE }" columntype="CARTYPE"></baseinfo:dic>
						</td>
						<td>${item.MENTOR }</td>
						<td>${item.PHONE }</td>	
						<td>${item.SIMID }</td>	
						<td>${item.OILWEAR }</td>	
						<td><baseinfo:org displayProperty="ORGANIZENAME" id="${item.CONTRACTORID }"></baseinfo:org> </td>			
					</tr>
				</c:forEach>
		</table>	
		</form>
		<div class="pagination_box">
		  <baseinfo:pagenation records="${map['total']}" url="${ctx }/carassign/carUnAssignAction!unAssignCars.action?${condition['qStr'] }"></baseinfo:pagenation>
		</div>	
		</div>
	</body>
</html>