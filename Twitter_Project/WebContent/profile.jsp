<%@page import="dto.TwitDTO"%>
<%@ page import="dto.InfoDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	page import = "java.util.ArrayList" %>
<%
	InfoDTO info = null;
	Integer index = 0;
	
	Object object = request.getAttribute("info");
	if(object != null) {
		info = (InfoDTO) object;
		index = info.getTwitCount();
	}
	ArrayList<TwitDTO> array = (ArrayList) request.getAttribute("twits");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>
		<%
// 			if(session.getAttribute("userId") != null) {
// 				out.print((String)session.getAttribute("userId")) ;
// 			} 
		%>
	</title>
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%
// 		if(session.getAttribute("userId") == null) {
// 			response.sendRedirect("index.jsp");
// 		}
		session.setAttribute("currentPage", "./Page.do");
	%>
	<div class="hnDiv">
		<nav class="hnNav">
			<%@ include file = "./nav.jsp" %>
		</nav>
			
		<section class="hnSection">
			<div class="hnLine">
				<div class="profileSectionTop">
					<a href="home.jsp"><img id="profileBackButton" src="./img/arrow.png"></a>
					<div id="profileText">
						<span id="profileTwitId"><%= session.getAttribute("userId") %></span>
						<span id="profileTwitCount"><%= info.getTwitCount() %> 트윗</span>
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
								가입일: 	<%= info.getBirthdaDto().getYear() %>년 
										<%= info.getBirthdaDto().getMonth() %>월
										<%= info.getBirthdaDto().getDay() %>일 </span>
							</div>
							<div id="profileFw">
								<span id="profileText2"><span id="profileTwitId" style="margin: 0 auto;"><%= info.getFwdto().getFollow() %></span> 팔로워</span>
								<span id="profileText2"><span id="profileTwitId" style="margin: 0 auto;"><%= info.getFwdto().getFollower() %></span> 팔로우 중</span>
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
			</div>
			<% if(info.getTwitCount() == 0) { %>
				<div class="noTwitDiv">
					<h3 id="noTwitH3">트위터에 오신 것을 환영합니다!</h3>
					<p id="noTwitP">전 세계에서 무슨 일이 일어나고 있는지 알아보기에 최적인 장소입니다.<br>지금 팔로우할 사람과 주제를 찾아보세요.</p>
				</div>
			<% } else { 					
					for(int i = 0; i < index; i++) { %>
						<section class="timelineContainer">
							<div class="timeline">
								<div class="TLLeft">
									<img src="./img/profile.png" id="TLProfileImg">
								</div>
								<div class="TLRight">
									<form action="./TwitDelete.do" method="post">
									<input type="hidden" name="twitnumber" value="<%= array.get(i).getTwitnumber() %>">
										<div id="TLTwitContainer">
											<div id="TLTwitInfo">
												
												<div>
													<span id="userNickname"><%= session.getAttribute("userId") %></span>
													<span id="userId"><%= "@" + session.getAttribute("userId") %></span>
													<span id="twitTime"><%= "25분" %></span>
												</div>
												<div id="deleteButton">
													<span><input type="image" src="./img/exit.png" id="deleteImg"></span>
												</div>
											</div>
											<div id="TLTwitText">
												<%= array.get(i).getText() %>
											</div>			
											<div class="TLTwitButtons">
												<img src="./img/img.png" id="TLButton">
												<img src="./img/gif.png" id="TLButton">
												<img src="./img/barchart.png" id="TLButton">
												<img src="./img/smile.png" id="TLButton">
												<img src="./img/event.png" id="TLButton">
												<p id="TLButton" style="margin: 0px;"></p>
											</div>
										</div>
									</form>
								</div>
							</div>
						</section>
					<% } %>
			<% } %>
			
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