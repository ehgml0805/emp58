<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%
//1.요청분석(요청한 게 없음)==Controller
request.setCharacterEncoding("utf-8");
String word = request.getParameter("word");
//word 가 null ,'','단어' 경우의 수 3개



//2. 업무처리==Model--> 모델데이터(단일값 혹은 자료구조형태(배열 리스트 등등))
//드라이버 설치 및 확인
Class.forName("org.mariadb.jdbc.Driver");
System.out.println("드라이버 성공");
// 연결 혹은 접속 확인
Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees", "root", "java1234");
System.out.println(conn + "<--conn");

String sql=null;
PreparedStatement stmt=null;
if(word==null){
sql = "SELECT dept_no deptNo, dept_name deptName FROM departments ORDER BY dept_no ASC";
 stmt = conn.prepareStatement(sql);
}else{
	sql="SELECT dept_no deptNo, dept_name deptName FROM departments WHERE dept_name LIKE? ORDER BY dept_no ASC";
	 stmt = conn.prepareStatement(sql);
	 stmt.setString(1,"%"+word+"%");
}
ResultSet rs = stmt.executeQuery();
//이게 모델데이터 일반적 타입x,독립적인 타입x 일반적인 타입은 배열임
//ResultSet rs라는 모델자료구조를 좀 더 일반적이고 독립적인 자료구조로 변경해야 함
ArrayList<Department> list = new ArrayList<Department>();
while (rs.next()) { //ResultSet의 API(사용방법)를 모른다면 사용할 수 없는 반복문임
	Department d = new Department();
	d.deptNo = rs.getString("deptNo");
	d.deptName = rs.getString("deptName");
	list.add(d);
}
//3.출력==View--> 모델데이터를 고객이 원하는 형태로 출력 ->뷰(리포트)
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
<title>부서 목록</title>
</head>
<body>
	<div style="text-align: center;">
		<jsp:include page="/inc/menu.jsp"></jsp:include>
		<!-- =request.getContextPath() 인클루드 안에 안 적음 -->
	</div>
	<div>
		<h1 style="text-align: center;">부서 관리</h1>
	</div>
	<!-- 부서명 검색창 -->
	<form method="post" style="text-align: center;"
		action="<%=request.getContextPath()%>/dept/deptList.jsp">
		<label for="">부서이름 검색: </label> <input type="text" name="word"
			id="word">
		<button type="submit" class="btn btn-primary">검색</button>
	</form>
	<div>
		<a href="<%=request.getContextPath()%>/dept/insertDeptForm.jsp">부서 추가</a>
	</div>
	<div>
		<!-- 부서목록 출력 내림차순으로 -->
		<table class="table table-bordered">
				<tr class="table-primary">
					<th>부서번호</th>
					<th>부서이름</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
				<%
				for (Department d : list) {//일반적인 자바 문법에서 제공하는 foreach문
				%>
				<tr>
					<td><%=d.deptNo%></td>
					<td><%=d.deptName%></td>
					<td><a
						href="<%=request.getContextPath()%>/dept/updateDeptForm.jsp?deptNo=<%=d.deptNo%>">수정</a></td>
					<td><a
						href="<%=request.getContextPath()%>/dept/deletDept.jsp?deptNo=<%=d.deptNo%>">삭제</a></td>

					<%
					}
					%>
				</tr>
		</table>
	</div>
</body>
</html>