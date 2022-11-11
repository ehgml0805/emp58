<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<% 
//분석 받아오기
request.setCharacterEncoding("utf-8");
String boardNo= request.getParameter("boardNo");
String commentPw=request.getParameter("commentPw");
String commentContent=request.getParameter("commentContent");

//드라이버 설치 및 연결
Class.forName("org.mariadb.jdbc.Driver");
Connection conn=DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees", "root", "java1234");
System.out.println(conn+"<--conn");
//쿼리...
String sql="INSERT INTO comment(comment_content, comment_pw,board_no, createdate) value(?,?,?, curdate()) ";
PreparedStatement stmt=conn.prepareStatement(sql);
stmt.setString(1,commentContent);
stmt.setString(2,commentPw);
//java.sql.SQLException: (conn=1149) Field 'board_no' doesn't have a default value 오류 떠서 추가함
stmt.setString(3,boardNo);

int row=stmt.executeUpdate();
if(row==1){
	System.out.println("입력성공");
}else{
	System.out.println("입력실패");
}

response.sendRedirect(request.getContextPath()+"/board/boardOne.jsp?boardNo="+boardNo);
//추가는 되는데 원폼으로 안넘어감,,,넘어가려면 boardNo 적어주기 

%>