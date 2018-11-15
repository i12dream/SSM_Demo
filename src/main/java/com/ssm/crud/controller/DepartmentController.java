package com.ssm.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssm.crud.bean.Department;
import com.ssm.crud.service.DepartmentService;
import com.ssm.crud.util.Msg;

@Controller
public class DepartmentController {

	@Autowired
    DepartmentService departmentService;
	
	@ResponseBody
	@RequestMapping("/depts")
	public Msg getDepts(){
	    return Msg.success().add("depts", departmentService.getAll()) ;
	}
	
}
