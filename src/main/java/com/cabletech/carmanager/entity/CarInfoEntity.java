package com.cabletech.carmanager.entity;


import java.text.SimpleDateFormat;
import java.util.Date;

/***
 * 车辆实体类
 * @author 陆道伟 2012-6-15 
 *
 */
public class CarInfoEntity {
	private String id;                  //车辆编号
	private String carno;               //车辆车牌号
	private String cartype;             //车辆类型
	private String gpsno;               //GPS编号
	private String gpscompany;          //GPS生产商
	private String simid;				//SIM卡号
	private String regionid;			//区域id		
	private String mentor;				//司机
	private String contractorid;		//分配部门id
	private String phone;				//司机电话号码
	private Date createdate;			//创建时间
	private String buydateformat;		//汽车购买时间的String转化
	private String createdateformate;	//创建时间的String格式化
	private String outputvolume;		//汽车排量
	private Date buydate;				//购买时间
	private String oilwear;				//标准油耗
	private String usestate;			//汽车使用状态
	private String carstate;			//汽车状态
	private String adduserid;			//添加人员的id
	private String status;				//状态 ，主要用于删除（删除修改为9）
	private String userorgid ;
	private String userdeptid;
	
	public String getUserorgid() {
		return userorgid;
	}
	public void setUserorgid(String userorgid) {
		this.userorgid = userorgid;
	}
	public String getUserdeptid() {
		return userdeptid;
	}
	public void setUserdeptid(String userdeptid) {
		this.userdeptid = userdeptid;
	}
	public String getBuydateformat() {
		return buydateformat;
	}
	public String getCreatedateformate() {
		return createdateformate;
	}
	public Date getCreatedate() {
		return createdate;
	}
	/**
	 * 设置当前日期
	 * @param createdate 当前日期
	 */
	public void setCreatedate(Date createdate) {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		if(createdate!=null && !createdate.equals(""))
			createdateformate=sdf.format(createdate);
		this.createdate = createdate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCarno() {
		return carno;
	}
	public void setCarno(String carno) {
		this.carno = carno;
	}
	public String getCartype() {
		return cartype;
	}
	public void setCartype(String cartype) {
		this.cartype = cartype;
	}
	public String getGpsno() {
		return gpsno;
	}
	public void setGpsno(String gpsno) {
		this.gpsno = gpsno;
	}
	public String getGpscompany() {
		return gpscompany;
	}
	public void setGpscompany(String gpscompany) {
		this.gpscompany = gpscompany;
	}
	public String getSimid() {
		return simid;
	}
	public void setSimid(String simid) {
		this.simid = simid;
	}
	public String getRegionid() {
		return regionid;
	}
	public void setRegionid(String regionid) {
		this.regionid = regionid;
	}
	public String getMentor() {
		return mentor;
	}
	public void setMentor(String mentor) {
		this.mentor = mentor;
	}
	public String getContractorid() {
		return contractorid;
	}
	public void setContractorid(String contractorid) {
		this.contractorid = contractorid;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getOutputvolume() {
		return outputvolume;
	}
	public void setOutputvolume(String outputvolume) {
		this.outputvolume = outputvolume;
	}
	public Date getBuydate() {
		return buydate;
	}
	/**
	 * 设置购买日期
	 * @param buydate 购买日期
	 */
	public void setBuydate(Date buydate) {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		if(buydate!=null && !buydate.equals(""))
			buydateformat =sdf.format(buydate);
		this.buydate = buydate;
	}
	public String getOilwear() {
		return oilwear;
	}
	public void setOilwear(String oilwear) {
		this.oilwear = oilwear;
	}
	public String getUsestate() {
		return usestate;
	}
	public void setUsestate(String usestate) {
		this.usestate = usestate;
	}
	public String getCarstate() {
		return carstate;
	}
	public void setCarstate(String carstate) {
		this.carstate = carstate;
	}
	public String getAdduserid() {
		return adduserid;
	}
	public void setAdduserid(String adduserid) {
		this.adduserid = adduserid;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
