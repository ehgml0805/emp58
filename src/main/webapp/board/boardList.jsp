<%@page import="vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.Board.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%
//1 요청분석

int currentPage = 1;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}

//2 처리 후 필요하다면 모델데이터를 생성
Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees", "root", "java1234");

//페이징 하기
final int ROW_PER_PAGE = 10;//finer을 붙이면 나중에 rowPerPage 변경 불가 10개씩 출력할 것
int beginRow = (currentPage - 1) * ROW_PER_PAGE;//몇번부터 뽑을거냐?  Limit beginRow, ROW_PER_PAGE
String cntSql = "SELECT COUNT(*) cnt FROM board";
PreparedStatement cntStmt = conn.prepareStatement(cntSql);
ResultSet cntRs = cntStmt.executeQuery();
int cnt = 0;//전체 행의 개수
if (cntRs.next()) {
	cnt = cntRs.getInt("cnt");
}
int lastPage = (int) Math.ceil((double) cnt / (double) ROW_PER_PAGE);// 마지막 페이지

String listSql = "SELECT board_no boardNo, board_title boardTitle, board_content boardContent,board_writer boardWriter,createdate createDate FROM board ORDER BY board_no asc LIMIT ?,?";
PreparedStatement listStmt = conn.prepareStatement(listSql);
listStmt.setInt(1, beginRow);//몇번부터 뽑을거냐
listStmt.setInt(2, ROW_PER_PAGE);//몇개씩 출력할거냐
ResultSet listRs = listStmt.executeQuery();

ArrayList<Board> boardList = new ArrayList<Board>();
while (listRs.next()) {
	Board b = new Board();
	b.boardNo = listRs.getInt("boardNo");
	b.boardTitle = listRs.getString("boardTitle");
	b.boardWriter = listRs.getString("boardWriter");
	boardList.add(b);
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
	<h1>자유게시판</h1>
	<!-- 모델데이터 어레이리스트 -->
	<table class="table table-bordered table-hover">
		<thead class="table-success">
			<tr>
				<th>No.</th>
				<th>제목</th>
				<th>작성자</th>
			</tr>
		</thead>
		<tbody>
			<%
			for (Board b : boardList) {
			%>
			<tr>
				<td><%=b.boardNo%></td>
				<td><a
					href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.boardNo%>">
						<%=b.boardTitle%>
				</a></td>
				<td><%=b.boardWriter%></td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>
	<div>
		<a href="<%=request.getContextPath()%>/board/insertBoardForm.jsp">게시글
			추가</a>
	</div>


	<!-- 페이징 -->

	<a
		href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=1">처음</a>
	<%
	if (currentPage > 1) {//현재페이지가 1보다 클때 이전 표시
	%>
	<a
		href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage - 1%>">이전</a>
	<%
	}
	%>
	<span><%=currentPage%></span>
	<%
	if (currentPage < lastPage) {//마지막 페이지보다 작을 때 다음 표시
	%>
	<a
		href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
	<%
	}
	%>

	<a
		href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=lastPage%>">마지막</a>

</body>
</html>