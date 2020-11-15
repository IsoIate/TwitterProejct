<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 	request.setCharacterEncoding("utf-8"); 
	String id = request.getParameter("createId");
	String email = request.getParameter("createEmail");
	String date = request.getParameter("year") + "." + request.getParameter("month") + "." + request.getParameter("day");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>인증메일 발송</title>
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
</head>
<body>
	<div class=mainDiv style="overflow-y: hidden; overflow-x: hidden;">
		<form action="signUp_1.jsp" method="post">
			<header class="signUp_header">
				<img alt="" src="./img/twitter_logo.png" width="45" height="37" style="margin-left: 30px;">
				<input type="submit" value="다음" class="btn btn-info" style="float:right;">
			</header>
			
			<section class="signUp_section">
			
				<h3 id="signUp_comment"><%= out.print(email) %>코드를 보내드렸습니다.</h3><br>
				
				<div id="signUp_comment">
					<p><% %>인증을 위해 아래에 입력하세요.</p>
				</div>
				
				<div class="signUp_input">
					<p>확인 코드</p>
					<input type="text" name="checkCode" class="form-control"><br>
				</div>
			</section>
		</form>
	</div>
	<script type="text/javascript" src="./js/bootstrap.js"></script>
</body>
</html>