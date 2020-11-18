<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>
		<%
			if(session.getAttribute("userId") != null) {
		%>
			<%= (String) session.getAttribute("userId") %>
		<%	} %>
	</title>
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%
		if(session.getAttribute("userId") == null) {
			response.sendRedirect("index.jsp");
		}
	%>
	<div class="hnDiv">
		<nav class="hnNav">
			<%@ include file = "./nav.jsp" %>
		</nav>
			
		<section class="hnSection">
			<div class="profileSectionTop">
				<a href="home.jsp"><img id="profileBackButton" src="./img/arrow.png"></a>
				<div id="profileText">
					<span id="profileTwitId"><%= session.getAttribute("userId") %></span>
					<span id="profileTwitCount"><%= session.getAttribute("twitCount") %> 트윗</span>
				</div>
			</div>
			<div class="profileSectionMid">
				<div id="profileBg"></div>
				<div id="profileSetting">
					<div id="profileSettool">
						<img src="./img/profile.png" id="profileImage">
						<button type="button" id="profileSettingBtn" class="btn btn-default">프로필 설정하기</button>
					</div>
					<div id="profileInfo">
						<span id="profileTwitId"><%= session.getAttribute("userId") %></span>
						<span id="profileText2">@<%= session.getAttribute("userId") %></span>
						<div id="profileFw">
							<img src="./img/event.png" style="width: 18px; height: 18px; margin-left: 5px;">
							<span id="profileText2" style="margin: 0 auto;"> 
							가입일: 	<%= session.getAttribute("madeYear") %>년 
									<%= session.getAttribute("madeMonth") %>월
									<%= session.getAttribute("madeDay") %>일 </span>
						</div>
						<div id="profileFw">
							<span id="profileText2"><span id="profileTwitId" style="margin: 0 auto;"><%= session.getAttribute("follow") %></span> 팔로워</span>
							<span id="profileText2"><span id="profileTwitId" style="margin: 0 auto;"><%= session.getAttribute("follower") %></span> 팔로우 중</span>
						</div>
					</div>
				</div>
			</div>
			<div id="profileSectionBottom">
				<div Id="twit"> 트윗	</div>
				<div Id="twitAndAnwser"> 트윗 및 답글 </div>
				<div Id="media"> 미디어 </div>
				<div Id="heart"> 마음에 들어요 </div>
			</div>
			
			<section class="profileTimeline">
			<p>adlkjfaldks</p>
			<jsp:include page="twit.jsp"></jsp:include>
		</section>
		</section>
		
		

		<aside class="hnAside">
			<div id="hnSearch">
				<i id="hnSearchImg" class="fa fa-search fa-2x"></i>
				<input type="text" class="form-control" id="hnSearchText" placeholder="트위터 검색">
			</div>
		</aside>
	
	
	
	</div>
</body>
</html>