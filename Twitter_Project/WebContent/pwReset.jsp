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
		<img alt="" src="./img/twitter_logo.png" width="35" height="27">
		비밀번호 재설정
	</header>
	
	<div class="pwResetMain">
		<h2 id="pwResetH2">트위터 계정을 찾으세요</h2>
		<p>이메일, 휴대폰 번호, 아이디를 입력하세요.</p>
		<form action="" method="post">
			<input type="text" name="searchId" class="form-control" id="pwResetInput">
			<input type="submit" class="btn btn-info btn-sm" value="검색">
		</form>
	</div>
</body>
</html>