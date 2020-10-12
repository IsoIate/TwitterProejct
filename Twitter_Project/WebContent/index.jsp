<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
	<script type="text/javascript">
		$(function(){
			$(".signIn").click(function(){
				window.open('./signIn.jsp', 'signIn', 'width=430,height=500,location=no,status=no,scrollbars=yes');
			});
		});
	</script>
</head>
<body>
<form action="home.jsp">
	<input type="text" name="twitterId" placeholder="휴대폰, 이메일, 사용자 아이디">
	<input type="text" name="twitterPw" placeholder="비밀번호">
	<input type="submit" value="로그인">
	
	<br>
	지금 전 세계에서 무슨 일이 일어나고 있는지 알아보세요<br>
	오늘 트위터에 가입하세요.<br>
	<div class="signIn">
		<!-- <button onclick="window.open('./signIn.jsp','signIn','width=430,height=500,location=no,status=no,scrollbars=yes');">가입하기</button> -->
		<a href="#">가입하기<!-- <input type="button" onClick="window.open('./signIn.jsp', 'signIn')" value="가입하기"></a> --><br>
	</div>
	
	<input type="button" id="login" value="로그인">
</form>
</body>
</html>