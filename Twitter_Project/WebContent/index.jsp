<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>트위터, 핵심은 '실시간'입니다.</title>
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#signUp").click(function(){
				window.open('./signUp.jsp', 'signUp', 'width=500,height=550,location=no,status=no,scrollbars=no');
			});
			$("#login").click(function(){
				location.href="./login.jsp";
			});
		});
	</script>
</head>
<body>
	<%
// 		if(session.getAttribute("userId") != null) {
// 			response.sendRedirect("home.jsp");
// 		}
	%>
	<div class="mainDiv">
		<div class="leftDiv">
			<div class="leftText">
				<div id="text">관심사를 팔로우하세요.</div>
				<div id="text">사람들이 무엇에 대해 이야기하고 있는<br>지 알아보세요.</div>
				<div id="text">대화에 참여하세요.</div>
			</div>
		</div>
		<div class="rightDiv">
			<form action="LoginController" method="post">
				<div class="inputArea">
					<div id="indexIDPW">
						<span>휴대폰, 이메일, 사용자 아이디</span>
						<input type="text" name="loginId" id="IDPW" autocomplete=off>
					</div>
					<div id="indexIDPW">
						<span>비밀번호</span>
						<input type="password" name="loginPw" id="IDPW">
					</div>
					
					<input type="submit" value="로그인" class="btn btn-default" id="indexLogin">
				</div>
				<a href="pwReset.jsp" style="margin-left: 100px; text-decoration: none;"> 비밀번호를 잊으셨나요? </a>
			</form>
			<div class="rightText">
				<div class="img_wrap">
					<img alt="" src="./img/twitter_logo.png" width="45" height="37" class="main_img">
				</div>
				<p id="boldText">지금 전 세계에서 무슨 일이 일어나고 있는지 알아보세요<br><br>
				<p id="miniText">오늘 트위터에 가입하세요.<br>
				<input type="button" value="가입하기" class="btn btn-info btn-block" id="signUp">
				<input type="button" value="로그인" class="btn btn-default btn-block" id="login" style="font-size: 16px; font-weight: bold;">
			</div>
		</div>
	</div>
	<script type="text/javascript" src="./js/bootstrap.js"></script>
</body>
</html>