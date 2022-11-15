<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>

<%
//분석
request.setCharacterEncoding("utf-8");
String word = request.getParameter("word");
int currentPage = 1;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
//설치 및 연결
String driver = "org.mariadb.jdbc.Driver";
Class.forName(driver);
System.out.println("설치성공");
String dbUrl = "jdbc:mariadb://127.0.0.1:3306/employees";
String dbUser = "root";
String dbPw = "java1234";
Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
System.out.println("연결: " + conn);

int rowPerPage = 10;//10개씩 보여줄거
int beginRow = (currentPage - 1) * rowPerPage;//0번부터 보여줄거 0으로 설정 해버리면 다음페이지 넘어가서도 0~9번까지만 나옴
//페이징
String countSql = null;
PreparedStatement countStmt = null;
if (word == null) {
	countSql = "SELECT COUNT(*) c FROM dept_emp;";
	countStmt = conn.prepareStatement(countSql);
} else {
	countSql = "SELECT COUNT(*) c FROM dept_emp de INNER JOIN  employees e ON de.emp_no=e.emp_no WHERE e.first_name LIKE ? OR e.last_name LIKE ?;";
	countStmt = conn.prepareStatement(countSql);
	countStmt.setString(1, "%" + word + "%");
	countStmt.setString(2, "%" + word + "%");
}
ResultSet countRs = countStmt.executeQuery();
int count = 0;//전체 행의 개수
if (countRs.next()) {
	count = countRs.getInt("c");
}

int lastPage = count / rowPerPage;
if (lastPage != 0) {
	lastPage = lastPage + 1;
}
//쿼리
String sql = null;
PreparedStatement stmt = null;
if (word == null) {
	sql = "SELECT de.emp_no empNo, CONCAT(e.first_name, ' ' ,e.last_name) name , d.dept_name deptName, de.from_date fromDate, de.to_date toDate FROM dept_emp de INNER JOIN employees e ON de.emp_no=e.emp_no INNER JOIN departments d ON de.dept_no=d.dept_no ORDER BY de.emp_no ASC LIMIT ?,?;";
		//dept_emp안에 있는 emp-no를 employees에서 참조하고 dept_emp안에 있는 dept_no를 departments에서 참조 
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, beginRow);
	stmt.setInt(2, rowPerPage);
} else {
	sql = "SELECT de.emp_no empNo, CONCAT(e.first_name, ' ' ,e.last_name) name , d.dept_name deptName, de.from_date fromDate, de.to_date toDate FROM dept_emp de INNER JOIN employees e ON de.emp_no=e.emp_no INNER JOIN departments d ON de.dept_no=d.dept_no WHERE e.first_name LIKE ? OR e.last_name LIKE ? ORDER BY de.emp_no ASC LIMIT ?,?;";
		//dept_emp안에 있는 emp-no를 employees에서 참조하고 dept_emp안에 있는 dept_no를 departments에서 참조   
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, "%" + word + "%");
	stmt.setString(2, "%" + word + "%");
	stmt.setInt(3, beginRow);
	stmt.setInt(4, rowPerPage);
}

ResultSet rs = stmt.executeQuery();
ArrayList<DeptEmp> list = new ArrayList<DeptEmp>();
while (rs.next()) {
	DeptEmp de = new DeptEmp();
	de.emp = new Employee();//dept_emp에 employee결합
	de.emp.empNo = rs.getInt("empNo");
	de.emp.firstName = rs.getString("name");
	de.emp.lastName = rs.getString("name");
	de.dept = new Department();//dept_emp에 departments 결합
	de.dept.deptName = rs.getString("deptName");
	de.fromDate = rs.getString("fromDate");
	de.toDate = rs.getString("toDate");
	list.add(de);
}
stmt.close();
conn.close();
%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
table {
	background-color:;
	text-align: center;
}
</style>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="text-align: center;">
		<jsp:include page="/inc/menu.jsp"></jsp:include>
		<!-- =request.getContextPath() 인클루드 안에 안 적음 -->
	</div>
	<h1 style="text-align: center">사원별 부서 관리</h1>
	<!-- 사원 검색 -->
	<form action="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp">
		<label>사원 검색: </label><input type="text" name="word" id="word">
		<button type="submit">검색</button>
	</form>
	<table class="table table-bordered table-hover">
		<tr>
			<th>사원 번호</th>
			<th>사원 이름</th>
			<th>부서명</th>
			<th>입사일</th>
			<th>퇴사일</th>
		</tr>
		<%
		for (DeptEmp de : list) {
		%>
		<tr>
			<td><%=de.emp.empNo%></td>
			<td><%=de.emp.firstName%></td>
			<td><%=de.dept.deptName%></td>
			<td><%=de.fromDate%></td>
			<td><%=de.toDate%></td>
		</tr>
		<%
		}
		%>
	</table>
	<%
	if (word == null || word.equals("")) {
	%>
		<a href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=1">처음</a>
		<%
		if (currentPage > 1) {
		%>
		<a href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=<%=currentPage - 1%>">이전</a>
		<%
		}
		%>
		<span><%=currentPage%></span>
		<%
		if (currentPage < lastPage) {
		%>
		<a href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
		<%
		}
		%>
		<a href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=<%=lastPage%>">마지막</a>
	<%
	} else {
	%>
		<a href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=1&word=<%=word%>">처음</a>
		<%
		if (currentPage > 1) {
		%>
		<a href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=<%=currentPage - 1%>&word=<%=word%>">이전</a>
		<%
		}
		%>
		<span><%=currentPage%></span>
		<%
		if (currentPage < lastPage) {
		%>
		<a href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=<%=currentPage + 1%>&word=<%=word%>">다음</a>
		<%
		}
		%>
		<a href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=<%=lastPage%>&word=<%=word%>">마지막</a>
	<%
	}
	%>


</body>
</html>