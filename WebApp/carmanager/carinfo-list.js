//导出
function expExcel() {
	/*
	 * if($('#sel_orgs').combobox('getText') == ''){
	 * $('#sel_orgs').combotree('setValue','') } var url=contextPath +
	 * '/carmanage/carsmgr!expExcel.action?sel_orgs='+$('#sel_orgs').combobox('getValue')+'&txt_cartype='
	 * +$('#txt_cartype').combobox('getValue')+'&tet_sim='+$('#tet_sim').val()+'&txt_begindate='+$('#txt_begindate').val()
	 * +'&txt_enddate='+$('#txt_enddate').val(); window.location.href=url;
	 */
	var urls = contextPath + "/carmanage/carsmgr!expExcel.action?t="
			+ Math.random();
	if ($("#carno").val() != '') {
		urls += "&carno=" + $("#carno").val();
	} else {
		var queryString = $("#myform").formSerialize();
		urls += "&" + queryString;
	}
	window.location = urls;
}
function toGoSave() {
	window.location.href = contextPath
			+ "/carinfo/carinfoAction!toSave.action?t=" + Math.random();
}


function cellBackContractorid(id) {
	$("#contractorid").val(id);
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
