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
import com.cabletech.carassign.service.CarUnAssignService;
import com.cabletech.core.action.BaseAction;
import com.cabletech.core.entity.config.GlobalConfigInfo;

/**
 * 
 * 未分配车辆
 * @author wj
 * 2012-06-13
 *
 */
@Namespace("/carassign")
@Results({ @Result(name = "list", location = "/carassign/car-unassign-list.jsp"),
@Result(name = "reload", location = "carUnAssignAction!unAssignCars.action", type = "redirect")
})
@Action("carUnAssignAction")
public class CarUnAssignAction extends BaseAction{

	/**
	 * 序列化编号
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 车辆行程统计业务
	 */
	@Resource(name = "carUnAssignServiceImpl")
	private CarUnAssignService carUnAssignService;
	/**
	 * 全局配置信息实体
	 */
	@Resource(name = "globalConfigInfo")
	private GlobalConfigInfo configInfo;

	@Override
	public String execute() {
		return null;
	}

	/**
	 * 未分配的列表
	 * @return
	 * @throws Exception
	 */
	public String unAssignCars() throws Exception {
		Map<String, Object> condition = this.initCondition();
		Map<String, Object> map = carUnAssignService.queryPageMap("getUnAssignCars", condition,super.getPage("page"), super.getLimit("rows"));
		request.setAttribute("map", map);
		request.setAttribute("condition", condition);
		revealTipMessage("assignCarsMessage");//取出信息用于前台获取
		return LIST;
	}
	
	/**
	 * 分配车辆
	 * @return
	 * @throws Exception
	 */
	public String assignCars() throws Exception {
		String[] carIds = request.getParameterValues("checkbox_car_id");
		String userOrgId = request.getParameter("assign_org_id");
		String userDeptId = request.getParameter("assign_dept_id");
		String assignOrgId = getUser().getOrgId();
		String assignUserName = this.getUser().getUserName();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("carIds", carIds);
		map.put("userOrgId", userOrgId);
		map.put("userDeptId", userDeptId);
		map.put("assignOrgId", assignOrgId);
		map.put("assignUserName", assignUserName);
		carUnAssignService.assignCars(map);
		setTipMessage("assignCarsMessage","车辆分配成功");//设置提示信息
		return this.RELOAD;
	}

	/**
	 * 封装查询条件
	 * @return Map
	 */
	private Map<String, Object> initCondition() {
		Map<String, Object> map = new HashMap<String, Object>();
		UserInfo userInfo = super.getUser();
		String qStr = "";
		String carNo = request.getParameter("carNo");//车牌号 CARNO   carNo
		String carType = request.getParameter("carType");//车型      CARTYPE carType
		String mentor = request.getParameter("mentor");//司机      MENTOR mentor  
		String contractorId = request.getParameter("contractorId");//所属公司 CONTRACTORID contractorId
		if(StringUtils.isNotBlank(carNo))qStr += "carNo="+carNo;
		if(StringUtils.isNotBlank(carType))qStr += "&carType="+carType;
		if(StringUtils.isNotBlank(mentor))qStr += "&mentor="+mentor;
		if(StringUtils.isNotBlank(contractorId))qStr += "&contractorId="+contractorId;
		map.put("useOrgId", userInfo.getOrgId());//使用单位
		map.put("assignOrgId", userInfo.getOrgId());//所用单位
		map.put("carNo", carNo);//车牌号 CARNO   carNo
		map.put("carType", carType);//车型      CARTYPE carType
		map.put("mentor", mentor);//司机      MENTOR mentor  
		map.put("contractorId", contractorId);//所属公司 CONTRACTORID contractorId
		map.put("qStr", qStr);//所属公司 CONTRACTORID contractorId
		return map;
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
}