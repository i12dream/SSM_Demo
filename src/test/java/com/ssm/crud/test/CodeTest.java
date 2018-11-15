package com.ssm.crud.test;

import java.io.IOException;
import org.apache.log4j.xml.DOMConfigurator;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.ssm.crud.mapper.DepartmentMapper;
import com.ssm.crud.mapper.EmployeeMapper;


public class CodeTest {
	
	DepartmentMapper departmentMapper;

	@Test
	public void testCRUD() throws IOException{
		//PropertyConfigurator.configure  与  DOMConfigurator.configure  是不同的，分别用于加载 properties 和 xml 类型的配置文件
		
        //下面这句话，加载的配置文件路径是   xxx/target/test-classes/log4j.xml  结果 找不到， 因为真正的路径是  xxx/target/classes/6log4j.xml  
//        DOMConfigurator.configure(Thread.currentThread().getContextClassLoader().getResource("").getPath()+"6log4j.xml");  
        //因为无法正确加载路径，所以采取了 另一种 路径方法
        String config=System.getProperty("user.dir");//获取程序的当前路径 
        System.out.println("config="+config);
	    DOMConfigurator.configure(config+"/target/classes/6log4j.xml");  

       //要想 启用log4j 框架  只需要加载log4j配置文件就行 ,上面的代码已经加载 了
//     Log4j的 调用方法，版本是 1.X 的，  因为 log4j 2.x 的版本 ，配置文件和调用方法 都变不同了。 
//	   Logger logger = Logger.getLogger(MapperTest.class); 
//      // 记录debug级别的信息  
//      logger.error("This is debug message."); 
		
	    //1、创建SpringIOC容器  ，这个地方 却可以 正确加载 路径 xxx/target/classes/springIOC.xml
		
		//1、创建SpringIOC容器
		ApplicationContext ioc = new ClassPathXmlApplicationContext("springIOC.xml");
		//2、从容器中获取mapper
		EmployeeMapper bean = ioc.getBean(EmployeeMapper.class);
		
		System.out.println(bean.selectByPrimaryKey(1));
       		
	}

}
