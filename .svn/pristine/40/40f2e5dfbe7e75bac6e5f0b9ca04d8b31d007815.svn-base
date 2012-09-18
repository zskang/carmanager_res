package com.cabletech.googlemap.service;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.cabletech.core.service.BaseServiceImpl;
import com.cabletech.googlemap.mapper.GoogleMapServerMapper;

/**
 * google map 地图接口实现类
 * @author Administrator
 *
 */
@Service
public class GoogleMapServerServiceImpl extends BaseServiceImpl implements GoogleMapServerService {
	@Resource(name = "googleMapServerMapper")
	private GoogleMapServerMapper mapper;

	@Override
	public List<Map<String, Object>> getCarInfo(Map<String, Object> map){
		
		return null;
	}
	
	@Override
	public List<Map<String, Object>> getHistoryPositions(Map<String, Object> map){
		return mapper.getHistoryPositions(map);
	}
	
	@Override
	public List<Map<String, Object>> searchCars(Map<String, Object> map){
		return mapper.searchCars(map);
	}
	
	@Override
	public List<Map<String, Object>> getMentors(Map<String, Object> map){
		return mapper.getMentors(map);
	}
	
	@Override
	public List<Map<String, Object>> getPositionAndDisplay(Map<String, Object> map){
		return mapper.getPositionAndDisplay(map);
	}
	
	@Override
	public List<Map<String, Object>> getLocus(Map<String, Object> map){
		return mapper.getLocus(map);
	}
	
	@Override
	public List<Map<String, Object>> getRegions(Map<String, Object> map) {
		return mapper.getRegions(map);
	}
	
	@Override
	public List<Map<String, Object>> getOnlineCarsInfo(Map<String, Object> map){
		return mapper.getOnlineCarsInfo(map);
	}
	
}
