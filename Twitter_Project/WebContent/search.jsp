<%@page import="dto.TwitDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<TwitDTO> dto = (ArrayList) request.getAttribute("searchResult");
	for(int i = 0; i < dto.size(); i++) {
		System.out.println("ID : " + dto.get(i).getLoginDTO().getId());
		System.out.println("Time : " + dto.get(i).getTwittime());
		System.out.println("Twit : " + dto.get(i).getText());
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
<!-- 	<link rel="stylesheet" href="./css/bootstrap.css"> -->
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<script type="text/javascript">
		$(function(){
			$("#popular").submit(function(){
				document.form_chk.action = "${SearchController}";
				document.form_chk.submit();	
				console.log("aaa");
			});
		});
	</script>
</head>
<body>
	<div class="searchDiv">
		<nav class="hnNav">
			<%@ include file = "./nav.jsp" %>
		</nav>
		<div class="searchTop">
			<div id="searchContaioner">
				<div id="searchBack">
					<a href="home.jsp" id="searchA"><img id="searchBackButton" src="./img/arrow.png"></a>
				</div>
				<div id="searchInput">
					<i id="hnSearchImg" class="fa fa-search fa-2x"></i>
					<input type="text" class="form-control" id="searchContext" placeholder="트위터 검색">
				</div>
				<div id="searchBack">
					<a href="home.jsp" id="searchA"><img id="searchMoreButton" src="./img/ellipsis_1.png"></a>
				</div>
			</div>
			<form action="search.do" method="post">
				<div id="searchButtons">
					<div><input type="submit" id="searchSub" name="popularity" value="인기"></div>
					<div><input type="submit" id="searchSub" name="latest" value="최신"></div>
					<div><input type="submit" id="searchSub" name="user" value="사용자"></div>
					<div><input type="submit" id="searchSub" name="photo" value="사진"></div>
					<div><input type="submit" id="searchSub" name="video" value="동영상"></div>
				</div>
			</form>
		</div>
		<aside class="hnAside">
			<div id="hnSearch">
				<i id="hnSearchImg" class="fa fa-search fa-2x"></i>
				<input type="text" class="form-control" id="hnSearchText" placeholder="트위터 검색">
			</div>
		</aside>
	</div>
</body>
</html>