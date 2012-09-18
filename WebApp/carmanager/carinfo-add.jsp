<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>
		<c:if test="${id==null || id==''}">车辆添加</c:if>
		<c:if test="${id!=null && id!=''}">车辆修改</c:if>
		</title>
		<script type="text/javascript">
		In.css('.ui-form-input {width:200px}');	
		In.add('ct-ui',{path:'http://${config.webliburl}/cabletech/ui/css/jquery-ct-ui-custom.css'});
		In.add('lhgdialog',{path:'http://${config.webliburl}/cabletech/ui/lhgdialog/lhgdialog.min.js',type:'js',charset:'utf-8'});
	In
			.add(
					'button-js',
					{
						path : 'http://${config.webliburl}/cabletech/ui/js/jquery.ct.ui.linkbutton.js',
						type : 'js',
						charset : 'utf-8'
					});
		In.add('carinfo-js',{path:'${ctx}/carmanager/carinfo-add.js',type:'js',charset:'utf-8',rely:['lhgdialog']});
		In.add('validate',{path:'http://${config.webliburl}/cabletech/ui/js/jquery.validate.min.js',type:'js',charset:'utf-8',rely:['validatemessage']});
		In.add('validatemessage',{path:'http://${config.webliburl}/cabletech/ui/js/messages_cn.js',type:'js',charset:'utf-8'});
		In.add('cabletech',{path:'http://${config.webliburl}/cabletech/common/cabletech.js',type:'js',charset:'utf-8'});
		In.add('wdatepicker',{path:'http://${config.webliburl}/cabletech/ui/wdatepicker/WdatePicker.js',type:'js',charset:'utf-8'});
		In.add('ztreejs',{path:'http://${config.webliburl}/cabletech/ui/js/jquery.ztree.all-3.1.min.js',type:'js',charset:'utf-8',rely:['ztreecss']});
   	    In.add('ztreecss',{path:'http://${config.webliburl}/cabletech/ui/css/zTreeStyle.css'});
		In.ready('ct-ui','button-js','carinfo-js','cabletech','ztreejs','validate','wdatepicker',function(){
			initOrgTree_01();
			initRegionTree_02();
			jQuery.validator.addMethod("isMobile", function(value, element) {      
					var length = value.length;  
					var mobile = /^((1[0-9]{1}[0-9]{1})+\d{8})$/;  
					return this.optional(element) || (length == 11 && mobile.test(value));      
					}, 
					"请正确填写正确的手机号码");   
					
			jQuery.validator.addMethod("isExistsSimId", function(value, element) {   
					var carNum = "0";   
					$.ajax({
						async : false,
						dataType : "json",
						url : "${ctx}/carinfo/carinfoAction!isExistsSimId.action?simId=" + value + "&carId=" + $("#id").val(),
						success : function (data){	
							carNum = data;													
						}
						});
					//alert(carNum);
					return this.optional(element) || (carNum == "0");      
					}, 
					"SIM卡不能重复");   	
					
			jQuery.validator.addMethod("isExistsCarNo", function(value, element) {   
					var carNum = "0";   
					$.ajax({
						async : false,
						dataType : "json",
						url : "${ctx}/carinfo/carinfoAction!isExistsCarNo.action?carNo=" + encodeURI(value) + "&carId=" + $("#id").val(),
						success : function (data){	
							carNum = data;													
						}
						});
					//alert(carNum);
					return this.optional(element) || (carNum == "0");      
					}, 
					"车牌号不能重复");   		
			$("#entity").validate();
		});
		function submitForm(){
			jQuery('#entity').submit();
		}
		</script>
	</head>
	<body>
		<div class="ui-title-banner-bg" style="height:5%;">
        	<div id="title" class="ui-title-banner-text">当前位置-
        	<c:if test="${id==null || id==''}">车辆添加</c:if>
			<c:if test="${id!=null && id!=''}">车辆修改</c:if>
        	</div>
    	</div>
    	<table>    	
    	
    	<c:if test="${id==null || id==''}">
    	<form action="${ctx }/carinfo/carinfoAction!save.action" name="car"  id="entity" method="post">
    	</c:if>
    	<c:if test="${id!=null && id!=''}">
    	<form action="${ctx }/carinfo/carinfoAction!update.action" name="car"  id="entity" method="post">
    	</c:if>
		
    		<tr>
    			<td>
    				<div class="ui-form-input-box">
			    		<span class="ui-form-input-title" style="width:100px;">车牌号：</span><input id="carno" name="carno" class="ui-form-input required isExistsCarNo" maxlength="25" type="text" style="width:245px;" value="${entity.carno }"/> <span style="color:red">*</span> 
		   	    		<input type="hidden" id="id" name="id" value="${entity.id }">
		   	    		<input type="hidden" id="usestate" name="usestate" value="${entity.usestate}">
		   	    	</div>
    			</td>
    		</tr>
    		<tr>
    			<td>
    				<div class="ui-form-input-box">
			    		<span class="ui-form-input-title" style="width:100px;">车 型：</span><baseinfo:dicselector name="cartype" keyValue="${entity.cartype}" columntype="CARTYPE" type="select" cssClass="ui-form-input" style="width:245"></baseinfo:dicselector>
		   	   	    </div>
    			</td>
    		</tr>
    		<tr>
    			<td>
    				 <div class="ui-form-input-box">
				    	<span class="ui-form-input-title" style="width:100px;">GPS 号：</span><input id="gpsno" value="${entity.gpsno }" name="gpsno" class="ui-form-input" maxlength="25" type="text" style="width:245px;"/> 
			   	    </div>
    			</td>
    		</tr>
    		<tr>
    			<td>
    				 <div class="ui-form-input-box">
				    	<span class="ui-form-input-title" style="width:100px;">GPS设备公司：</span><input id="gpscompany" value="${entity.gpscompany }" name="gpscompany" class="ui-form-input" maxlength="25" type="text" style="width:245px;"/> 
			   	    </div>
    			</td>
    		</tr>
    		<tr>
    			<td>
    				 <div class="ui-form-input-box">
				    	<span class="ui-form-input-title" style="width:100px;">SIM 卡：</span><input id="simid" name="simid" value="${entity.simid }" class="ui-form-input required isMobile isExistsSimId" maxlength="25" type="text" style="width:245px;"/> <span style="color:red">*</span>
			   	    </div>
    			</td>
    		</tr>
    		<tr>
    			<td>
    				  <div class="ui-form-input-box">
				    	<span class="ui-form-input-title" style="width:100px;">司 机：</span><input id="mentor" name="mentor" value="${entity.mentor }" class="ui-form-input required" maxlength="25" type="text" style="width:245px;"/> <span style="color:red">*</span>
			   	    </div>
    			</td>
    		</tr>
    		<tr>
    			<td>
    				 <div class="ui-form-input-box">
				    	<span class="ui-form-input-title" style="width:100px;">司机电话：</span><input id="phone" name="phone" value="${entity.phone }" class="ui-form-input required isMobile" maxlength="25" type="text" style="width:245px;"/> <span style="color:red">*</span>
			   	    </div>
    			</td>
    		</tr>
    		<tr>
    			<td>
    				<div class="ui-form-input-box">
			    		<span class="ui-form-input-title" style="width:100px;">所属公司：</span>
						<baseinfo:orgtree widgetId="01" isMultiple="false" regionId="${USER.regionId }" orgType="2"
						callBackId="cellBackContractorid"
						defaultValue="${entity.contractorid}" cls="ui-form-input"></baseinfo:orgtree>
						<span style="color:red">*</span>
			    		<input type="hidden" id="contractorid"  name="contractorid" value="${entity.contractorid }">
		   	   	    </div>
    			</td>
    		</tr>
    		<tr>
    			<td>
    				<div class="ui-form-input-box">
			    	<span class="ui-form-input-title" style="width:100px;">所属区域：</span><baseinfo:regiontree
					widgetId="02" regionId="${USER.regionId }" defaultValue="${entity.regionid}"
					callBackId="cellBackRegion" cls="ui-form-input"></baseinfo:regiontree>
					<span style="color:red">*</span>
				    	<input type="hidden" id="regionid"  name="regionid" value="${entity.regionid }">
			   	    </div>
    			</td>
    		</tr>
    		<tr>
    			<td>
    				 <div class="ui-form-input-box">
				    	<span class="ui-form-input-title" style="width:100px;">排 量：</span><input id="outputvolume" value="${entity.outputvolume }" name="outputvolume" class="ui-form-input" maxlength="25" type="text" style="width:245px;"/> 
			   	    </div>
    			</td>
    		</tr>
    		<tr>
    			<td>
    				 <div class="ui-form-input-box">
				    	<span class="ui-form-input-title" style="width:100px;">标准油耗：</span><input id="oilwear" name="oilwear" value="${entity.oilwear }" class="ui-form-input required number" maxlength="25" type="text" style="width:245px;"/> <span style="color:red">*</span>
			   	    </div>
    			</td>
    		</tr>
		    <tr>
    			<td>
    				<div class="ui-form-input-box">
				    	<span class="ui-form-input-title" style="width:100px;">购买时间：</span><input id="buydate" value="${entity.buydateformat }" onclick="WdatePicker();" name="buydate" class="ui-form-input" maxlength="25" type="text" style="width:245px;"/> 
			   	    </div>
    			</td>
    		</tr>			
	   	   	<tr>
    			<td>
	    			<div class="ui-form-input-box">
				    	<span class="ui-form-input-title" style="width:100px;">车辆状态：</span><baseinfo:dicselector name="carstate" keyValue="${entity.carstate}" columntype="CARSTATE" type="select" cssClass="ui-form-input" style="width:245"></baseinfo:dicselector>
			   	    </div>
    			</td>
    		</tr>  
		   	<tr>
    			<td>
    				<div class="ui-form-input-box">
				    	<center><c:if test="${entity.id==null || entity.id==''}">
				    		<a href="javascript:submitForm();" class="l-btn"
										icon="ui-icon-save">添加</a>
				    	</c:if>
								<c:if test="${entity.id!=null && entity.id!=''}">
								<a href="javascript:submitForm();" class="l-btn"
										icon="ui-icon-save">修改</a>
								</c:if>
							&nbsp;&nbsp;
							<a href="javascript:history.go(-1);" class="l-btn"
										icon="ui-icon-undo">返回</a></center>
		   	    	</div>
    			</td>
    		</tr>   		   	   	   
    	</form>
    </table>	
    </body>
</html>