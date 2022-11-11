<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>

<%
//분석
request.setCharacterEncoding("utf-8");

String boardNo=request.getParameter("boardNo");
System.out.println(request.getParameter("boardNo"));
String commentNo=request.getParameter("commentNo");
System.out.println(request.getParameter("commentNo"));// 값을 못 받아와서 오류남 왜?
String commentPw=request.getParameter("commentPw");
System.out.println(request.getParameter("commentPw"));

//설치 및 연결
Class.forName("org.mariadb.jdbc.Driver");
Connection conn=DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees", "root", "java1234");
System.out.println(conn + "<--conn");

//쿼리 문자열 생성
String sql="DELETE FROM comment WHERE comment_no=? AND comment_pw";
//쿼리 세팅
PreparedStatement stmt=conn.prepareStatement(sql);
stmt.setString(1, commentNo);
stmt.setString(2, commentPw);
//쿼리실행
int row=stmt.executeUpdate();
if(row==1){
	System.out.println("삭제 성공");
	response.sendRedirect(request.getContextPath()+"/board/boardOne.jsp?boardNo="+boardNo);
}else{
	System.out.println("삭제 실패");
	String msg = URLEncoder.encode("비밀번호를 확인하세요", "utf-8");
	response.sendRedirect(request.getContextPath()+"/board/deletCommentForm.jsp?boardNo="+boardNo+"&commentNo="+commentNo);
}


%>