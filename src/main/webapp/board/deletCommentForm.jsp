<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
//받아오기
request.setCharacterEncoding("utf-8");
String boardNo=request.getParameter("boardNo");
//System.out.println(request.getParameter("boardNo"));디버깅
String commentNo=request.getParameter("cemmentNo");
//System.out.println(request.getParameter("commentNo"));디버깅
String msg=request.getParameter("msg");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>댓글 삭제</h1>
	<%
		if(msg!=null){
	%>
		<div><%=msg%></div>
	<%		
		}
	%>
	<form action="<%=request.getContextPath()%>/board/deletCommentAction.jsp?commentNo=<%=commentNo %>" method="post">
		<div> 비밀번호
			<input type="password" name="commentPw">
		</div>
		<button type="submit">삭제</button>
		<button type="button" onclick="history.back(-1)">취소</button>
	</form>

</body>
</html>