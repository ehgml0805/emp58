<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<!-- partial jsp 페이지 사용할 코드 -->
		<a href="<%=request.getContextPath()%>/index.jsp">홈으로</a>
		<a href="<%=request.getContextPath()%>/dept/deptList.jsp">부서 관리</a>
		<a href="<%=request.getContextPath()%>/emp/empList.jsp">사원 관리</a>
		<a href="<%=request.getContextPath()%>/salary/salaryMap.jsp">연봉 관리</a>
		<a href="<%=request.getContextPath()%>/board/boardList.jsp">게시판 관리</a>
		<a href="<%=request.getContextPath()%>/deptEmp/deptEmpListMap.jsp">부서별 사원 관리</a>