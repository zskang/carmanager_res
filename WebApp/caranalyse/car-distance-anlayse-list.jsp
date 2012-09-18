<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>车辆行程统计</title>
		<script type="text/javascript">
		var analyseType = "${condition['analyseType']}";
		var ifWorkDay = "${condition['ifWorkDay']}";
	In
			.add(
					'ct-ui',
					{
						path : 'http://${config.webliburl}/cabletech/ui/css/jquery-ct-ui-custom.css'
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
	In
			.add(
					'validate-js',
					{
						path : 'http://${config.webliburl}/cabletech/ui/js/jquery.validate.min.js',
						type : 'js',
						charset : 'utf-8'
					});
	In.add('message-js', {
		path : 'http://${config.webliburl}/cabletech/ui/js/messages_cn.js',
		type : 'js',
		charset : 'utf-8'
	});
	In
			.add(
					'wdatepicker-js',
					{
						path : 'http://${config.webliburl}/cabletech/ui/wdatepicker/WdatePicker.js',
						type : 'js',
						charset : 'utf-8'
					});
	In.add('analyse-list', {
		path : '${ctx}/caranalyse/car-distance-anlayse-list.js',
		type : 'js',
		charset : 'utf-8'
	});
	In.ready('ct-ui', 'button-js', 'ztree-js', 'ztree-css', 'validate-js',
			'message-js', 'wdatepicker-js','analyse-list', function() {
				initPage();
			});
</script>
	</head>
	<body>
		<div class="ui-title-banner-bg">
			<div class="ui-title-banner-text">
				首页 - 统计分析 - 车辆行程统计
			</div>
		</div>
			<form id="carAnalyseForm" method="post"
				action="${ctx }/caranalyse/carDistanceAnalyseAction!list.action">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<div class="ui-form-input-box">
								<span class="ui-form-input-title" style="width: 100px;">统计类型：</span>
							</div>
						</td>
						<td colspan="5">
							<div class="ui-form-input-box">
								<label>
									<input id="analyseType_car" name="analyseType" value="car"
										type="radio" onclick="changeFormInput('car');" checked />
									按单个车辆统计
								</label>
								<label>
									<input id="analyseType_depart" name="analyseType"
										value="depart" type="radio"
										onclick="changeFormInput('depart');" />
									按使用部门统计
								</label>
								<label>
									<input id="analyseType_org" name="analyseType" value="org"
										type="radio" onclick="changeFormInput('org');" />
									按所属公司统计
								</label>
							</div>
						</td>
						
					</tr>
					<tr>
						<td width="10%">
							<div class="ui-form-input-box" >
								<span class="ui-form-input-title" style="width: 100px;">行驶时间段从：</span>
							</div>
						</td>
						<td width="20%">
							<input id="beginDate" name="beginDate"
								class="ui-form-input required" type="text" style="width: 180px;"
								readonly value="${condition['beginDate'] }"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endDate\')}'})">
							<span class="ui-form-symbol-color">*</span>
						</td>
						<td width="10%">
							<div class="ui-form-input-box">
								<span class="ui-form-input-title" style="width: 100px;">到：</span>
							</div>
						</td>
						<td  width="20%">
							<input id="endDate" name="endDate" class="ui-form-input required"
								type="text" style="width: 180px;" readonly
								value="${condition['endDate'] }"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'beginDate\')}'})">
							<span class="ui-form-symbol-color">*</span>
						</td>
						<td width="10%">
							<div class="ui-form-input-box">
								<span class="ui-form-input-title" style="width: 100px;">是否为工作日：</span>
							</div>
						</td>
						<td width="30%">
							<div class="ui-form-input-box">
								<label>
									<input id="ifWorkDay" name="ifWorkDay" value="true"
										type="checkbox" />
								</label>
							</div>
						</td>
					</tr>
					<tbody id="carTb">
						<tr>
							<td>
								<div class="ui-form-input-box">
									<span class="ui-form-input-title" style="width: 100px;">车牌号：</span>
								</div>
							</td>
							<td>
								<input id="carNo" name="carNo" class="ui-form-input" type="text"
									style="width: 180px;" value="${condition['carNo'] }">
							</td>
							<td>
								<div class="ui-form-input-box">
									<span class="ui-form-input-title" style="width: 100px;">车载SIM卡号：</span>
								</div>
							</td>
							<td>
								<input id="simId" name="simId" class="ui-form-input" type="text"
									style="width: 180px;" value="${condition['simId'] }">
							</td>
							<td>
								<div class="ui-form-input-box">
									<span class="ui-form-input-title" style="width: 100px;">司机：</span>
								</div>
							</td>
							<td>
								<input id="mentor" name="mentor" class="ui-form-input"
									type="text" style="width: 180px;"
									value="${condition['mentor'] }">
							</td>
						</tr>					
					</tbody>
					<tr id="departTb">
						<td>
							<div class="ui-form-input-box">
								<span class="ui-form-input-title" style="width: 100px;">使用部门：</span>
							</div>
						</td>
						<td>
							<baseinfo:depttree widgetId="02" callBackId="setDepartId"
								cls="ui-form-input" defaultValue="${condition['departId'] }"
								orgId="${USER.orgId }"></baseinfo:depttree>
							<input id="departId" name="departId" type="hidden"
								value="${condition['departId'] }">
						</td>
						<td>
						</td>
						<td>
						</td>
						<td>
						</td>
						<td>
						</td>
					</tr>
					<tr id="orgTb">
						<td>
							<div class="ui-form-input-box">
								<span class="ui-form-input-title" style="width: 100px;">所属公司：</span>
							</div>
						</td>
						<td>
							<baseinfo:orgtree widgetId="01" callBackId="setOrgId"
								cls="ui-form-input" defaultValue="${condition['orgId'] }"
								regionId="${USER.regionId }" orgType="2"></baseinfo:orgtree>
							<input id="orgId" name="orgId" type="hidden"
								value="${condition['orgId'] }">
						</td>
						<td>
						</td>
						<td>
						</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align: center;">
							<div class="ui-form-input-box">
								<div class="toolbar">
									<a href="javascript:submitForm();" class="l-btn"
										icon="ui-icon-search">搜索</a>
									<a href="javascript:resetForm();" class="l-btn"
										icon="ui-icon-redo">重置</a>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</form>
		<div class="ui-table-list">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<c:if test="${condition['analyseType']=='car' }">
						<th>
							车牌号
						</th>
						<th>
							司机
						</th>
						<th>
							车载SIM卡
						</th>
						<th>
							标准油耗
						</th>
						<th>
							公里数
						</th>
						<th>
							理论油耗
						</th>
					</c:if>
					<c:if test="${condition['analyseType']=='depart' }">
						<th>
							组织机构
						</th>
						<th>
							部门名称
						</th>
						<th>
							车辆总数
						</th>
					</c:if>
					<c:if test="${condition['analyseType']=='org' }">
						<th>
							公司名称
						</th>
						<th>
							车辆总数
						</th>
					</c:if>
					<c:if test="${not empty analyseType}">
						<th>
							开始时间
						</th>
						<th>
							结束时间
						</th>
					</c:if>
					<c:if
						test="${condition['analyseType']=='depart'||condition['analyseType']=='org' }">
						<th>
							公里数
						</th>
					</c:if>
					<c:if test="${condition['analyseType']=='car' }">
						<th>
							使用部门
						</th>
						<th>
							所属公司
						</th>
					</c:if>
				</tr>
				<c:forEach items="${map['rows']}" var="item">
					<tr>
						<c:if test="${condition['analyseType']=='car' }">
							<td>
								${item.CARNO }
							</td>
							<td>
								${item.MENTOR }
							</td>
							<td>
								${item.SIMID }
							</td>
							<td>
								${item.OILWEAR }
							</td>
							<td>
								${item.DISTANCE }
							</td>
							<td>
								${item.OILWEAR_SUM }
							</td>
						</c:if>
						<c:if test="${condition['analyseType']=='depart' }">
							<td>
								<baseinfo:org id="${item.USERORGID }"
									displayProperty="organizename"></baseinfo:org>
							</td>
							<td>
								<baseinfo:dept id="${item.USERDEPTID }"
									displayProperty="deptname"></baseinfo:dept>
							</td>
							<td>
								${item.CAR_NUM }
							</td>
						</c:if>
						<c:if test="${condition['analyseType']=='org' }">
							<td>
								<baseinfo:org id="${item.CONTRACTORID }"
									displayProperty="organizename"></baseinfo:org>
							</td>
							<td>
								${item.CAR_NUM }
							</td>
						</c:if>
						<c:if test="${not empty analyseType}">
							<td>
								<fmt:formatDate value="${item.KSSJ }" var="kssj"
									pattern="yyyy-MM-dd HH:mm:ss" />
								${kssj }
							</td>
							<td>
								<fmt:formatDate value="${item.JSSJ }" var="jssj"
									pattern="yyyy-MM-dd HH:mm:ss" />
								${jssj }
							</td>
						</c:if>
						<c:if
							test="${condition['analyseType']=='depart'||condition['analyseType']=='org' }">
							<td>
								${item.DISTANCE }
							</td>
						</c:if>
						<c:if test="${condition['analyseType']=='car' }">
							<td>
								<baseinfo:dept id="${item.USERDEPTID }"
									displayProperty="deptname"></baseinfo:dept>
							</td>
							<td>
								<baseinfo:org id="${item.CONTRACTORID }"
									displayProperty="organizename"></baseinfo:org>
							</td>
						</c:if>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="pagination_box">
			<c:if test="${map['total'] > 0}">
				<baseinfo:pagenation records="${map['total']}"
					url="${ctx }/caranalyse/carDistanceAnalyseAction!list.action?${condition['querystring'] }"></baseinfo:pagenation>
			</c:if>
		</div>
	</body>
</html>