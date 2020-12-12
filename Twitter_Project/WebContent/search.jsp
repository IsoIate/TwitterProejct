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
	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<script type="text/javascript">
	var list = null;
	/* body 실행 시 load.do 요청 */
	function searchLoadData(){
		$.ajax({
			url:"searchLoad.do",
			type:"post",
			success: function(temp) { /* 호출에 성공하면 response로 받은 ArrayList를 list에 삽입 */
					console.log(temp);
				list = temp;
			}
		});
	}
		$(function(){
			/* homeImagePrint 클릭 시 */
			$(".homeImagePrint").on('click', function() {
				var img;
				var data = $(this).attr('data-id');		/* data-id(twitnumber) 를 가져옴 */
 				console.log(data);
 				console.log(list.length);
				for(var i = 0; i < list.length; i++) {	/* 클릭한 twitnumber와 일치하는지 비교 */
					if(list[i].twitnumber == data) {
						img = list[i].image;
					}
				}
				
				$("#modalImagePrint").attr("src", img);	/* 모달에 해당 이미지 주소를 삽입 */
				$("#ImgModal").modal('show');
			});
			
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
				location.href = "./tab.do?searchContext="+value+"&tabName="+iden;
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
<body onLoad="searchLoadData()">
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
							<input type="text" class="form-control" id="searchContext" name="searchContext" value="<%= input %>" autocomplete=off>
							<input type="submit" hidden="hidden">
						</div>
					</form>
					<div id="searchBack">
						<a href="#" id="searchA"><img id="searchMoreButton" src="./img/ellipsis_1.png"></a>
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
									<% if(dto.get(i).getImage() == null || dto.get(i).getImage().trim().isEmpty()) { %>
									<% } else {%>
									<!-- 모달 작업 전 -->
										<img data-id=<%= dto.get(i).getTwitnumber() %> class="homeImagePrint" src="<%=dto.get(i).getImage()%>"> 
									<% } %>	
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
			<div class="searchSide">
				<div id="recommend">
					<div id="trHeader">
						<h3>팔로우 추천</h3>
					</div>
					<div id="reContext">
						<div>
							<img src="./img/profile.png" id="trImg">
						</div>
						<div>
							<h4>Honam</h4>
							<p>@honam</p>
						</div>
						<div class="reFollow">
							<input type="button" value="팔로우" class="btn btn-info" id="reFollowBtn">
						</div>
					</div>
					<div id="reContext">
						<div>
							<img src="./img/profile.png" id="trImg">
						</div>
						<div>
							<h4>Honam</h4>
							<p>@honam</p>
						</div>
						<div class="reFollow">
							<input type="button" value="팔로우" class="btn btn-info" id="reFollowBtn">
						</div>
					</div>
					<div id="reContextF">
						<div>
							<img src="./img/profile.png" id="trImg">
						</div>
						<div>
							<h4>Honam</h4>
							<p>@honam</p>
						</div>
						<div class="reFollow">
							<input type="button" value="팔로우" class="btn btn-info" id="reFollowBtn">
						</div>
					</div>
				</div>
				<div id="trend">
					<div id="trHeader">
						<h3>나를 위한 트렌드</h3>
					</div>
					<div id="trContext">
						<p>대한민국에서 트렌드 중</p>
						<h4>#호남대학교</h4>
						<p>3,000 트윗</p>
					</div>
					<div id="trContext">
						<h4>#헐왓챠에_해리포터</h4>
						<p>전 시리즈는 왓챠에서 감상하세요!</p>
						<p>watch.kr님이 프로모션 함</p>
					</div>
					<div id="trContext">
						<p>대한민국에서 트렌드 중</p>
						<h4>#호남대학교</h4>
						<p>3,000 트윗</p>
					</div>
					<div id="trContext">
						<p>대한민국에서 트렌드 중</p>
						<h4>#호남대학교</h4>
						<p>3,000 트윗</p>
					</div>
					<div id="trContextF">
						<p>대한민국에서 트렌드 중</p>
						<h4>#호남대학교</h4>
						<p>3,000 트윗</p>
					</div>
				</div>
			</div>
		</aside>
		
		<div class="modal fade" id="ImgModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
			  		<div class="modal-content">
			      		<div class="modal-header">
			      			<button type="reset" data-dismiss="modal" id="modalCloseBtn"><img src="./img/exit.png" id="wtExitButton"></button>
			     	 	</div>
					      	 <div class="modal-body" id="modalImageContainer">
					        	<img id="modalImagePrint" >
					      	 </div>
			    	</div>
			  	</div>
			</div>
		
		
	</div>
</body>
</html>