<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
		<!-- =request.getContextPath() 인클루드 안에 안 적음 -->
	</div>
	<h1>게시글 추가하기</h1>
	<form action="<%=request.getContextPath()%>/board/insertBoardAction.jsp"
		method="post">
		<table class="table table-bordered">
			<tr>
				<td>제목</td>
				<td><input type="text" name="boardTitle"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea cols="50" rows="10" name="boardContent"></textarea>
				</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="boardWriter"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="text" name="boardPw"></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-success d-grid" >추가</button>
	</form>

</body>
</html>  