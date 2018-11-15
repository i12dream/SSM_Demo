package com.ssm.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.crud.bean.Employee;
import com.ssm.crud.bean.EmployeeExample;
import com.ssm.crud.bean.EmployeeExample.Criteria;
import com.ssm.crud.mapper.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;

	public List<Employee> getAll() {

		return employeeMapper.selectByExampleWithDept(null);

	}

	public void saveEmp(Employee employee) {
		// 下面这个方法 是全部插入 ,包括 连自增的id 都是
		// employeeMapper.insert(employee);
		// 下面这个方法是 有选择的插入，自增Id 被忽略 不会插入。
		employeeMapper.insertSelective(employee);
	}

	/**
	 * 检验用户名是否可用
	 * 
	 * @param empName
	 * @return true:代表当前姓名可用 false:代表不可用
	 */
	public boolean checkUser(String empName) {

		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		// 按照条件，统计符号条件的记录数
		long count = employeeMapper.countByExample(example);
		return count==0;
	}

	/**
	 * 按照员工Id 查询员工
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		// TODO Auto-generated method stub
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	/***
	 * 员工更新
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		//根据主键有选择的更新，因为我们页面传过来的pojo，不包括 empName 属性
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
    
	/**
	 * 根据id 删除用户
	 * @param id
	 */
	public void deleteEmp(int id) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(id);
		
	}
	
    /**
     * 
     * @param ids
     */
	public void deleteBatch(List<Integer> ids) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
	    Criteria criteria = example.createCriteria();
		//delete  from  xxx where emp_id in (1,2,3)
	    criteria.andEmpIdIn(ids);
	    employeeMapper.deleteByExample(example);
		
	}
	
	
	

}
