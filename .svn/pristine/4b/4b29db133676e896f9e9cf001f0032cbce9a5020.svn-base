//查询表单提交
function submitForm() {
	jQuery('#carAssignForm').submit();
}
// 查询表单重置
function resetForm() {
	document.getElementById("carAssignForm").reset();
}
// 选择所属公司回调方法
function setOrgId(id) {
	jQuery("#orgId").val(id);
}
// 选择使用部门回调方法
function setDepartId(id) {
	jQuery("#departId").val(id);
}
// 设置全选/全不选
function changeCarIdChecked() {
	var check = jQuery("#checkAll").attr("checked");
	if (check == "checked") {
		jQuery("input[name='carId']").attr("checked", "true");
	} else {
		jQuery("input[name='carId']").removeAttr("checked");
	}
}
// 进行车辆的回收
function unAssign(carId) {
	var url = contextPath + "/carassign/carAssignedAction!unAssign.action?";
	if (carId) {
		url += "&carId=" + carId;
	} else {
		var n = $("input[name='carId']:checked").length;
		if (n > 0) {
			url += "&" + jQuery("input[name='carId']").serialize();
		} else {
			alert("没有选择回收的车辆！");
			return;
		}
	}
	location = url;
}
// 查看车辆详细信息
function viewCarInfo(carId) {
	var url = contextPath + "/carinfo/carinfoAction!view.action?carId=" + carId;
	location = url;
}
// 提示信息
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
	message = "";
}