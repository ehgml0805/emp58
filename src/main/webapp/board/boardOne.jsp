<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>

<%
//분석
request.setCharacterEncoding("utf-8");
int boardNo = Integer.parseInt(request.getParameter("boardNo"));
int currentPage = 1;//페이지는 1번부터 시작할거
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}

//처리
Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees", "root", "java1234");
System.out.print(conn);
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
//댓글 페이징 하기
int rowPerPage = 5;//한페이지에 5개만 나오게 보여줄거
int beginRow = (currentPage - 1) * rowPerPage;//몇번 부터 뽑아서 보여 줄거? 0번 째부터 보여줄거
String cntSql = "SELECT COUNT(*) cnt FROM comment WHERE board_no=?; ";//총 행 개수 쿼리가 아니라 board_no1에 있는 댓글 수 
PreparedStatement cntStmt = conn.prepareStatement(cntSql);
cntStmt.setInt(1, board.boardNo);
ResultSet cntRs = cntStmt.executeQuery();
int cnt = 0;//전체 행의 개수
if (cntRs.next()) {
	cnt = cntRs.getInt("cnt");
}
int lastPage = cnt / rowPerPage;
if(cnt%rowPerPage!=0){//딱 나누어 떨어지지 않으면 페이지 하나더 추가
	lastPage=lastPage+1;
}
//댓글 부분 만들기
String commentSql = "SELECT comment_no commentNo, comment_content commentContent FROM comment WHERE board_no = ? ORDER BY comment_no DESC LIMIT ?,?";
PreparedStatement commentStmt = conn.prepareStatement(commentSql);
commentStmt.setInt(1, boardNo);
commentStmt.setInt(2, beginRow);
commentStmt.setInt(3, rowPerPage);

ResultSet commentRs = commentStmt.executeQuery();
ArrayList<Comment> commentList = new ArrayList<Comment>();
while (commentRs.next()) {
	Comment c = new Comment();
	c.commentNo = commentRs.getInt("commentNo");
	c.commentContent = commentRs.getString("commentContent");
	commentList.add(c);

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
	<div>
		<!-- 댓글입력 폼 -->
		<h2>댓글입력</h2>
		<form
			action="<%=request.getContextPath()%>/board/insertCommentAction.jsp"
			method="post">
			<table>
				<input type="hidden" name="boardNo" value="<%=board.boardNo%>">
				<tr>
					<td>내용</td>
					<td><textarea rows="3" cols="50" name="commentContent"></textarea>
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="commentPw"></td>
				</tr>
			</table>
			<button type="submit">댓글입력</button>
		</form>
	</div>

	<div>
		<!-- 댓글목록 -->
		<%
		for (Comment c : commentList) {
		%>
		<div>
			<div>
				no<%=c.commentNo%>
				<a href="<%=request.getContextPath()%>/board/deletCommentForm.jsp?commentNo=<%=c.commentNo%>&boardNo=<%=boardNo%>">삭제
				</a>
			</div>
			<div>
				내용: &nbsp;
				<%=c.commentContent%></div>
		</div>
		<%
		}
		%>

		<!-- 댓글 페이징 -->
		<a
			href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=board.boardNo%>&currentPage=1">처음
		</a>

		<%
		if (currentPage > 1) {
		%>
		<a
			href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=board.boardNo%>&currentPage=<%=currentPage - 1%>">이전
		</a>
		<%
		}
		%>
			<span><%=currentPage%></span>
		<%
		if (currentPage < lastPage) {
		%>
		<a
			href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=board.boardNo%>&currentPage=<%=currentPage + 1%>">다음
		</a>
		<%
		}
		%>
		<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=board.boardNo%>&currentPage=<%=lastPage%>">마지막
		</a>

	</div>

</body>
</html>