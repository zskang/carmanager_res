package com.cabletech.core.common;

import java.sql.Connection;
import java.util.Properties;

import org.apache.ibatis.executor.statement.PreparedStatementHandler;
import org.apache.ibatis.executor.statement.RoutingStatementHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.session.RowBounds;

/**
 * SQL Statement拦截器
 * 
 * @author cqp 2012-05-11
 * 
 */
@Intercepts({ @Signature(type = StatementHandler.class, method = "prepare", args = { Connection.class }) })
public class DialectStatementHandlerInterceptor implements Interceptor {

	/**
	 * 实现拦截器方法
	 * @param invocation 拦截对象
	 */
	public Object intercept(Invocation invocation) throws Throwable {
		RoutingStatementHandler statement = (RoutingStatementHandler) invocation
				.getTarget();
		PreparedStatementHandler handler = (PreparedStatementHandler) ReflectUtil
				.getFieldValue(statement, "delegate");
		RowBounds rowBounds = (RowBounds) ReflectUtil.getFieldValue(handler,"rowBounds");
		BoundSql boundSql = statement.getBoundSql();
		String sql = boundSql.getSql();
		if(rowBounds.getLimit()<-1){
			sql = "select count(1) TOTAL from (" + sql+ ")";
		}else if (rowBounds.getLimit() > 0 && rowBounds.getLimit() < RowBounds.NO_ROW_LIMIT) {
			int page = rowBounds.getOffset();
			int pagesize = rowBounds.getLimit();
			int lastNumber = (page - 1) * pagesize;
			int startNumber = page * pagesize;
			StringBuffer buf = new StringBuffer();
			buf.append("select * from ( select row_.*, rownum rownum_ from ( ");
			buf.append(sql);
			buf.append(" ) row_ where rownum <= " + startNumber
					+ ") where rownum_ > " + lastNumber);
			sql = buf.toString();
		}
		ReflectUtil.setFieldValue(boundSql, "sql", sql);
		return invocation.proceed();
	}

	/**
	 * 
	 * @param target 目标对象
	 */
	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

	/**
	 * 
	 * @param properties 属性对象
	 */
	public void setProperties(Properties properties) {
	}

}
