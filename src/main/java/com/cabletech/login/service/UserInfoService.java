package com.cabletech.login.service;

import java.util.Map;

import com.cabletech.baseinfo.business.entity.UserInfo;


/**
 * 用户操作类接口
 * 
 * @author Administrator
 *
 */
public interface UserInfoService {
	/**
	 * 查询用户信息
	 * 
	 * @param map 查询条件
	 * @return
	 */
	public UserInfo searchloginuser(Map<String, Object> map) ;
	
	/**
	 * 搜索登录用户需要加载的地图
	 * 
	 * @param regionid 區域ID
	 * @return
	 */
	public String searchmapurl(String regionid);

    /**
     * SSO搜索登录用户信息
     * 
     * @param userid 用户ID
     * @return
     */
    public UserInfo ssologinuser(String userid);
}
