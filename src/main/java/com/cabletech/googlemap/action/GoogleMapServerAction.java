package com.cabletech.googlemap.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.validator.GenericTypeValidator;
import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import com.cabletech.baseinfo.business.entity.UserInfo;
import com.cabletech.core.action.BaseAction;
import com.cabletech.googlemap.service.GoogleMapServerServiceImpl;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Google地图服务
 * 
 * @author Administrator
 * 
 */
@Namespace("/googlemap")
@Results({
		@Result(name = "success", location = "/googlemap/googlemapv3.jsp"),
		@Result(name = "newmapwindow", location = "/googlemap/googlemapv3_newwin.jsp"),
		@Result(name = "error", location = "/error.jsp") })
@Action("gmsa")
public class GoogleMapServerAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	public Logger logger = Logger.getLogger(this.getClass());

	@Resource(name = "googleMapServerServiceImpl")
	private GoogleMapServerServiceImpl service;

	/**
	 * 跳转至地图页面
	 * 
	 * @return 地图页面
	 */
	public String toMap() {
		logger.info("ins google map server...");
		Map<String, Object> map = new HashMap<String, Object>();
		UserInfo entity = (UserInfo) request.getSession().getAttribute("USER");
		if (entity != null) {
			if (entity.getRegionId() != null
					&& !"".equals(entity.getRegionId())) {
				map.put("regionid", entity.getRegionId());
			}
			List<Map<String, Object>> list = service.getRegions(map);
			request.setAttribute("regions", list);
			return SUCCESS;
		} else {
			return "error";
		}
	}

	/**
	 * 获取地理位置信息
	 */
	public void getHistoryPositions() {
		String simid = request.getParameter("simid");
		String date = request.getParameter("date");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("simid", simid);
		map.put("begin", date + " 00:00:00");
		map.put("end", date + " 23:59:59");
		List<Map<String, Object>> list = service.getHistoryPositions(map);
		convertlisttojson(list);
	}

	/**
	 * 查询车辆
	 */
	public void searchCars() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		java.text.SimpleDateFormat format = new java.text.SimpleDateFormat(
				"yyyy/MM/dd");
		String date = format.format(new java.util.Date());
		map.put("date", date);
		map.put("selectlist", super.getParameterValue("selectlist"));// 选择搜索方式
		map.put("regionid", super.getParameterValue("regionid"));// 区域
		map.put("genlu", super.getParameterValue("genlu"));
		map.put("mentor",
				"%"
						+ super.converstringtoutf8(super
								.getParameterValue("mentor")) + "%");// 姓名
		map.put("phone", "%" + super.getParameterValue("phone") + "%");// 联系电话
		map.put("carno", "%" + super.getParameterValue("carno") + "%");// 车牌号

		Map<String, Object> querymap = service.queryPageMap("searchCars", map,
				getPage("page"), getLimit("rows"));
		convertmaptojson(querymap);
	}

	/**
	 * 获取车辆信息
	 */
	public void getMentors() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> list = service.getMentors(map);
		convertlisttojson(list);
	}

	/**
	 * 获取位置信息
	 */
	public void getPositionAndDisplay() {
		String simid = request.getParameter("simid");
		String date = request.getParameter("date");
		if (StringUtils.isBlank(date)) {
			java.text.SimpleDateFormat format = new java.text.SimpleDateFormat(
					"yyyy/MM/dd");
			date = format.format(new java.util.Date());
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("simid", simid);
		map.put("date", date.substring(0, 10));
		List<Map<String, Object>> list = service.getPositionAndDisplay(map);
		convertlisttojson(list);
	}

	/**
	 * 展现车辆某段时间地图轨迹
	 */
	public void getLocus() {
		String simid = request.getParameter("simid");
		String begindate = request.getParameter("begin");
		String enddate = request.getParameter("end");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("simid", simid);
		map.put("begindate", begindate);
		map.put("enddate", enddate);

		List<Map<String, Object>> list = service.getLocus(map);
		convertlisttojson(list);
	}

	/**
	 * 转向新地图页面
	 * 
	 * @return 地图页面
	 */
	public String toNewMapWindow() {
		String simid = request.getParameter("simid");
		String begindate = request.getParameter("begin");
		String enddate = request.getParameter("end");
		request.setAttribute("simid", simid);
		request.setAttribute("begindate", begindate);
		request.setAttribute("enddate", enddate);
		return "newmapwindow";
	}

	/**
	 * 根据sim卡获取车辆信息
	 */
	public void getCarInfo() {
		String simid = request.getParameter("simid");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("simid", simid);
		List<Map<String, Object>> list = service.getCarInfo(map);
		convertlisttojson(list);
	}

	/**
	 * 获取坐标值
	 */
	public void getLatlngs() {
		String page = request.getParameter("p");
		if ("".equals(page) || "0".equals(page))
			page = "1";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("regionid", super.getParameterValue("regionid"));
		map.put("begindate", super.getParameterValue("begindate"));
		// 页数
		int p = Integer.parseInt(page);
		// 起始页
		int start = (p - 1) * 10 + 1;
		// 结束页
		int end = p * 10;
		map.put("start", start);
		map.put("end", end);
		List<Map<String, Object>> list = service.getOnlineCarsInfo(map);
		convertlisttojson(list);
	}

	/**
	 * 获取页数
	 * 
	 * @param pagenum
	 *            当前页数
	 * @return int 页数
	 */
	public int getPage(String pagenum) {
		// 获取从哪条记录开始
		String page = request.getParameter(pagenum);
		if (StringUtils.isBlank(page) || page.equals("0")) {
			return 1;
		} else {
			return GenericTypeValidator.formatInt(page);
		}
	}

	/**
	 * 获取每页记录数
	 * 
	 * @param offset
	 *            每页记录数
	 */
	public int getLimit(String offset) {
		String limit = request.getParameter(offset);
		if (StringUtils.isBlank(limit)) {
			return 10;
		} else {
			return GenericTypeValidator.formatInt(limit);
		}
	}

	/**
	 * 将集合Map转成json
	 * 
	 * @param extJson
	 *            串
	 */
	public void convertmaptojson(Map<String, Object> extJson) {
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		String json = gson.toJson(extJson);
		logger.info(json);
		outmessage(json);
	}

	/**
	 * 将集合List转成json
	 * 
	 * @param list
	 *            结果集合
	 */
	public void convertlisttojson(List<Map<String, Object>> list) {
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		String json = gson.toJson(list);
		logger.info(json);
		outmessage(json);
	}

	@Override
	public String execute() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected void prepareSaveModel() throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	protected void prepareViewModel() throws Exception {
		// TODO Auto-generated method stub

	}
}