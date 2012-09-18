<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<%
	java.text.SimpleDateFormat format = new java.text.SimpleDateFormat(
			"yyyy/MM/dd");
	String date = format.format(new java.util.Date());
	request.setAttribute("date", date);
%>
<html>
<head>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
	border: 0
}

#map_canvas {
	height: 100%;
	width: 100%;
}
</style>
<link rel="stylesheet" type="text/css"
	href="${ctx}/googlemap/jquery/themes/default/easyui.css"></link>
<link type="text/css" charset="utf-8"
	href="${ctx}/googlemap/acbox/css/jquery.ajaxComboBox.css"></link>
<script type="text/javascript"
	src="http://${config.webliburl}/cabletech/ui/wdatepicker/WdatePicker.js"></script>
<script type="text/javascript"
	src="${ctx}/googlemap/jquery/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${ctx}/googlemap/jquery/easyloader.js"></script>
<script type="text/javascript"
	src="${ctx}/googlemap/acbox/js/jquery.ajaxComboBox.3.6.1.js"></script>
<script type="text/javascript" src="${ctx}/googlemap/googlemapInit.js"></script>
<script type="text/javascript"
	src="http://ditu.google.com/maps/api/js?v=3.1&sensor=true&language=zh-CN"></script>
<script type="text/javascript">
	$(function() {
		//区域
		$('#regoinid')
				.combobox(
						{
							width : 140,
							url : encodeURI(contextPath
									+ '/common/externalResources!getRegionJson.action?flag=1&pregionid=${USER.regionId}'),
							valueField : 'id',
							textField : 'text',
							onChange : function(n) {
								$('#rID').val(n);
							}
						});
		$('#searchtypeid')
				.combobox(
						{
							url : contextPath
									+ '/common/externalResources!getDictionaryJson.action?type=GOOGLESEARCHTYPE',
							valueField : 'CODEVALUE',
							textField : 'LABLE',
							onChange : function(n) {
								$('#sID').val(n);
								turnOption($('#sID').val());
							}
						});
		initialize();
	});
	setTimeout("getGPS()", 1000);
</script>
</head>
<body>
	<div id="cars_list" title="车辆列表">
		<div id="searchcars"></div>
	</div>
	<div id="map_control" title="筛选菜单">

		<table>
			<tr>
				<td><a
					href="${ctx }/carapply/carapplyAction!toDispatchedList.action">已调度列表</a>
				</td>
			</tr>
			<tr>
				<td><a
					href="${ctx }/carapply/carapplyAction!unallocatedList.action">未调度列表</a>
				</td>
			</tr><%--
			<tr>
				<td><a
					href="${ctx }/carapply/carapplyAction!toCheckList.action">待审核列表</a>
				</td>
			</tr>
			--%><tr>
				<td><a
					href="${ctx }/carapply/carapplyAction!toInsertCarApply.action">添加</a>
				</td>
			</tr>
		</table>



		<div id="search_content" style="bottom:10px;">
			地市：
			<div id="regoinid" style="width:80"></div>
			<input type="hidden" id="rID" name="rID"> 方式：<select
				id="searchtypeid"></select> <input type="hidden" id="sID"> <br />
			<span id="sub0" style="display:inline;"> <input name="genlu"
				id="genlu0" type="radio" value="0" checked="checked"><label
				for="genlu0">全部</label> <input name="genlu" id="genlu1" type="radio"
				value="1"><label for="genlu1">今已出车</label> <input
				name="genlu" id="genlu2" type="radio" value="2"><label
				for="genlu2">今未出车</label> </span> <span id="sub1" style="display:none;">
				姓名：<input id="mentor" name="mentor" class="inputtext"
				style="width:60;"> 号码：<input id="phone" name="phone"
				class="inputtext" style="width:70;" maxlength="11"> 车牌号：<input
				id="car_no" name="car_no" class="inputtext" style="width:70;">
			</span> <input type="button" class="button" value="搜索"
				onclick="searchPositionInfo();"> <input type="button"
				class="button" value="重置">
		</div>
	</div>
	<div id="map_canvas"></div>
</body>
</html>