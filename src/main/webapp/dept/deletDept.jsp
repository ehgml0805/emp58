<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
	//1. 요청분석
	request.setCharacterEncoding("utf-8");
	String deptNo=request.getParameter("deptNo");
	
	//2.요청처리
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn=DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	String sql="DELETE FROM departments WHERE dept_no=?";
	PreparedStatement stmt=conn.prepareStatement(sql);
	stmt.setString(1,deptNo);
	
	
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("삭제성공");
	} else {
		System.out.println("삭제실패");//
	}
	
	//3.출력
	response.sendRedirect(request.getContextPath()+"/dept/deptList.jsp");
%>