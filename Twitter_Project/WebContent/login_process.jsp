<%@page import="dao.TwitterDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	System.out.println(request.getParameter("loginId") + ":" + request.getParameter("loginPw"));
	TwitterDAO dao = TwitterDAO.getInstance();
	int result = dao.signIn(request.getParameter("loginId"), request.getParameter("loginPw"));
	System.out.println(result);
	if(result == 1) {
		response.sendRedirect("./profile.jsp");
	}
	else {
		request.setAttribute("errorMessage", "입력하신 아이디와 비밀번호가 등록된 정보와 일치하지 않습니다.\n 확인 후 다시 시도하세요.");
		RequestDispatcher dispatcher = request.getRequestDispatcher("./login.jsp");
		dispatcher.forward(request, response);
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	
</body>
</html>