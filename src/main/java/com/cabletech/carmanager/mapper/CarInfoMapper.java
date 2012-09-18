package com.cabletech.carmanager.mapper;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cabletech.carmanager.entity.CarInfoEntity;
import com.cabletech.carmanager.entity.CarassignEntity;


/***
 * 车辆信息Mapper
 * @author 陆道伟 2012-6-15
 *
 */
public interface CarInfoMapper {
	
	
	/***
	 *                  通过一个Map的集合查询车辆信息
	 *         返回车辆信息
	 * @param condition 查询条件
	 * @return   List<Map<String ,Object>>
	 */
	public List<Map<String ,Object>> getbymap(Map<String ,Object> condition);
	
	
	
	/****
	 *        得到所有车辆的信息
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String,Object>>getallitem();
	
	/****
	 *     添加车辆信息
	 * @param   carinfo 车辆信息
	 * @return  Integer
	 */
	public Integer create(CarInfoEntity carinfo);
	
	/***
	 *  插入车辆分配表
	 * @param carassignentity 分配实体
	 * @return  Integer
	 */
	public Integer insertCarAssign(CarassignEntity carassignentity);
	
	
	/***
	 *   通过id得到车辆信息
	 * @param id 车辆ID
	 * @return  CarInfoEntity
	 */
	public CarInfoEntity getbyid(String id);
	
	
	/***
	 *              修改车辆信息
	 * @param carinfo 车辆信息
	 * @return  Integer
	 */
	public Integer update(CarInfoEntity carinfo);
	
	/***
	 *       删除车辆分配表的信息
	 * @param id 车辆ID
	 * @return
	 */
	public Integer deleteCarassignEntity(String id);
	
	
	/***
	 *       删除车辆信息
	 * @param id 车辆ID
	 * @return
	 */
	public Integer deleteCarInfoEntity(String id);
	
	/**
	 * 根据车辆编号获取车辆的详细信息
	 * 
	 * @param carId
	 *            String 车辆编号
	 * @return List<Map<String, Object>> 车辆的详细信息
	 */
	public List<Map<String, Object>> viewCarInfo(String carId);
	
	/**
	 * 取得车辆分配信息
	 * @param carId String 车辆编号
	 * @return String 分配ID
	 */
	public String getCarAssignByCarId(String carId);
	
	/**
	 * 更新汽车使用状态
	 * @param hashMap 参数
	 */
	public void updateCarUser(HashMap<String ,Object> hashMap);
	
	/**
	 * 判断添加、修改车辆的sim卡对应的在库在是不是已存在
	 * @param map 查询条件
	 * @return
	 */
	public int isExistsSimId(Map<String, String> map);
	
	/**
	 * 判断添加、修改车辆的车牌号对应的在库在是不是已存在
	 * @param map 查询条件
	 * @return
	 */
	public int isExistsCarNo(Map<String, String> map);
}
