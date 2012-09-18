//初始化页面载入
function initPage() {
	jQuery("#carAnalyseForm").validate({
		focusInvalid : false,
		submitHandler : function(form) {
			form.submit();
		}
	});
	jQuery("#carTb").hide();
	jQuery("#departTb").hide();
	jQuery("#orgTb").hide();
	jQuery("#analyseType_car").removeAttr("checked");
	jQuery("#analyseType_depart").removeAttr("checked");
	jQuery("#analyseType_org").removeAttr("checked");
	if (ifWorkDay == "true") {
		jQuery("#ifWorkDay").attr("checked", "true");
	} else {
		jQuery("#ifWorkDay").removeAttr("checked");
	}
	if (analyseType != "") {
		jQuery("#" + analyseType + "Tb").show();
		jQuery("#analyseType_" + analyseType).attr("checked", "true");
	} else {
		jQuery("#carTb").show();
		jQuery("#analyseType_car").attr("checked", "true");
	}
	initOrgTree_01();
	initDeptTree_02();
}
// 提交统计表单
function submitForm() {
	jQuery('#carAnalyseForm').submit();
}
// 重置统计表单
function resetForm() {
	document.getElementById("carAnalyseForm").reset();
}
// 统计类型改变事件
function changeFormInput(type) {
	jQuery("#carTb").hide();
	jQuery("#departTb").hide();
	jQuery("#orgTb").hide();
	jQuery("#" + type + "Tb").show();
}
// 所属公司回调方法
function setOrgId(id) {
	jQuery("#orgId").val(id);
}
// 使用部门回调方法
function setDepartId(id) {
	jQuery("#departId").val(id);
}