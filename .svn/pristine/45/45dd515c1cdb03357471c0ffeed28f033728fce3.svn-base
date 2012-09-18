<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<%
	java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy/MM/dd");
	String date = format.format(new java.util.Date());
	request.setAttribute("date",date);
	String simid = request.getParameter("simid");
	String begindate = request.getParameter("begin");
	String enddate = request.getParameter("end");
	request.setAttribute("simid", simid);
	request.setAttribute("begindate", begindate);
	request.setAttribute("enddate", enddate);
%>
<html>
	<head>
		<style type="text/css">
			body{margin:0;padding:0;border:0}
			#map_canvas{height: 100%;width:100%;}
		</style>
		<script type="text/javascript" src="http://${config.webliburl}/cabletech/ui/wdatepicker/WdatePicker.js"></script>
		<script type="text/javascript" src="http://ditu.google.com/maps/api/js?v=3.1&sensor=true&language=zh-CN"></script>
		<script type="text/javascript">
			var map;
			var poly;
		  	var infowindow;
		  	var LatM = 0,LonM = 0;
		    //点集合
		    var points = [];
		    var hispoints = [];
		 	 //设置线样式		
			 var polyOptions = {
		   		strokeColor: 'blue',
		   		strokeOpacity: 1.0,
		   		strokeWeight: 5
		   	}
		  //播放
		  var speed = 7000;//1000  2000  3000  4000 5000 6000 7000 8000 9000速度
		  function onlinePlay(speed){
			//新建折线对象
		   	poly = new google.maps.Polyline(polyOptions);
		   	poly.setMap(map);
		   	google.maps.event.addListener(poly, 'rightclick', delLatLng);
		  	//获取点信息并绘制
		  	var istatus = $('#istatus').html();
		  	hispoints.length=0;
		  	var object = {};
		    var url = "${ctx}/googlemap/gmsa!getLocus.action";
		    $.ajax({
				url: url,
				type: 'post',
				async: false,
				dataType: 'json',
				data: "simid=${simid}&begin=${begindate}&end=${enddate}&t="+Math.random(),
		    	success: function(data){
					if(data && data.length>0){
				    	for(var i=0; i< data.length; i++){
							hispoints.push(data[i]);
				    	}
					}else{
						if(document.getElementById('istatus'))
							$('#istatus').html("没有数据！");					
					}
					$('#istatus').html("正在播放！");
					drawPosition(speed);										    		
		    	}
		    });
		  }
		  
			//绘制轨迹  
			var sequence = 0;var stop = false;
			function drawPosition(speed){
			  //间隔7s绘制一个
			  var iID = setTimeout("drawPosition('"+sequence+"');",speed);
			  if(!stop){
			 	if(hispoints && sequence < hispoints.length){
			 		poly.setMap(map);
			   		var obj = hispoints[sequence];
					var y = obj.Y+LatM;
					var x = obj.X+LonM;
			        var latlng = new google.maps.LatLng(y, x);
					//绘制折线
			        var path = poly.getPath();
			       	path.push(latlng);
			        //添加点
			       	map.panTo(latlng);
			        sequence++;
			    }else{
			    	if(document.getElementById('istatus'))
			    		$('#istatus').html("播放完毕！");
			    	clearTimeout(iID);
			    }
			   }else{
			  		$('#istatus').html("已停止！");
			  		clearTimeout(iID);     	
			   }
			}		  
		  
	    	//定位车辆
	    	var getPositionAndDisplay = function(){
	    		var url = "${ctx}/googlemap/gmsa!getPositionAndDisplay.action";
				$.ajax({
					url: url,
					type: 'post',
					async: false,
					dataType: 'json',
					data: "simid=${simid}&date=&t="+Math.random(),
					success: function(data){
						var latlng = new google.maps.LatLng(data[0].Y, data[0].X);
				        var marker = createMarker(data[0], latlng);
				        map.addMarker(marker);
		        		map.panTo(latlng);
				        map.setZoom(15);
					    infowindow = newOpenWindow(data[0]);
				        infowindow.open(map, marker);
					}
				});
			}

			//生成标注
			function createMarker(obj, latlng) {
			  var marker = new google.maps.Marker({position: latlng, map: map, title: "No："+obj.CARNO});
			  google.maps.event.addListener(marker, "click", function() {
			    //if(infowindow) infowindow.close();
			    infowindow = newOpenWindow(obj);
			    infowindow.open(map, marker);
			  });
			  return marker;
			}
			
			//显示标注内容
			function newOpenWindow(obj){
			return new google.maps.InfoWindow({content:
			  	 "负责人："+obj.MENTOR+"<br/>联系电话："+obj.PHONE+
			     "<br/>编号："+obj.CARNO+"<br/>车型："+obj.CARTYPE+
			     "<br/>SIM卡号："+obj.SIMID+"<br/>日期从：${begindate}到${enddate}"+
			     "<br/>播放状态：<span id='istatus'>未播放！</span>"+
			     "<br/><a style='text-decoration:underline;cursor:hand;' href='javascript:void(0);' onclick=\"javascript:poly.setMap(null);sequence=0;onlinePlay(7000);return false;\">在线播放</a>"});  
			}					
			
			//删除线段
			function delLatLng(event) {
			 poly.setMap(null);
			}				
		  $(function(){
			  google.maps.Map.prototype.markers = new Array();
			  google.maps.Map.prototype.addMarker = function(marker) {
			    this.markers[this.markers.length] = marker;
			  };
			  google.maps.Map.prototype.getMarkers = function() {
			    return this.markers
			  };
			  google.maps.Map.prototype.clearMarkers = function() {
			    if(infowindow) {
			      infowindow.close();
			    }
			    for(var i=0; i<this.markers.length; i++){
			      this.markers[i].setMap(null);
			    }
			  };  
			var latlng = new google.maps.LatLng(43.780, 87.298);     
			var myOptions = {
				zoom: 10,
				center: latlng,
				navigationControl: true,
				scaleControl: true,
				streetViewControl: true,      
				mapTypeId: google.maps.MapTypeId.ROADMAP
			};
			map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
	  		//新建折线对象
	  		poly = new google.maps.Polyline(polyOptions);
	   		poly.setMap(map);
			google.maps.event.addListener(poly, 'rightclick', delLatLng);
		  	getPositionAndDisplay();			  
		  });
		</script>	  			
	</head>
	<body>
		<div id="map_canvas"></div>
	</body>
</html>