package com.cabletech.carassign.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.cabletech.baseinfo.base.DateUtil;
import com.cabletech.baseinfo.business.Service.BaseInfoProvider;
import com.cabletech.carassign.mapper.CarUnAssignMapper;
import com.cabletech.core.service.BaseServiceImpl;

/**
 * 
 * 未分配车辆接口实现
 * 
 * @author wj
 * 
 * 2012-06-13
 * 
 *
 */
@Service
public class CarUnAssignServiceImpl extends BaseServiceImpl implements CarUnAssignService{
	
	@Resource(name = "carUnAssignMapper")
	private CarUnAssignMapper carUnAssignMapper;
	
	@Resource(name = "baseInfoProvider")
	private BaseInfoProvider baseInfoProvider;
	
	
	
	/**
	 * 查询未分配车辆
	 * 
	 * @param condition Map<String, Object> 查询条件参数Map
	 * @return List<Map<String, Object>> 未分配车辆列表
	 */
	public List<Map<String, Object>> getUnAssignCars(Map<String, Object> condition){
		return carUnAssignMapper.getUnAssignCars(condition);
	}
	
	/**
	 * 分配车辆
	 * 
	 * @param condition Map<String, Object> 参数Map
	 */
	public void assignCars(Map<String, Object> condition){
		String[] carIds = (String[]) condition.get("carIds");

		condition.remove("carIds");
		for(String carId:carIds){
			condition.put("carId", carId);
			carUnAssignMapper.assignCars(condition);
			assignCarsHis(condition);//记录历史
		}
	}
	
	/**
	 * 分配车辆历史记录
	 * 
	 * @param condition Map<String, Object> 参数Map
	 */
	public void assignCarsHis(Map<String, Object> condition){
		String carId = (String) condition.get("carId");
		String userOrgId = (String) condition.get("userOrgId");
		String userDeptId = (String) condition.get("userDeptId");
		String assignOrgId = (String) condition.get("assignOrgId");
		String assignUserName = (String) condition.get("assignUserName");
		String userOrgName = (String) baseInfoProvider.getOrgMap(userOrgId).get("ORGANIZENAME");
		String userDeptName = (String) baseInfoProvider.getDeptService().getDeptBaseInfo(userDeptId).get("DEPTNAME");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", this.getXTBH());
		map.put("carId", carId);
		map.put("assignDate",DateUtil.getNowDate());
		map.put("userOrgName", userOrgName);
		map.put("userDeptName", userDeptName);
		map.put("assignUserName", assignUserName);
		carUnAssignMapper.assignCarsHis(map);
	}
}