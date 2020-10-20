<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>프로필</title>
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
</head>
<body>
	<%-- ID : <%= request.getParameter("twitterId") %>
	PW : <%= request.getParameter("twitterPw") %> --%>
	<div class="profileDiv">
		<nav class="profileNav">
			<%@ include file = "./nav.jsp" %>
		</nav>
			
		<section class="profileSection">
			<div class="profileSectionTop">
				<a href=""><img id="profileBackButton" src="./img/list.png"></a>
				<div id="profileText">
					<p id="profileTwitId"><%= request.getParameter("twitterId") %></br>0 트윗</p>
					<%-- <%= request.getParameter("twitCount") %> --%><p> </p>
				</div>
			</div>
		</section>
	
		<aside class="profileAside">
			
		</aside>
	
	
	
	</div>
</body>
</html>