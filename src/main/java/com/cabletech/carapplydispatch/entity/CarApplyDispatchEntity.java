package com.cabletech.carapplydispatch.entity;

/***
 * 调度表的实体
 * @author 陆道伟 2012-6-20 创建
 * @author 周刚 添加了审批人电话号码 approversim
 */
public class CarApplyDispatchEntity {
	private String id; 
	private String adisp_code;
	private String users;
	private String phone;
	private String use_start_date;
	private String use_end_date;
	private String use_reason;
	private String apply_date;
	private String disp_state; 
	private String car_no;
	/**
	 * 车牌号码
	 */
	private String carno;
	public String getCarno() {
		return carno;
	}
	public void setCarno(String carno) {
		this.carno = carno;
	}
	private String disp_date;
	private String dispatcher;
	private String approver;
	private String approve_date;
	private String approve_result;
	private String approve_remark;
	private String recall_remark;
	private String recall_date;
	private String recall_person;
	private String applicant;
	private String username;  
	private String approversim;
	
	public String getApproversim() {
		return approversim;
	}
	public void setApproversim(String approversim) {
		this.approversim = approversim;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getAdisp_code() {
		return adisp_code;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getDisp_state() {
		return disp_state;
	}
	public void setDisp_state(String dispState) {
		disp_state = dispState;
	}
	public String getAdispcode() {
		return adisp_code;
	}
	public void setAdisp_code(String adisp_code) {
		this.adisp_code = adisp_code;
	}
	public String getUsers() {
		return users;
	}
	public void setUsers(String users) {
		this.users = users;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getUse_start_date() {
		return use_start_date;
	}
	public void setUse_start_date(String use_start_date) {
		this.use_start_date = use_start_date;
	}
	public String getUse_end_date() {
		return use_end_date;
	}
	public void setUse_end_date(String use_end_date) {
		this.use_end_date = use_end_date;
	}
	public String getUse_reason() {
		return use_reason;
	}
	public void setUse_reason(String use_reason) {
		this.use_reason = use_reason;
	}
	public String getApply_date() {
		return apply_date;
	}
	public void setApply_date(String apply_date) {
		this.apply_date = apply_date;
	}
	public String getCar_no() {
		return car_no;
	}
	public void setCar_no(String car_no) {
		this.car_no = car_no;
	}
	public String getDisp_date() {
		return disp_date;
	}
	public void setDisp_date(String disp_date) {
		this.disp_date = disp_date;
	}
	public String getDispatcher() {
		return dispatcher;
	}
	public void setDispatcher(String dispatcher) {
		this.dispatcher = dispatcher;
	}
	public String getApprover() {
		return approver;
	}
	public void setApprover(String approver) {
		this.approver = approver;
	}
	public String getApprove_date() {
		return approve_date;
	}
	public void setApprove_date(String approve_date) {
		this.approve_date = approve_date;
	}
	public String getApprove_result() {
		return approve_result;
	}
	public void setApprove_result(String approve_result) {
		this.approve_result = approve_result;
	}
	public String getApprove_remark() {
		return approve_remark;
	}
	public void setApprove_remark(String approve_remark) {
		this.approve_remark = approve_remark;
	}
	public String getRecall_remark() {
		return recall_remark;
	}
	public void setRecall_remark(String recall_remark) {
		this.recall_remark = recall_remark;
	}
	public String getRecall_date() {
		return recall_date;
	}
	public void setRecall_date(String recall_date) {
		this.recall_date = recall_date;
	}
	public String getRecall_person() {
		return recall_person;
	}
	public void setRecall_person(String recall_person) {
		this.recall_person = recall_person;
	}
	public String getApplicant() {
		return applicant;
	}
	public void setApplicant(String applicant) {
		this.applicant = applicant;
	}
}
