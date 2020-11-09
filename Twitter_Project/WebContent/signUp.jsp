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
		<header class="signUp_header">
			<img alt="" src="./img/twitter_logo.png" width="45" height="37" style="margin-left: 30px;">
			<input type="button" value="다음" disabled="disabled" class="btn btn-info" style="float:right;">
		</header>
		
		<section class="signUp_section">
		
			<h3 id="signUp_comment">계정을 생성하세요</h3><br>
			
			<div class="signUp_input">
				<input type="text" name="creatId" class="form-control" placeholder="이름"><br>
				<input type="text" name="createPhoneNumber" class="form-control" placeholder="휴대폰"><br>
			</div>
			
			<div id="signUp_comment">
			
				<a href="">대신 이메일 사용하기</a><br><br>
				
				<p style="font-size:14px; font-weight:bold;">생년월일</p>
				<p>이 정보는 공개적으로 표시되지 않습니다. 비즈니스, 반려동물 등 계정 주제에 상관 없이 나의 연령을 확인하세요</p>
			</div>
			
			<div class="signUp_select">
				<select class="form-control" id="select" style="width: 150px;">
					<option>월</option>
					<% 	for(int i = 1; i <= 12; i++) {
						 %>
						<option><%= i %></option>	
					<%
						}
					%>
				</select>
				<select class="form-control" id="select" style="width: 80px;">
					<option>일</option>
					<% 	for(int i = 1; i <= 31; i++) {
						 %>
						<option><%= i %></option>	
					<%
						}
					%>
				</select>
				<select class="form-control" id="select" style="width: 120px;">
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
	</div>
	<script type="text/javascript" src="./js/bootstrap.js"></script>
</body>
</html>