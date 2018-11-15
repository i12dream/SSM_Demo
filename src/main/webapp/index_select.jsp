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
			<div class="col-md-4 offset-md-8">
				<button class="btn btn-primary btn-sm">
					<i class="icon-edit icon-large"></i> 编辑
				</button>
				<button class="btn btn-danger btn-sm">
					<i class="icon-trash icon-large"></i> 删除
				</button>
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
		//页面加载完成以后，直接发送ajax请求，拿到分页数据
	
		//1、页面加载完成以后，直接去发送ajax请求,要到分页数据
		$(function(){
			//去首页
			to_page(1);
		});
		
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
		
/* 		$(function() {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=1",
				type : "GET",
				success : function(result) {
					//console.log(result) 
					//1、解析并显示员工信息
					build_emps_table(result);
					//2、解析并显示分页信息
					build_page_info(result);
					//3、解析显示分页条
					build_page_nav(result);

				}
			});
		}); */

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
	</script>

</body>
</html>