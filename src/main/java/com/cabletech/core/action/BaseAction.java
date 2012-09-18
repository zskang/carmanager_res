package com.cabletech.core.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.validator.GenericTypeValidator;
import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.cabletech.baseinfo.business.Service.BaseInfoProvider;
import com.cabletech.baseinfo.business.entity.UserInfo;
import com.cabletech.core.entity.config.GlobalConfigInfo;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

/**
 * Action基类
 * 
 * @author Administrator
 * @author 杨隽 2012-06-13 添加getUser()方法
 * 
 */
public abstract class BaseAction extends ActionSupport implements
		ModelDriven<Object>, ServletRequestAware, ServletResponseAware,
		Preparable {
	public Logger logger = Logger.getLogger(this.getClass());
	private static final long serialVersionUID = 1L;

	@Resource(name = "baseInfoProvider")
	protected BaseInfoProvider baseInfoProvider;

	@Resource(name = "globalConfigInfo")
	protected GlobalConfigInfo config;

	// 载入list页面
	public static final String LIST = "list";
	public static final String VIEW = "view";
	public static final String RELOAD = "reload";
	public HttpServletResponse response;

	public HttpServletRequest request;

	/**
	 * 抽象方法，获取实体
	 */
	public abstract Object getModel();

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	/**
	 * 抽象方法，struts的默认执行方法
	 */
	public abstract String execute();

	/**
	 * Action函数，显示新增或修改Entity界面。建议return INPUT。
	 */
	@Override
	public String input() throws Exception {
		return INPUT;
	}

	/**
	 * Action函数，显示Entity详细信息界面。 建议return VIEW。
	 */
	public String view() throws Exception {
		return VIEW;
	}

	/**
	 * 在input()前执行二次绑定。
	 */
	public void prepareInput() throws Exception {
		prepareViewModel();
	}

	/**
	 * 在search()前执行二次绑定。
	 */
	public void prepareSearch() throws Exception {
		prepareViewModel();
	}

	/**
	 * 在view()前执行二次绑定。
	 */
	public void prepareView() throws Exception {
		prepareViewModel();
	}

	/**
	 * 在view()前执行二次绑定。
	 */
	public void prepareSave() throws Exception {
		prepareSaveModel();
	}

	/**
	 * 在delete()前执行二次绑定
	 * 
	 * @throws Exception
	 */
	public void prepareDelete() throws Exception {
		prepareViewModel();
	}

	/**
	 * 等同于prepare()的内部函数，供prepardView()函数调用。
	 */
	protected abstract void prepareViewModel() throws Exception;

	/**
	 * 等同于prepare()的内部函数，供prepardView()函数调用。
	 */
	protected abstract void prepareSaveModel() throws Exception;

	/**
	 * 实现prepare接口的默认载入方法
	 * 
	 */
	public void prepare() throws Exception {

	}

	/**
	 * 获取页数
	 * 
	 * @param pagenum
	 *            页码
	 * @return int
	 */
	public int getPage(String pagenum) {
		// 获取从哪条记录开始
		String page = request.getParameter(pagenum);
		if (StringUtils.isBlank(page) || page.equals("0")) {
			return 1;
		} else {
			return GenericTypeValidator.formatInt(page);
		}
	}

	/**
	 * 获取每页记录数
	 * 
	 * @param offset
	 *            每页记录数
	 * @return int
	 */
	public int getLimit(String offset) {
		String limit = request.getParameter(offset);
		if (StringUtils.isBlank(limit)) {
			return 10;
		} else {
			return GenericTypeValidator.formatInt(limit);
		}
	}

	/**
	 * 返回模糊查询字符串
	 * 
	 * @param name
	 *            字符串名
	 * @return
	 */
	public String returnquerystring(String name) {
		if (StringUtils.isNotBlank(name)) {
			name = "%" + this.decodestring(name) + "%";
		} else {
			name = "%%";
		}
		return name;
	}

	/**
	 * 将指定的MAP转换为JSON数据 <br />
	 * 
	 * @param map
	 *            集合
	 */
	public void convertmaptojson(Map<String, Object> map) {
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		String json = gson.toJson(map).toLowerCase();
		logger.info(json);
		outmessage(json);
	}

	/**
	 * 将指定的List转换为JSON数据 <br />
	 * 
	 * @param list
	 *            列表
	 */
	public void convertmaptojson(List<Map<String, Object>> list) {
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		String json = gson.toJson(list).toLowerCase();
		logger.info(json);
		outmessage(json);
	}

	/**
	 * 通用action的消息输出
	 * 
	 * @param message
	 *            消息
	 * @return PrintWriter
	 */
	public PrintWriter outmessage(String message) {
		response.setCharacterEncoding("utf-8");
		PrintWriter out;
		try {
			out = response.getWriter();
			out.write(message);
			out.flush();
			out.close();
			return out;
		} catch (IOException ex) {
			logger.error("Action输出信息出错：", ex);
		}
		return null;
	}

	/**
	 * 获取JS传递字符时乱码的转换
	 * 
	 * @param str
	 *            字符串
	 * @return String
	 */
	public String converstringtoutf8(String str) {
		try {
			return new String(str.trim().getBytes("ISO-8859-1"), "UTF-8");
		} catch (Exception ex) {
			logger.error("字符串编码转换出错： ", ex);
		}
		return null;
	}

	/**
	 * 转码
	 * 
	 * @param str
	 *            字符串
	 * @return String
	 */
	public String decodestring(String str) {
		try {
			return java.net.URLDecoder.decode(str, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			logger.info("编码解析错误： ", e);
		}
		return "";
	}

	/**
	 * 将查询的结果转换为ajaxcombox需要的json数据格式的通用方法
	 * 
	 * @param querymap
	 *            結果map
	 * @param columnmap
	 *            条件Map，包含ID 和 NAME
	 * @return Map<String, Object>
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> converttoajaxcomboxjson(
			Map<String, Object> querymap, Map<String, Object> columnmap) {
		List<Map<String, Object>> list = (List<Map<String, Object>>) querymap
				.get("rows");
		int total = GenericTypeValidator.formatInt(querymap.get("total")
				.toString());
		Map<String, Object> combojson = new HashMap<String, Object>();
		String[] primarykey = new String[list.size()];
		String[] candidate = new String[list.size()];
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> listmap = list.get(i);
			primarykey[i] = listmap.get(columnmap.get("id").toString())
					.toString();
			candidate[i] = listmap.get(columnmap.get("name").toString())
					.toString();
		}
		combojson.put("cnt_page", Math.ceil(total / getLimit("per_page")));
		combojson.put("candidate", candidate);
		combojson.put("primary_key", primarykey);
		combojson.put("cnt", total);
		return combojson;
	}

	/**
	 * 获取参数公共方法
	 * 
	 * @param parameter
	 *            参数
	 * @return String
	 */
	public String getParameterValue(String parameter) {
		String str = "";
		if (StringUtils.isNotBlank(request.getParameter(parameter))) {
			str = request.getParameter(parameter);
		}
		return str;
	}

	/**
	 * 将map转换为通用附加参数的形式
	 * 
	 * @param map
	 *            条件
	 * @return String
	 */
	public String convertMaptoParameter(Map<String, Object> map) {
		StringBuffer param = new StringBuffer();
		Iterator<String> iterator = map.keySet().iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			String value = (String) map.get(key);
			if (map.get(key) == null) {
				value = "";
			} else {
				value = value.replaceAll("%", "");
			}
			param.append(key + "=" + value + "&");
		}
		String parameter = param.substring(0, param.lastIndexOf("&"))
				.toString();
		return parameter;
	}

	/**
	 * 去掉模糊查询的%
	 * 
	 * @param map
	 *            条件
	 * @return Map<String, Object>
	 */
	public Map<String, Object> removeLikeString(Map<String, Object> map) {
		Map<String, Object> removemap = new HashMap<String, Object>();
		Iterator<String> iterator = map.keySet().iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			String value = (String) map.get(key);
			value = value.replaceAll("%", "");
			removemap.put(key, value);
		}
		return removemap;
	}

	/**
	 * 将查询参数解码
	 * 
	 * @param condition
	 *            参数条件
	 * @param user
	 *            登录用户
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getDecodeCondtionMap(String condition,
			UserInfo user) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(condition)) {
			String[] decodeConditions = java.net.URLDecoder.decode(condition,
					"utf-8").split("&");
			for (int i = 0; i < decodeConditions.length; i++) {
				String[] params = decodeConditions[i].split("=");
				if (params.length > 1) {
					map.put(params[0], params[1] == null ? "" : params[1]);
				} else {
					map.put(params[0], "");
				}
			}
			map.remove("serializeQueryCondition");
		}
		List<String> regionids = new ArrayList<String>();
		List<String> orgids = new ArrayList<String>();
		if (user.isMobile()) {
			regionids = baseInfoProvider.getRegionService().getRegionIdList(
					user.getUserId());
			map.put("regionids", regionids);
		} else {
			orgids = baseInfoProvider.getOrgService().getOrgIdList(
					user.getUserId());
			map.put("orgids", orgids);
		}
		return map;
	}

	/**
	 * 获取会话中登录用户信息
	 * @return UserInfo 会话中登录用户信息
	 */
	public UserInfo getUser() {
		UserInfo userInfo = (UserInfo) request.getSession()
				.getAttribute("USER");
		return userInfo;
	}
	
	
	
	/**
	 * 设置提示信息
	 * @param messageKey 信息KEY
	 * @param message 信息
	 */
	protected void setTipMessage(String messageKey,String message){
		 request.getSession().setAttribute(messageKey,message);
	}
	/**
	 * 
	 * 显示提示信息
	 * @param messageKey 信息KEY
	 */
	protected void revealTipMessage(String messageKey){
		String message = "";
		if(null != request.getSession().getAttribute(messageKey)){
			message = (String) request.getSession().getAttribute(messageKey);
			request.getSession().removeAttribute(messageKey);
		}
		request.setAttribute(messageKey, message);
	}
	
}