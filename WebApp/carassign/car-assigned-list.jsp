<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>已分配车辆</title>
		<script type="text/javascript">
	var contextPath = "${ctx}";
	In.css('.ui-form-input {width:200px}');
	In
			.add(
					'ct-ui',
					{
						path : 'http://${config.webliburl}/cabletech/ui/css/jquery-ct-ui-custom.css'
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
	In
			.add(
					'ztree-js',
					{
						path : 'http://${config.webliburl}/cabletech/ui/js/jquery.ztree.all-3.1.min.js',
						type : 'js',
						charset : 'utf-8'
					});
	In.add('ztree-css', {
		path : 'http://${config.webliburl}/cabletech/ui/css/zTreeStyle.css'
	});
	In.add('assigned-list', {
		path : '${ctx}/carassign/car-assigned-list.js',
		type : 'js',
		charset : 'utf-8',
		rely : [ 'lhgdialog' ]
	});
	In.ready('ct-ui', 'button-js', 'ztree-js', 'ztree-css', 'lhgdialog',
			'assigned-list', function() {
				initOrgTree_01();
				initDeptTree_02();
				tipMessage('${unAssignCarsMessage}');
			});
</script>
	</head>
	<body>
		<div class="ui-title-banner-bg">
			<div class="ui-title-banner-text">
				首页 - 车辆分配 - 已分配车辆
			</div>
		</div>
			<form id="carAssignForm" method="post"
				action="${ctx }/carassign/carAssignedAction!list.action">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td colspan="6">
						<div class="ui-form-input-box">
					
							<baseinfo:privilege userid="${USER.userId}" operation="back">
							<a href="javascript:unAssign();" class="l-btn"	icon="ui-icon-text">批量回收</a>
							</baseinfo:privilege>	
						</div>
					</td>
				</tr>
					<tr>
						<td>
							<div class="ui-form-input-box">
								<span class="ui-form-input-title">车牌号：</span>
							</div>
						</td>
						<td>
							<div class="ui-form-input-box">
								<input id="carNo" name="carNo" value="${condition['carNo'] }"
									class="ui-form-input" type="text">
							</div>
						</td>
						<td>
							<div class="ui-form-input-box">
								<span class="ui-form-input-title">司机：</span>
							</div>
						</td>
						<td>
							<div class="ui-form-input-box">
								<input id="mentor" name="mentor" value="${condition['mentor'] }"
									class="ui-form-input" type="text">
							</div>
						</td>
						<td>
							<div class="ui-form-input-box">
								<span class="ui-form-input-title">车型：</span>
							</div>
						</td>
						<td>
							<div class="ui-form-input-box">
								<baseinfo:dicselector name="carType" columntype="CARTYPE"
									type="select" isQuery="query" cssClass="ui-form-input"
									keyValue="${condition['carType'] }"></baseinfo:dicselector>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="ui-form-input-box">
								<span class="ui-form-input-title">使用部门：</span>
							</div>
						</td>
						<td>
							<div class="ui-form-input-box">
								<input id="departId" name="departId"
									value="${condition['departId'] }" type="hidden">
								<baseinfo:depttree widgetId="02" callBackId="setDepartId"
									cls="ui-form-input" defaultValue="${condition['departId'] }"
									orgId="${USER.orgId }"></baseinfo:depttree>
							</div>
						</td>
						<td>
							<div class="ui-form-input-box">
								<span class="ui-form-input-title">所属公司：</span>
							</div>
						</td>
						<td>
							<div class="ui-form-input-box">
								<input id="orgId" name="orgId" value="${condition['orgId'] }"
									type="hidden">
								<baseinfo:orgtree widgetId="01" callBackId="setOrgId"
									cls="ui-form-input" defaultValue="${condition['orgId'] }"
									regionId="${USER.regionId }" orgType="2"></baseinfo:orgtree>
							</div>
						</td>
						<td>
						</td>
						<td>
							<div class="ui-form-but" style="text-align: center;">
								
								<a href="javascript:submitForm();" class="l-btn"
									icon="ui-icon-search">查询</a>
							</div>
						</td>
					</tr>					
				</table>
			</form>
		<div class="ui-table-list">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<th>
						<input id="checkAll" name="checkAll" value="1" type="checkbox"
							onclick="changeCarIdChecked();">
					</th>
					<th>
						车牌号
					</th>
					<th>
						车型
					</th>
					<th>
						司机
					</th>
					<th>
						司机电话
					</th>
					<th>
						车载SIM卡
					</th>
					<th>
						标准油耗
					</th>
					<th>
						使用部门
					</th>
					<th>
						所属公司
					</th>
					<th>
						操作
					</th>
				</tr>
				<c:forEach items="${map['rows']}" var="item">
					<tr>
						<td>
							<input id="carId_${item.ID }" name="carId" value="${item.ID }"
								type="checkbox">
						</td>
						<td>
							<a href="javascript:viewCarInfo('${item.ID }');" alt="查看">
								${item.CARNO }</a>
						</td>
						<td>
							<baseinfo:dicselector name="" columntype="CARTYPE" type="view"
								keyValue="${item.CARTYPE }"></baseinfo:dicselector>
						</td>
						<td>
							${item.MENTOR }
						</td>
						<td>
							${item.PHONE }
						</td>
						<td>
							${item.SIMID }
						</td>
						<td>
							${item.OILWEAR }
						</td>
						<td>
							<baseinfo:dept id="${item.USERDEPTID }"
								displayProperty="deptname"></baseinfo:dept>
						</td>
						<td>
							<baseinfo:org id="${item.CONTRACTORID }"
								displayProperty="organizename"></baseinfo:org>
						</td>
						<td>
							<baseinfo:privilege userid="${USER.userId}" operation="back">
							<a href="javascript:unAssign('${item.ID }');"><img
									src="${ctx }/css/image/hsz.gif" alt="回收" /> </a>
							</baseinfo:privilege>			
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="pagination_box">
			<c:if test="${map['total'] > 0}">
				<baseinfo:pagenation records="${map['total']}"
					url="${ctx }/carassign/carAssignedAction!list.action?${condition['querystring'] }"></baseinfo:pagenation>
			</c:if>
		</div>
	</body>
</html>