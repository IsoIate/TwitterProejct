<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! String[] src = {"./img/home.png", "./img/sharp.png", "./img/alarm.png", "./img/message.png", "./img/bookmark.png",
					"./img/list.png", "./img/list.png", "./img/list.png"};
	String[] href = {"./home.jsp", "", "", "", "", "", "./profile.jsp", ""};
	String[] text = {"홈", "탐색하기", "알림", "쪽지", "북마크", "리스트", "프로필", "더보기"};
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
</head>
<body style="width:100%; height:100%;">
	<div class="navDiv">
		<div id="navBird">
			<img src="./img/twitter_logo.png" width="30" height="27">
		</div>
		<div id="navList">
			<ul class="navUl">
				<% 
					for(int i = 0; i < src.length; i++) {
				%>
					<li id="navLi"><a id="navA" href= <%= href[i] %>><img id="navImg" src=<%= src[i] %>><%= text[i] %></a></li>
				<%		
					}
				%>
			</ul>
		</div>
		<div id="navButton">
			<input type="button" class="btn btn-info btn-block" value="트윗" id="navTwitButton">
			
			<form action="LogoutController" method="post">
				<input type="submit" value="로그아웃" class="btn btn-info btn-block" id="navTwitButton">
			</form>
		</div>
	</div>
</body>
</html>