<%@page import="javax.print.DocFlavor.STRING"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>

<%


//분석
//request.setCharacterEncoding("utf-8"); 쓰니까 오류뜸 지움,,
int boardNo = Integer.parseInt(request.getParameter("boardNo"));
//디버깅 System.out.println(request.getParameter("boardNo"));
String boardPw = request.getParameter("boardPw");

//처리
Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees", "root", "java1234");
System.out.println(conn + "<--conn");
//비밀번호가 같은지 검사하기 ???
/* 처음 생각은 나눠서 해야 하나 생각함 근데 AND로 한번에 가능
String sql1 = "SELECT * FROM board WHERE board_pw=?";
PreparedStatement stmt1 = conn.prepareStatement(sql1);
stmt1.setString(1, boardPw);
ResultSet rs = stmt1.executeQuery();
if (rs.next()) {	

}
*/
//쿼리 문자열 생성
String sql2 = "DELETE FROM board WHERE board_no=? AND board_pw=?";
//쿼리 세팅
PreparedStatement stmt2 = conn.prepareStatement(sql2);
stmt2.setInt(1, boardNo);
stmt2.setString(2, boardPw);
//쿼리 실행
int row = stmt2.executeUpdate();
if (row == 1) {
	System.out.println("삭제성공");
	response.sendRedirect(request.getContextPath() + "/board/boardList.jsp");
} else {
	System.out.println("삭제실패");
	String msg = URLEncoder.encode("비밀번호를 확인하세요", "utf-8");
	response.sendRedirect(request.getContextPath() + "/board/deletBoardForm.jsp?boardNo="+boardNo+"&msg"+msg);
}
//만약 비밀번호 입력 안할 시에 리스트로 다시 보낼 필요가 없음 어차피 실패 하면 딜리트 폼으로 다시 갈거고 비밀번호 확인하라는 메시지 띄울거라서.
/*
if (request.getParameter("boardPw") == null || request.getParameter("boardPw").equals("")) {
	response.sendRedirect(request.getContextPath() + "/board/boardList.jsp");
	return;
}
*/
//출력
%>
