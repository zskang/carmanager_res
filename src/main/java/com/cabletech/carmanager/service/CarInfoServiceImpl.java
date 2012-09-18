package com.cabletech.carmanager.service;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import com.cabletech.baseinfo.business.entity.UserInfo;
import com.cabletech.baseinfo.excel.ExportSupport;
import com.cabletech.carmanager.entity.CarInfoEntity;
import com.cabletech.carmanager.entity.CarassignEntity;
import com.cabletech.carmanager.mapper.CarInfoMapper;
import com.cabletech.core.service.BaseServiceImpl;

/***
 * 车辆事务类实现接口
 * @author 陆道伟
 * @author guixy 2012-6-18 重构代码
 *
 */

@Service
public class CarInfoServiceImpl extends BaseServiceImpl implements CarInfoService,ExportSupport{

	@Resource(name = "carInfoMapper")
	protected CarInfoMapper carInfoMapper;

	@Transactional
	@Override
	public Integer create(CarInfoEntity carinfo, UserInfo user) {
		carinfo.setId(this.getXTBH());
		carinfo.setAdduserid(user.getPersonId());
		carinfo.setUsestate("0");
		carInfoMapper.create(carinfo);
		return insertCarAssign(carinfo.getId(), user);
	}

	@Override
	public List<Map<String, Object>> getallitem() {
		// TODO Auto-generated method stub
		return carInfoMapper.getallitem();
	}

	@Override
	public CarInfoEntity getbyid(String id) {
		// TODO Auto-generated method stub
		return carInfoMapper.getbyid(id);
	}

	@Override
	public List<Map<String, Object>> getbymap(Map<String, Object> condition) {
		// TODO Auto-generated method stub
		return carInfoMapper.getbymap(condition);
	}	

	@Transactional(readOnly = true)
	@Override
	public Map<String, Object> viewCarInfo(String carId) {
		List<Map<String, Object>> list = carInfoMapper.viewCarInfo(carId);
		if (CollectionUtils.isEmpty(list)) {
			return new HashMap<String, Object>();
		}
		return list.get(0);
	}

	@Transactional
	@Override
	public Integer update(CarInfoEntity carinfo, UserInfo user) {
		String assignId = carInfoMapper.getCarAssignByCarId(carinfo.getId());		
		if(StringUtils.isBlank(assignId)) {
			// 车辆分配表没有数据
			insertCarAssign(carinfo.getId(), user);
		}
		return carInfoMapper.update(carinfo);
	}

	@Transactional
	@Override
	public Integer insertCarAssign(String carId, UserInfo user) {
		CarassignEntity carAssign=new CarassignEntity();
		carAssign.setId(super.getXTBH());
		carAssign.setCarid(carId);
		carAssign.setAddorgid(user.getOrgId());
		carAssign.setAssignorgid(user.getOrgId());		
		return carInfoMapper.insertCarAssign(carAssign);
	}

	@Override
	public Integer deleteCarInfoEntity(String id) {
		// TODO Auto-generated method stub
		return carInfoMapper.deleteCarInfoEntity(id);
	}

	@Override
	public Integer deleteCarassignEntity(String id) {
		// TODO Auto-generated method stub
		return carInfoMapper.deleteCarassignEntity(id);
	}

	@Override
	public List getExportDatas(Map<String, Object> condition) {
		return getbymap(condition);
	}

	/* (non-Javadoc)
	 * @see com.cabletech.carmanager.service.CarInfoService#updateCarUser(java.util.HashMap)
	 */
	@Override
	public void updateCarUser(HashMap<String, Object> hashmap) {
		carInfoMapper.updateCarUser(hashmap);		
	}

	public CarInfoMapper getCarInfoMapper() {
		return carInfoMapper;
	}

	public void setCarInfoMapper(CarInfoMapper carInfoMapper) {
		this.carInfoMapper = carInfoMapper;
	}

	@Override
	public int isExistsSimId(String simId, String carId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("carId", carId);
		map.put("simId", simId);
		return carInfoMapper.isExistsSimId(map);
	}
	
	@Override
	public int isExistsCarNo(String carNo, String carId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("carNo", carNo);
		map.put("carId", carId);
		return carInfoMapper.isExistsCarNo(map);
	}
}