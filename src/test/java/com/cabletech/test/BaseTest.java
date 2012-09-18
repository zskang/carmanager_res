package com.cabletech.test;

import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

//import com.cabletech.res.service.basemgr.GldxtService;

/**
 * 单元测试基础类
 * 
 * @author cqp
 * 
 */
@ContextConfiguration(locations = { "/applicationContext-test.xml"})
public class BaseTest extends AbstractJUnit4SpringContextTests {
	/*@Resource(name = "gldxtServiceImpl")
	private GldxtService gldxtService;
	*//**
	 * 单元测试
	 */
	/*@Test
	public void test() {
		Map<String, Object> map = gldxtService.queryPageMap("queryGldxtList",
				null, 1, 10);
	}*/

}
