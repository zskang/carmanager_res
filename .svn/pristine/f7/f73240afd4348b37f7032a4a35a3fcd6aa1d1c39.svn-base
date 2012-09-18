<%@ page language="java"
	import="com.cabletech.baseinfo.business.entity.UserInfo"
	pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>车辆列表</title>
<script type="text/javascript">
	//In.css('.ui-form-input {width:200px}');
	In
	.add(
			'ct-ui',
			{
				path : 'http://${config.webliburl}/cabletech/ui/css/jquery-ct-ui-custom.css'
			});
	In
			.add(
					'csss',
					{
						path : '${ctx}/css/css.css'
					});
	In
			.add(
					'lhgdialog',
					{
						path : 'http://${config.webliburl}/cabletech/ui/lhgdialog/lhgdialog.min.js',
						type : 'js',
						charset : 'utf-8'
					});
	In
			.add(
					'button-js',
					{
						path : 'http://${config.webliburl}/cabletech/ui/js/jquery.ct.ui.linkbutton.js',
						type : 'js',
						charset : 'utf-8'
					});
	In.add('carinfo-js', {
		path : '${ctx}/carmanager/carinfo-list.js',
		type : 'js',
		charset : 'utf-8',
		rely : [ 'lhgdialog' ]
	});
	In.add('cabletech', {
		path : 'http://${config.webliburl}/cabletech/common/cabletech.js',
		type : 'js',
		charset : 'utf-8'
	});
	In
			.add(
					'ztreejs',
					{
						path : 'http://${config.webliburl}/cabletech/ui/js/jquery.ztree.all-3.1.min.js',
						type : 'js',
						charset : 'utf-8',
						rely : [ 'ztreecss' ]
					});
	In.add('ztreecss', {
		path : 'http://${config.webliburl}/cabletech/ui/css/zTreeStyle.css'
	});
	
	In.ready('ct-ui', 'button-js', 'carinfo-js', 'ztreejs', 'cabletech','csss',
			function() {
				initOrgTree_01();
				initRegionTree_03();
				tipMessage('${carDeal}');
			});
			
	function submitForm() {
		var queryString = $("#myform1").serialize();
		//alert(queryString);				  
	  	$("#myform1").attr('action',$("#myform1").attr('action') + "?" + queryString);
		$("#myform1").submit();
	}
	
	function cellBackRegionId(id){
		$("#regionId").val(id);
	}

	
