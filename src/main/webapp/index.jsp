<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>

<style type="text/css">
body {
	background-color: #DAD9FF;
}

h1 {
	text-align: center;
}
</style>
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
			href="<%=request.getContextPath()%>/deptEmp/deptEmpListMap.jsp">부서별 사원 관리</a></li>
		<li class="nav-item"><a class="nav-link"
			href="<%=request.getContextPath()%>/board/boardList.jsp">게시판 관리</a></li>
		<li class="nav-item"><a class="nav-link"
			href="<%=request.getContextPath()%>/salary/salaryMap.jsp">연봉 관리</a></li>
		

	</ol>
</body>
</html>