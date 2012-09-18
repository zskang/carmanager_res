package com.cabletech.carapplydispatch.service;

import java.util.List;
import java.util.Map;

import com.cabletech.carapplydispatch.entity.CarAndCardispatchEntity;
import com.cabletech.carapplydispatch.entity.CarApplyDispatchEntity;
import com.cabletech.core.service.BaseService;

/**
 * 调度单业务接口
 * @author Administrator
 *
 */
public interface CarApplyDispatchService extends BaseService {
	/**
	 * 查询车辆申请调度单
	 * @param condition 条件
	 * @return
	 */
	public Map<String, Object> selectCarApplyDispatch(
			Map<String, Object> condition);

	/**
	 * 保存调度单
	 * @param applydispatchentity 调度单实体
	 * @return
	 */
	public Integer insertCarApplyDispatch(
			CarApplyDispatchEntity applydispatchentity);

	/**
	 * 保存手机申请至数据库中
	 * @param applydispatchentity 调度单实体
	 * @return
	 */
	public Integer insertCarApplyDispatchByMobile(
			CarApplyDispatchEntity applydispatchentity);

	/**
	 * 根据要找手机号码
	 * @param userid 用户ID
	 * @return
	 */
	public String selectPhoneById(String userid);

	
	/**
	 * 根据手机号找用户
	 * @param phone 手机号
	 * @return
	 */
	public  Map<String, Object>  selectUserByPhone(String phone); 

 
	/**
	 * 选择没有使用过的车辆
	 * @param mps 参数
	 * @return
	 */
	@SuppressWarnings("rawtypes") 
	public List<Map<String, String>> selectUnusedCar(Map<String, Object> mps);

	/**
	 * 取调度单
	 * @param id 调度单ID
	 * @return
	 */
	public CarApplyDispatchEntity selectCarDispatchById(String id);

	/**
	 * 更新调度单
	 * @param entity 调度单实体
	 * @return
	 */
	public Integer updateCarDispatch(CarApplyDispatchEntity entity);

	/**
	 * 更新车辆状态
	 * @param carno 车辆ID
	 * @return
	 */
	public Integer updateCarUnused(String carno);
	
	/**
	 * 更新车辆使用状态
	 * @param carno 车辆ID
	 * @return
	 */
	public Integer updateCarUsed(String carno);

	/**
	 * 查询调度车辆信息
	 * @param condition 条件
	 * @return
	 */
	public Map<String, Object> selectCarApplyDispatched(
			Map<String, Object> condition);

	/**
	 * 查询车辆及车辆调度
	 * @param id 车辆ID
	 * @return
	 */
	public CarAndCardispatchEntity selectCarAndCarDispatche(String id);

	/**
	 * 调回
	 * @param entity 实体
	 * @return
	 */
	public Integer backed(CarApplyDispatchEntity entity);

	/**
	 * 取得调单号
	 * @param mps 条件
	 * @return
	 */
	public String GeneralDispCode(Map<String, Object> mps);

	/**
	 * 更表车辆调度单号
	 * @param mp 参数
	 * @return
	 */
	public Integer updateDispCode(Map<String,Object> mp);

	/**
	 * 根据调单取调度单
	 * @param dispCode 调度单
	 * @return
	 */
	public CarApplyDispatchEntity selectCarDispatchByDispCode(String dispCode);

	/**
	 * 更新状态
	 * @param mp 参数
	 * @return
	 */
	public int updateState(Map<String,Object> mp);

	/**
	 * 取得车辆负责人电话
	 * @param car_no 车辆ID
	 * @return
	 */
	public String getCarManPhone(String car_no);

	/**
	 * 更新车辆
	 * @param car_no 车辆ID
	 * @return
	 */
	public int updateCarUnusedById(String car_no); 
	
	public Integer updateApprDate(String id);

}
