package com.cabletech.message.sender.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import com.cabletech.baseinfo.jms.JmsSmMessageSender;
import com.cabletech.baseinfo.jms.JmsSmParameter;
import com.cabletech.carapplydispatch.Contanst.MessageConfig;
import com.cabletech.carapplydispatch.mapper.CarScheduleMapper;
import com.cabletech.core.service.BaseServiceImpl;

/**
 * 
 * @author 杨隽 2012-07-05 创建
 * 
 */
@Service
public class CarAutoScheduleSendMsgServiceImpl extends BaseServiceImpl
		implements CarAutoScheduleSendMsgService {
	@Resource(name = "smMessageSender")
	private JmsSmMessageSender smSender;
	@Resource(name = "carScheduleMapper")
	private CarScheduleMapper mapper;

	@Transactional
	@Override
	public List<JmsSmParameter> autoScheduleSendMessage() {
		logger.info("自动调度短信发送开始......................");
		List<Map<String, Object>> runningCarList = mapper.selectRunningCar();
		if (CollectionUtils.isEmpty(runningCarList)) {
			logger.info("没有启动车辆，自动调度短信发送结束......................");
			return new ArrayList<JmsSmParameter>();
		}
		List<JmsSmParameter> list = new ArrayList<JmsSmParameter>();
		for (int i = 0; i < runningCarList.size(); i++) {
			String id = (String) runningCarList.get(i).get("ID");
			List<Map<String, Object>> taskList = mapper
					.selectCarScheduleTask(id);
			if (CollectionUtils.isEmpty(taskList)) {
				continue;
			}
			for (int j = 0; j < taskList.size(); j++) {
				String taskId = (String) taskList.get(j).get("ID");
				String code = (String) taskList.get(j).get("ADISP_CODE");
				String phone = (String) taskList.get(j).get("PHONE");
				JmsSmParameter parameter = JmsSmParameter.getInstanceForNeedResponse(
						phone, MessageConfig.MESSAGE_SCHEDULE_AUTO);
				parameter.setBusinessCode(MessageConfig.BussCode2 + code);
				mapper.updateCarScheduleSendState(taskId);
				list.add(parameter);
			}
		}
		logger.info("自动调度短信发送结束......................");
		return list;
	}

	@Override
	public void sendMessage(List<JmsSmParameter> list) {
		if (CollectionUtils.isEmpty(list)) {
			return;
		}
		for (int i = 0; i < list.size(); i++) {
			smSender.sendMessage(list.get(i));
		}
	}
}
