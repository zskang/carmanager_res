package com.cabletech.carassign.mapper;

import java.util.List;
import java.util.Map;

/**
 * 已分配车辆Mapper
 * 
 * @author 杨隽 2012-06-13 创建
 * 
 */
public interface CarAssignedMapper {
	/**
	 * 获取已分配车辆列表
	 * 
	 * @param condition
	 *            Map<String, Object> 查询条件参数Map
	 * @return List<Map<String, Object>> 已分配车辆列表
	 */
	public List<Map<String, Object>> getAssignedCarList(
			Map<String, Object> condition);

	/**
	 * 获取回收车辆的分配信息
	 * 
	 * @param carId
	 *            String 回收车辆的编号
	 * @return List<Map<String, Object>> 回收车辆的分配信息
	 */
	public List<Map<String, Object>> getAssignedCarById(String carId);

	/**
	 * 进行车辆的回收（使用部门的组织回收正在使用的车辆）
	 * 
	 * @param condition
	 *            Map<String, Object> 回收条件参数Map
	 */
	public void unAssignCarByUseDepart(Map<String, Object> condition);

	/**
	 * 进行车辆的回收（分配的组织回收未使用的车辆）
	 * 
	 * @param condition
	 *            Map<String, Object> 回收条件参数Map
	 */
	public void unAssignCarByAssignOrg(Map<String, Object> condition);

	/**
	 * 进行车辆的回收（添加车辆的组织回收未使用的车辆）
	 * 
	 * @param condition
	 *            Map<String, Object> 回收条件参数Map
	 */
	public void unAssignCarByAddOrg(Map<String, Object> condition);
}
