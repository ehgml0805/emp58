<%@page import="org.eclipse.jdt.internal.compiler.env.INameEnvironment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%
	//페이지 알고리즘
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	//2
	int rowPerPage = 10;//한 페이지에 10개씩 보여줄거
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees", "root", "java1234");
	
	String countSql = "SELECT COUNT(*) FROM employees";//총 개수
	PreparedStatement countStmt = conn.prepareStatement(countSql);
	ResultSet countRs = countStmt.executeQuery();
	int count = 0;
	if (countRs.next()) {
		count = countRs.getInt("COUNT(*)");
	}
	
	int lastPage = count / rowPerPage;//총 개수 나누기 한페이지에 나타날 개수
	if (count % rowPerPage != 0) {//딱 나누어 떨어지지 않으면 한페이지 더 추가 할 거
		lastPage = lastPage + 1;
	}
	
	//한페이지당 출력할 emp 목록
	String empsql = "SELECT emp_no empNo, first_name firstName, last_name lastName FROM employees ORDER BY emp_no ASC LIMIT ?,?";
	PreparedStatement empStmt = conn.prepareStatement(empsql);
	empStmt.setInt(1, rowPerPage * (currentPage - 1));//몇번부터 고정적으로 몇개씩 출력할 것인가? 나는 0번부터 10개씩 1페이지씩 늘려갈거다
	empStmt.setInt(2, rowPerPage);//고정 출력 개수 10
	ResultSet empRs = empStmt.executeQuery();
	
	ArrayList<Employee> empList = new ArrayList<Employee>();
	while (empRs.next()) {
		Employee e = new Employee();
		e.empNo = empRs.getInt("empNo");
		e.firstName = empRs.getString("firstName");
		e.lastName = empRs.getString("lastName");
		empList.add(e);
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
		<!-- =request.getContextPath() 인클루드 안에 안 적음 -->
	</div>

	<h1>사원목록</h1>
	<!-- 부서별 사원 목록 출력 되도록 -->

	<div>
		현재 페이지:<%=currentPage%></div>

	<table border="1">
		<tr>
			<th>사원번호</th>
			<th>퍼스트 네임</th>
			<th>라스트 네임</th>
		</tr>
		<%
			for (Employee e : empList) {
			%>
		<tr>
			<td><%=e.empNo%></td>
			<td><%=e.firstName%></td>
			<td><%=e.lastName%></td>
		</tr>
		<%
			}
			%>
	</table>


	<a href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=1">처음</a>
	<%
	if (currentPage > 1) {//currentPage가 1페이지보다 클 때만 이전 띄움
	%>
	<a href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=currentPage - 1%>">이전</a>
	<%
	}

	if (currentPage < lastPage) {
	%>
	<a href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
	<%
	}
	%>
	<a href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=lastPage%>">마지막</a>
</body>
</html>