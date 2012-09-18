<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>车辆调度申请</title>
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
	In
			.add(
					'validate',
					{
						path : 'http://${config.webliburl}/cabletech/ui/js/jquery.validate.min.js',
						type : 'js',
						charset : 'utf-8',
						rely : [ 'validatemessage' ]
					});
	In.add('validatemessage', {
		path : 'http://${config.webliburl}/cabletech/ui/js/messages_cn.js',
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
					'wdatepicker',
					{
						path : 'http://${config.webliburl}/cabletech/ui/wdatepicker/WdatePicker.js',
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
	In.ready('ct-ui', 'button-js', 'cabletech', 'ztreejs', 'validate',
			'wdatepicker', function() {
			});
	function submitForm() {
		if ($("#recall_remark").val() == ''
				|| $("#recall_remark").val() == null) {
			$("#recall_remark1").html("请填写调回原因");
			return;
		}
		alert("调回成功");
		jQuery('#entity').submit();
	}
</script>
</head>
<body>
	<div class="ui-title-banner-bg" style="height:5%;">
		<div id="title" class="ui-title-banner-text">当前位置- 查询已调度列表-调回</div>
	</div>
	<table>
		<form action="${ctx }/carapply/carapplyAction!saveBack.action"
			name="entity" id="entity" method="post">
			<input type="hidden" id="id" name="id" value="${entity.id }">
			<tr>
				<td colspan="2">
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width:100px;">车牌号：</span><span
							class="ui-form-input-title" style="width:100px;"> <input
							id="car_no" readonly name="car_no" class="ui-form-input"
							value="${entity.car_no}" maxlength="25" type="text"
							style="width:245px;" /> </span>
					</div></td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width:100px;">驾驶员：</span><span
							class="ui-form-input-title" style="width:100px;"><input
							id="mentor" readonly name="mentor" class="ui-form-input"
							value="${entity.mentor}" maxlength="25" type="text"
							style="width:245px;" /> </span>
					</div></td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width:100px;">联系电话：</span><span
							class="ui-form-input-title" style="width:100px;"><input
							id="mentorphone" readonly name="mentorphone"
							class="ui-form-input" value="${entity.mentorphone}"
							maxlength="25" type="text" style="width:245px;" /> </span>
						<%--听她说 好像是 去
						跑什么账的 她不是很想去。。。
					--%>
					</div></td>
			</tr>
		<tr>
			<td colspan="2">
				<div class="ui-form-input-box">
					<span class="ui-form-input-title" style="width:100px;">申请人：</span><span
						class="ui-form-input-title" style="width:100px;"> <input
						id="users" readonly name="users" class="ui-form-input"
						value="${entity.users}" maxlength="25" type="text"
						style="width:245px;" /> </span>
				</div></td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="ui-form-input-box">
					<span class="ui-form-input-title" style="width:100px;">联系电话：</span><span
						class="ui-form-input-title" style="width:100px;"> <input
						id="phone" readonly name="phone" class="ui-form-input"
						value="${entity.phone}" maxlength="25" type="text"
						style="width:245px;" /> </span>
				</div></td>
		</tr>
		<tr>
			<td>
				<div class="ui-form-input-box">
					<span class="ui-form-input-title" style="width:100px;">申请使用时间：</span>
					<span class="ui-form-input-title" style="width:200px;"> <input
						id="use_start_date" readonly name="use_start_date"
						class="ui-form-input" value="${entity.use_start_date}" type="text"
						style="width:135px;" />至
					</span>  
			</td>
			<td><span class="ui-form-input-title" style="width:200px;">
					<input id="use_end_date" readonly name="use_end_date"
					class="ui-form-input" value="${entity.use_end_date}" type="text"
					style="width:135px;" /> </span>
				</div></td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="ui-form-input-box">
					<span class="ui-form-input-title" style="width:100px;">执行任务：</span>
					<input id="use_reason" readonly name="use_reason"
						class="ui-form-input" value="${entity.use_reason}" maxlength="25"
						type="text" style="width:245px;" />

				</div></td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="ui-form-input-box">
					<span class="ui-form-input-title" style="width:100px;">调回原因：</span>
					<textarea rows="5" name="recall_remark" id="recall_remark"
						cols="55"></textarea>
					<span style="font-size:12px" id="recall_remark1"></span><span
						style="color:red">*</span>
				</div></td>
		</tr>
		<tr>
			<td>
				<div class="ui-form-input-box">
					<center>
						<a href="javascript:submitForm();" class="l-btn"
							icon="ui-icon-save">提交</a>
				</div></td>
		</tr>
		</form>
	</table>
</body>
</html>