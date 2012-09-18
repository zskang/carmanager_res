package com.cabletech.carmanager.service;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cabletech.baseinfo.business.entity.UserInfo;
import com.cabletech.carmanager.entity.CarInfoEntity;
import com.cabletech.core.service.BaseService;

/***
 * 车辆事务类接口
 * @author 陆道伟 2012 -6-12
 * @author guixy 2012-6-18 重构代码
 *
 */
public interface CarInfoService extends BaseService {
	
	/**
	 * 查询车辆信息列表的方法
	 * @param condition 查询条件
	 * @return
	 */
	public List<Map<String ,Object>> getbymap(Map<String ,Object> condition);	
	
	/**
	 * 得到所有车辆的信息
	 * @return
	 */
	public List<Map<String,Object>>getallitem();
	
	/**
	 * 保存车辆信息
	 * @param carinfo 车辆信息
	 * @param user 当前登录人员
	 * @return
	 */
	public Integer create(CarInfoEntity carinfo, UserInfo user);
	
	/**
	 * 取得车辆信息实体
	 * @param id 车辆ID
	 * @return
	 */
	public CarInfoEntity getbyid(String id);
	
	/**
	 * 更新车辆信息
	 * @param carinfo 车辆信息
	 * @param user 登录用户
	 * @return
	 */
	public Integer update(CarInfoEntity carinfo, UserInfo user);
	
	/**
	 * 保存车辆分配表
	 * @param carId 车辆ID
	 * @param user 登录用户
	 * @return
	 */
	public Integer insertCarAssign(String carId, UserInfo user);
	
	/**
	 * 删除车辆信息
	 * @param id 车辆ID
	 * @return
	 */
	public Integer deleteCarassignEntity(String id);
	
	
	/**
	 * 删除车辆分配信息
	 * @param id 车辆ID
	 * @return
	 */
	public Integer deleteCarInfoEntity(String id);
	
	/**
	 * 根据车辆编号获取车辆的详细信息
	 * 
	 * @param carId
	 *            String 车辆编号
	 * @return Map<String, Object> 车辆的详细信息
	 */
	public Map<String, Object> viewCarInfo(String carId);
	
	/**
	 * 更新车使用状态
	 * @param hashmap 条件
	 */
	public void updateCarUser(HashMap<String,Object> hashmap);	
	
	
	/**
	 * 判断添加、修改车辆的sim卡对应的在库在是不是已存在
	 * @param simId sim卡号
	 * @param carId 车辆ID
	 * @return
	 */
	public int isExistsSimId(String simId, String carId);
	
	/**
	 * 判断添加、修改车辆的CarNo对应的在库在是不是已存在
	 * @param carNo 车牌号
	 * @param carId 车辆ID
	 * @return
	 */
	public int isExistsCarNo(String carNo, String carId);
	
}
