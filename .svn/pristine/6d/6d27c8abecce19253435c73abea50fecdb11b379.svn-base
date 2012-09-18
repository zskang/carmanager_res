/**
 * 作者：吕仁钊 
 * 公司：鑫干线(合肥)
 * 时间：2012/01/29
 */
package com.cabletech.core.action.config;

import javax.annotation.Resource;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import com.cabletech.baseinfo.business.Service.BaseInfoProvider;
import com.cabletech.baseinfo.business.entity.UserInfo;
import com.cabletech.core.action.BaseAction;

/**
 * 通用权限获取gis配置action
 */
@Namespace("/")
@Action("config")
public class ConfigAction extends BaseAction {
	/**
	 * 基础服务提供类
	 */
	@Resource(name = "baseInfoProvider")
	private BaseInfoProvider baseInfoProvider;

	/**
	 * Action默认执行方法
	 * @return String
	 */
	public String execute() {
		String userid = "";
		//获取session中user信息
		Object objuser = request.getSession().getAttribute("user");
		//如果user信息不为空，将userid赋值。
		if(objuser != null){
			userid = ((UserInfo)objuser).getUserId();
		}else{
			userid = request.getParameter("userid");
		}
		//根据userid获取json格式的配置信息
		String json="{map:{baselayers:[{label:'合肥基础图层',type:'tiled',alpha:'1',visible:'true',url:'http://219.232.241.14:8399/arcgis/rest/services/foshan_res/MapServer'}],optlayers:[{label:'合肥资源图层',type:'dynamic',alpha:'1',visible:'true',url:'http://219.232.241.14:8399/arcgis/rest/services/foshan_zy/MapServer'}]},widgets:[],components:[{componentid:'HeaderWidget',url:'viewer.HeaderWidget'},{componentid:'TaskWidget',url:'viewer.TaskWidget'},{componentid:'StatusWidget',url:'viewer.StatusWidget'},{componentid:'ToolWidget',url:'viewer.ToolWidget'}]}";
		super.outmessage(json);
		return null;
	}
 
	@Override
	protected void prepareSaveModel() throws Exception {

	}

	@Override
	protected void prepareViewModel() throws Exception {

	}

	@Override
	public Object getModel() {
		return null;
	}

}
