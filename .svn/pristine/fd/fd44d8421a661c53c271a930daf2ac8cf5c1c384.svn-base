//简单查询
function simplSearch(){
	$("#queryForm").submit();
}
//分配
function assign(userOrgId){
	var hasCarChecked = carHasChecked();
	var hasDeptChecked = deptHasChecked();
	if(!hasDeptChecked){
		alert("请选择待分配的组织或部门");
		return;
	}
	if(!hasCarChecked){
		alert("请选择待分配的车辆");
		return;
	}
	var deptId = $("#assign_dept_id").val();
	var orgId = $("#assign_org_id").val();
	if(''==deptId&&orgId==userOrgId){
		alert("车辆不能分配到本单位");
		return;
	 }
    $("#assignForm").submit();
}
//车辆分配 部门选择树--回调
function assignDeptTreeCallBack(obj){
	var objType = obj.OBJTYPE;
	var deptId = obj.ID;
	var orgId = obj.ORGID;
	if('DEPT'==objType){
		$("#assign_dept_id").val(deptId);
		$("#assign_org_id").val(orgId);
	}else{
		$("#assign_dept_id").val('');
		$("#assign_org_id").val(orgId);
	}
}
//车辆分配 部门选择树--清空--回调
function assignDeptTreeClean(obj){
		$("#assign_dept_id").val('');
		$("#assign_org_id").val('');
}
//查询组织选择树--回调
function queryOrgTreeCallBack(id){
		$("#query_org_id").val(id);
}
//查询组织选择树--清空--回调
function queryOrgTreeClean(){
	$("#query_org_id").val('');
}
//全选
function checkboxAll(obj){
	var flag = obj.checked;
	if(flag){
		$("[name='checkbox_car_id']").attr("checked",'true');
	}else{
		$("[name='checkbox_car_id']").removeAttr("checked");
	}
}
//取消 全选
function unCheckboxAll(){
	$("#checkbox_car_all").removeAttr("checked");
}
//是否选部门
function deptHasChecked(){
	var deptId = $("#assign_org_id").val();
	if(''!=deptId){
		return true;
	}
	return false;
}
//是否选车辆
function carHasChecked(){
	var ls = document.getElementsByName("checkbox_car_id");
	for(var i = 0;i<ls.length;i++){
		var flag = ls[i].checked;
		if(flag){
			return true;
		}
	}
	return false;
}
//提示信息
function tipMessage(message){
	if(''!=message&&null!=message&&'null'!=message){
		$.dialog({
		    time: 2,
		    left: '45%',
		    top: '1%',
		    maxBtn:false,
		    minBtn:false,
		    xButton:false,
		    title:'提示',
		    content: message
		});
	}
}