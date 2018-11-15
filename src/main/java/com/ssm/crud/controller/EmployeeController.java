package com.ssm.crud.controller;

import java.awt.Checkbox;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.annotation.JsonTypeInfo.Id;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.crud.bean.Employee;
import com.ssm.crud.mapper.EmployeeMapper;
import com.ssm.crud.service.EmployeeService;
import com.ssm.crud.util.Msg;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	@Autowired
	EmployeeMapper employeeMapper;

	/**
	 * uri 风格请求： /emp/{id} GET 查询员工 /emp POST 保存员工 /emp/{id} PUT 更新员工 /emp/{id}
	 * DELETE 删除员工
	 ***/
	
	
	
    /**
     * 单个、批量 删除二合一，
     * 批量删除 1-2-3
     * 单个删除 1
     * 
     * @param ids
     * @return
     */
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteByEmpId(@PathVariable("ids") String ids){
		//批量删除
		if(ids.contains("-")){
			   List<Integer> delete_id = new ArrayList<>() ;
               String[] str_ids = ids.split("-");
               for (String str :str_ids) {
            	   delete_id.add(Integer.parseInt(str));
			   }
				employeeService.deleteBatch(delete_id);

		}else{
			int id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Msg.success();
	}
	
	/*** 批量 单个 方法 合在一起了
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method=RequestMethod.DELETE)
	public Msg deleteByEmpId(@PathVariable("id") int id){
		employeeService.deleteEmp(id);
		return Msg.success();
	}
	***/
	
	/**
	 * 如果直接发送ajax=PUT形式的请求
	 * 封装的数据
	 * Employee 
	 * [empId=1014, empName=null, gender=null, email=null, dId=null]
	 * 
	 * 问题：
	 * 请求体中有数据；
	 * 但是Employee对象封装不上；
	 * update tbl_emp  where emp_id = 1014;
	 * 
	 * 原因：
	 * Tomcat：
	 * 		1、将请求体中的数据，封装一个map。
	 * 		2、request.getParameter("empName")就会从这个map中取值。
	 * 		3、SpringMVC封装POJO对象的时候。
	 * 				会把POJO中每个属性的值，request.getParamter("email");
	 * AJAX发送PUT请求引发的血案：
	 * 		PUT请求，请求体中的数据，request.getParameter("empName")拿不到
	 * 		Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
	 * org.apache.catalina.connector.Request【类名】--parseParameters()【方法名】 (行号:3111);
	 * 
	 * protected String parseBodyMethods = "POST";
	 * if( !getConnector().isParseBodyMethod(getMethod()) ) {
                success = true;
                return;
            }
	 * 
	 * 
	 * 解决方案；
	 * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
	 * 1、配置上HttpPutFormContentFilter；
	 * 2、他的作用；将请求体中的数据解析包装成一个map。
	 * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
	 * 员工更新方法
	 * @param employee
	 * @return
	 */
	/***
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee,HttpServletRequest request){
		System.out.println("请求体中的值："+request.getParameter("gender"));
		System.out.println("将要更新的员工数据："+employee);
		employeeService.updateEmp(employee);
		return Msg.success()	;
	}
	***/
	
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee){
		
		System.out.println("将要更新的员工数据："+employee);
		employeeService.updateEmp(employee);
		return Msg.success();
		
	}
	
	
	/**
	 * 根据id查询员工
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	
	
	/**
	 * 检查用户名是否可用
	 * 
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkUser")
	public Msg checkUser(String empName) {
		// 先判断用户名是否是合法的表达式;
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if (!empName.matches(regx)) {
			return Msg.fail().add("user_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
		}

		boolean b = employeeService.checkUser(empName);
		if (b)
			return Msg.success();
		else
			return Msg.fail().add("user_msg", "用户名不可用");
	}

	

	/**
	 * 员工保存
	 * 1、支持JSR303校验
	 * 2、导入Hibernate-Validator
	 * 3、在bean的属性中 添加校验注解
	 * 4、在调用方法参数中，写上 @Valid 启用校验功能，BindingResult 设置校验结果返回
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	public Msg saveEmpWithJson(@Valid Employee employee ,BindingResult result) {
		if(result.hasErrors())
		{
			//校验失败，应该返回失败，在模态框中显示校验失败的错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}
		else {
			System.out.println(employee);
			employeeService.saveEmp(employee);
			return Msg.success();

		}
		
	}

	/****
	 * 
	 * // 查询员工数据（分页查询） //这个方法是响应 浏览器前端http请求的,靠http请求来交互数据的
	 * //@RequestMapping("/emps") public String getEmps(@RequestParam(value =
	 * "pn", defaultValue = "1") Integer pn, Model model) { // 这不是一个分页查询； //
	 * 引入PageHelper分页插件 // 在查询之前只需要调用，传入页码，以及每页的大小 PageHelper.startPage(pn, 5);
	 * // startPage后面紧跟的这个查询就是一个分页查询 List<Employee> emps =
	 * employeeService.getAll();
	 * 
	 * // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。 //
	 * 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数 PageInfo<Employee> page = new
	 * PageInfo<Employee>(emps, 5); model.addAttribute("pageInfo", page);
	 * 
	 * 
	 * // 一开始 EmployeeService 方法中 居然 返回的 null，忘记修改了 坑爹的教训啊
	 * System.out.println("当前页码："+page.getPageNum());
	 * System.out.println("总记录数："+page.getTotal());
	 * System.out.println("每页的记录数："+page.getPageSize());
	 * System.out.println("总页码："+page.getPages());
	 * System.out.println("是否第一页："+page.isIsFirstPage());
	 * System.out.println("连续显示的页码："); int[] nums = page.getNavigatepageNums();
	 * for (int i = 0; i < nums.length; i++) { System.out.println(nums[i]); }
	 * 
	 * return "list"; }
	 * 
	 * //这个是 为了验证 返回 list 数据的写法，返回值 要写成 List<E> 类型 public List<Employee>
	 * getEmpsJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
	 * Model model) { // 这不是一个分页查询； // 引入PageHelper分页插件 //
	 * 在查询之前只需要调用，传入页码，以及每页的大小 PageHelper.startPage(pn, 5); //
	 * startPage后面紧跟的这个查询就是一个分页查询 List<Employee> emps =
	 * employeeService.getAll();
	 * 
	 * return emps; }
	 * 
	 ***/
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

		// 引入PageHelper分页插件
		//设置返回查询结果的排序规律(字段名 排序规律)
		PageHelper.orderBy("emp_id asc");
		// 在查询之前只需要调用，传入页码，以及每页的大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟着的这个查询操作就是一个分页查询操作
		List<Employee> emps = employeeService.getAll();

		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
		// 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
		PageInfo<Employee> page = new PageInfo<Employee>(emps, 5);

		return Msg.success().add("pageInfo", page);
	}

}
