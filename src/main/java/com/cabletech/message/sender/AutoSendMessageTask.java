package com.cabletech.message.sender;

import java.util.List;
import java.util.TimerTask;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.cabletech.baseinfo.jms.JmsSmParameter;
import com.cabletech.message.sender.service.CarAutoScheduleSendMsgService;

/**
 * 
 * @author 杨隽 2012-07-05 创建
 * 
 */
@Component
public class AutoSendMessageTask extends TimerTask {
	@Resource(name = "carAutoScheduleSendMsgServiceImpl")
	private CarAutoScheduleSendMsgService service;

	@Override
	public void run() {
		List<JmsSmParameter> list = service.autoScheduleSendMessage();
		service.sendMessage(list);
	}
}
