package com.cabletech.googlemap.action;

import java.io.IOException;
import java.io.PrintWriter;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.rpc.ServiceException;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import com.cabletech.baseinfo.base.BaseConfig;
import com.cabletech.baseinfo.business.Service.BaseInfoProvider;
import com.cabletech.baseinfo.business.entity.UserInfo;
import com.opensymphony.xwork2.ActionSupport;


/**
 * 外部资源访问接口--action
 * 
 * (通用权限：  CommonContractor
 *  基础信息：  BaseinfoModel
 *  流程服务：  flowService)
 * 
 * 
 * @author wangjie
 * @since 2011-10-09
 * 
 * 
 * **/
@Namespace("/common")
@Action("externalResources")
public class ExternalResourcesAccessAction extends ActionSupport implements
ServletRequestAware, ServletResponseAware{
	
	private static final long serialVersionUID = 5767952220675870501L;
	private Logger logger = Logger.getLogger("ExternalResourcesAccessService");

	@Resource(name = "baseInfoProvider")
    private BaseInfoProvider baseInfoProvider;

	public HttpServletResponse response;

	public HttpServletRequest request;
	private static final String CONTRACTOR_USER_TYPE = "2";
	
	
	/**
	 * 获取区域
	 * @throws Exception
	 */
	public void getRegionJson() throws Exception{
		UserInfo user = (UserInfo)request.getSession().getAttribute("USER");
		String userRegionId = user.getRegionId();
		String parentid = StringUtils.isBlank(request.getParameter("node"))?"000000":request.getParameter("node");
		String nodeid = "";
		if("000000".equals(parentid)){
			parentid= "";
			nodeid = userRegionId;
		}else{
			nodeid = "";
		}
		String content =  baseInfoProvider.getRegionJson(parentid,nodeid,BaseConfig.EASYUI_JSON_TYPE);
		outmessage(content);
	}
	
	/**
	 *  获取所在机构及下属机构 objtype='ORG' 只显示组织 orgtype 1、2,1为移动，2为代维，不传为所有 objtype='ORG'  orgtype
	 * @throws ServiceException
	 */
	public void getOrgDeptUserJson() throws Exception {
		UserInfo user = (UserInfo)request.getSession().getAttribute("USER");
		String roleid = user.getOrgtType();
		String regionid = request.getParameter("regionid");// 区域ID
		String objtype = request.getParameter("objtype");
		String orgtype = request.getParameter("orgtype");
		String node = request.getParameter("node");// 组织ID
		String lv = request.getParameter("lv");// 组织ID
		regionid = StringUtils.isBlank(regionid)?"":regionid;
		objtype = StringUtils.isBlank(objtype)?"":objtype;
		orgtype = StringUtils.isBlank(orgtype)?"":orgtype;
		if (StringUtils.isBlank(node)) {
			if(CONTRACTOR_USER_TYPE.equals(roleid)){
				node = user.getOrgId();
			}else{
				node = "";
			}
		}
		node = StringUtils.isBlank(lv)?"":node;
		String content =  baseInfoProvider.getOrgDepUserJson(node, regionid,  orgtype,lv,"1");
		outmessage(content);
	}
	
	/**
	 *  获取所在机构及下属机构 objtype='ORG' 只显示组织 orgtype 1、2,1为移动，2为代维，不传为所有  objtype='ORG'  orgtype
	 * @throws ServiceException
	 */
	public void getPatrolmanUserJson() throws Exception {
		String regionid = request.getParameter("regionid");// 区域ID
		if (!StringUtils.isNotBlank(regionid)) {
			regionid = "";
		}
		String objtype = request.getParameter("objtype");
		if (!StringUtils.isNotBlank(objtype)) {
			objtype = "";
		}
		String orgtype = request.getParameter("orgtype");
		if(!StringUtils.isNotBlank(orgtype)) {
			orgtype = "";
		}
		String node = request.getParameter("node");// 组织ID
		if (!StringUtils.isNotBlank(node)) {
			node = "";
		}
		String lv = request.getParameter("lv");// 级数
		if (!StringUtils.isNotBlank(lv)) {
			node = "";
		}
		String content =  baseInfoProvider.getUserJson( regionid,"","","1","");
		outmessage(content);
	}
	
	/**
	 * 字典
	 * @throws ServiceException
	 */
	public void getDictionaryJson() throws Exception {
		String type = request.getParameter("type");
		String content =  baseInfoProvider.getDicJson(type);
		logger.debug(content);
		outmessage(content);
	}
	

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	@Override
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}
	
	/**
	 * 输出消息
	 * @param message 消息
	 * @return 流
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
}