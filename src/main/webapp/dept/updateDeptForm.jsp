<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%	
	//1. 요청분석
	request.setCharacterEncoding("utf-8");
	Department d= new Department();
	d.deptNo=request.getParameter("deptNo");
	if(request.getParameter("deptNo")==null){
		response.sendRedirect(request.getContextPath()+"/dept/deptList.jsp");
		return;
	}

	//2.요청처리
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn=DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");	
	String sql="SELECT dept_name FROM departments WHERE dept_no=?";
	PreparedStatement stmt=conn.prepareStatement(sql);
	stmt.setString(1,d.deptNo);
	
	ResultSet rs=stmt.executeQuery();
		
	if(rs.next()){
		d.deptName=rs.getString("dept_name");
	}

%>


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
<title>부서 수정</title>
</head>
<body>
	<div style="text-align: center;">
		<jsp:include page="/inc/menu.jsp"></jsp:include> <!-- =request.getContextPath() 인클루드 안에 안 적음 -->
	</div>
	<h2 style="text-align: center;"><p class="text-primary">부서 수정</p></h2>
	
	
	<form method="post" action="<%=request.getContextPath()%>/dept/updateDeptAction.jsp">
		<table class="table table-bordered">
			<tr>
				<td>부서번호</td>
				<td>
					<input type="text" class="form-control" name="dept_no" value="<%=d.deptNo %>" readonly="readonly"><!--부서번호는 수정 불가  -->
				</td>
			</tr>
			<tr>
				<td>부서이름</td>
				<td>
					<input type="text" class="form-control" name="dept_name" value="<%=d.deptName %>">
				</td>
			</tr>
		</table>
		<button type="submit" class="btn btn-primary">수정</button>
	</form>
</body>
</html>