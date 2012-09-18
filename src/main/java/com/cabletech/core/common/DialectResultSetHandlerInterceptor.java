package com.cabletech.core.common;

import java.sql.Statement;
import java.util.Properties;

import org.apache.ibatis.executor.resultset.FastResultSetHandler;
import org.apache.ibatis.executor.resultset.ResultSetHandler;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.session.RowBounds;

/**
 * 拦截器
 * 
 * @author cqp
 * 
 */
@Intercepts({ @Signature(type = ResultSetHandler.class, method = "handleResultSets", args = { Statement.class }) })
public class DialectResultSetHandlerInterceptor implements Interceptor {

	/**
	 * 实现拦截器方法
	 * 
	 * @param invocation 反射对象
	 */
	public Object intercept(Invocation invocation) throws Throwable {
		FastResultSetHandler resultSet = (FastResultSetHandler) invocation
				.getTarget();

		RowBounds rowBounds = (RowBounds) ReflectUtil.getFieldValue(resultSet,
				"rowBounds");
		if(rowBounds.getLimit() < -1){
			ReflectUtil.setFieldValue(resultSet, "rowBounds", new RowBounds());
		}else if (rowBounds.getLimit() > 0
				&& rowBounds.getLimit() < RowBounds.NO_ROW_LIMIT) {
			ReflectUtil.setFieldValue(resultSet, "rowBounds", new RowBounds());
		}
		return invocation.proceed();

	}

	/**
	 * 插件
	 * @param target 目标对象
	 */
	public Object plugin(Object target) {
		return Plugin.wrap(target, this);

	}

	/**
	 * 设置属性
	 * 
	 * @param arg0 属性参数
	 */
	public void setProperties(Properties arg0) {

	}

}
