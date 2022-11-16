<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%><!-- hashmap<키, 값> ArrayList<요소>-->

<%
//분석 페이징..currentPage
request.setCharacterEncoding("utf-8");
String word= request.getParameter("word");
int currentPage = 1;//페이지 1부터 시작
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}

//처리 
//db연결 후 모델 생성
String driver = "org.mariadb.jdbc.Driver";
Class.forName(driver);
// 디버깅 System.out.println("드라이버 설치 성공");
String dburl1 = "jdbc:mariadb://127.0.0.1:3306/employees";
String dbUser = "root";
String dbPw = "java1234";
Connection conn = DriverManager.getConnection(dburl1, dbUser, dbPw);//커넥션 가져오는거
// 디버깅 System.out.println(conn + "<-연결ㅇ");

int rowPerPage = 10;// final 상수 잘 안만듦 한 페이지에 10개씩
int beginRow = (currentPage-1)*rowPerPage;//0번부터 뽑을거

//페이징
String countSql=null;
PreparedStatement countStmt=null;
if(word==null){
	countSql = "SELECT COUNT(*) c FROM salaries; ";
	countStmt = conn.prepareStatement(countSql);
}else{
	countSql="SELECT COUNT(*) c FROM salaries s INNER JOIN employees e ON s.emp_no=e.emp_no WHERE e.first_name LIKE ? OR e.last_name LIKE ?;";
	countStmt=conn.prepareStatement(countSql);
	countStmt.setString(1, "%"+word+"%");
	countStmt.setString(2, "%"+word+"%");
}
ResultSet countRs = countStmt.executeQuery();
int count = 0;//전체 행의 개수
if (countRs.next()) {
	count = countRs.getInt("c");
}
int lastPage = count / rowPerPage;//마지막 페이지 
if (lastPage != 0) {
	lastPage = lastPage + 1;
}
//쿼리
String sql=null;
PreparedStatement stmt=null;
if(word==null){
	sql = "SELECT s.emp_no empNo,s.salary salary , s.from_date fromDate, CONCAT(e.first_name, ' ' ,e.last_name) name FROM salaries s INNER JOIN employees e ON s.emp_no=e.emp_no ORDER BY s.emp_no ASC LIMIT ?,?;";//salaries 안에 있는 emp_no를 employees에서 참조
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, beginRow);
	stmt.setInt(2, rowPerPage);
}else{
	sql = "SELECT s.emp_no empNo, s.salary salary , s.from_date fromDate, CONCAT(e.first_name, ' ' ,e.last_name) name FROM salaries s INNER JOIN employees e ON s.emp_no=e.emp_no WHERE e.first_name LIKE ? OR e.last_name LIKE ? ORDER BY s.emp_no ASC LIMIT ?,?;";//salaries 안에 있는 emp_no를 employees에서 참조
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, "%"+word+"%");
	stmt.setString(2, "%"+word+"%");
	stmt.setInt(3, beginRow);
	stmt.setInt(4, rowPerPage);
	
}
ResultSet rs = stmt.executeQuery();
ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
while (rs.next()) {
	HashMap<String, Object> m = new HashMap<String, Object>();
	m.put("empNo", rs.getInt("empNo")); //put
	m.put("salary", rs.getInt("salary")); //put
	m.put("fromDate", rs.getString("fromDate")); //put
	m.put("name", rs.getString("name")); //put
	list.add(m);
}


stmt.close();
conn.close();//커넥션 끊는거 중간에 쓰면 오류 남! 맨 밑에 써주기
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
	background-color:;
	text-align: center;
}
</style>
<meta charset="UTF-8">
<title>연봉 관리</title>
</head>
<body>
	<div style="text-align: center;">
		<jsp:include page="/inc/menu.jsp"></jsp:include>
		<!-- =request.getContextPath() 인클루드 안에 안 적음 -->
	</div>
	<h1 style="text-align: center">연봉 관리</h1>
	<!-- 사원검색 -->
	<form action="<%=request.getContextPath()%>/salary/salaryMap.jsp">
		<label>사원 검색: </label> <input type="text" name="word" id="word">
		<button type="submit">검색</button>
	</form>
	<table class="table table-bordered table-hover ">
		<tr class="table-success">
			<th>사원 번호</th>
			<th>사원 이름</th>
			<th>연봉</th>
			<th>연봉 협상일</th>
		</tr>
		<%
		for (HashMap<String, Object> m : list) {
		%>
		<tr>
			<td><%=m.get("empNo")%></td>
			<td><%=m.get("name")%></td>
			<td><%=m.get("salary")%></td>
			<td><%=m.get("fromDate")%></td>
		</tr>
		<%
		}
		%>

	</table>
	<!--  페이징 -->
	<%
	if(word==null||word.equals("")){//검색 값이 없으면 그냥 페이지 보여주듯? 보여주고
%>
	<a
		href="<%=request.getContextPath()%>/salary/salaryMap.jsp?currentPage=1">처음</a>
	<%
		if (currentPage > 1) {
		%>
	<a
		href="<%=request.getContextPath()%>/salary/salaryMap.jsp?currentPage=<%=currentPage - 1%>">이전</a>
	<%
		}
		%>
	<span><%=currentPage%></span>
	<%
		if (currentPage < lastPage) {
		%>
	<a
		href="<%=request.getContextPath()%>/salary/salaryMap.jsp?currentPage=<%=currentPage + 1%>">다음</a>
	<%
		}
		%>
	<a
		href="<%=request.getContextPath()%>/salary/salaryMap.jsp?currentPage=<%=lastPage%>">마지막</a>
	<%
	} else{
%>
	<a
		href="<%=request.getContextPath()%>/salary/salaryMap.jsp?currentPage=1&word=<%=word%>">처음</a>
	<%
		if (currentPage > 1) {
		%>
	<a
		href="<%=request.getContextPath()%>/salary/salaryMap.jsp?currentPage=<%=currentPage - 1%>&word=<%=word%>">이전</a>
	<%
		}
		%>
	<span><%=currentPage%></span>
	<%
		if (currentPage < lastPage) {
		%>
	<a
		href="<%=request.getContextPath()%>/salary/salaryMap.jsp?currentPage=<%=currentPage + 1%>&word=<%=word%>">다음</a>
	<%
		}
		%>
	<a
		href="<%=request.getContextPath()%>/salary/salaryMap.jsp?currentPage=<%=lastPage%>&word=<%=word%>">마지막</a>

	<%		
	}
%>

</body>
</html>