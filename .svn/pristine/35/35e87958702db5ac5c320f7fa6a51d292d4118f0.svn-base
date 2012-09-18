package com.cabletech.carassign.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import org.apache.commons.lang.ArrayUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import com.cabletech.carassign.mapper.CarAssignedMapper;
import com.cabletech.core.service.BaseServiceImpl;

/**
 * 已分配车辆业务接口实现
 * 
 * @author 杨隽 2012-06-13 创建
 * 
 */
@Service
@Transactional
public class CarAssignedServiceImpl extends BaseServiceImpl implements
		CarAssignedService {
	/**
	 * 已分配车辆Mapper
	 */
	@Resource(name = "carAssignedMapper")
	private CarAssignedMapper carAssignedMapper;

	@Override
	@Transactional(readOnly = true)
	public List<Map<String, Object>> getAssignedCarList(
			Map<String, Object> condition) {
		return carAssignedMapper.getAssignedCarList(condition);
	}

	@Override
	public void unAssignCar(String userOrgId, String[] carId) {
		if (ArrayUtils.isEmpty(carId)) {
			return;
		}
		for (int i = 0; i < carId.length; i++) {
			String id = carId[i];
			unAssignOneCar(userOrgId, id);
		}
	}

	/**
	 * 进行单个车辆的回收
	 * 
	 * @param userOrgId
	 *            String 当前登录用户组织编号
	 * @param carId
	 *            String 回收车辆编号
	 */
	private void unAssignOneCar(String userOrgId, String carId) {
		List<Map<String, Object>> list = carAssignedMapper
				.getAssignedCarById(carId);
		if (CollectionUtils.isEmpty(list)) {
			return;
		}
		Map<String, Object> carMap = list.get(0);
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("userOrgId", userOrgId);
		condition.put("carId", carId);
		// 使用部门回收正在使用的车辆
		if (carMap.get("USERDEPTID") != null) {
			carAssignedMapper.unAssignCarByUseDepart(condition);
			// 分配组织回收自己组织使用的车辆
			if (carMap.get("ASSIGNORGID").equals(carMap.get("USERORGID"))) {
				carAssignedMapper.unAssignCarByAssignOrg(condition);
			}
			return;
		}
		// 分配组织回收未使用的车辆
		if (userOrgId.equals(carMap.get("ASSIGNORGID"))
				&& carMap.get("USERORGID") != null) {
			carAssignedMapper.unAssignCarByAssignOrg(condition);
			return;
		}
		// 添加车辆组织回收未使用的车辆
		if (userOrgId.equals(carMap.get("ADDORGID"))
				&& !userOrgId.equals(carMap.get("ASSIGNORGID"))) {
			carAssignedMapper.unAssignCarByAddOrg(condition);
			return;
		}
	}
}
