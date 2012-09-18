package com.cabletech.message.sender.service;

import java.util.List;

import com.cabletech.baseinfo.jms.JmsSmParameter;
import com.cabletech.core.service.BaseService;

/**
 * 
 * @author 杨隽 2012-07-05 创建
 * 
 */
public interface CarAutoScheduleSendMsgService extends BaseService {
	/**
	 * 获取自动调度短信信息列表
	 */
	public List<JmsSmParameter> autoScheduleSendMessage();

	/**
	 * 发送短信
	 * 
	 * @param list 内容
	 *            
	 */
	public void sendMessage(List<JmsSmParameter> list);
}
