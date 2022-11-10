<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%
//분석
request.setCharacterEncoding("utf-8");
int boardNo=Integer.parseInt(request.getParameter("boardNo"));
String boardTitle=request.getParameter("boardTitle");
String boardContent=request.getParameter("boardContent");
String boardWriter=request.getParameter("boardWriter");
String boardPw=request.getParameter("boardPw");
String createdate=request.getParameter("createdate");

Board b = new Board();
b.boardNo=boardNo;
b.boardTitle=boardTitle;
b.boardContent=boardContent;
b.boardWriter=boardWriter;
b.boardPw=boardPw;
b.createDate=createdate;

//처리
Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root", "java1234");
	String sql = "UPDATE board SET board_title=?, board_content=?, board_writer=? WHERE board_no = ? AND board_pw = ?";//오타조심...
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, b.boardTitle);
	stmt.setString(2, b.boardContent);
	stmt.setString(3, b.boardWriter);
	stmt.setInt(4, b.boardNo);
	stmt.setString(5, b.boardPw);


int row=stmt.executeUpdate();
if (row == 1) {
	System.out.println("수정성공");
} else {
	System.out.println("수정실패");
}

response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
//출력

%>