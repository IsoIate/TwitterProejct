<%@page import="dto.TwitDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<TwitDTO> dto = (ArrayList) request.getAttribute("searchResult");
	String input = (String) request.getAttribute("searchInput");			
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<script type="text/javascript">
		$(function(){
			$("#popular").submit(function(){
				document.form_chk.action = "${SearchController}";
				document.form_chk.submit();	
				console.log("aaa");
			});
			$(document).on('click','#searchSub', function(){
				console.log('click');
				let iden = $(this).val();
				console.log(iden+" 버튼 누름"); 
				let value = $('#searchButtons').attr('data-search');
				location.href = "./tab.do?searchContext="+value+"&popularity="+iden;
			});
		});
		
		function onEnterSearch(){
			var keyCode = window.event.keyCode;	
			if (keyCode == 13) { 
				searchForm.submit();
			}
		}
	</script>
</head>
<body>
	<div class="searchDiv">
		<nav class="hnNav">
			<%@ include file = "./nav.jsp" %>
		</nav>
		<section class="searchSection">
			<div class="searchTop">
				<div id="searchContaioner">
					<div id="searchBack">
						<a href="login.do" id="searchA"><img id="searchBackButton" src="./img/arrow.png"></a>
					</div>
					<form action="search.do" method="post" name="searchForm" id="searchForm">
						<div id="searchInput" onkeydown="javascript:onEnterSearch();">
							<i id="hnSearchImg" class="fa fa-search fa-2x"></i>
							<input type="text" class="form-control" id="searchContext" name="searchContext" placeholder="트위터 검색" autocomplete=off>
							<input type="submit" hidden="hidden">
						</div>
					</form>
					<div id="searchBack">
						<a href="login.do" id="searchA"><img id="searchMoreButton" src="./img/ellipsis_1.png"></a>
					</div>
				</div>
				<!-- <form action="search.do" method="post"> -->
					<div id="searchButtons" data-search="<%=input%>">
						<div class="test"><input type="submit" id="searchSub" name="popularity" value="인기"></div>
						<div><input type="submit" id="searchSub" name="latest" value="최신"></div>
						<div><input type="submit" id="searchSub" name="user" value="사용자"></div>
						<div><input type="submit" id="searchSub" name="photo" value="사진"></div>
						<div><input type="submit" id="searchSub" name="video" value="동영상"></div>
					</div>
				<!-- </form> -->
			</div>
			<div class="searchResultContainer">
				<% for(int i = 0; i < dto.size(); i++) { %>
				
					<div class="searchTimeline">
						<div class="TLLeft">
							<img src="./img/profile.png" id="TLProfileImg">
						</div>
						<div class="TLRight">
							<div id="TLTwitContainer">
								<div id="TLTwitInfo">
									<div>
										<span id="userNickname"><%= dto.get(i).getLoginDTO().getId() %></span>
										<span id="userId"><%= "@" + dto.get(i).getLoginDTO().getId() %></span>
										<span id="twitTime"><%= dto.get(i).getTwittime() %></span>
									</div>
									<div id="deleteButton">
										<span><input type="image" src="./img/ellipsis_1.png" id="deleteImg"></span>
									</div>
								</div>
								<div id="TLTwitText">
									<input type="text" name="twitContent" id="twitContents" value="<%= dto.get(i).getText() %>" disabled="disabled">
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
				<% } %>
			</div>
				
		</section>		
		<aside class="hnAside" onkeydown="javascript:onEnterSearch();">
			<form action="search.do" method="post" name="searchForm">
			<div id="hnSearch">
					<i id="hnSearchImg" class="fa fa-search fa-2x"></i>
					<input type="text" class="form-control" id="hnSearchText" name="searchContext" placeholder="트위터 검색" autocomplete=off>
					<input type="submit" hidden="hidden">
			</div>
			</form>
		</aside>
	</div>
</body>
</html>