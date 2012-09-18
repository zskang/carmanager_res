<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<c:if test="${empty USER}">
	<script>
		<%
			request.getSession().removeAttribute("USER");
		%>
		self.location.replace('${ctx}/');
	</script>
</c:if>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>车辆监控系统</title>		
		<link href="${ctx }/css/css.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">			
		In.add('ztreejs',{path:'http://${config.webliburl}/cabletech/ui/js/jquery.ztree.all-3.1.min.js',type:'js',charset:'utf-8',rely:['ztreecss']});
        In.add('ztreecss',{path:'http://${config.webliburl}/cabletech/ui/css/zTreeStyle.css'});
       	In.add('indexcss',{path:'${ctx }/css/css.css'});
       	In.add('layoutjs', {path: 'http://${config.webliburl}/cabletech/ui/js/jquery.ct.ui.layout.js'});
       	In.add('ctcss',{path:'http://${config.webliburl}/cabletech/ui/css/jquery-ct-ui-custom.css'});
        In.ready('ztreejs','indexcss', 'layoutjs', 'ctcss', function(){   
        	var panes = { // default options for 'all panes' - will be overridden by 'per-pane settings'
				applyDemoStyles: 		false		// NOTE: renamed from applyDefaultStyles for clarity
			,	closable:				true		// pane can open & close
			,	resizable:				true		// when open, pane can be resized 
		 
			,	spacing_open:			0			// space between pane and adjacent panes - when pane is 'open'
		  
			 
			};
		
			$('body').layout({
			panes:panes,	
			west:{
			 spacing_open:    6
			}
			,east:{
			  spacing_open:    6
			}
			});
              	
			$.fn.zTree.init($("#menutree"), setting,menuJson);
	    });
	    
	    // 后台菜单json
	    var menuJson = ${menujson};
	    // json设置
        var setting = {
			view: {
				showLine: false
			},
			data:{
				simpleData: {
					enable: true,
					idKey:"ID",
					pIdKey:"PARENTID",
					rootPId:"root"	
				},
				key: {
					title: "TEXT",
					name: "TEXT"						
				}
			},
			callback: {
				onClick:pageSkip
			}				
		};
	     
	    
		//页面跳转
	  	function pageSkip(e, treeId, node) {	  
		  	if(node.HREFURL)
				document.getElementById("ifrMain").src = node.HREFURL; 
		}
		function logOut(){
			$('#optForm').submit();
		}			
	</script>
	</head>
	<body>
		<div id="topregion" class="ui-layout-north">
			<div class="top">
				<div class="top_left">
					<div class="top_sys_name">
						车辆监控系统
					</div>
				</div>
				<div class="top_right_bgimg">
					 <form action="login!logout.action" method="post" id="optForm">
					 </form>
					<div style="position:absolute; top:58px; right:160px;M">
						用户：${USER.userName}
						<a href="javascript:void(0);" onclick="logOut()">注销</a>
					</div>
				</div>
			</div>

		</div>
		<div class="ui-layout-west">
			<div id="menutree" class="ztree">菜单</div>
		</div>
		<div class="ui-layout-center" id="mainregion" region="center"
			style="overflow-x: hidden; overflow-y: auto; padding: 0px;">
			<iframe name="contentdiv" id="ifrMain" frameborder="0"  
				style="width: 100%; height: 100%; overflow-x: hidden; overflow-y: auto;" src="${ctx}/googlemap/gmsa!toMap.action">
			</iframe>
		</div>
	</body>
	
</html>