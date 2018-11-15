<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
		http://localhost:3306/crud
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
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list}" var="emp">
						<tr>
							<td>${emp.empId}</td>
							<td>${emp.empName }</td>
							<td>${emp.gender == "M" ? "男" : "女"}</td>
							<td>${emp.email}</td>
							<td>${emp.department.deptName}</td>
							<td>
								<button class="btn btn-primary btn-sm">
									<i class="icon-edit icon-large"></i> 编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<i class="icon-trash icon-large"></i> 删除
								</button>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<div class="col-md-6">
				当前第${pageInfo.pageNum}页,总共有${pageInfo.pages}页，总共有${pageInfo.total}记录。
			</div>


			<div class="col-md-6">
				<nav aria-label="Page navigation example">
				<ul class="pagination">
					<li class="page-item"><a class="page-link"
						href="${APP_PATH}/emps?pn=1">首页</a></li>

					<c:if test="${pageInfo.hasPreviousPage}">
						<li class="page-item"><a class="page-link"
							href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span><span
								class="sr-only">Previous</span></a></li>
					</c:if>
					<!-- jstl 标签 获取的都是用 .属性  不能用 get属性方法，否则会报错-->
					<c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
						<c:choose>
							<c:when test="${pageInfo.pageNum == page_Num }">
								<li class="page-item active"><a class="page-link" href="#">${page_Num}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link"
									href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<c:if test="${pageInfo.hasNextPage}">
						<li class="page-item"><a class="page-link"
							href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span> <span
								class="sr-only">Next</span>
						</a></li>
					</c:if>
					<li class="page-item"><a class="page-link"
						href="${APP_PATH}/emps?pn=${pageInfo.pages }">末页</a></li>
				</ul>
				</nav>
			</div>
		</div>
	</div>


</body>
</html>