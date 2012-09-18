package com.cabletech.login.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cabletech.baseinfo.business.entity.UserInfo;
import com.cabletech.login.mapper.UserInfoMapper;

/**
 * 登录业务实现类
 * @author Administrator
 *
 */
@Service
public class UserInfoServiceImpl implements UserInfoService {

	@Resource(name = "userInfoMapper")
	private UserInfoMapper mapper;

	/**
	 * 模拟用户登录
	 * 
	 * @param map 查询条件
	 */
	public UserInfo searchloginuser(Map<String, Object> map) {
		return mapper.searchloginuser(map);
	}

	/**
	 * 搜索登录用户需要加载的地图
	 * 
	 * @param regionid 區域ID
	 * @return
	 */
	public String searchmapurl(String regionid){
		return mapper.searchmapurl(regionid);
	}
 
	@Override
    public UserInfo ssologinuser(String userid) {
        return mapper.ssologinuser(userid);
    }

}
