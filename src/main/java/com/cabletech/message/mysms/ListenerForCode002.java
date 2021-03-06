package com.cabletech.message.mysms;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import com.cabletech.baseinfo.jms.DoBusiness;
import com.cabletech.baseinfo.jms.JmsSmMessageSender;
import com.cabletech.baseinfo.jms.JmsSmParameter;  
import com.cabletech.carapplydispatch.Contanst.MessageConfig;
import com.cabletech.carapplydispatch.entity.CarApplyDispatchEntity;
import com.cabletech.carapplydispatch.service.CarApplyDispatchService;

/**
 * 短信监听器2
 * 
 * @author 周刚
 * 
 */
/***
 * 调度事物
 */
public class ListenerForCode002 implements DoBusiness {
	public Logger logger = Logger.getLogger(this.getClass());
	@Resource(name = "smMessageSender")
	private JmsSmMessageSender smSender;
	@Resource(name = "carApplyDispatchServiceImpl")
	private CarApplyDispatchService carApplyDispatchService;
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	String dispCode = "";

	/*
	 * 实现Jms onMessage()方法 接受短信 解析参数 修改分派表中状态
	 */
	@Override
	public void doSomething(JmsSmParameter message) { 
		CarApplyDispatchEntity applydispatchentity = new CarApplyDispatchEntity();
		String content = message.getContent();
		String bcodes = message.getBusinessCode();

		if (StringUtils.isBlank(bcodes)) {
			return;
		}
		if (StringUtils.isBlank(content)) {
			return;
		}
		if (bcodes.length() > 3) {
			dispCode = bcodes.substring(3, bcodes.length());
			applydispatchentity = carApplyDispatchService
					.selectCarDispatchByDispCode(dispCode);
			if (applydispatchentity != null) {
				saveOrUpdateDispatch(applydispatchentity, content);
			}
		} else {
			saveEntityToDB(message, MessageConfig.Code_WAITDisp);
			logger.info("短信申请已添加,等待调度!");
		}
	}

	/**
	 * 实现具体修改逻辑
	 * 
	 * @param applydispatchentity 实体
	 * @param content 短信内容
	 */
	public void saveOrUpdateDispatch(
			CarApplyDispatchEntity applydispatchentity, String content) {
		if (applydispatchentity.getDisp_state().equals(
				MessageConfig.Code_WAITCheck)) {
			if (content.toLowerCase().equals("y")) {
				updateStateById(MessageConfig.Code_DISPSuccess,
						applydispatchentity.getId());// 站长审核通过，将dispState状态改为1
				sendMessageToUserAfterSuccess(applydispatchentity,
						MessageConfig.Code_DISPSuccess);
			} else if (content.toLowerCase().equals("n")) {// 站长审核不通过将dispstate设置为4
				updateStateById(MessageConfig.Code_CANCEL,
						applydispatchentity.getId());
				sendMessageToUserAfterFailur(applydispatchentity,
						MessageConfig.Code_CANCEL);
			}
		}
		if (applydispatchentity.getDisp_state().equals(
				MessageConfig.Code_NONECar)) {
			if (content.toLowerCase().equals("d")) {
				updateStateById(MessageConfig.Code_DISPSuccess,
						applydispatchentity.getId());
			} else if (content.toLowerCase().equals("q")) {
				updateStateById(MessageConfig.Code_WAITDisping,
						applydispatchentity.getId());
			}
		}
		if (applydispatchentity.getDisp_state().equals(
				MessageConfig.Code_DISPSuccess)) {
			if (content.toLowerCase().equals("s")) {
				updateCarUsedByCarNo(applydispatchentity.getCar_no());
				updateStateById(MessageConfig.Code_CANCEL,
						applydispatchentity.getId());
			} else if (content.toLowerCase().equals("e")) {
				updateCarUnUsedByCarNo(applydispatchentity.getCar_no());
			}
		}
	}

	/**
	 * 修改分配状态
	 * 
	 * @param state 状态
	 * @param id 调度单ID
	 */
	public void updateStateById(String state, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("dispState", state);
		int a = carApplyDispatchService.updateState(map);
		if (a != 0) {
			logger.info("更改成功!");
		}
	}

