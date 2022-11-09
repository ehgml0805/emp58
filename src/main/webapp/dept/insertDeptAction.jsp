<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.URLEncoder" %>

<%	
		//액션 먼저 했을 때는 다시 추가 폼으로 돌려 보내겠음.
	
	//1. 요청분석
 	request.setCharacterEncoding("utf-8");
 	String deptNo = request.getParameter("dept_no");
 	String deptName = request.getParameter("dept_nsame");
 	if(request.getParameter("dept_no")== null ||request.getParameter("dept_name")== null 
 		|| request.getParameter("dept_no").equals("") ||request.getParameter("dept_name").equals("")) {
      String msg = URLEncoder.encode("부서번호와 부서이름을 입력하세요","utf-8"); // get방식 주소창에 문자열 인코딩
      response.sendRedirect(request.getContextPath()+"/dept/insertDeptForm.jsp?msg="+msg);
      return;
   }

	//2. 요청분석
	//동일한 부서 넘버가 들어오지 않게 동일한 넘버가 입력시 예외가 발생하지 않도록
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn=DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	System.out.println(conn+"<--conn");

	//dept_no중복검사
	String sql1="SELECT * FROM departments WHERE dept_no=? OR dept_name=?";
	PreparedStatement stmt1=conn.prepareStatement(sql1);
	stmt1.setString(1, deptNo);
	stmt1.setString(2, deptName);
	ResultSet rs=stmt1.executeQuery();
	if(rs.next()){
		String msg=URLEncoder.encode("부서번호 또는 부서이름이 중복되었습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/dept/insertDeptForm.jsp?msg="+msg);
		return;
	}
	// 2-2 입력
	   String sql2 = "INSERT INTO departments(dept_no, dept_name) value(?,?)";
	   PreparedStatement stmt2 = conn.prepareStatement(sql2);
	   stmt2.setString(1,deptNo);
	   stmt2.setString(2,deptName);

	int row=stmt2.executeUpdate();
	
	if(row==1){
		System.out.println("입력성공");
	}else {
		System.out.println("입력실패");
	}
	
	//3.결과 출력
	response.sendRedirect(request.getContextPath()+"/dept/deptList.jsp");//deptList로 자동 이동
%>