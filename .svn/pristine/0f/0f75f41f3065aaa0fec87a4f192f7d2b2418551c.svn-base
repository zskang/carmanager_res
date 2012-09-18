package com.cabletech.carassign.service;

import java.util.List;
import java.util.Map;

import com.cabletech.core.service.BaseService;

/**
 * 已分配车辆业务接口
 * 
 * @author 杨隽 2012-06-13 创建
 * 
 */
public interface CarAssignedService extends BaseService {
	/**
	 * 执行已分配车辆列表
	 * 
	 * @param condition
	 *            Map<String, Object> 查询条件参数Map
	 * @return List<Map<String, Object>> 车辆行程统计结果列表
	 */
	public List<Map<String, Object>> getAssignedCarList(
			Map<String, Object> condition);

	/**
	 * 执行车辆的回收
	 * 
	 * @param userOrgId
	 *            String 当前登录用户组织编号
	 * @param carId
	 *            String[] 回收车辆信息编号
	 */
	public void unAssignCar(String userOrgId, String[] carId);
}
