<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径：
不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:8080)；需要加上项目名
		http://localhost:8080/crud
 -->
<script type="text/javascript"
	src="${APP_PATH }/static/jquery-1.12.4/jquery.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-4.1.3-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-4.1.3-dist/js/bootstrap.bundle.min.js"></script>

<link
	href="${APP_PATH }/static/font-awesome-3.2.1/css/font-awesome.min.css"
	rel="stylesheet">

</head>

<body>
	<div class="container">
		<!-- 标题 -->
		<div class="col-md-12">
			<h1>SSM-CRUD</h1>
		</div>

		<!-- 按钮 -->
		<div class="row">
			<div class="ml-auto mr-5">
				<button class="btn btn-primary btn-sm" id="emp_add_modal_btn">
					<i class="icon-file-alt icon-large"></i>  新增
				</button>
				<button class="btn btn-danger btn-sm">
					<i class="icon-trash icon-large"></i> 删除
				</button>
			</div>
		</div>
		
		<div class="text-center">
		<h5>测试列表</h5>
		</div>
		
		<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">员工添加</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">

<form>
  <div class="form-group row">
    <label class="col-sm-3 col-form-label">empName</label>
    <div class="col-sm-9">
      <input type="text"  class="form-control" id="empName_add_input"  name="empName"  placeholder="empName">
      <div class="invalid-feedback"> 用户名错误，请输入6-16个英文或2-5汉字。  </div>
    </div>
  </div>
  
  <div class="form-group row">
    <label class="col-sm-3 col-form-label">email</label>
    <div class="col-sm-9">
      <input type="text"  class="form-control" id="email_add_input" name="email" placeholder="hl@163.com">
          <div class="invalid-feedback"> 邮箱输入错误。</div>
    </div>

  </div>
  
  <div class="form-group row">
    <label  class="col-sm-3 col-form-label">gender</label>  
    <div class="col-sm-9">
<div class="form-check form-check-inline">
  <input class="form-check-input" type="radio" name="gender" id="gender1_add_input" checked value="M">
  <label class="form-check-label" >男</label>
</div>
<div class="form-check form-check-inline">
  <input class="form-check-input" type="radio" name="gender" id="gender2_add_input" value="F">
  <label class="form-check-label" >女</label>
</div>
    </div>  
  </div>
  
    <div class="form-group row">
    <label  class="col-sm-3 col-form-label">departName</label>  
    <div class="col-sm-6">
    <!-- 部门提交部门id即可 -->
    <select class="custom-select my-1 mr-sm-2" name="dId" id="dept_add_select">
    </select>
    </div>
    </div>
</form>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_add_done_btn">保存</button>
      </div>
    </div>
  </div>
</div>
		
		
		
		
		
			<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">员工修改</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">

<form>
  <div class="form-group row">
    <label class="col-sm-3 col-form-label">empName</label>    
    <div class="col-sm-9">
      <input type="text" readonly class="form-control-plaintext" id="empName_update_input_disable" name="empName" value="none">
    </div>
    
  </div>
  
  <div class="form-group row">
    <label class="col-sm-3 col-form-label">email</label>
    <div class="col-sm-9">
      <input type="text"  class="form-control" id="email_update_input" name="email" placeholder="hl@163.com">
          <div class="invalid-feedback"> 邮箱输入错误。</div>
    </div>

  </div>
  
  <div class="form-group row">
    <label  class="col-sm-3 col-form-label">gender</label>  
    <div class="col-sm-9">
<div class="form-check form-check-inline">
  <input class="form-check-input" type="radio" name="gender" id="gender1_update_input" checked value="M">
  <label class="form-check-label" >男</label>
</div>
<div class="form-check form-check-inline">
  <input class="form-check-input" type="radio" name="gender" id="gender2_update_input" value="F">
  <label class="form-check-label" >女</label>
</div>
    </div>  
  </div>
  
    <div class="form-group row">
    <label  class="col-sm-3 col-form-label">departName</label>  
    <div class="col-sm-6">
    <!-- 部门提交部门id即可 -->
    <select class="custom-select my-1 mr-sm-2" name="dId" id="dept_update_select">
    </select>
    </div>
    </div>
</form>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_update_done_btn">更新</button>
      </div>
    </div>
  </div>
