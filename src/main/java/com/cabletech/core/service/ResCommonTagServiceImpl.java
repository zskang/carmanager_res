package com.cabletech.core.service;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.cabletech.core.mapper.ResCommonTagMapper;
/**
 * 标签显示 资源的 名称和 XTBH
 * @author zhanghaibo 2012-05-11
 *
 */
@Service
public class ResCommonTagServiceImpl extends BaseServiceImpl implements ResCommonTagService{
	@Resource(name="resCommonTagMapper")
	private ResCommonTagMapper mapper;
	
	/**
	 * 获取显示字段
	 * @param param 关键字段名称、关键字段值、表名称、待显示字段名称
	 * @return
	 */	
	public String getKeyColumnDisplayName(Map<String, Object> param){
		if(checkParams(param, 4)){
			return mapper.getDisplayName(param);
		}else{
			return "";
		}
	}
	
	/**
	 * 检查参数是否为空、完整
	 * @param param 条件
	 * @param limit 参数个数
	 * @return
	 */
	public boolean checkParams(Map<String, Object> param, int limit){
		boolean flag = true;
		int count = 0;
		Iterator iter = param.entrySet().iterator(); 
		while (iter.hasNext()) { 
			count++;
		    Map.Entry entry = (Map.Entry) iter.next(); 
		    Object val = entry.getValue();
		    if(val == null){
		    	flag = false;
		    	break;
		    }
		}
		if(count<limit) flag = false;
		return flag;
	}

	@Override
	public List<Map<String, Object>> fetchMutiResourceData(Map<String, Object> map) {
		return mapper.fetchMutiResourceData(map);
	}

	@Override
	public List<Map<String, Object>> fetchResourceData(Map<String, Object> map) {
		return mapper.fetchResourceData(map);
	}

}
