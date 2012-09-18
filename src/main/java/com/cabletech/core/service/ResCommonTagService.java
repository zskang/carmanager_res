package com.cabletech.core.service;

import java.util.List;
import java.util.Map;
/**
 * 自定义标签
 * @author Administrator
 *
 */
public interface ResCommonTagService extends BaseService {
	/**
	 * 获取显示字段
	 * @param map ｛关键字段名称、关键字段值、表名称、待显示字段名称｝
	 * @return
	 */	
	public String getKeyColumnDisplayName(Map<String, Object> map);
	
	/**
	 * 获取资源数据
	 * @param map 传入sql
	 * @return
	 */
	public List<Map<String, Object>> fetchResourceData(Map<String, Object> map);
	
	/**
	 * 获取2种资源数据
	 * @param map 传入sql
	 * @return
	 */
	public List<Map<String, Object>> fetchMutiResourceData(Map<String, Object> map);	
	
}