</div>
		

		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					
					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<div class="col-md-6" id="page_info_area"></div>
			
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>

	<script type="text/javascript">
		//定义 全局变量，总记录数
		var g_totalRecords ;
		//定义当前 页码数，由页面显示信息传递，不靠to page(n) 的n传递，因为n有可能是添加新用户后的 g_totalRecords
		var g_currentPage;
		var g_empName_reg =  /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
	    var g_empName_valid ="用户名可用";
	    var g_empName_invalid_format = "用户名可以是2-5位中文或者6-16位英文和数字的组合";
	    var g_empName_invalid_exist = "用户名已存在";
	    
		var g_email_reg =  /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
	    var g_email_valid = "";
	    var g_email_invalid_format="邮箱格式不正确";
	    
	    
	    //获取表单值
		//var empName = $("#empName_add_input").val();  
		//编写正则表达式(英文字母 6到16个 或者 中文 2到5个)
		       //一开始正则表达式写错了，导致两个中文的名字无法保存 ，关键就是大括号的位置啊
		       //var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]){2,5}/;
		//var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
	    //show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");

		
		//校验邮箱信息
		//var email = $("#email_add_input").val();
		      // 正则表达式 看花眼了啊 少了 一个 [
		      //var regEmail = /^(a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
	    //  var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;  
	    // show_validate_msg("#email_add_input","error","邮箱格式不正确");
	    
	    
	    function getDepts(ele){
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				async:false, 
				success:function(result){
					console.log(result);
	                //显示部门信息，在下拉列表中
	                // $("#dept_add_select") 换一种找法
	                //$("#empAddModal select")
	                
	                //清除之前留下的 option 标签
	                $(ele).empty();
	                $.each(result.extend.depts,function(){
	                	var optionEle = $("<option></option>").attr("value",this.deptId).append(this.deptName);
	                    optionEle.appendTo(ele);
	                });
				}
			});
		}
		
		//表单内容和样式重置方法
		function reset_form(ele){
			//重置表单内容
			$(ele)[0].reset();
			
			//清空表单样式
			$(ele).find("*").removeClass("is-invalid is-valid");
			$(ele).find(".valid-feedback .invalid-feedback").text("");
			}
		
		
		//校验表单元素  参数：元素 和 正则表达式 ,提示信息
		function validate_form_ele(ele,reg,tip_success,tip_error){
			//拿到要校验的数据，使用正则表达式
			var ele_value = $(ele).val();
	       if( reg.test(ele_value)){
	    	   show_validate_msg(ele,"success",tip_success);
	    	   return true;
	       }else{
	    	   show_validate_msg(ele,"error",tip_error);
	    	   return false;
	       }
		}
		
		//显示校验结果的提示信息
		function show_validate_msg(ele,status,msg){
			//清除当前元素的校验状态
			$(ele).removeClass("is-invalid is-valid");
			$(ele).next("div").removeClass("valid-feedback  invalid-feedback").text("");
			if("success"==status){
				$(ele).addClass("is-valid");
				$(ele).next("div").addClass("valid-feedback").text(msg);
			}else if("error" == status){
				$(ele).addClass("is-invalid");
				$(ele).next("div").addClass("invalid-feedback").text(msg);
			}
		}
		
		
		//1、页面加载完成以后，直接去发送ajax请求,要到分页数据
		$(function(){
			//去首页
			to_page(1);
		});
		
		
		
		/********************公共方法上面*********************/
		
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);
					//1、解析并显示员工数据
					build_emps_table(result);
					//2、解析并显示分页信息
					build_page_info(result);
					//3、解析显示分页条数据
					build_page_nav(result);
				}
			});
		}
		

		function build_emps_table(result) {
			//清空table表格,如果不请空，下一次请求时，数据会在原来的基础上，不断添加。
			$("#emps_table tbody").empty();
			
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				//alert(item.empName);
				
				//构建单元格
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);				
				/**
				<button class="btn btn-primary btn-sm">
					<i class="icon-edit icon-large"></i> 编辑
				</button>
				<button class="btn btn-danger btn-sm">
					<i class="icon-trash icon-large"></i> 删除
				</button>
				**/
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
				.append($("<i></i>").addClass("icon-edit icon-large")).append(" 编辑");
                //为编辑按钮添加一个自定义的属性，来表示当前员工id
                editBtn.attr("edit-id",item.empId);
                
                var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
				.append($("<i></i>").addClass("icon-trash icon-large")).append(" 删除");
                //为删除按钮添加一个自定义的属性来表示当前删除的员工id
                delBtn.attr("del-id",item.empId);
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

                //append方法执行完成以后还是返回原来的元素
				$("<tr></tr>")
                .append(empIdTd)
				.append(empNameTd)
				.append(genderTd)
				.append(emailTd)
				.append(deptNameTd)
				//.append(editBtn)
				//.append(delBtn)
				.append(btnTd)
				.appendTo("#emps_table tbody");
				
			});
		}
		
		//解析显示分页信息
		function build_page_info(result){
			//请空之前的分页显示信息，如果不请空，下一次请求时，数据会在原来的基础上，不断添加。
			$("#page_info_area").empty();
			
			$("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+
					"页，总共"+result.extend.pageInfo.pages+"页,总"+result.extend.pageInfo.total+"记录")
		     
					g_totalRecords = result.extend.pageInfo.total;
			        g_currentPage = result.extend.pageInfo.pageNum
		}
		
		//解析显示分页条
		function build_page_nav(result) {
			//page_nav_area
			//请空之前的分页条，如果不请空，下一次请求时，数据会在原来的基础上，不断添加。
			$("#page_nav_area").empty();
			
			var ul = $("<ul></ul>").addClass("pagination");
			
			//构建元素
			var firstPageLi = $("<li></li>").addClass("page-item").append(  $("<a></a>").addClass("page-link").attr("href","#").append("首页")  );
			var prePageLi = $("<li></li>").addClass("page-item").append(  $("<a></a>").addClass("page-link").append("&laquo;")  );
		
			var lastPageLi = $("<li></li>").addClass("page-item").append(  $("<a></a>").addClass("page-link").attr("href","#").append("末页")   );
			var nextPageLi = $("<li></li>").addClass("page-item").append(  $("<a></a>").addClass("page-link").append("&raquo;")   );

			//添加首页和前一页 的提示
			ul.append(firstPageLi).append(prePageLi);
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				//为元素添加点击翻页的事件
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum -1);
				});
			}
			
			//遍历页码号1,2，3等，给ul中添加页码提示
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi = $("<li></li>").addClass("page-item").append(  $("<a></a>").addClass("page-link").append(item)  );
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				
				numLi.click(function(){
					to_page(item);
				});
				
				ul.append(numLi);
			})
			
			//添加下一页和末页 的提示
			ul.append(nextPageLi).append(lastPageLi);
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum +1);
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
			}
			
			//把ul加入到nav
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		
		/********************加载网页模块结束*********************/

		
		
        /********************添加用户信息模块*********************/
        
		//添加模态框的事件，一开始忘记添加#号了，emp_add_modal_btn
		$("#emp_add_modal_btn").click(function(){
			
			//清除表单数据（表单完整重置（表单的数据，表单的样式））
			reset_form("#empAddModal form");
			
			//发送ajax请求，弹出部门信息，显示在下拉列表中
			getDepts("#empAddModal select");
			
			//弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		

		//添加模态框 保存事件
		$("#emp_add_done_btn").click(function(){
			
			//alert("校验测试");
			
			//1、判断之前的ajax用户名重复性校验是否成功。如果成功。
			if($(this).attr("ajax-check-user")=="error"){
				return false;
			}
			
	
			if(! validate_form_ele("#empName_add_input",g_empName_reg,
					g_empName_valid,g_empName_invalid_format))	
				return false;
		
			if(! validate_form_ele("#email_add_input",g_email_reg,
					g_email_valid,g_email_invalid_format))	
				return false;
			
			//1.将模态框框中的数据提交给服务器进行保存
			//2.方式ajax请求，保存员工
			//alert($("#empAddModal form").serialize());
			
		  $.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(), 
				success:function(result){
					//经过测试，服务器返回的是 json形式的 Msg对象， 到了浏览器中 变成了 result。所以: result.msg 相当于Msg对象里面的msg属性
					console.log(result);
					//alert(result.msg);
					if(result.code==100)
					{
						//1、员工保存成功，需要关闭模态框。
						$("#empAddModal").modal("hide");
						//2、来到最后一页，显示刚才的数据；发送ajax请求，显示最后一页数据即可(用总记录数请求，保证是请求足够大，mybatis 分页插件 已经在mybatis-config.xml中配置了数据合法性校验，只会返回最后一页数据)
						to_page(g_totalRecords);
					}else{
						//显示失败信息
						//console.log(result);
						//有哪个字段的错误信息，就显示哪个字段
						//alert(result.extend.errorFileds.email);
						//alert(result.extend.errorFileds.empName);
		                if(undefined!=result.extend.errorFileds.email){
		                	//显示邮箱错误信息
		    				show_validate_msg("#email_add_input","error",result.extend.errorFileds.email);
		                }
		                if(undefined!=result.extend.errorFileds.empName){
		                	//显示员工名字错误信息
		    				show_validate_msg("#emPName_add_input","error",result.extend.errorFileds.empName);
		                }
						
					}
					
					
				}
			}); 
			
		});
		
		
		//校验添加的用户名 是否可用。需要在 保存按钮提交前进行 判断，自定义属性留个记号，让保存按钮可用来判断 后端校验情况。
		$("#empName_add_input").change(function(){
			
			if(! validate_form_ele("#empName_add_input",g_empName_reg,
					g_empName_valid,g_empName_invalid_format))	
				return false;
		
			
			//发送 ajax 请求，校验 用户名 是否可用。
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkUser",
				type:"POST",
				data:"empName="+empName,
				success:function(result){
					if(result.code==100){
						show_validate_msg("#empName_add_input","success",g_empName_valid);
					    $("#emp_add_done_btn").attr("ajax-check-user","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.user_msg)
					    $("#emp_add_done_btn").attr("ajax-check-user","error");	
					}
				}
				
			});
		});
		
		//校验 email框
		$("#email_add_input").change(function(){
			//校验表单
			validate_form_ele("#email_add_input",g_email_reg,g_email_valid,g_email_invalid_format)
					
			});
		
		
		/**********************更新 员工模块**************************/
		/*** 
		1、我们是按钮创建之前就绑定了click，所以绑定不上。
		$(".edit_btn").click(function(){
			alert("edit");
		});
		****/
		//1）、可以在创建按钮的时候绑定。   
		//2）、绑定点击  live() 方法，这个方法就算是后来添加的元素，也能绑定方法
		/***
		$(".edit_btn").live(function(){
			alert("edit");
		});
		***/
		//但是新版jquery没有live方法，使用on方法进行替代
		/*** 下面的写法 不对
		$(".edit_btn").on("click",function(){
			alert("edit");
		});
		***/
		//注意 这里是 .edit_btn  叫伪类吧
		$(document).on("click",".edit_btn",function(){
			
			//0、清空表单样式和内容
			reset_form("#empUpdateModal form");
			
			//1、查出部门信息，并显示部门列表
			getDepts("#empUpdateModal select");
			//2、查询员工信息，并显示员工信息  // 坑爹 一开始写成了 attr(edit-id) 
			 getEmp($(this).attr("edit-id"));
			
			//3、把员工的id传递给模态框的更新按钮，为了发送ajax时传递id
			$("#emp_update_done_btn").attr("edit-id",$(this).attr("edit-id"));
			
			//alert("edit");
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
			
			
		});
		
		function getEmp(id){
			
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"get",
				success:function(result){
					console.log(result);
					var empData = result.extend.emp;
					$("#empName_update_input_disable").val(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
				
			})
		}
		
		//校验 email框
		$("#email_update_input").change(function(){
			//校验表单
			validate_form_ele("#email_update_input",g_email_reg,g_email_valid,g_email_invalid_format)
			console.log("变化方法---邮箱校验");		
			});
		
	
		
		//点击更新，更新员工信息
		$("#emp_update_done_btn").click(function(){
			
			console.log("提交更新方法---邮箱校验");		

			//验证邮箱是否合法
			if(!validate_form_ele("#email_update_input",g_email_reg,g_email_valid,g_email_invalid_format))
            return false;

			
			//2、发送ajax请求保存更新的员工数据
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"post",
				data:$("#empUpdateModal form").serialize()+"&_method=put",
				success:function(result){
					//alert(result);
					//console.log(result);
					if(result.code=100){
						//1、员工修改成功，需要关闭模态框。
						$("#empUpdateModal").modal("hide");
						//2、来到最后一页，显示刚才的数据；发送ajax请求，显示最后一页数据即可(用总记录数请求，保证是请求足够大，mybatis 分页插件 已经在mybatis-config.xml中配置了数据合法性校验，只会返回最后一页数据)
						to_page(g_currentPage);
						}
					else{
						//后端校验  显示失败信息
						if(undefined!=result.extend.errorFileds.email){
		                	//显示邮箱错误信息
		    				show_validate_msg("#email_update_input","error",result.extend.errorFileds.email);
		                }
					}
					
				}
							
			  /****	
			$.ajax({			  
			    url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					//1、关闭对话框
					$("#empUpdateModal").modal("hide");
					//2、回到本页面
					to_page(currentPage);
				}
			});
				*****/
				
			});
		});
		
		
	</script>

</body>
</html>