<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
h1 {
	text-align: center;
	width: 600px;
	background-color: #DAD9FF;
	margin: 0 auto;
}
</style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>index</title>
</head>
<body>

	<h1>INDEX</h1>
	<ol class="nav nav justify-content-center">
		<li class="nav-item"><a class="nav-link"
			href="<%=request.getContextPath()%>/dept/deptList.jsp">부서 관리</a></li>
		<li class="nav-item"><a class="nav-link"
			href="<%=request.getContextPath()%>/emp/empList.jsp">사원 관리</a></li>
		<li class="nav-item"><a class="nav-link"
			href="<%=request.getContextPath()%>/board/boardList.jsp">게시판 관리</a></li>
		<li class="nav-item"><a class="nav-link"
			href="<%=request.getContextPath()%>/salary/salaryMap.jsp">연봉 관리</a></li>

	</ol>
</body>
</html>