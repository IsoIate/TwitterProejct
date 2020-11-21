<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<div class="homeSectionTop">
				<div>
					<p id="homeText">홈</p>
				</div>
				<form action="TwitWriteController" method="post">
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
				</form>
				<div class="homeTimeline">
				<% if(session.getAttribute("twitCount").equals(0)) { %>
					<%@ include file = "./noTwit.jsp" %>
				<% } else { %>
					
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