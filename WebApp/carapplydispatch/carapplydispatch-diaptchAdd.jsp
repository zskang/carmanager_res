<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>车辆调度</title>
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
				initPersonTree_01();
				toChooseCar();
				toPutPhone('${USER.personId}');
				$("#entity").validate();
			});
	function submitForm(obj) {
		$("#disp_state").val(obj);
		if (obj != '2') {
			if (($("#approver").val() == null || $("#approver").val() == '')) {
				$("#approver1").html("审批人不能为空!");
				return;
			}
			if ($("#approversim").val() == null
					|| $("#approversim").val() == '')
				return;

			if ($("#car_no").val() == '0' || $("#car_no").val() == null
					|| $("#car_no").val() == '') {
				$("#car_no1").html("请选择车辆!");
				return;
			} else
				$("#car_no1").html("");
			alert("调度成功!");
		} else {
			alert("无车可调,请等待!");
		}
		jQuery("#entity").submit();
	}

	function toPutPhone(userid) {
		if (userid == null || userid == '') {
			$("#approversim").val("");
			return;
		}
		jQuery.get(contextPath
				+ "/carapply/carapplyAction!getPhoneJson.action?userid="
				+ userid, function(data) {
			if (data == "" || data == null) {
				alert("该用户没有完善联系电话信息！");
				$("#approversim").html("申请人没有联系电话请重新选择审批人！");
				$("#approversim").val("");
			} else {
				$("#approversim").html("");
				$("#approversim").val(data);
			}
		}, 'text');
	}

	function toChooseCar() {
		var carMan1 = $("#CarManName").val();
		var CarNumber1 = $("#CarNumber").val();
		jQuery
				.post(
						contextPath
								+ "/carapply/carapplyAction!getUnusedCarJson.action",
						{
							carMan : carMan1,
							CarNumber : CarNumber1
						},
						function(data) {
							//alert(data);
							if (data == "" || data == null) {
								alert("没有可用车辆可调用！");
								$("#sd").html("请重新选择查询条件！");
								$("#sd").val("");
							} else {
								$("#sd")
										.html(
												"<select id='car_no' name='car_no' class='ui-form-input' style='width: 245px;'>"
														+ data + "</select>");
							}
							$("#car_no").val(data);
						}, 'text');
	}

	//将人树的值赋值给隐藏域的input
	function cellBack(id) {
		$("#approver").val(id);
		toPutPhone(id);
	}
</script>
</head>
<body>
	<div class="ui-title-banner-bg" style="height: 5%;">
		<div id="title" class="ui-title-banner-text">当前位置- 查询待调度列表-调度</div>
	</div>
	<table>
		<form action="${ctx }/carapply/carapplyAction!update.action"
			name="entity" id="entity" method="post">
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">申请人：</span>
						<input type="hidden" id="applicant" readonly="readonly"
							name="applicant" value="${entity.applicant}" /> <input
							type="text" id="username" readonly="readonly" name="username"
							value="${entity.username}" /> <input type="hidden"
							id="disp_state" name="disp_state" /> <input type="hidden"
							id="id" name="id" value="${entity.id }" /> <input type="hidden"
							id="apply_date" name="apply_date" value="${entity.apply_date }" />
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">联系电话：</span>
						<input id="phone" readonly name="phone" class="ui-form-input"
							value="15866554433" maxlength="25" type="text"
							style="width: 245px;" /><span id="phone1"></span>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">用车人：</span>
						<input id="users" name="users" class="ui-form-input required"
							maxlength="25" readonly type="text" style="width: 245px;"
							value="${entity.users }" />
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">使用时间：</span><input
							id="use_start_date" name="use_start_date"
							value="${entity.use_start_date }" maxlength="25"
							onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							type="text" style="width: 115px;" /> -- <input id="use_end_date"
							name="use_end_date" value="${entity.use_end_date }"
							onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							maxlength="25" type="text" style="width: 115px;" /> <span
							style="color: red">*</span>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">审批人：</span>
						<baseinfo:persontree widgetId="01" defaultValue="${USER.personId}"
							orgId="${USER.orgId }" callBackId="cellBack"></baseinfo:persontree>
						<span style="color: red">*</span> <input type="hidden"
							value="${USER.personId }" id="approver" name="approver" />
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">审批人电话：</span>
						<input id="approversim" readonly name="approversim"
							class="ui-form-input" maxlength="25" type="text"
							style="width: 245px;" /><span id="phone1"></span>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">事由：</span>
						<textarea id="use_reason" name="use_reason" rows="7"
							class="required" cols="35" readonly="readonly">${entity.use_reason }</textarea>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<table>
							<tr>
								<td colspan="2"><span class="ui-form-input-title">调度车辆：</span>
								</td>
							</tr>
							<tr>
								<td><span style="padding-left: 10px">驾驶员姓名：</span></td>
								<td><input name="carMan" id="CarManName" type="text"
									style="width: 145px;" class="ui-form-input"></td>
							</tr>
							<tr>
								<td><span style="padding-left: 10px">车牌号码：</span></td>
								<td><input name="CarNumber" id="CarNumber" type="text"
									style="width: 145px;" class="ui-form-input"> <a
									href="javascript:toChooseCar();" class="l-btn"
									icon="ui-icon-save">查询</a></td>
							</tr>
							<tr>
								<td colspan="2" style="padding-left: 10px">
									<div id="sd"></div> <span id="car_no1"></span> <span
									style="color: red">*</span></td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		<tr>
			<td>
				<div class="ui-form-input-box">
					<center>
						<a href="javascript:submitForm('5');" class="l-btn"
							icon="ui-icon-save">提交</a> <a href="javascript:submitForm('2');"
							class="l-btn" icon="ui-icon-save">无车可调</a>
					</center>
				</div>
			</td>
		</tr>
		</form>
	</table>
</body>
</html>