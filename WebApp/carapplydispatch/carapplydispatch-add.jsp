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
						rely : [ 'ztreecss']
					});
	In.add('ztreecss', {
		path : 'http://${config.webliburl}/cabletech/ui/css/zTreeStyle.css'
	});
	In.ready('ct-ui', 'button-js', 'cabletech', 'validate', 'ztreejs',
			'wdatepicker', function() {
				initPersonTree_01();
				toPutPhone('${USER.personId}');
				$("#entity").validate();
			});
	function submitForm() {
		if (($("#use_start_date").val() == null || $("#use_start_date").val() == '')
				|| ($("#use_end_date").val() == null || $("#use_end_date")
						.val() == '')) {
			$("#date").html("使用时间不能为空");
			return;
		} else {
			$("#date").html("");
		}
		if ($('#phone').val() == null || $('#phone').val() == '')
			return;
		$("#entity").submit();
		alert("调度信息添加成功");
	}

	function toPutPhone(userid) {
		if (userid == null || userid == '') {
			$('#phone').val("");
			return;
		}
		jQuery.get(contextPath
				+ "/carapply/carapplyAction!getPhoneJson.action?userid="
				+ userid, function(data) {
			if (data == "" || data == null) {
				alert("该用户没有完善联系电话信息");
				$("#phone1").html("申请人没有联系电话请重新选择申请人");
				$("#phone").val("");
			} else {
				$("#phone1").html("");
				$("#phone").val(data);
			}
		}, 'text');
	}

	//将人树的值赋值给隐藏域的input
	function cellBack(id) {
		$("#applicant").val(id);
		toPutPhone(id);
	}
</script>
</head>
<body>
	<div class="ui-title-banner-bg" style="height:5%;">
		<div id="title" class="ui-title-banner-text">当前位置- 车辆调度申请</div>
	</div>
	<table>
		<form action="${ctx }/carapply/carapplyAction!save.action"
			name="entity" id="entity" method="post">
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width:100px;">申请人：</span> 
						<input id="applicantw" readonly name="applicantw"
							class="ui-form-input" value="${userName}" maxlength="25"
							type="text" style="width:245px;" /> 
						<input type="hidden" id="applicant" name="applicant"
							value="${USER.personId}" />
					</div></td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width:100px;">联系电话：</span><input
							id="phone" readonly name="phone" class="ui-form-input" value="212121111"
							maxlength="25" type="text" style="width:245px;" /><span
							id="phone1"></span><span style="color:red">*</span>
					</div></td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width:100px;">用车人：</span><input
							id="users" name="users" class="ui-form-input required"
							maxlength="25" type="text" style="width:245px;" /><span
							style="color:red">*</span>
					</div></td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width:100px;">使用时间：</span><input
							id="use_start_date" name="use_start_date"
							onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							readonly maxlength="25" type="text" style="width:115px;" /> -- <input
							id="use_end_date" readonly name="use_end_date"
							onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							maxlength="25" type="text" style="width:115px;" /><span
							id="date"></span><span style="color:red">*</span>
					</div></td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width:100px;">事由：</span>
						<textarea id="use_reason" name="use_reason" rows="7"
							class="required" cols="35"></textarea>
						<span style="color:red">*</span>
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