	/**
	 * 修改车辆使用状态
	 * 
	 * @param carno 车辆ID
	 */
	public void updateCarUsedByCarNo(String carno) {
		int a = carApplyDispatchService.updateCarUsed(carno);
		if (a != 0) {
			logger.info("更改成功!");
		}
	}

	/**
	 * 修改车辆使用状态
	 * 
	 * @param carno 车辆ID
	 */
	public void updateCarUnUsedByCarNo(String carno) {
		int a = carApplyDispatchService.updateCarUsed(carno);
		if (a != 0) {
			logger.info("更改成功!");
		}
	}

	/**
	 * 审核通过后发信息给申请人和 用车人
	 * 
	 * @param cad 实体
	 * @param dispState 状态
	 */
	public void sendMessageToUserAfterSuccess(CarApplyDispatchEntity cad,
			String dispState) {
		String adispcode = cad.getAdisp_code();
		StringBuffer contents = new StringBuffer();
		String carManPhone = carApplyDispatchService.getCarManPhone(cad
				.getCar_no());// 当前这个人车的使用人电话。
		contents.append("您申请的于" + cad.getApply_date() + "因"
				+ cad.getUse_reason() + "需要使用" + cad.getCarno() + "车，已经审批通过 。");
		JmsSmParameter parameter1 = JmsSmParameter.getInstanceForNotNeedResponse(
				cad.getPhone(), contents.toString());
		parameter1.setBusinessCode(MessageConfig.BussCode2 + adispcode);
		smSender.sendMessage(parameter1);
		contents.setLength(0);
		contents.append(cad.getUsers() + "于" + cad.getApprove_date() + "因"
				+ cad.getUse_reason() + "需要使用" + cad.getCarno() + "车，请及时做好准备。");
		JmsSmParameter parameter2 = JmsSmParameter.getInstanceForNotNeedResponse(
				carManPhone, contents.toString());
		parameter2.setBusinessCode(MessageConfig.BussCode2 + adispcode);
		smSender.sendMessage(parameter2);
		logger.info("发送完成.....");
	}

	/**
	 * 审核不通过后发信息给申请人
	 * 
	 * @param cad 实体
	 * @param dispState 状态
	 */ 
	public void sendMessageToUserAfterFailur(CarApplyDispatchEntity cad,
			String dispState) {
		String adispcode = cad.getAdisp_code();
		StringBuffer contents = new StringBuffer();
		contents.append("您申请的于" + cad.getApply_date() + "因"
				+ cad.getUse_reason() + "需要使用" + cad.getCarno() + "车，审批不通过 。");
		JmsSmParameter parameter = JmsSmParameter.getInstanceForNotNeedResponse(
				cad.getPhone(), contents.toString());
		parameter.setBusinessCode(MessageConfig.BussCode2 + adispcode);
		smSender.sendMessage(parameter);
		logger.info("发送完成.....");
	}

	/**
	 * 保存数据至数据库中 主要是针对短信申请
	 * 
	 * @param msg 短信对象
	 * @param dispState 状态
	 */
	public void saveEntityToDB(JmsSmParameter msg, String dispState) {
		CarApplyDispatchEntity applydispatchentity = new CarApplyDispatchEntity();
		Map<String, Object> map = carApplyDispatchService.selectUserByPhone(msg
				.getSrcTerminalId());
		if (null != map) {
			applydispatchentity.setApplicant(map.get("SID").toString());//申请人ID
			applydispatchentity.setUsers(map.get("USERNAME").toString());//用车人姓名
			applydispatchentity.setPhone(msg.getSrcTerminalId());// 电话号码
			applydispatchentity.setApprove_date(sdf.format(new Date()));// 申请时间
			applydispatchentity.setUse_reason(msg.getContent());// 手机短信内容都是申请原因。
			applydispatchentity.setDisp_state(dispState);// 入库时候 // 设置调度状态为0
			carApplyDispatchService
					.insertCarApplyDispatchByMobile(applydispatchentity);
			logger.info("success");
		}
		
	}
 
}