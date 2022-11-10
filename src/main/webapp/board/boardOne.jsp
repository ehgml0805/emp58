<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>

<%
//분석
request.setCharacterEncoding("utf-8");
int boardNo = Integer.parseInt(request.getParameter("boardNo"));
//처리
Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees", "root", "java1234");
String sql = "SELECT board_title boardTitle, board_content boardContent,board_writer boardWriter,createdate FROM board WHERE board_no=?";
PreparedStatement stmt = conn.prepareStatement(sql);
stmt.setInt(1, boardNo);
ResultSet rs = stmt.executeQuery();
Board board = null;
if (rs.next()) {
	board = new Board();
	board.boardNo = boardNo;
	board.boardTitle = rs.getString("boardTitle");
	board.boardContent = rs.getString("boardContent");
	board.boardWriter = rs.getString("boardWriter");
	board.createDate = rs.getString("createdate");
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
	<table class="table table-bordered table-hover">
		<tr>
			<td>번호</td>
			<td><%=board.boardNo%></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><%=board.boardTitle%></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><%=board.boardContent%></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><%=board.boardWriter%></td>
		</tr>
		<tr>
			<td>작성날짜</td>
			<td><%=board.createDate%></td>
		</tr>
	</table>
	<a
		href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=board.boardNo%>">수정</a>
	<a
		href="<%=request.getContextPath()%>/board/deletBoardForm.jsp?boardNo=<%=board.boardNo%>">삭제</a>


</body>
</html>