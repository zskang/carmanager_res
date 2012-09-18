package com.cabletech.core.common;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.cabletech.core.service.ResCommonTagService;

/**
 * 自定义显示标签
 * @author Administrator
 *
 */
public class ResCommonTag extends TagSupport {

	private static final long serialVersionUID = 1L;
	private String keyValue;
	private String keyColumn;
	private String displayName;
	private String tableName;
	
	/**
	 * 自定义标签
	 */
	public int doStartTag() throws JspException {
		ResCommonTagService service = (ResCommonTagService)WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext()).getBean("resCommonTagServiceImpl");
		//ResCommonTagService service = (ResCommonTagService)this.getBean("resCommonTagServiceImpl");		
		JspWriter out = pageContext.getOut();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyValue", keyValue);
		map.put("keyColumn", keyColumn);
		map.put("displayName", displayName);
		map.put("tableName", tableName);
		try{
			String s = service.getKeyColumnDisplayName(map);
			out.print(s==null?"":s);
		}catch (Exception e) {
			throw new JspTagException(e.getMessage());
		}
		return SKIP_BODY;
	}	
	
	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public String getKeyColumn() {
		return keyColumn;
	}

	public void setKeyColumn(String keyColumn) {
		this.keyColumn = keyColumn;
	}

	public String getKeyValue() {
		return keyValue;
	}

	public void setKeyValue(String keyValue) {
		this.keyValue = keyValue;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getTableName() {
		return tableName;
	}
	/**
	 * 自定义标签
	 */
	public int doEndTag() throws JspException {
		return 0;
	}

}
