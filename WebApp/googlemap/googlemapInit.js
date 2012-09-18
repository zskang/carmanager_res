	var map;
	var poly;
  	var infowindow;
  	var LatM = 0,LonM = 0;
 	 //设置线样式		
	 var polyOptions = {
   		strokeColor: 'red',
   		strokeOpacity: 1.0,
   		strokeWeight: 5
   	}


//初始化参数
var initialize = function(){  
	google.maps.Map.prototype.markers = [];
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
 	var thead = ["车牌号","SIM卡号","负责人","联系电话","最后一次发送时间","操作"];
	$('#searchcars').datagrid({
        width: '516',
        height: '200',	
		nowrap: false,
		striped: true,
		fitColumns: true,
		pagination:true,
		rownumbers:true,
		pageSize: 10,
		page: 1,			
		columns:[[
			{field:'CARNO',title:thead[0],width:80},
			{field:'SIMID',title:thead[1],width:80},
			{field:'MENTOR',title:thead[2],width:60},
			{field:'PHONE',title:thead[3],width:80},
			{field:'ACTIVETIME',title:thead[4],width:110},
			{field:'OPT',title:thead[5], width:80,
			formatter:function(value,rec){
					var disp = '<a href="javascript:;" onclick="javascript:map.clearMarkers();getPosAndDisplay(\''+rec.SIMID+'\',\''+rec.ACTIVETIME+'\');return false;">定位</a>';
					return '<span>'+disp+'</span>';
				}
			}					
		]]
	});			
 
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
 	
 	poly = new google.maps.Polyline(polyOptions);
  	poly.setMap(map);
  		
	$('#map_control').window({
		width: 520,
		height: 80, 
        top:$(window).height()-80,   
		minimizable: false,
		maximizable: false,
		closable: false,
		inline: true
	});
	$('#map_control').window('open');
	$('#map_control').css({bottom: '10px'});
	$('#cars_list').window({
		width:530,
		height:250,
		top: 0,
		left: 0,
		minimizable: false,
		maximizable: false
	});
	$('#cars_list').window('close');		   		
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
//生成标注
function createMarker(obj, latlng, date) {
  var marker = new google.maps.Marker({position: latlng, map: map, title: "No："+obj.CARNO});
  google.maps.event.addListener(marker, "click", function() {
    if(infowindow) infowindow.close();
    infowindow = newOpenWindow(obj, date);
    infowindow.open(map, marker);
  });
  return marker;
}
//显示标注内容
function newOpenWindow(obj,date){
return new google.maps.InfoWindow({content:
  "负责人："+obj.MENTOR+"<br/>联系电话："+obj.PHONE+
     "<br/>编号："+obj.CARNO+"<br/>车型："+obj.CARTYPE+
     "<br/>SIM卡号："+obj.SIMID+"<br/>日期：<input type='text' id='bdate' class='input' style='width:80;' value='"+date.substring(0,10)+"' readonly='true' onfocus=\"WdatePicker({dateFmt:'yyyy/MM/dd'})\"/>"+
     "<br/>播放状态：<span id='istatus'>未播放！</span>"+
     "<br/><a style='text-decoration:underline;cursor:hand;' href='javascript:void(0);' onclick=\"javascript:poly.setMap(null);sequence=0;onlinePlay('"+obj.SIMID+"');return false;\">在线播放</a>"});  
}
//删除线段		  	
function delLatLng(event) {
 poly.setMap(null);
}		  	

var turnOption = function(v){
	if(v == 1){
		$('#sub0').hide();
		$('#sub1').show();
	}else{
		$('#sub0').show();
		$('#sub1').hide();	    	
	}
}


		  //点集合
		  var points = [];
		  var hispoints = [];
			
		  //播放
		  var speed = 7000;//1000  2000  3000  4000 5000 6000 7000 8000 9000速度
		  function onlinePlay(simid, speed){
			//新建折线对象
		   	poly = new google.maps.Polyline(polyOptions);
		   	poly.setMap(map);
		   	google.maps.event.addListener(poly, 'rightclick', delLatLng);
		  	//获取点信息并绘制
		  	var istatus = $('#istatus').html();
		  	var date = $('#bdate').val();
		  	if(date == '') date = '${date}';
		  	hispoints.length=0;
		  	var object = {};
		    var url = contextPath+"/googlemap/gmsa!getHistoryPositions.action";
		    $.ajax({
				url: url,
				type: 'post',
				async: false,
				dataType: 'json',
				data: "simid="+simid+"&date="+date+"&t="+Math.random(),
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
		  var getGPS = function(){
		  		var url = contextPath+"/googlemap/gmsa!getPositionAndDisplay.action";
				$.ajax({
					url: url,
					type: 'post',
					async: false,
					dataType: 'json',
					success: function(data){
						for(var i=0; i<data.length; i++){
							var latlng = new google.maps.LatLng(data[i].Y, data[i].X);
					        var marker = createMarker(data[i], latlng, data[i].ACTIVETIME);
					        map.addMarker(marker);
						    /**infowindow = newOpenWindow(data[i],date);
					        if(infowindow) {
					      		infowindow.close();
					    	}
					        infowindow.open(map, marker);**/
				        }
					}					
				});		  
		  }
	    	//定位车辆
	    	var getPosAndDisplay = function(simid,date){
	    		var dataValue = "simid="+simid+"&date="+date+"&t="+Math.random();
		  		var url = contextPath+"/googlemap/gmsa!getPositionAndDisplay.action";
				$.ajax({
					url: url,
					type: 'post',
					async: false,
					dataType: 'json',
					data: dataValue,
					success: function(data){
						var latlng = new google.maps.LatLng(data[0].Y, data[0].X);
				        var marker = createMarker(data[0], latlng, date);
				        map.addMarker(marker);
		        		map.panTo(latlng);
				        map.setZoom(15);
					    infowindow = newOpenWindow(data[0],date);
				        if(infowindow) {
				      		infowindow.close();
				    	}
				        infowindow.open(map, marker);
					}					
				});	
			}
			
		    var searchPositionInfo = function(){
			    var url = contextPath+"/googlemap/gmsa!searchCars.action?regionid="+$('#rID').val()+"&genlu="+getRadioVal('genlu')+"&mentor="+$('#mentor').val()+"&phone="+$('#phone').val()+"&carno="+$('#car_no').val()+"&selectlist="+$('#sID').val()+"&rad="+Math.random();
		    	$('#cars_list').window('open');
		    	$('#searchcars').datagrid({
		    	 	url: encodeURI(url)
		    	});
		    }
			var getRadioVal = function(radioName){
			   var obj = document.getElementsByName(radioName);
			   if(obj){
			       var i;
			       for(i=0;i<obj.length;i++){
			           if(obj[i].checked){
			               return obj[i].value;       
			           }
			       }
			   }
			   return null; 
			}
			
			var resetValue = function(){
				$('#regoinid').combobox('setValue','');
				$('#searchtypeid').combobox('setValue','');
				$('#rID').val('');
				$('#sID').val('');
			}