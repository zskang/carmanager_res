package com.cabletech.core.mapper;

import java.util.Map;
import org.apache.ibatis.annotations.Select;

/**
 * 基础mapper
 * 
 * @author lvrenzhao 2012-05-22
 */
public interface BaseMapper {

	/**
	 * 获取系统编号序列
	 * @return
	 */
	@Select("select lpad(SEQ_CARINFO_ID.NEXTVAL,12,'0') as ID from dual")
	String getXTBH();	

	/**
	 * 获取SDE OBJECTID
	 * @param map 需要获取OBJECTID的表名称
	 * @return String 返回系统ID的序列
	 */
	public String getObjectID(Map<String,Object> map);
	
	/**
	 * 获取SDE插入几何字段时需要的SRID
	 * @param map 需要获取OBJECTID的表名称
	 * @return String 存储空间字段
	 */
	public String getSRID(Map<String,Object> map);
}
