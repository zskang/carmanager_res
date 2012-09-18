package com.cabletech.core.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.jasig.cas.client.validation.Assertion;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.cabletech.baseinfo.business.Service.BaseInfoProvider;
import com.cabletech.baseinfo.business.entity.UserInfo;

/**
 * 单点登录过滤
 * @author wangt
 *
 */
public class SingleSignInFilter implements Filter {


	private Logger logger = Logger.getLogger(this.getClass());

	/**
	 * Default constructor.
	 */
	public SingleSignInFilter() {
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}


	/**
	 * 过滤逻辑：首先判断单点登录的账户是否已经存在本系统中， 如果不存在使用用户查询接口查询出用户对象并设置在Session中
	 * @param request 
	 * @param response 
	 * @param chain 
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;

		// _const_cas_assertion_是CAS中存放登录用户名的session标志
		Object object = httpRequest.getSession().getAttribute(
				"_const_cas_assertion_");

		if (object != null) {
			Assertion assertion = (Assertion) object;
			String loginName = assertion.getPrincipal().getName();			
			 UserInfo user =(UserInfo)httpRequest.getSession().getAttribute("USER");

			// 第一次登录系统
			if (user == null) {
				WebApplicationContext web = WebApplicationContextUtils.getWebApplicationContext(httpRequest.getSession().getServletContext());
				BaseInfoProvider baseInfoProvider = (BaseInfoProvider) web.getBean("baseInfoProvider");
				//获取用户信息
				UserInfo userInfo = baseInfoProvider.getUserInfoByUserId(loginName);
				if (userInfo != null) {
					httpRequest.getSession().setAttribute("USER", userInfo); 
					httpRequest.getSession().setAttribute("userid", userInfo.getUserId());
					logger.debug("车辆登陆成功！"+userInfo);
				}

			}

		}
		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig fConfig) throws ServletException {
	}

}
