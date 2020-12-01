<%@page import="dto.ProfileDTO"%>
<%@ page import="dto.TwitDTO" %>
<%@ page import="dto.InfoDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	page import = "java.util.ArrayList" %>
<%
	InfoDTO info = null;
	ProfileDTO pro = null;
	Integer index = 0;
	
	Object object = request.getAttribute("info");
	Object object_1 = request.getAttribute("profile");
	
	if(object != null) {
		info = (InfoDTO) object;
		index = info.getTwitCount();
	}
	if(object_1 != null) {
		pro = (ProfileDTO) object_1;
	}
	
	ArrayList<TwitDTO> array = (ArrayList) request.getAttribute("twits");
	
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
		$(function onEnterLogin(){
			var keyCode = window.event.keyCode;	
			if (keyCode == 13) { //엔테키 이면
				loginForm.submit();
			}
		});
		var InputImage = 
			 (function loadImageFile() {
			    if (window.FileReader) {
					var ImagePre; 
			        var ImgReader = new window.FileReader();
			        var fileType = /^(?:image\/bmp|image\/gif|image\/jpeg|image\/png|image\/x\-xwindowdump|image\/x\-portable\-bitmap)$/i; 
			 
			        ImgReader.onload = function (Event) {
			        	if (!ImagePre) {
			                var newPreview = document.getElementById("imagePreview");
			                ImagePre = new Image();
			                
			                newPreview.appendChild(ImagePre);
			            }
			            ImagePre.src = Event.target.result;  
			        };
			 
			        return function () {
			        	var img = document.getElementById("image").files; 
			        	if (!fileType.test(img[0].type)) { 
				        	alert("이미지 파일을 업로드 하세요"); 
				            return; 
			        	}
			            ImgReader.readAsDataURL(img[0]);
			        }
			    }
			        document.getElementById("imagePreview").src = document.getElementById("image").value;
			})();
	</script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%
		// 로그인하지 않고 접근 시 index로 돌려보냄
// 		if(info.getUser_num() == 0) {
// 			response.sendRedirect("index.jsp");
// 		}
		// 현재 페이지 저장	
		session.setAttribute("currentPage", "home");	
	%>
	<div class="hnDiv">
		<nav class="hnNav">
			<%@ include file = "./nav.jsp" %>
		</nav>
			
		<section class="hnSection">
			<div class="homeSectionTop" >
				<div class="homeTitleContainer">
					<p id="homeText">홈</p>
				</div>
				<form action="write.do" method="post" enctype="multipart/form-data"> <!--  -->
					<div class="hnLine">
						<div class="homeInputArround">
							<img src="./img/profile.png" id="homeProfileImg">
							<div class="homeInput">
								<div id="homeTwitDiv">
									<textarea id="homeTwitWritePlace" name="twit" placeholder="무슨 일이 일어나고 있나요?"></textarea>
									<div id="imagePreview"></div>
								</div>
								<div class="hometwc">
									<div class="homeTwitIcon">
									<div class="button" onclick="onclick=document.all.image.click()">
										<img src="./img/img.png" id="icon">
										<label>
								        	<!-- <input type="file" name="file" style="display: none;"> -->
								        	<input id="image" type="file" name="inputImage" onchange="InputImage();" style="display: none;">
								        </label>	
								    </div>
								        <!-- <img src="./img/img.png" id="icon"> -->						        							
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
				
					<!-- 작성 트윗이 존재하지 않을 때  -->
					<% if(index == 0) { %>
						<div class="noTwitDiv">
							<h3 id="noTwitH3">트위터에 오신 것을 환영합니다!</h3>
							<p id="noTwitP">전 세계에서 무슨 일이 일어나고 있는지 알아보기에 최적인 장소입니다.<br>지금 팔로우할 사람과 주제를 찾아보세요.</p>
						</div>
						
					<!-- 작성 트윗이 존재할 때  -->
					<% } else { 
							for(int i = 0; i < index; i++) { %>
								<section class="timelineContainer">
									<div class="timeline">
										<div class="TLLeft">
											<img src="./img/profile.png" id="TLProfileImg">
										</div>
										<div class="TLRight">
											<div id="TLTwitContainer">
												<form action="delete.do" method="post">
												<input type="hidden" name="twitnumber" value="<%= array.get(i).getTwitnumber() %>">
													<div id="TLTwitInfo">
														<div>
															<span id="userNickname"><%= pro.getNickname() %></span>
															<span id="userId"><%= "@" + session.getAttribute("userId") %></span>
															<span id="twitTime"><%= "25분" %></span>
														</div>
														<div id="deleteButton">
															<span><input type="image" src="./img/exit.png" id="deleteImg"></span>
														</div>
													</div>
													<div id="TLTwitText">
														<input type="text" name="twitContent" id="twitContents" value="<%= array.get(i).getText() %>" disabled="disabled">
														<%--<img id="homeImagePrint" src="./upload/EoCUL1UVcAEeG363.jpg">--%>
														<% if(array.get(i).getImage() == null || array.get(i).getImage().trim().isEmpty()) { %>
														<% } else {%>
															<img id="homeImagePrint" src="<%=array.get(i).getImage()%>"> 
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
												</form>
											</div>
										</div>
									</div>
								</section>
							<% } %>
					<% } %>
				</div>
			</div>
		</section>
	
		<aside class="hnAside" onkeydown="javascript:onEnterLogin();">
			<form action="search.do" method="post" name="searchEnter">
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