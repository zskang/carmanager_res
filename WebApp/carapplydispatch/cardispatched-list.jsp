<%@ page language="java"
	import="com.cabletech.baseinfo.business.entity.UserInfo"
	pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>查询已调度列表</title>
<script type="text/javascript">
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
	In
			.add(
					'wdatepicker',
					{
						path : 'http://${config.webliburl}/cabletech/ui/wdatepicker/WdatePicker.js',
						type : 'js',
						charset : 'utf-8'
					});
	In.add('ztreecss', {
		path : 'http://${config.webliburl}/cabletech/ui/css/zTreeStyle.css'
	});
	In.ready('ct-ui', 'button-js', 'cabletech', 'ztreejs', 'wdatepicker',
			function() {
				initPersonTree_01();
				tipMessage('${carapply}');
			});
	function submitForm() {
		jQuery("#myform1").submit();
	}
	function tipMessage(message) {
		if ('' != message && null != message && 'null' != message) {
			jQuery.dialog({
				time : 2,
				left : '45%',
				top : '1%',
				maxBtn : false,
				minBtn : false,
				xButton : false,
				title : '提示',
				content : message
			});
		}
	}
	function cellBack(id) {
		$("#applicant").val(id);
	}
</script>
</head>
<body>
	<div class="ui-title-banner-bg" style="height: 5%;">
		<div id="title" class="ui-title-banner-text">当前位置-查询已调度列表</div>
	</div>
	<form id="myform1"
		action="${ctx }/carapply/carapplyAction!toDispatchedList.action">
		<table>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title">申请人:</span>
						<baseinfo:persontree widgetId="01"
							defaultValue="${condition['applicant'] }" orgId="${USER.orgId }"
							callBackId="cellBack"></baseinfo:persontree>
						<input type="hidden" id="applicant" name="applicant"
							value="${condition['applicant'] }" />
					</div>
				</td>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title">申请用车时间:</span> <input id="start"
							name="start" style="width: 112px"
							onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							value="${condition['start'] }" type="text" /> 至 <input id="end"
							name="end" style="width: 112px"
							onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							value="${condition['end'] }" type="text" />
					</div>
				</td>
				<td colspan="2" style="text-align: center;">&nbsp;</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title">用车状态:</span> <input
							type="checkbox" id="dispstate" name="dispstate" value="1"
							<c:forEach items="${condition['dispstateList']}" var="item"><c:if test="${item=='1' }">checked</c:if></c:forEach>>&nbsp;调用成功&nbsp;&nbsp;
						<input type="checkbox" id="dispstate" name="dispstate" value="2"
							<c:forEach items="${condition['dispstateList']}" var="item"><c:if test="${item=='2' }">checked</c:if></c:forEach>>&nbsp;无车调用&nbsp;&nbsp;
						<input type="checkbox" id="dispstate" name="dispstate" value="4"
							<c:forEach items="${condition['dispstateList']}" var="item"><c:if test="${item=='4' }">checked</c:if></c:forEach>>&nbsp;取消&nbsp;&nbsp;
					</div>
				</td>
				<td colspan="2">
					<div class="ui-form-input-box">
						<span class="ui-form-input-title">车牌号:</span> <input id="carno"
							name="carno" class="ui-form-input" value="${condition['carno'] }"
							style="width: 155px" maxlength="25" type="text" />
					</div>
				</td>
				<td style="text-align: center;">
					<div class="ui-form-input-box">
						<a href="javascript:submitForm();" class="l-btn"
							icon="ui-icon-search">查询</a>
					</div>
				</td>
			</tr>
		</table>
	</form>
	<div id="tableContainner" class="ui-table-list">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<th width="10%">申请人手机号</th width="20%">
				<th>申请开车事由</th>
				<th width="20%">申请用车时间</th>
				<th width="10%">车牌号</th>
				<th width="15%">申请时间</th>
				<th width="15%">状态</th>
				<th>操作</th>
			</tr>
			<c:forEach items="${map['rows']}" var="item">
				<tr class="tr_hover">
					<td>${item.PHONE }</td>
					<td>${item.USE_REASON }</td>
					<td>${item.USE_START_DATE}-${item.USE_END_DATE }</td>
					<td>${item.CARNO }</td>
					<td>${item.APPLY_DATE }</td>
					<td><c:if test="${item.DISP_STATE eq '1' }">调度成功</c:if> <c:if
							test="${item.DISP_STATE eq '2' }">无车调用</c:if> <c:if
							test="${item.DISP_STATE eq '4' }">取消</c:if></td>
					<td><c:if test="${item.DISP_STATE eq '1' }">
							<span><img
								src="http://${config.webliburl}/cabletech/ui/css/images/table_img/tick.png"
								width="16" alt="" height="16"><a
								href="${ctx }/carapply/carapplyAction!toBack.action?id=${item.ID }">调回
							</a> </span>
						</c:if></td>
				</tr>
			</c:forEach>
		</table>
		<div class="pagination_box">
			<baseinfo:pagenation records="${map['total']}"
				url="${ctx }/carapply/carapplyAction!toDispatchedList.action?"></baseinfo:pagenation>
		</div>
	</div>
	<input type="hidden" id="power_map_json" value=${power_map_json } />
	<input type="hidden" id="regionId" value="${USER.regionId }" />
</body>
</div>
</html>