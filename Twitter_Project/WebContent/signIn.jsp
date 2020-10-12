<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header>
		<input type="button" value="다음" disabled="disabled">
	</header>
	<section>
		<h3>계정을 생성하세요</h3><br>
		<input type="text" name="creatId" placeholder="이름"><br>
		<input type="text" name="createPhoneNumber" placeholder="휴대폰"><br>
		<a href="">대신 이메일 사용하기</a><br>
		<p>생년월일</p>
		<p>이 정보는 공개적으로 표시되지 않습니다. 비즈니스, 반려동물 등 계정 주제에 상관 없이 나의 연령을 확인하세요</p>
		<select style="width: 150px;">
			<option>월</option>
			<% 	for(int i = 1; i <= 12; i++) {
				 %>
				<option><%= i %></option>	
			<%
				}
			%>
		</select>
		<select style="width: 80px;">
			<option>일</option>
			<% 	for(int i = 1; i <= 31; i++) {
				 %>
				<option><%= i %></option>	
			<%
				}
			%>
		</select>
		<select style="width: 120px;">
			<option>년</option>
			<% 	for(int i = 1900; i <= 2020; i++) {
				 %>
				<option><%= i %></option>	
			<%
				}
			%>
		</select>	
	</section>
</body>
</html>