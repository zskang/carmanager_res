package com.cabletech.carapplydispatch.mapper;

import java.util.List;
import java.util.Map; 

/***
 * 调度Mapper接口
 * 
 * @author 杨隽 2012-07-04 创建
 * 
 */
public interface CarScheduleMapper {
	/**
	 * 
	 * @param id
	 *            String
	 */
	public void updateCarScheduleSendState(String id);

	/**
	 * 
	 * 
	 * @return List<Map<String,Object>>
	 */
	public List<Map<String, Object>> selectRunningCar();

	/**
	 * 
	 * 
	 * @param id
	 *            String
	 * @return List<Map<String, Object>>
	 */
	public List<Map<String, Object>> selectCarScheduleTask(String id);
}