</script>
</head>
<body>
	<div class="ui-title-banner-bg" style="height: 5%;">
		<div id="title" class="ui-title-banner-text">当前位置-车辆列表</div>
	</div>
	<form id="myform1" action="${ctx }/carinfo/carinfoAction!list.action"
		method="post" class="ui-form-container">
	<div class="ui-div-list-search" style="width: 98.5%;">
    		<ul class="searchul">
    			<li class="searchli">
					<font>车牌号:</font>
					<input id="carno" name="carno"  value="${conditionMap['carno'] }" maxlength="25" type="text" />
				</li>
				<li class="searchli">
					<font>车载SIM卡:	</font>
					<input id="simid" name="simid" value="${conditionMap['simid'] }" type="text" />
				</li>
				<li class="searchli">
					<font>区域:</font>
					<baseinfo:regiontree widgetId="03" regionId="${USER.regionId}" callBackId="cellBackRegionId" defaultValue="${conditionMap['regionId'] }"></baseinfo:regiontree>
					<input type="hidden" id="regionId" name="regionId" value="${conditionMap['regionId'] }">					
				</li>
			</ul>
			<ul class="searchul">
			<li class="searchli">
					<font>车型:</font>
					<baseinfo:dicselector isQuery="query" style="width:135px;"	name="cartype" columntype="CARTYPE" type="select"
							keyValue="${conditionMap['cartype'] }"></baseinfo:dicselector>
				</li>
    			
				<li class="searchli">
					<font>司机:	</font>
					<input id="mentor" name="mentor"  value="${conditionMap['mentor'] }" type="text" />
				</li>
				<li class="searchli">
					<font>所属公司:	</font>
					<baseinfo:orgtree widgetId="01" callBackId="cellBackContractorid"
							regionId="${USER.regionId }" orgType="2" 
							defaultValue="${conditionMap['contractorid'] }"></baseinfo:orgtree>
						<input type="hidden" id="contractorid" name="contractorid"
							value="${conditionMap['contractorid'] }">
				</li>
				
			</ul>	
			<ul class="searchul">
				<li class="searchli">
					<font>车辆状态:	</font>
					<baseinfo:dicselector  name="carstate" style="width:135px;"
							isQuery="query" columntype="CARSTATE" type="select"
							keyValue="${map['carstate'] }" ></baseinfo:dicselector>
				</li>
    			<li class="searchli" style="float:right">
					<a href="javascript:submitForm();" class="l-btn"
							icon="ui-icon-search">查询</a>
					<baseinfo:privilege userid="${USER.userId}" operation="add">
							<a href="javascript:toGoSave();" class="l-btn" icon="ui-icon-add">添加</a>
					</baseinfo:privilege>
					<baseinfo:expexcel cls="l-btn" businessId="carinfos"
							name="导出excel"></baseinfo:expexcel>
				</li>
			</ul>
   		</div>	
	</form>
	<div id="tableContainner" class="ui-table-list">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<th>车牌号</th>
				<th>车型</th>
				<th>司机</th>
				<th>司机电话</th>
				<th>车载SIM卡</th>
				<th>标准油耗</th>
				<th>所属公司</th>
				<th>操作</th>
			</tr>
			<c:forEach items="${map['rows']}" var="item">
				<tr class="tr_hover">
					<td>${item.CARNO }</td>
					<td><baseinfo:dic displayProperty="LABLE"
							codevalue="${item.CARTYPE }" columntype="CARTYPE"></baseinfo:dic>
					</td>
					<td>${item.MENTOR }</td>
					<td>${item.PHONE }</td>
					<td>${item.SIMID }</td>
					<td>${item.OILWEAR }</td>
					<td><baseinfo:org displayProperty="ORGANIZENAME"
							id="${item.CONTRACTORID }"></baseinfo:org></td>
					<td><baseinfo:privilege userid="${USER.userId}"
							operation="edit">
							<span><a
								href="${ctx }/carinfo/carinfoAction!toSave.action?id=${item.ID }"><img
									src="http://${config.webliburl}/cabletech/ui/css/images/table_img/pencil.png"
									width="16" alt="修改" height="16"> </a> </span>
						</baseinfo:privilege> <baseinfo:privilege userid="${USER.userId}" operation="view">
							<span><a
								href="${ctx }/carinfo/carinfoAction!view.action?carId=${item.ID }"><img
									src="http://${config.webliburl}/cabletech/ui/css/images/table_img/zoom.png"
									alt="查看" width="16" height="16"> </a> </span>
						</baseinfo:privilege> <c:if
							test="${(item.USERORGID==null || item.USERORGID=='')&&(item.USERDEPARTID==null ||item.USERDEPARTID=='' )}">
							<baseinfo:privilege userid="${USER.userId}" operation="del">
								<span><a
									href="${ctx }/carinfo/carinfoAction!delete.action?id=${item.ID }"
									onclick="return confirm('是否确认删除此条车辆信息？');"><img
										src="http://${config.webliburl}/cabletech/ui/css/images/table_img/cross.png"
										alt="删除" width="16" height="16"> </a> </span>
							</baseinfo:privilege>
						</c:if></td>
				</tr>
			</c:forEach>
		</table>
		<div class="pagination_box">
			<baseinfo:pagenation records="${map['total']}"
				url="${ctx }/carinfo/carinfoAction!list.action?${condition}"></baseinfo:pagenation>
		</div>
	</div>
</body>
</div>
</html>