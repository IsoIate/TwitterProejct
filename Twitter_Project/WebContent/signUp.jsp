<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
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
				<input type="submit" value="다음" class="btn btn-info" id="signUpNextbtn">
			</header>
			
			<section class="signUp_section">
			
				<h3 id="signUp_comment">계정을 생성하세요</h3><br>
				
				<div class="signUp_input">
					<input type="text" name="createId" class="form-control" placeholder="이름"><br>
					<input type="text" name="createEmail" class="form-control" placeholder="이메일"><br>
				</div>
				
				<div id="signUp_comment">
					
					<p style="font-size:14px; font-weight:bold;">생년월일</p>
					<p>이 정보는 공개적으로 표시되지 않습니다. 비즈니스, 반려동물 등 계정 주제에 상관 없이 나의 연령을 확인하세요</p>
				</div>
				
				<div class="signUp_select">
					<select class="form-control" id="select" name="month" style="width: 150px;">
						<option>월</option>
						<% 	for(int i = 1; i <= 12; i++) {
							 %>
							<option><%= i %></option>	
						<%
							}
						%>
					</select>
					<select class="form-control" id="select" name="day" style="width: 80px;">
						<option>일</option>
						<% 	for(int i = 1; i <= 31; i++) {
							 %>
							<option><%= i %></option>	
						<%
							}
						%>
					</select>
					<select class="form-control" id="select" name="year" style="width: 120px;">
						<option>년</option>
						<% 	for(int i = 1900; i <= 2020; i++) {
							 %>
							<option><%= i %></option>	
						<%
							}
						%>
					</select>	
				</div>
			</section>
		</form>
	</div>
	<script type="text/javascript" src="./js/bootstrap.js"></script>
</body>
</html>