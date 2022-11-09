<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	//1. 요청분석
	request.setCharacterEncoding("utf-8");
	String deptNo=request.getParameter("dept_no");//form table name이랑 똑같이 쓰기
	String deptName=request.getParameter("dept_name");
	
	//2.요청처리
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn=DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	System.out.println(conn+"<--conn");
	
	//dept_no 중복검사
	String sql1="SELECT * FROM departments WHERE dept_name=?";//부서번호는 수정 불가니까 뺴고
	PreparedStatement stmt1=conn.prepareStatement(sql1);
	stmt1.setString(1,deptName);
	ResultSet rs=stmt1.executeQuery();
	if(rs.next()){
		String msg=URLEncoder.encode(deptName+"는(은) 사용할 수 없습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/dept/updateDeptForm.jsp?msg="+msg);
		return;
	}
	
	String sql2="update departments set dept_name=? where dept_no=?";
	PreparedStatement stmt2=conn.prepareStatement(sql2);
	stmt2.setString(1,deptName);
	stmt2.setString(2,deptNo);
	
	int row = stmt2.executeUpdate();
	if(row == 1) {
		System.out.println("수정성공");
	} else {
		System.out.println("수정실패");
	}
	
	//3.출력
	response.sendRedirect(request.getContextPath()+"/dept/deptList.jsp");
%>