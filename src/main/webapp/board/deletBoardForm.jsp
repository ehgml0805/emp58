<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%
//분석
request.setCharacterEncoding("utf-8");
//강사님이 쓰신거
//String msg=request.getParameter("msg");
//삭제 실패하면 폼으로 돌아와서 여기서 에러남 java.lang.NumberFormatException: Cannot parse null string
//int boardNo= Integer.parseInt(request.getParameter("boardNo"));

//내가 생각한 것
Board b = new Board();
//삭제 실패하면 폼으로 돌아와서 여기서 에러남 java.lang.NumberFormatException: Cannot parse null string
//해결 방법: Action에서 44행 마지막에 실패시 폼으로 돌려 보낸다 쓰고 블라블라~ ?boardNo="+boardNo+"&msg"+msg 이거 써주니 해결됨 근데 무슨 뜻?
//흐음... 이게 msg는 받아오는데 boardNo를 다시 못 받아와서 써줘야하나,,?
b.boardNo = Integer.parseInt(request.getParameter("boardNo"));
String msg=request.getParameter("msg");

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
	<%
		if(msg!=null){
	%>
		<div><%=msg%></div>
	<%	
		}
	%>
	<form action="<%=request.getContextPath()%>/board/deletboardAction.jsp"
		method="post">
		<table class="table table-bordered table-hover">
			<tr>
				<td>번호</td>
				<td><input type="text" name="boardNo" value="<%=b.boardNo%>"
					readonly="readonly"></td><!-- type hidden 가능 -->
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="boardPw"></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-success d-grid">삭제</button>
		<button type="button" onclick="history.back(-1)" class="btn btn-success d-grid">취소</button>
	</form>

</body>
</html>