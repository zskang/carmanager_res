<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>车辆详细信息</title>
		<script type="text/javascript">
	In
			.add(
					'ct-ui',
					{
						path : 'http://${config.webliburl}/cabletech/ui/css/jquery-ct-ui-custom.css'
					});
	In
			.add(
					'button-js',
					{
						path : 'http://${config.webliburl}/cabletech/ui/js/jquery.ct.ui.linkbutton.js',
						type : 'js',
						charset : 'utf-8'
					});
	In.add('cabletech', {
		path : 'http://${config.webliburl}/cabletech/common/cabletech.js',
		type : 'js',
		charset : 'utf-8'
	});
	In.ready('ct-ui', 'button-js', 'cabletech');
</script>
	</head>
	<body>
		<div class="ui-title-banner-bg" style="height: 5%;">
			<div id="title" class="ui-title-banner-text">
				当前位置-车辆详细信息
			</div>
		</div>
		<div class="ui-form-container" style="width: 480px;">
		<table>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">车牌号：</span>
						${entity.CARNO }
					</div>
				</td>				
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">车 型：</span>
						<baseinfo:dicselector name="" columntype="CARTYPE" type="view"
							keyValue="${entity.CARTYPE}"></baseinfo:dicselector>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">GPS号：</span>
						${entity.GPSNO }
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">GPS设备公司：</span>
						${entity.GPSCOMPANY }
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">SIM
							卡：</span> ${entity.SIMID }
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">司 机：</span>
						${entity.MENTOR }
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">司机电话：</span>
						${entity.PHONE }
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">所属公司：</span>
						<baseinfo:org displayProperty="organizename"
							id="${entity.CONTRACTORID }"></baseinfo:org>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">所属区域：</span>
						<baseinfo:region displayProperty="regionname"
							id="${entity.REGIONID }"></baseinfo:region>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">排 量：</span>
						${entity.OUTPUTVOLUME }
					</div>
				</td>
			</tr>	
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">标准油耗：</span>
						${entity.OILWEAR }
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">购买时间：</span>
						<fmt:formatDate var="buyDate" value="${entity.BUYDATE }"
							pattern="yyyy-MM-dd" />
						${buyDate }
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">分配组织：</span>
						<baseinfo:org displayProperty="organizename"
							id="${entity.ASSIGNORGID }"></baseinfo:org>
					</div>
				</td>
			</tr>	
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">使用组织：</span>
						<baseinfo:org displayProperty="organizename"
							id="${entity.USERORGID }"></baseinfo:org>
					</div>
				</td>
			</tr>	
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">使用部门：</span>
						<baseinfo:dept displayProperty="deptname" id="${entity.USERDEPTID }"></baseinfo:dept>
					</div>
				</td>
			</tr>	
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">使用状态：</span>
						<baseinfo:dicselector name="" columntype="USESTATE" type="view"
							keyValue="${entity.USESTATE}"></baseinfo:dicselector>
					</div>
				</td>
			</tr>	
			<tr>
				<td>
					<div class="ui-form-input-box">
						<span class="ui-form-input-title" style="width: 100px;">车辆状态：</span>
						<baseinfo:dicselector name="" columntype="CARSTATE" type="view"
							keyValue="${entity.CARSTATE}"></baseinfo:dicselector>
					</div>
				</td>
			</tr>	
			<tr>
				<td>
					<div class="ui-form-input-box">
						<center>
							<a href="javascript:history.go(-1);" class="l-btn"
								icon="ui-icon-undo">返回</a>
						</center>
					</div>
				</td>
			</tr>					
		</table>
		</div>
	</body>
</html>