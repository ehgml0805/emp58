<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>


<%
	//요청분석
	request.setCharacterEncoding("utf-8");
	String boardTitle= request.getParameter("boardTitle");
	String boardContent= request.getParameter("boardContent");
	String boardWriter= request.getParameter("boardWriter");
	int boardPw=Integer.parseInt(request.getParameter("boardPw"));


	//요청처리
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn=DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	System.out.println(conn+"<--conn");
	
	String sql="INSERT INTO board(board_title, board_content, board_writer, board_pw, createdate) value(?,?,?,?,curdate())";
	PreparedStatement stmt=conn.prepareStatement(sql);
	stmt.setString(1, boardTitle);
	stmt.setString(2, boardContent);
	stmt.setString(3, boardWriter);
	stmt.setInt(4, boardPw);
	
	int row=stmt.executeUpdate();
	
	if(row==1){
		System.out.println("입력성공");
	}else {
		System.out.println("입력실패");
	}
	
	
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	//출력

%>