package com.cabletech.core.mapper;

import java.util.List;
import java.util.Map;

/**
 * 标签显示 资源的 名称和 XTBH
 * @author zhanghaibo 2012-05-11
 *
 */
public interface ResCommonTagMapper {
	/**
	 * 获取显示字段
	 * @param map ｛关键字段名称、关键字段值、表名称、待显示字段名称｝
	 * @return
	 */	
	public String getDisplayName(Map<String, Object> map);
	
	/**
	 * 获取资源数据
	 * @param map 传入sql
	 * @return
	 */
	public List<Map<String, Object>> searchResourceData(Map<String, Object> map);
	
	/**
	 * 获取2种资源数据
	 * @param map 传入sql
	 * @return
	 */
	public List<Map<String, Object>> searchMutiResourceData(Map<String, Object> map);	
	
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
