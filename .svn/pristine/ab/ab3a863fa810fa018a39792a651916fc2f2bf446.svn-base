package com.cabletech.carmanager.action;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.cabletech.baseinfo.business.entity.UserInfo;
import com.cabletech.carmanager.service.CarLeaseService;
import com.cabletech.core.action.BaseAction;

/**
 * 车辆租赁查询
 * 
 * @author guixy 2011-6-11 新建
 *
 */
@Namespace("/carmanager")
@Results( {			
		@Result(name = "list", location = "/carmanager/carlease-list.jsp") })
@Action("carLeaseAction")
public class CarLeaseAction extends BaseAction {
	
	@Resource(name = "carLeaseServiceImpl")
	private CarLeaseService carLeaseService;

	@Override
	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String execute() {
		// TODO Auto-generated method stub
		return "list";
	}

	@Override
	protected void prepareViewModel() throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	protected void prepareSaveModel() throws Exception {
		// TODO Auto-generated method stub

	}
	
	/**
	 * 查询车辆租赁信息
	 * @throws Exception
	 */
	public String list() throws Exception {
		UserInfo user = (UserInfo) request.getSession().getAttribute("USER");
		String condition = request.getQueryString();		
		Map<String, Object> conditionMap = super.getDecodeCondtionMap(condition, user);		
		String methodName;
		if(user.isMobile()) {
			// 移动用户
			methodName = "getCarLeaseByMobile";
			if(StringUtils.isNotBlank(user.getDeptId())) {
				conditionMap.put("userdeptids", super.baseInfoProvider.getDeptService().searchAllChildren(user.getDeptId()));
			} else {
				conditionMap.put("userorgids", super.baseInfoProvider.getOrgService().searchAllChildren(user.getOrgId()));
			}
		} else {
			methodName = "getCarLeaseByContractor";
		}
		
		Map<String, Object> map = carLeaseService.queryPageMap(methodName, conditionMap, super.getPage("page"), super.getLimit("rows"));		
		request.setAttribute("map", map);
		request.setAttribute("conditionMap", conditionMap);
		request.setAttribute("condition", condition);
		return "list";
	}

}
