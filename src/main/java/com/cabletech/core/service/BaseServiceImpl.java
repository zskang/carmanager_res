package com.cabletech.core.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;

import com.cabletech.core.entity.config.GlobalConfigInfo;
import com.cabletech.core.mapper.BaseMapper;

/**
 * Service基类，结合Spring进行控制管理 <br />
 * 
 * @author cqp
 * 
 * 
 */
public class BaseServiceImpl implements BaseService {
	public Logger logger = Logger.getLogger(this.getClass());

	@Resource(name = "globalConfigInfo")
	protected GlobalConfigInfo config;

	@Resource(name = "sqlSession")
	public SqlSession session;

	@Resource(name = "baseMapper")
	public BaseMapper mapper;

	/**
	 * 获取一个随机ID
	 * 
	 * @return String
	 */
	public String getUUID() {
		return UUID.randomUUID().toString();
	}

	/**
	 * 获取XTBH
	 * 
	 * @return String
	 */
	public String getXTBH() {
		return mapper.getXTBH();
	}

	/**
	 * 获取SDE OBJECTID
	 * 
	 * @param tableName
	 *            获取序列的表名称
	 * @return String objectid序列
	 */
	public String getObjectID(String tableName) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tablename", tableName);
		map.put("tablespacename", config.getTablespacename());
		return mapper.getObjectID(map);
	}

	/**
	 * 获取SDE插入几何字段时需要的SRID
	 * 
	 * @param tableName
	 *            表名称
	 */
	public String getSRID(String tableName) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tablename", tableName);
		map.put("tablespacename", config.getTablespacename());
		return mapper.getSRID(map);
	}

	/**
	 * 组合两点之间的线段shape
	 * 
	 * @param sx
	 *            起点x
	 * @param sy
	 *            起点y
	 * @param ex
	 *            终点x
	 * @param ey
	 *            终点y
	 * @return
	 */
	public String getLineStr(String sx, String sy, String ex, String ey) {
		String lineStr = "";
		if(StringUtils.isBlank(sx) || StringUtils.isBlank(sy) || StringUtils.isBlank(ex) || StringUtils.isBlank(ey)){
			return lineStr;
		}
		if (isNumber(sx) && isNumber(sy) && isNumber(ex) && isNumber(ey) && (!sx.equals(ex) && !sy.equals(ey))) {
			lineStr = "linestring (" + sx + " " + sy + "," + ex + " " + ey + ")";
		}
		return lineStr;
	}
	
	/**
	 * 根据多点获取线段的shape
	 * @param points 传入点的集合
	 */
	public String getLineStr(List<String[]> points) {
		String lineStr = "";
		return lineStr;
	}
   
	/**
	 * 通用分页查询方法
	 * @param mapId  对应Mapper文件中的ID，如searchAllRegion等
	 * @param parameter   查询条件，传递对应ID的查询条件
	 * @param page   页数
	 * @param pagesize 每页记录数
	 * @return List<Map<String, Object>>
	 */
	@SuppressWarnings("unchecked")
	private List<Map<String, Object>> queryPage(String mapId, Object parameter,
			int page, int pagesize) {
		List<Map<String, Object>> list = session.selectList(mapId, parameter,
				new RowBounds(page, pagesize));
		return list;
	}

	/**
	 * 获取总的记录数
	 * 
	 * @param mapId  对应Mapper文件中的ID，如searchAllRegion等
	 * @param parameter 查询条件，传递对应mapId的查询条件
	 * @return int 页数
	 */
	@SuppressWarnings("unchecked")
	public int getRecordCounts(String mapId, Object parameter) {
		List<Map<String, Object>> list = session.selectList(mapId, parameter,
				new RowBounds(-4, -4));
		int count = Integer.parseInt(list.get(0).get("TOTAL").toString());
		return count;
	}

	/**
	 * 返回总记录数和当前页数的记录列表
	 * 
	 * @param mapId 对应Mapper文件中的ID，如searchAllRegion等
	 * @param parameter  查询条件，传递对应ID的查询条件
	 * @param page  页数
	 * @param pagesize  每页记录数
	 * @return Map<String, Object>
	 */
	public Map<String, Object> queryPageMap(String mapId, Object parameter,
			int page, int pagesize) {
		// logger.info("Mapper Time: " + mapId);
		Date start = new Date();
		List<Map<String, Object>> list = this.queryPage(mapId, parameter, page,
				pagesize);
		Date end = new Date();
		logger.info(mapId + "时间： " + (end.getTime() - start.getTime()));
		int counts = this.getRecordCounts(mapId, parameter);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rows", list);
		map.put("total", counts);

		return map;
	}
	
	/**
	 * 判断是否整数
	 * 
	 * @param number 数字
	 * 
	 */
	public boolean isNumber(String number) {
		int index = number.indexOf(".");
		if (index < 0) {
			return StringUtils.isNumeric(number);
		} else {
			String num1 = number.substring(0, index);
			String num2 = number.substring(index + 1);

			return StringUtils.isNumeric(num1) && StringUtils.isNumeric(num2);
		}
	}
}
