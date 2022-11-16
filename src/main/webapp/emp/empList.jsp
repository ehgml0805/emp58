<%@page import="org.eclipse.jdt.internal.compiler.env.INameEnvironment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%

//분석
request.setCharacterEncoding("utf-8");
String word=request.getParameter("word");

//페이지 알고리즘
int currentPage = 1;//페이지 시작 1부터
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
//2
int rowPerPage = 10;//한 페이지에 10개씩 보여줄거

Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees", "root", "java1234");


String countSql =null;
PreparedStatement countStmt=null;
if(word==null||word.equals("")){
countSql = "SELECT COUNT(*) FROM employees ";//총 개수
countStmt = conn.prepareStatement(countSql);
}else{
	countSql = "SELECT COUNT(*) FROM employees WHERE first_name LIKE? OR last_name LIKE?;";//검색한 거 총 개수
	countStmt = conn.prepareStatement(countSql);
	countStmt.setString(1,"%"+word+"%");
	countStmt.setString(2,"%"+word+"%");
}
ResultSet countRs = countStmt.executeQuery();

int count = 0; //전체 행의 개수
if (countRs.next()) {
	count = countRs.getInt("COUNT(*)");
}

int lastPage = count / rowPerPage;//총 개수 나누기 한페이지에 나타날 개수
if (count % rowPerPage != 0) {//딱 나누어 떨어지지 않으면 한페이지 더 추가 할 거
	lastPage = lastPage + 1;
}

//한페이지당 출력할 emp 목록
String empSql=null;
PreparedStatement empStmt=null;
if(word==null){
empSql = "SELECT emp_no empNo, first_name firstName, last_name lastName FROM employees ORDER BY emp_no ASC LIMIT ?,?";
empStmt = conn.prepareStatement(empSql);
empStmt.setInt(1, rowPerPage * (currentPage - 1));//몇번부터 고정적으로 몇개씩 출력할 것인가? 나는 0번부터 10개씩 1페이지씩 늘려갈거다
empStmt.setInt(2, rowPerPage);//고정 출력 개수 10
}else{
	empSql = "SELECT emp_no empNo, first_name firstName, last_name lastName FROM employees WHERE first_name LIKE? OR last_name LIKE? ORDER BY emp_no ASC LIMIT ?,?";
	empStmt = conn.prepareStatement(empSql);
	empStmt.setString(1, "%"+word+"%");
	empStmt.setString(2, "%"+word+"%");
	empStmt.setInt(3, rowPerPage * (currentPage - 1));//몇번부터 고정적으로 몇개씩 출력할 것인가? 나는 0번부터 10개씩 1페이지씩 늘려갈거다
	empStmt.setInt(4, rowPerPage);//고정 출력 개수 10
}
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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<style type="text/css">
body {
	background: #DAD9FF;
	text-align: center;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="text-align: center;">
		<jsp:include page="/inc/menu.jsp"></jsp:include>
		<!-- =request.getContextPath() 인클루드 안에 안 적음 -->
	</div>

	<h1 style="text-align: center">사원 목록</h1>
	<!-- 부서별 사원 목록 출력 되도록 -->

	<div style="text-align: center">
		현재 페이지:&nbsp; <%=currentPage%></div>
	<form action="<%=request.getContextPath()%>/emp/empList.jsp"
		method="post">
		<label>사원 검색:&nbsp; </label> <input type="text" name="word" id="word">
		<button type="submit">검색</button>
	</form>

	<table class="table table-bordered table-hover" style="color: black;">
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
	<%
	if (word == null||word.equals("")){ //검색 값이 없으면 그냥 페이지 보여주듯? 보여주고
	%>
		<a href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=1">처음</a>
		<%
		if (currentPage > 1) {//currentPage가 1페이지보다 클 때만 이전 띄움
		%>
		<a href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=currentPage - 1%>">이전</a>
		<%
			}
		%>
		<span><%=currentPage%></span>
		<%
		if (currentPage < lastPage) {
		%>
			<a href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
		<%
			}
		%>
		<a href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=lastPage%>">마지막</a>
	<%
	}else{ //검색 값이 있는거 페이지
	%>
		<a href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=1&word=<%=word%>">처음</a>
		<%
		if(currentPage>1){
		%>
			<a href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=currentPage - 1%>&word=<%=word%>">이전</a>
		<%
		}
		%>
		<span><%=currentPage%></span>
		<%
		if(currentPage<lastPage){
		%>
			<a href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=currentPage + 1%>&word=<%=word%>">다음</a>
		<%
		}
		%>
		<a href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=lastPage%>&word=<%=word%>">마지막</a>
	<%
	} 
	%>

</body>
</html>