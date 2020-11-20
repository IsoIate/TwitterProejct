<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	
	

	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
	<style>
	.login-form{display: none;position: fixed;z-index: 99;left: 0;top: 0;width: 100%;height: 100%;overflow: auto;background-color: rgb(0,0,0);background-color: rgba(0,0,0,0.4);padding-top: 200px;}
		#testBtn {
			z-index: 10;
			width: 100%;height: 100%;
			overflow: auto;
			background-color: rgb(0,0,0);
			background-color: rgba(0,0,0,0.4);
			display: none;
			position : fixed;
			
			
		}
		.content{
		z-index: 15;
		width : 500px; height : 300px; padding-top : 300px;position: absolute;
		background-color: #fff;
			top: 100px;			left : calc(50% - 150px);}
		
		.animate {-webkit-animation: animatezoom 0.6s; animation: animatezoom 0.6s}
		@-webkit-keyframes animatezoom { from {-webkit-transform: scale(0)} to {-webkit-transform: scale(1)} }
		@keyframes animatezoom { from {transform: scale(0)} to {transform: scale(1)} }
	</style> 
	<script type="text/javascript">
		$(function(){
			$('.button').click(function(){
				$('#testBtn').css('display','block');
			});
			$('.btn').click(function(){
				$('#testBtn').css('display','none');
			});
		});
	</script>
	
</head>
<body>
	<div id="testBtn">
	<div class="animate">
		<div class="content">
		<p>test</p>
		
		<button class="btn">닫기</button>
		</div>
		</div>
	</div>
	
	<button class="button">click</button>


	<!-- 
	<div class="twitDiv">
		<div>
			<img src="./img/profile.png" id="twitProfileImg">
		</div>
		<div id="twitContainer">
			<div id="twitInfo">
				<div id="twitText"></div>
				<div id="twitButtons"></div>
				
		
			</div>
		</div>
	</div> 
	-->
</body>
</html>