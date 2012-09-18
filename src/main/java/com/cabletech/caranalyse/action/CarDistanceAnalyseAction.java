package com.cabletech.caranalyse.action;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.cabletech.baseinfo.business.entity.UserInfo;
import com.cabletech.caranalyse.service.CarDistanceAnalyseService;
import com.cabletech.core.action.BaseAction;
import com.cabletech.core.entity.config.GlobalConfigInfo;

/**
 * 车辆行程统计Action
 * 
 * @author 杨隽 2012-06-13 创建
 * 
 */
@Namespace("/caranalyse")
@Results({ @Result(name = "list", location = "/caranalyse/car-distance-anlayse-list.jsp") })
@Action("carDistanceAnalyseAction")
public class CarDistanceAnalyseAction extends BaseAction {
	/**
	 * 序列化编号
	 */
	private static final long serialVersionUID = 0L;
	/**
	 * 车辆行程统计业务
	 */
	@Resource(name = "carDistanceAnalyseServiceImpl")
	private CarDistanceAnalyseService carDistanceAnalyseService;
	/**
	 * 全局配置信息实体
	 */
	@Resource(name = "globalConfigInfo")
	private GlobalConfigInfo configInfo;

	@Override
	public String execute() {
		return null;
	}

	/**
	 * 进入车辆行程统计页面
	 * 
	 * @return String
	 * @throws Exception
	 */
	public String list() throws Exception {
		if (StringUtils.isNotBlank(request.getParameter("analyseType"))) {
			Map<String, Object> map = initCondition();
			Map<String, Object> carList = carDistanceAnalyseService
					.queryPageMap("analyseCarDistance", map,
							super.getPage("page"), super.getLimit("rows"));
			request.setAttribute("map", carList);
			request.setAttribute("condition", map);
		}
		return LIST;
	}

	@Override
	public Object getModel() {
		return null;
	}

	@Override
	protected void prepareSaveModel() throws Exception {
	}

	@Override
	protected void prepareViewModel() throws Exception {
	}

	/**
	 * 初始化查询条件Map
	 * 
	 * @return Map<String, Object> 查询条件Map
	 */
	private Map<String, Object> initCondition() {
		Map<String, Object> map = new HashMap<String, Object>();
		UserInfo userInfo = super.getUser();
		StringBuffer queryString = new StringBuffer("");
		map.put("regionId", userInfo.getRegionId());
		processParamValue(map, queryString, "analyseType");
		processParamValue(map, queryString, "departId");
		processParamValue(map, queryString, "orgId");
		processParamValue(map, queryString, "carNo");
		processParamValue(map, queryString, "mentor");
		processParamValue(map, queryString, "simId");
		setDateParam(map, queryString);
		map.put("querystring", queryString.toString());
		return map;
	}

	/**
	 * 将request中的参数值放入查询条件Map，并构建查询QueryUri
	 * 
	 * @param map
	 *            Map<String, Object> 查询条件Map
	 * @param queryString
	 *            StringBuffer 查询条件的queryUri
	 * @param key
	 *            String 参数
	 */
	private void processParamValue(Map<String, Object> map,
			StringBuffer queryString, String key) {
		String value = request.getParameter(key);
		map.put(key, value);
		if (StringUtils.isNotBlank(value)) {
			queryString.append("&" + key + "=" + value);
		}
	}

	/**
	 * 设置日期查询条件参数
	 * 
	 * @param map
	 *            Map<String, Object> 查询条件Map
	 * @param queryString
	 *            StringBuffer 查询条件的queryUri
	 */
	private void setDateParam(Map<String, Object> map, StringBuffer queryString) {
		String beginDate = request.getParameter("beginDate");
		String endDate = request.getParameter("endDate");
		String ifWorkDay = request.getParameter("ifWorkDay");
		if (ifWorkDay != null && ifWorkDay.equals("true")) {
			map.put("ifWorkDay", "true");
			queryString.append("&ifWorkDay=true");
			try {
				beginDate = beginDate.substring(0, 11)
						+ configInfo.getWorkStartTime();
				endDate = endDate.substring(0, 11)
						+ configInfo.getWorkEndTime();
			} catch (Exception ex) {
				beginDate = "";
				endDate = "";
			}
		} else {
			queryString.append("&ifWorkDay=");
		}
		queryString.append("&beginDate=" + beginDate);
		queryString.append("&endDate=" + endDate);
		map.put("beginDate", beginDate);
		map.put("endDate", endDate);
	}
}
