package com.cabletech.core.action;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource; 
import org.apache.commons.lang.StringUtils; 
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import com.cabletech.baseinfo.business.Service.BaseInfoProvider;
import com.cabletech.baseinfo.business.entity.UserInfo;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
/**
 * 通用访问模块
 * 
 * @author Administrator
 * 
 */
@Namespace("/common")
@Results({ @Result(name = "regiontree", location = "/common/region_select.jsp") })
@Action("commonaccess")
public class CommonAccess extends BaseAction {
	private static final long serialVersionUID = 1L;
	@SuppressWarnings("rawtypes")
	public Map sessionManager; 
	@Resource(name = "baseInfoProvider")
	private BaseInfoProvider baseInfoProvider;
	/**
	 * 将单个对象转换成JSON对象
	 * 
	 * @param obj
	 *            Object
	 */
	private String datafomat = "yyyy-MM-dd HH:mm:ss";

	public String convertObjToJsonStr(Object obj) {
		try {
			Gson gson = new GsonBuilder().setDateFormat(this.datafomat)
					.create();
			return gson.toJson(obj);
		} catch (Exception e) {
			return "";
		}
	}

	/**
	 * 获取区域Action
	 * 
	 * @return
	 */
	public String getregion() {
		List<Map<String, Object>> list = getRegionList();
		String jsonstr = convertObjToJsonStr(list);
		request.getSession().setAttribute("regiontree", jsonstr);
		return "regiontree";
	}

	/**
	 * 获取区域List
	 * 
	 * @return
	 */
	private List<Map<String, Object>> getRegionList() {
		UserInfo user = super.getUser();
		String lv = request.getParameter("lv");// 级别
		if (!StringUtils.isNotBlank(lv)) {
			lv = "";
		}
		List<Map<String, Object>> regiongrouplist = baseInfoProvider
				.regionIteration(user.getRegionId(), lv);
		return regiongrouplist;

	}

	@Override
	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String execute() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected void prepareViewModel() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	protected void prepareSaveModel() throws Exception {
		// TODO Auto-generated method stub
		
	}
  
 

}
