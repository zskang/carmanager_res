package com.cabletech.carassign.action;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.cabletech.baseinfo.business.entity.UserInfo;
import com.cabletech.carassign.service.CarAssignedService;
import com.cabletech.core.action.BaseAction;

/**
 * 已分配车辆Action  
 * 
 * @author 杨隽 2012-06-13 创建
 * 
 */
@Namespace("/carassign")
@Results({
		@Result(name = "list", location = "/carassign/car-assigned-list.jsp"),
		@Result(name = "reload", location = "/carassign/carAssignedAction!list.action", type = "redirect") })
@Action("carAssignedAction")
public class CarAssignedAction extends BaseAction {
	/**
	 * 序列化编号
	 */
	private static final long serialVersionUID = 0L;
	/**
	 * 车辆行程统计业务
	 */
	@Resource(name = "carAssignedServiceImpl")
	private CarAssignedService carAssignedService;

	@Override
	public String execute() {
		return null;
	}

	/**
	 * 进入已分配车辆列表页面
	 * 
	 * @return String
	 * @throws Exception
	 */
	public String list() throws Exception {
		Map<String, Object> map = initCondition();
		Map<String, Object> carList = carAssignedService.queryPageMap(
				"getAssignedCarList", map, super.getPage("page"),
				super.getLimit("rows"));
		request.setAttribute("map", carList);
		request.setAttribute("condition", map);
		revealTipMessage("unAssignCarsMessage");
		return LIST;
	}

	/**
	 * 进行车辆的回收
	 * 
	 * @return String
	 * @throws Exception
	 */
	public String unAssign() throws Exception {
		UserInfo userInfo = super.getUser();
		String[] carId = request.getParameterValues("carId");
		carAssignedService.unAssignCar(userInfo.getOrgId(), carId);
		setTipMessage("unAssignCarsMessage", "车辆回收成功！");
		return RELOAD;
	}

	@Override
	public Object getModel() {
		return null;
	}

	@Override
	protected void prepareSaveModel() throws Exception {
	}

	@Override
	protected void prepareViewModel() throws Exception {
	}

	/**
	 * 初始化查询条件Map
	 * 
	 * @return Map<String, Object> 查询条件Map
	 */
	private Map<String, Object> initCondition() {
		Map<String, Object> map = new HashMap<String, Object>();
		UserInfo userInfo = super.getUser();
		StringBuffer queryString = new StringBuffer("");
		map.put("userOrgId", userInfo.getOrgId());
		processParamValue(map, queryString, "departId");
		processParamValue(map, queryString, "orgId");
		processParamValue(map, queryString, "carNo");
		processParamValue(map, queryString, "mentor");
		processParamValue(map, queryString, "carType");
		map.put("querystring", queryString.toString());
		return map;
	}

	/**
	 * 将request中的参数值放入查询条件Map，并构建查询QueryUri
	 * 
	 * @param map
	 *            Map<String, Object> 查询条件Map
	 * @param queryString
	 *            StringBuffer 查询条件的queryUri
	 * @param key
	 *            String 参数
	 */
	private void processParamValue(Map<String, Object> map,
			StringBuffer queryString, String key) {
		String value = request.getParameter(key);
		map.put(key, value);
		if (StringUtils.isNotBlank(value)) {
			queryString.append("&" + key + "=" + value);
		}
	}
}
