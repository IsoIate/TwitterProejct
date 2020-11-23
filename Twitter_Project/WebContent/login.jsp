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
	<script type="text/javascript">
		$(function(){
			$(".signUp").click(function(){
				window.open('./signUp.jsp', 'signUp', 'width=500,height=550,location=no,status=no,scrollbars=no');
			});
		});
	</script>
</head>
<body>
	<div class=login_mainDiv>
	
		<header class="login_header">
			<img alt="" src="./img/twitter_logo.png" id="loginLogoImg">
		</header>
		
		<section>
			<h3 id="login_comment">트위터 로그인</h3><br>
			<div>
				<form action="./login.do" method="post">
					<input type="text" name="loginId" class="form-control" placeholder="휴대폰, 이메일, 사용자 아이디"><br>
					<input type="password" name="loginPw" class="form-control" placeholder="비밀번호"><br>
					<input type=submit id="loginPageBtn" class="btn btn-info btn-block" value="로그인">
				</form>
			</div>
			<div id="login_bottom">
				<a href="pwReset.jsp">비밀번호를 잊으셨나요?</a>
				·
				<a href="#" class="signUp">트위터 가입</a>
			</div>
		</section>
	</div>
</body>
</html>