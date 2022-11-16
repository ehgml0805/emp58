<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<style type="text/css">
body {
	background: ;
	text-align: center;
}
</style>
<meta charset="UTF-8">
<title>부서 추가</title>
</head>
<body>
	<div style="text-align: center;">
		<jsp:include page="/inc/menu.jsp"></jsp:include> <!-- =request.getContextPath() 인클루드 안에 안 적음 -->
	</div>
	<h2 style="text-align: center;"> <p class="text-primary">부서 추가</p></h2>
	
	<!-- msg 파라미터값이 있으면 출력 -->
	<%
		if(request.getParameter("msg")!=null){
	%>
		 <div><%=request.getParameter("msg")%></div>
	<%
		}
	%>
	<form action="<%=request.getContextPath()%>/dept/insertDeptAction.jsp" method="post">
		<table class="table table-bordered">
			<tr>
				<td>부서번호</td>
				<td>
					<input type="text" class="form-control" name="dept_no">
				</td>
			</tr>
			<tr>
				<td>부서이름</td>
				<td>
					<input type="text" class="form-control" name="dept_name">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit" class="btn btn-primary">추가</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>