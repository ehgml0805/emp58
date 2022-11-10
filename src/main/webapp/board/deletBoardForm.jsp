<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%
//분석
request.setCharacterEncoding("utf-8");

Board b = new Board();
b.boardNo = Integer.parseInt(request.getParameter("boardNo"));

//처리
Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees", "root", "java1234");
System.out.println(conn + "<--conn");
String sql = "SELECT board_pw FROM board WHERE board_no=?";
PreparedStatement stmt = conn.prepareStatement(sql);
stmt.setInt(1, b.boardNo);

ResultSet rs = stmt.executeQuery();

if (rs.next()) {
	b.boardPw = rs.getString("board_pw");

}
%>

<!DOCTYPE html>
<html>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시물 삭제</h1>
	<form action="<%=request.getContextPath()%>/board/deletboardAction.jsp"
		method="post">
		<table class="table table-bordered table-hover">
			<tr>
				<td>번호</td>
				<td><input type="text" name="boardNo" value="<%=b.boardNo%>"
					readonly="readonly"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="text" name="boardPw"></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-success d-grid">삭제</button>
		<button type="button" onclick="history.back(-1)" class="btn btn-success d-grid">취소</button>
	</form>

</body>
</html>