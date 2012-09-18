package com.cabletech.caranalyse.service;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cabletech.caranalyse.mapper.CarDistanceAnalyseMapper;
import com.cabletech.core.service.BaseServiceImpl;

/**
 * 车辆行程统计业务接口实现
 * 
 * @author 杨隽 2012-06-12 创建
 * 
 */
@Service
public class CarDistanceAnalyseServiceImpl extends BaseServiceImpl implements
		CarDistanceAnalyseService {
	/**
	 * 车辆行程统计Mapper
	 */
	@Resource(name = "carDistanceAnalyseMapper")
	private CarDistanceAnalyseMapper carDistanceAnalyseMapper;

	@Override
	@Transactional(readOnly = true)
	public List<Map<String, Object>> analyseCarDistance(
			Map<String, Object> condition) {
		return carDistanceAnalyseMapper.analyseCarDistance(condition);
	}
}
