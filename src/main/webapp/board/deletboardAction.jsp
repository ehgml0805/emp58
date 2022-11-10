<%@page import="javax.print.DocFlavor.STRING"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
//분석
request.setCharacterEncoding("utf-8");
int boardNo = Integer.parseInt(request.getParameter("boardNo"));
String boardPw = request.getParameter("boardPw");
//만약 비밀번호 입력 안할 시에
if (request.getParameter("boardPw") == null || request.getParameter("boardPw").equals("")) {
	response.sendRedirect(request.getContextPath() + "/board/boardList.jsp");
	return;
}


//처리
Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees", "root", "java1234");
System.out.println(conn + "<--conn");
//비밀번호가 같은지 검사하기 ???
/*
String sql1 = "SELECT * FROM board WHERE board_pw=?";
PreparedStatement stmt1 = conn.prepareStatement(sql1);
stmt1.setString(1, boardPw);
ResultSet rs = stmt1.executeQuery();
if (rs.next()) {	

}
*/
String sql2 = "DELETE FROM board WHERE board_no=? AND board_pw=?";
PreparedStatement stmt2 = conn.prepareStatement(sql2);
stmt2.setInt(1, boardNo);
stmt2.setString(2, boardPw);
int row = stmt2.executeUpdate();
if (row == 1) {
	System.out.println("삭제성공");
} else {
	System.out.println("삭제실패");
}
response.sendRedirect(request.getContextPath() + "/board/boardList.jsp");
//출력
%>
