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
	<title>회원가입</title>
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
</head>
<body>
	<div class=mainDiv style="overflow-y: hidden; overflow-x: hidden;">
		<form action="SignUpController" method="post">
			<header class="signUp_header">
				<a href="signUp.jsp"><img src="./img/arrow.png" width="30" height="20" style="float: left; 
					margin: 5px 5px 5px 10px;"class="img-responsive" alt="Responsive image"></a>
				<h4 style="margin: 0 auto; padding: 5px 280px 0px 0px; font-weight: bold;">3단계 중 2단계</h4>
			</header>
			
			<section class="signUp_section">
			
				<h3 id="signUp_comment">계정을 생성하세요</h3><br>
				<div class="signUp_input">
					<input type="text" class="form-control" name="createId" value="<% out.println(id);%>"><br>
					<input type="text" class="form-control" name="createPw" placeholder="비밀번호 입력"><br>
					<input class="form-control" name="createEmail" value="<% out.println(email); %>"><br>
					<input type="hidden" name="createDate" value="<% out.println(date); %>"><br>
				</div>
				
				<div id="signUp_comment">
					<p>가입 시 이용약관 및 쿠키 사용을 포함한 개인정보 처리방침에 동의하게 됩니다.</br>개인정보 설정에 따라 이메일 주소 또는 휴대폰 번호로 나를 찾을 수 있습니다.</p>
				</div>
				<input type="submit" value="가입" class="btn btn-info btn-block">
			</section>
		</form>
	</div>
	<script type="text/javascript" src="./js/bootstrap.js"></script>
</body>
</html>