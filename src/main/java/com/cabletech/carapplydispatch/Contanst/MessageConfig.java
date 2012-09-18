package com.cabletech.carapplydispatch.Contanst;

/**
 * 常量类
 * @author Administrator
 *
 */
public class MessageConfig {
	public final static String Code_WAITDisp = "0";// 0：待调度
	public final static String Code_DISPSuccess = "1";// 1：调成功
	public final static String Code_NONECar = "2";// 2：无车调用
	public final static String Code_WAITDisping = "3";// 3、等待调度
	public final static String Code_CANCEL = "4";// 4、取消（结束）
	public final static String Code_WAITCheck = "5";// 5，等待审批

	public final static String Car_Free = "0";// 0 空闲
	public final static String Car_Busy = "1";// 1任务中 
	public final static String BussCode1="001";
	public final static String BussCode2="002";//
	
	

	public final static String MESSAGE_WAITCHECK = "您需要的车辆已经调度成功，已经报给站长进行审批！";
	public final static String MESSAGE_WAITDISP = "您选择的日期没有可以调度的车辆，如果需要继续等待回复D，取消请回复Q ";
	public final static String MESSAGE_DISPBACK = "调度回来  ";// 待用
	public final static String MESSAGE_SCHEDULE_AUTO="使用车辆出发请回复s，任务执行结束回复 e";//自动调度发送短信
	public static final int TIMED =10;

}
