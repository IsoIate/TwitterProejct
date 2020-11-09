<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	String msg = (String)request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>트위터에 로그인 / 트위터</title>
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
</head>
<body>
	<div class=login_mainDiv style="overflow-y: hidden; overflow-x: hidden;">
		<header class="login_header">
			<img alt="" src="./img/twitter_logo.png" width="35" height="27">
		</header>
		
		<section>
		
			<h3 id="login_comment">트위터 로그인</h3><br>
			
			<div class="signUp_input">
				<form action="login_process.jsp">
					<%
						if(msg != null) {
					%>
					<p> <%= msg %></p>
					<% } %>
					
					<input type="text" name="loginId" class="form-control" placeholder="휴대폰, 이메일, 사용자 아이디"><br>
					<input type="password" name="loginPw" class="form-control" placeholder="비밀번호"><br>
					<input type=submit class="btn btn-info btn-block" value="로그인">
				</form>
			</div>
			
			<div id="login_bottom" style="margin-top:30px;">
				<a href="">비밀번호를 잊으셨나요?</a>
				·
				<a href="">트위터 가입</a>
			</div>
		</section>
	</div>
</body>
</html>