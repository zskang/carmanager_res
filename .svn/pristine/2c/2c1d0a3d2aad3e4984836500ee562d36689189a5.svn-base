package com.cabletech.login.action; 

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.cabletech.baseinfo.business.Service.BaseInfoProvider;
import com.cabletech.baseinfo.business.entity.UserInfo;
import com.cabletech.core.action.BaseAction;
import com.cabletech.login.service.UserInfoService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


/**
 * 接收用户登录信息
 *  
 * @author Administrator
 * 
 */

@Namespace("/")
@Results( { @Result(name = "success", location = "/index.jsp"),
		@Result(name = "error", location = "/error.jsp"),
		@Result(name = "login", location = "/login.jsp", type = "redirect") })
@Action("login")
public class LoginAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Resource(name = "userInfoServiceImpl")
	private UserInfoService userinfoservice;

	@Resource(name = "baseInfoProvider")
	private BaseInfoProvider baseInfoProvider;

	private UserInfo entity;


	/**
	 * 消息注销方法
	 * @return
	 */
	public String logout() {
		this.request.getSession().removeAttribute("USER");
		return "login";
	}

	/* (non-Javadoc)
	 * @see com.cabletech.core.action.BaseAction#execute()
	 */
	@Override
	public String execute() {
		String userid = super.getParameterValue("userid");
		String password = super.getParameterValue("password");
		UserInfo userinfo = null;
		if ("".equals(userid)) {
			userinfo = (UserInfo) request.getSession().getAttribute("USER");
		} else {
			userinfo = baseInfoProvider.getUserInfoByUserIdAndPassword(userid, password);
			request.getSession().setAttribute("USER", userinfo);
		}
		if (userinfo == null) {
			return "error";
		}
		List<Map<String, Object>> menuList = new ArrayList<Map<String, Object>>();
		menuList = baseInfoProvider.getMenuList(userinfo.getUserId(), "",
				"XJCZ");
		String menujson = convertMapToJson(menuList);
		request.setAttribute("menujson", menujson);
		request.setAttribute("userid", userid);
		return SUCCESS;
	}
	
	/**
	 * 将List对象转换成json
	 * @param list 对list象
	 * @return
	 */
	public String convertMapToJson(List<Map<String, Object>> list) {
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		String json = gson.toJson(list);
		return json;
	}

	/**
	 * 取用户消息
	 * @deprecated 获取用户信息
	 * @return
	 */
	public String getUserInfo() {
		String userid = request.getParameter("id").trim();
		String password = request.getParameter("password");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		map.put("password", password);
		UserInfo entity = userinfoservice.searchloginuser(map);
		request.getSession().setAttribute("USER", entity);
		request.getSession().setAttribute("user", entity);
		return null;
	}


	@Override
	protected void prepareSaveModel() throws Exception {

	}

	@Override
	protected void prepareViewModel() throws Exception {

	}

	@Override
	public UserInfo getModel() {
		return entity;
	}

}
