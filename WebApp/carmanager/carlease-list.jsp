<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">		
		<title>租赁车辆查询</title>	
		<script type="text/javascript">
			In.add('ctcss',{path:'http://${config.webliburl}/cabletech/ui/css/jquery-ct-ui-custom.css'});		
			In.add('lhgdialog',{path:'http://${config.webliburl}/cabletech/ui/lhgdialog/lhgdialog.min.js',type:'js',charset:'utf-8'});
			In.add('button-js',{path : 'http://${config.webliburl}/cabletech/ui/js/jquery.ct.ui.linkbutton.js',type : 'js',charset : 'utf-8'});
			In.add('ztreejs',{path:'http://${config.webliburl}/cabletech/ui/js/jquery.ztree.all-3.1.min.js',type:'js',charset:'utf-8',rely:['ztreecss']});
	   	    In.add('ztreecss',{path:'http://${config.webliburl}/cabletech/ui/css/zTreeStyle.css'});
			In.css('.ui-form-input {width:200px}');	
			In.ready('ctcss','lhgdialog', 'button-js', 'ztreejs', function(){
				initOrgTree_01();	
				initDeptTree_02();
			});
			
			function callBackDeptid(id) {
				$("#deptid").val(id);
			}
			
			function cellBackContractorid(id){
				$("#contractorid").val(id);
			}	
			
			function submitForm() {
			  var queryString = $("#myform1").serialize();	
			  //window.location = $("#myform1").attr('action') + "?" + queryString;
			  $("#myform1").attr('action',$("#myform1").attr('action') + "?" + queryString);
			  $('#myform1').submit();
			}
			
			// 查看车辆详细信息
			function viewCarInfo(carId) {
				var url = contextPath + "/carinfo/carinfoAction!view.action?carId=" + carId;
				location = url;
			}
		</script>			
	</head>
	<body>
	<div class="ui-title-banner-bg">
    	<div class="ui-title-banner-text">当前位置- 租赁车辆查询</div>
    </div>
   	<form id="myform1" method="post" action="${ctx }/carmanager/carLeaseAction!list.action">   	
   		<table>
   			<tr>
   				<td>
   					<div class="ui-form-input-box">
				    	<span class="ui-form-input-title">车牌号:</span>		    	
				    	<input id="carno" name="carno" class="ui-form-input" maxlength="25" type="text" value="${conditionMap['carno'] }"/> 
		   	    	</div>	
   				</td>
   				<td>
   					 <div class="ui-form-input-box">
				    	<span class="ui-form-input-title">所属公司:</span>			    	
				    	<baseinfo:orgtree widgetId="01" regionId="${USER.regionId }" orgType="2" callBackId="cellBackContractorid" cls="ui-form-input" defaultValue="${conditionMap['contractorid'] }"></baseinfo:orgtree>
			    		<input type="hidden" id="contractorid" name="contractorid" value="${conditionMap['contractorid'] }">
			   	    </div>		
   				</td>
   				<td colspan="2">
	   				<div class="ui-form-input-box">
			    		<span class="ui-form-input-title">车型:</span>
			    		<baseinfo:dicselector cssClass="ui-form-input" isQuery="query" name="cartype" keyValue="${conditionMap['cartype'] }" columntype="CARTYPE" type="select"></baseinfo:dicselector>				
		   	   	    </div>
   				</td>
   				
   			</tr>
   			<tr>
   				<td>
   					<div class="ui-form-input-box">
				       <span class="ui-form-input-title">司机:</span>
				       <input id="mentor" name="mentor" class="ui-form-input"  type="text" value="${conditionMap['mentor'] }"/> 
		   	       </div>
   				</td>
   				<td>
   					<div class="ui-form-input-box">
			   	    	<span class="ui-form-input-title">使用部门:</span>
			   	    	<baseinfo:depttree widgetId="02" orgId="${USER.orgId}" callBackId="callBackDeptid" cls="ui-form-input" defaultValue="${conditionMap['deptid'] }"></baseinfo:depttree>
			   	    	<input type="hidden" id="deptid" name="deptid" value="${conditionMap['deptid'] }">
			   	     </div>		
   				</td>
   				<td>
   					<div class="ui-form-input-box">
			   	    	<span class="ui-form-input-title">车辆状态:</span>
			   	    	<baseinfo:dicselector cssClass="ui-form-input" name="carstate" isQuery="query" columntype="CARSTATE" type="select" style="width:200px" keyValue="${conditionMap['carstate'] }"></baseinfo:dicselector>
			   	    </div>	
   				</td>
   				<td>
   					<div class="ui-form-but">
						<a href="javascript:submitForm();" class="l-btn"
							icon="ui-icon-search">查询</a>
					</div>	  
   				</td>
   			</tr>  
   		</table>
   	</form>
	<div class="ui-table-list">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
		    <th>车辆号</th>
		    <th>车型</th>
		    <th>司机</th>
		    <th>司机电话</th>
		    <th>车载SIM卡</th>
		    <th>标准油耗</th>
		    <th>使用单位</th>
		    <th>所属公司</th>
		    <th>操作</th>
		  </tr>
		  <c:forEach items="${map['rows']}" var="item">
		  <tr class="tr_hover">
		    <td>${item.CARNO}</td>
		    <td><baseinfo:dic displayProperty="lable" codevalue="${item.CARTYPE }" columntype="CARTYPE"></baseinfo:dic> </td>
		    <td>${item.MENTOR}</td>
		    <td>${item.PHONE}</td>
		    <td>${item.SIMID}</td>
		    <td>${item.OILWEAR}</td>
		    <td><baseinfo:org displayProperty="ORGANIZENAME" id="${item.USEORGID}"></baseinfo:org> </td>
		    <td><baseinfo:org displayProperty="ORGANIZENAME" id="${item.CONTRACTORID}"></baseinfo:org></td>
		    <td><span><a href="javascript:viewCarInfo('${item.ID }');""><img src="http://${config.webliburl}/cabletech/ui/css/images/table_img/zoom.png" width="16" height="16"></a></span></td>
		  </tr>
		  </c:forEach>
		 </table>
		 <div class="pagination_box">
		 	<baseinfo:pagenation records="${map['total']}" url="${ctx }/carmanager/carLeaseAction!list.action?${condition }"></baseinfo:pagenation>
		 </div>		
	 </div>
	</body>
	
</html>