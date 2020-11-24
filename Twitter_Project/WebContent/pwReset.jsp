<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 재설정</title>
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="./css/style.css">
</head>
<body>
	<header id="pwResetHeader">
		<img src="./img/twitter_logo.png" id="pwResetImg">
		<p id="pwResetText">비밀번호 재설정</p>
	</header>
	
	<% if (request.getAttribute("isID") == "yes") { %>
	<div class="pwResetMain">
		<div id="pwResetContext">
			<h2 id="pwResetT1">해당하는 정보로 회원님의 계정을 찾았습니다</h2>
			<p>이메일, 생년월일을 입력해주세요.</p>
		</div>
		<div id="pwResetInputBox">
			<form action="pwReset.do" method="post">
				<input type="text" name="searchE" class="form-control" id="pwResetInput">
				<div class="signUp_select">
					<select class="form-control" id="selectMonth" name="searchM">
						<option>월</option>
						<% 	for(int i = 1; i <= 12; i++) {
							 %>
							<option><%= i %></option>	
						<%
							}
						%>
					</select>
					<select class="form-control" id="selectDay" name="searchD">
						<option>일</option>
						<% 	for(int i = 1; i <= 31; i++) {
							 %>
							<option><%= i %></option>	
						<%
							}
						%>
					</select>
					<select class="form-control" id="selectYear" name="searchY">
						<option>년</option>
						<% 	for(int i = 1900; i <= 2020; i++) {
							 %>
							<option><%= i %></option>	
						<%
							}
						%>
					</select>	
				</div>
				<input type="submit" class="btn btn-info btn-sm" value="검색" id="pwResetSubmit">
			</form>
		</div>
	</div>
	
	<% } else if (request.getAttribute("isID") =="no") { %>
	<div class="pwResetMain">
		<div id="pwResetContext">
			<h2 id="pwResetT2">해당하는 정보로 회원님의 계정을 찾을 수 없었습니다</h2>
			<p>이메일, 휴대폰 번호 또는 아이디로 다시 검색해주세요.</p>
		</div>
		<div id="pwResetInputBox">
			<form action="searchID.do" method="post">
				<input type="text" name="searchId" class="form-control" id="pwResetInput">
				<input type="submit" class="btn btn-info btn-sm" value="검색" id="pwResetSubmit">
			</form>
		</div>
	</div>
	
	<% } else if(request.getAttribute("correct") == "yes") { %>
	<div class="pwResetMain">
		<div id="pwResetContext">
			<h2 id="pwResetT1">비밀번호를 변경하세요</h2>
			<p>새 비밀번호 작성</p>
		</div>
		<div id="pwResetInputBox">
			<form action="pwChange.do" method="post">
				<input type="password" name="newPw" class="form-control" id="pwResetInput" placeholder="새 비밀번호">
				<input type="password" name="newPwRepeat" class="form-control" id="pwResetInput" placeholder="새 비밀번호 확인">
				<input type="submit" class="btn btn-info btn-sm" value="변경" id="pwResetSubmit">
			</form>
		</div>
	</div>
	
	<% } else if(request.getAttribute("pwRepeat") == "yes") { %>
	<div class="pwResetMain">
		<div id="pwResetContext">
			<h2 id="pwResetT1">비밀번호 변경이 완료되었습니다</h2>
			<p>다시 로그인 해 주세요.</p>
		</div>
		<div id="pwResetInputBox">
			<a href="login.jsp"><input type="button" class="btn btn-info btn-sm" value="로그인"></a>
		</div>
	</div>
	
	<% } else if(request.getAttribute("pwRepeat") == "no") { %>
	<div class="pwResetMain">
		<div id="pwResetContext">
			<h2 id="pwResetT1">비밀번호를 변경하세요</h2>
			<p>새 비밀번호 작성</p>
		</div>
		<div id="pwResetInputBox">
			<h3 id="pwResetT3">두 비밀번호가 서로 다릅니다.</h3>
			<form action="pwChange.do" method="post">
				<input type="text" name="newPw" class="form-control" id="pwResetInput" placeholder="새 비밀번호">
				<input type="text" name="newPwRepeat" class="form-control" id="pwResetInput" placeholder="새 비밀번호 확인">
				<input type="submit" class="btn btn-info btn-sm" value="변경" id="pwResetSubmit">
			</form>
		</div>
	</div>
	
	<% } else { %>
	<div class="pwResetMain">
		<div id="pwResetContext">
			<h2 id="pwResetT1">트위터 계정을 찾으세요</h2>
			<p>이메일, 휴대폰 번호, 아이디를 입력하세요.</p>
		</div>
		<div id="pwResetInputBox">
			<form action="searchID.do" method="post">
				<input type="text" name="searchId" class="form-control" id="pwResetInput">
				<input type="submit" class="btn btn-info btn-sm" value="검색" id="pwResetSubmit">
			</form>
		</div>
	</div>
	<% } %>
</body>
</html>