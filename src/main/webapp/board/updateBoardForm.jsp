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

String sql = "SELECT board_title, board_content,board_writer,createdate FROM board WHERE board_no=?";
PreparedStatement stmt = conn.prepareStatement(sql);
stmt.setInt(1, b.boardNo);

ResultSet rs = stmt.executeQuery();

if (rs.next()) {
	b.boardTitle = rs.getString("board_title");
	b.boardContent = rs.getString("board_content");
	b.boardWriter = rs.getString("board_Writer");
	b.createDate = rs.getString("createdate");
}
//출력
%>



<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
		<!-- =request.getContextPath() 인클루드 안에 안 적음 -->
	</div>
	<h1>게시글 수정하기</h1>
	<form
		action="<%=request.getContextPath()%>/board/updateboardAction.jsp"
		method="post">
		<table class="table table-bordered table-hover">
			<tr>
				<td>번호</td>
				<td><input type="text" name="boardNo" value="<%=b.boardNo%>"
					readonly="readonly"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="boardTitle"
					value="<%=b.boardTitle%>"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea cols="50" rows="10" name="boardContent"></textarea></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="boardWriter"
					value="<%=b.boardWriter%>"></td>
			</tr>
			<tr>
				<td>작성날짜</td>
				<td><input type="text" name="createdate"
					value="<%=b.createDate%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="text" name="boardPw"></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-success d-grid">수정</button>
	</form>
</body>
</html>