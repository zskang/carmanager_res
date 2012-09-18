package com.cabletech.carassign.service;

import java.util.List;
import java.util.Map;

import com.cabletech.core.service.BaseService;
/**
 * 
 * 未分配车辆接口
 * 
 * @author wj
 * 
 * 2012-06-13
 * 
 *
 */
public interface CarUnAssignService extends BaseService {
	
	/**
	 * 查询未分配车辆
	 * 
	 * @param condition Map<String, Object> 查询条件参数Map
	 * @return List<Map<String, Object>> 未分配车辆列表
	 */
	public List<Map<String, Object>> getUnAssignCars(Map<String, Object> condition);
	
	/**
	 * 分配车辆
	 * 
	 * @param condition Map<String, Object> 参数Map
	 */
	public void assignCars(Map<String, Object> condition);
	
	
	/**
	 * 分配车辆历史记录
	 * 
	 * @param condition Map<String, Object> 参数Map
	 */
	public void assignCarsHis(Map<String, Object> condition);
}
