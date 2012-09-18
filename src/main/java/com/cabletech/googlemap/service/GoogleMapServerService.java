package com.cabletech.googlemap.service;

import java.util.List;
import java.util.Map;
import com.cabletech.core.service.BaseService;

/**
 * 地图服务
 */
public interface GoogleMapServerService extends BaseService{
	
	/**
	 * 根据SIM卡号获取车辆信息
	 * @param map 信息
	 * @return 结果
	 */
	public List<Map<String, Object>> getCarInfo(Map<String, Object> map);	
	
	/**
	 * 获取历史位置信息
	 * @param map 信息
	 * @return 结果
	 */
	public List<Map<String, Object>> getHistoryPositions(Map<String, Object> map);
	
	/**
	 * 搜索车辆
	 * @param map 查询参数
	 * @return
	 */
	public List<Map<String, Object>> searchCars(Map<String, Object> map);
	
	/**
	 * 获取车辆信息
	 * @param map 信息
	 * @return 结果
	 */
	public List<Map<String, Object>> getMentors(Map<String, Object> map);
	
	/**
	 * 获取位置并播放
	 * @param map 信息
	 * @return 结果
	 */
	public List<Map<String, Object>> getPositionAndDisplay(Map<String, Object> map);
	
	/**
	 * 展现车辆某段时间地图轨迹
	 * @param map 信息
	 * @return 结果
	 */
	public List<Map<String, Object>> getLocus(Map<String, Object> map);
	
	/**
	 * 获取区域信息
	 * @param map 信息
	 * @return 结果
	 */
	public List<Map<String, Object>> getRegions(Map<String, Object> map);
	
	/**
	 * 获取在线车辆
	 * @param map 信息
	 * @return 结果
	 */
	public List<Map<String, Object>> getOnlineCarsInfo(Map<String, Object> map);
	
}
