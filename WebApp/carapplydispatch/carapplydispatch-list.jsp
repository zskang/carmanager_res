<%@ page language="java"
	import="com.cabletech.baseinfo.business.entity.UserInfo"
	pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>查询待调度列表</title>
<meta http-equiv="refresh"
	content="10;url=${ctx }/carapply/carapplyAction!unallocatedList.action">
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
	In.ready('ct-ui', 'button-js', 'cabletech', function() {
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
 
</script>
</head>
<body>
	<div class="ui-title-banner-bg" style="height: 5%;">
		<div id="title" class="ui-title-banner-text">当前位置-查询待调度列表</div>
	</div>
	<div id="tableContainner" class="ui-table-list">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<th width="20%">申请人手机号</th>
				<th width="45%">申请开车事由</th>
				<th width="15%">申请时间</th>
				<th width="10%">状态</th>
				<th>操作</th>
			</tr>
			<c:forEach items="${map['rows']}" var="item">
				<tr class="tr_hover">
					<td>${item.PHONE }</td>
					<td>${item.USE_REASON }</td>
					<td><c:out value=""></c:out> ${item.APPLY_DATE }</td>
					<td><c:if test="${item.DISP_STATE eq '0' }">未调度</c:if> <c:if
							test="${item.DISP_STATE eq '3' }">等待调度</c:if></td>
					<td><span><a
							href="${ctx }/carapply/carapplyAction!toDispatch.action?id=${item.ID }"><img
								src="http://${config.webliburl}/cabletech/ui/css/images/table_img/pencil.png"
								width="16" alt="调度" height="16"> </a> </span></td>
				</tr>
			</c:forEach>
		</table>
		<div class="pagination_box">
			<baseinfo:pagenation records="${map['total']}"
				url="${ctx }/carapply/carapplyAction!unallocatedList.action?"></baseinfo:pagenation>
		</div>
	</div>
	<input type="hidden" id="power_map_json" value=${power_map_json } />
	<input type="hidden" id="regionId" value="${USER.regionId }" />
</body>
</div>
</html>