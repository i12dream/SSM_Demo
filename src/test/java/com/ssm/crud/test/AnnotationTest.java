package com.ssm.crud.test;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.xml.DOMConfigurator;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ssm.crud.bean.Department;
import com.ssm.crud.bean.Employee;
import com.ssm.crud.mapper.DepartmentMapper;
import com.ssm.crud.mapper.EmployeeMapper;

/**
 * 测试dao层的工作
 * 
 * @author lfy 推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件 1、导入SpringTest模块
 *         2、@ContextConfiguration指定Spring配置文件的位置 3、直接autowired要使用的组件即可
 */

// @RunWith这个是 junit-4.jar包 提供的注解, 而 SpringJUnit4ClassRunner.class 是spring-test 提供的类
@RunWith(SpringJUnit4ClassRunner.class)

//@ContextConfiguration 这个是 spring-test.jar包 提供的注解 , 用于启动 spring容器，方便直接获取spring容器中的bean
@ContextConfiguration(locations = { "classpath:springIOC.xml" })
public class AnnotationTest {

	@Autowired
	DepartmentMapper departmentMapper;

	@Autowired
	EmployeeMapper employeeMapper;

	@Autowired
	SqlSession sqlSession;

	/**
	 * 测试DepartmentMapper
	 */

	@Test
	public void testCRUD() throws IOException {

		String config = System.getProperty("user.dir");// 获取程序的当前路径
//		System.out.println("config=" + config);
		DOMConfigurator.configure(config + "/target/classes/6log4j.xml");
//
//		System.out.println(employeeMapper.selectByPrimaryKey(1));

		List<Employee> emps = employeeMapper.selectByExampleWithDept(null);
		for (Employee employee : emps) {
			System.out.println("ID：" + employee.getEmpId() + "==>Name:" + employee.getEmpName());
		}
  /*****
		
		// 1、插入几个部门
		departmentMapper.insertSelective(new Department(null, "开发部"));
		departmentMapper.insertSelective(new Department(null, "测试部"));

		// 2、生成员工数据，测试员工插入
		employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@atguigu.com", 1));

		// 3、批量插入多个员工；批量，使用可以执行批量操作的sqlSession。

		// for(){
		// employeeMapper.insertSelective(new Employee(null, , "M",
		// "Jerry@atguigu.com", 1));
		// }
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 100; i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5) + i;
			mapper.insertSelective(new Employee(null, uid, "M", uid + "@atguigu.com", 1));
		}
		System.out.println("批量完成");

***/

	}

}
