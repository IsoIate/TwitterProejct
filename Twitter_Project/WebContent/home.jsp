<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	page import = "java.util.ArrayList" %>
<%
	Integer index = (Integer) session.getAttribute("twitCount");
	ArrayList<String> array = (ArrayList) session.getAttribute("twits");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>홈</title>
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#homeTwitWritePlace").on('keydown keyup', function () {
				  $(this).height(1).height( $(this).prop('scrollHeight')+12 );
			});
			
			$("#homeTwitWritePlace").on('input', function() {
				if($("#homeTwitWritePlace").val() == ''){
					$("#homeTwitButton").prop("disabled", true);
				}else{
					$("#homeTwitButton").attr("disabled", false);
				}
			}); 
			
		});
		
	</script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%
		if(session.getAttribute("userId") == null) {
			response.sendRedirect("index.jsp");
		}
		session.setAttribute("currentPage", "home.jsp");
	%>
	<div class="hnDiv">
		<nav class="hnNav">
			<%@ include file = "./nav.jsp" %>
		</nav>
			
		<section class="hnSection">
			<div class="homeSectionTop" >
				<div>
					<p id="homeText">홈</p>
				</div>
				<form action="TwitWriteController" method="post">
					<div class="hnLine">
						<div class="homeInputArround">
							<img src="./img/profile.png" id="homeProfileImg">
							<div class="homeInput">
								<div id="homeTwitDiv">
									<textarea id="homeTwitWritePlace" name="twit" placeholder="무슨 일이 일어나고 있나요?"></textarea>
								</div>
								<div class="hometwc">
									<div class="homeTwitIcon">
										<img src="./img/img.png" id="icon">
										<img src="./img/gif.png" id="icon">
										<img src="./img/barchart.png" id="icon">
										<img src="./img/smile.png" id="icon">
										<img src="./img/event.png" id="icon">
									</div>
									<div class="homeTwb">
										<input type="submit" value="트윗" class="btn btn-info" id="homeTwitButton" disabled="disabled">
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
				<div class="homeTimeline">
					
					<% if(index == 0) { %>
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
											<div id="TLTwitContainer">
												<div id="TLTwitInfo">
											
													<div>
														<span id="userNickname"><%= session.getAttribute("userId") %></span>
														<span id="userId"><%= "@" + session.getAttribute("userId") %></span>
														<span id="twitTime"><%= "25분" %></span>
													</div>
													<div id="detailButton">
														<span><img src="./img/exit.png" id="detailImg"></span>
													</div>
												</div>
												<div id="TLTwitText">
													<%= array.get(index - (i + 1)) %>
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
										</div>
									</div>
								</section>
							<% } %>
					<% } %>
				</div>
			</div>
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