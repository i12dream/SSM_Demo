package com.ssm.crud.test;

import static org.junit.Assert.*;

import java.util.List;

import org.apache.log4j.xml.DOMConfigurator;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;

/**
 * 使用Spring测试模块提供的测试请求功能，测试curd请求的正确性 Spring4测试的时候，需要servlet3.0的支持
 * 
 * @author lfy
 *    当我构建好Maven的web项目时，我发现 有两个 放 web 文件的 地方，我选择将网页文件放在 WebContent 文件夹中
 *    file:WebContent/WEB-INF/springMVC-servlet.xml 【WebContent下面有网页文件】
 *    file:src/main/webapp/WEB-INF/springMVC-servlet.xml 【src/main/webapp下面什么文件都没有】
 */

//@RunWith这个是 junit-4.jar包 提供的注解, 而 SpringJUnit4ClassRunner.class 是spring-test 提供的类
@RunWith(SpringJUnit4ClassRunner.class)
//@WebAppConfiguration  这个是 spring-test.jar包 提供的注解， 用于根据 web.xml的配置，注入 SpringMVC 容器，使SpringMVC容器不需要创建 ，直接获取就行。
@WebAppConfiguration
//@ContextConfiguration 这个是 spring-test.jar包 提供的注解 , 用于启动 spring容器，方便直接获取spring容器中的bean
@ContextConfiguration(locations = { "classpath:springIOC.xml", "file:src/main/webapp/WEB-INF/springMVC-servlet.xml" })
public class SpringMVCTest {

	
	@Autowired// 传入Springmvc的ioc,因为容器内部的bean可以自动注入，但SpringMVC这个容器不是springIOC中的bean，无法自动注入，所以需要在类前面添加 @WebAppConfiguration ，根据web.xml配置 来注入SpringMVC容器
	WebApplicationContext context;
	
	// 虚拟mvc请求，获取到处理结果。
	MockMvc mockMvc;

	@Before // 表示 每次调用 http请求 都要初始化一下
	public void initMokcMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}

	@Test
	public void testPage() throws Exception {
		
 
		// 模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "3")).andReturn();

        // 现在 返回 json 字符串了
		System.out.println(result.getResponse().getContentAsString()); 

		
		/***
		 
		// 请求成功以后，请求域中会有pageInfo；我们可以取出pageInfo进行验证

		MockHttpServletRequest request = result.getRequest();
		System.out.println(request); 
		
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
		System.out.println("当前页码：" + pi.getPageNum());
		System.out.println("总页码：" + pi.getPages());
		System.out.println("总记录数：" + pi.getTotal());
		System.out.println("在页面需要连续显示的页码");
		int[] nums = pi.getNavigatepageNums();
		for (int i : nums) {
			System.out.println(" " + i);
		}

		// 获取员工数据
		List<Employee> list = pi.getList();
		for (Employee employee : list) {
			System.out.println("ID：" + employee.getEmpId() + "==>Name:" + employee.getEmpName());
		}
		
	    ***/

	}

}
