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
	<script type="text/javascript">
		$(function(){
			$("#homeTwitWritePlace").on('keydown keyup', function () {
				  $(this).height(1).height( $(this).prop('scrollHeight')+12 );
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
	%>
	<div class="homeDiv">
		<nav class="homeNav">
			<%@ include file = "./nav.jsp" %>
		</nav>
			
		<section class="homeSection">
			<div class="homeSectionTop">
				<div id="homeText">
					<p>홈</p>
				</div>
				<div class="homeInputArround">
					<img src="./img/profile.png" id="homeProfileImg">
					<div class="homeInput">
						<div id="homeTwitDiv">
							<textarea id="homeTwitWritePlace" placeholder="무슨 일이 일어나고 있나요?"></textarea>
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
								<input type="submit" value="트윗" class="btn btn-info" id="homeTwitButton">
							</div>
						</div>
					</div>
				</div>
				<div class="homeTimeline">
					
				</div>
			</div>
		</section>
	
		<aside class="homeAside">
			<div id="homeSearch">
				<i id="homeSearchImg" class="fa fa-search fa-2x"></i>
				<input type="text" class="form-control" id="homeSearchText" placeholder="트위터 검색">
			</div>
		</aside>
	
	
	
	</div>
</body>
</html>