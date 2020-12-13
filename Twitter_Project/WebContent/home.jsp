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
	int count = 0;
	
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
	<link rel="stylesheet" type="text/css" href="./css/style.css?ver=4">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
	<script type="text/javascript">
	var list = null;
		/* body 실행 시 load.do 요청 */
		function loadData(){
			$.ajax({
				url:"load.do",
				type:"post",
				success: function(temp) { /* 호출에 성공하면 response로 받은 ArrayList를 list에 삽입 */
// 					console.log(temp);
					list = temp;
				}
			});
		}
		
		$(function(){
			/* homeImagePrint 클릭 시 */
			$(".homeImagePrint").on('click', function() {
				var img;
				var data = $(this).attr('data-id');		/* data-id(twitnumber) 를 가져옴 */
// 				console.log(data);
// 				console.log(list.length);
				for(var i = 0; i < list.length; i++) {	/* 클릭한 twitnumber와 일치하는지 비교 */
					if(list[i].twitnumber == data) {
						img = list[i].image;
					}
				}
				
				$("#modalImagePrint").attr("src", img);	/* 모달에 해당 이미지 주소를 삽입 */
				$("#ImgModal").modal('show');
			});
			
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
		var HomeImputImg = 
			 (function loadImageFile() {
			    if (window.FileReader) {
					var ImagePre; 
			        var ImgReader = new window.FileReader();
			        var fileType = /^(?:image\/bmp|image\/gif|image\/jpeg|image\/png|image\/x\-xwindowdump|image\/x\-portable\-bitmap)$/i; 
			 
			        ImgReader.onload = function (Event) {
			        	if (!ImagePre) {
			                var newPreview = document.getElementById("homeImgPreview");
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
			        document.getElementById("homeImgPreview").src = document.getElementById("image").value;
			})();
		
	</script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body onLoad="loadData()">

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
							
								<div class="homeLeft">
									<img src="./img/profile.png" id="homeProfileImg">
								</div>
								<div class="homeRight">
									<div id="homeTwitDiv">
										<textarea id="homeTwitWritePlace" name="twit" placeholder="무슨 일이 일어나고 있나요?"></textarea>
										<div id="homeImgPreview"></div>
									</div>
									<div class="hometwc">
										<div class="homeTwitIcon">
										<div class="ImageInputButton" onclick="onclick=document.all.image.click()">
											<img src="./img/img.png" id="icon">
											<label>
									        	<!-- <input type="file" name="file" style="display: none;"> -->
									        	<input id="image" type="file" name="inputImage" onchange="HomeImputImg();" style="display: none;">
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
														<% } else { %>
																<img data-id=<%= array.get(i).getTwitnumber() %> class="homeImagePrint" src="<%=array.get(i).getImage()%>" > 
														<% } %>	
														
													</div>			
													<div class="TLTwitButtons">
														<img src="./img/comment.png" id="TLButton">
														<img src="./img/retweet.png" id="TLButton" style="height: 15px;">
														<img src="./img/heart.png" id="TLButton">
														<img src="./img/upload.png" id="TLButton">
														<img src="./img/analytics.png" id="TLButton">
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
			<div class="searchContainer">
				<form action="search.do" method="post" name="searchEnter">
					<div id="hnSearch">
						
							<i id="hnSearchImg" class="fa fa-search fa-2x"></i>
							<input type="text" class="form-control" id="hnSearchText" name="searchContext" placeholder="트위터 검색" autocomplete=off>
							<input type="submit" hidden="hidden">
					</div>
				</form>
			</div>
			<div class="searchSide">
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
						<p>호남대학교에서 트렌드 중</p>
						<h4>#대학종강</h4>
						<p>1,240 트윗</p>
					</div>
					<div id="trContext">
						<p>대한민국에서 트렌드 중</p>
						<h4>#크리스마스</h4>
						<p>1,225 트윗</p>
					</div>
					<div id="trContextF">
						<p>광주광역시에서 트렌드 중</p>
						<h4>#연말인데_코로나</h4>
						<p>1,020 트윗</p>
					</div>
				</div>
				<div id="recommend">
					<div id="trHeader">
						<h3>팔로우 추천</h3>
					</div>
					<div id="reContext">
						<div>
							<img src="./img/gsIcon.png" id="trImg">
						</div>
						<div>
							<h4>광산구청</h4>
							<p>@Gwangsan_gu</p>
						</div>
						<div class="reFollow">
							<input type="button" value="팔로우" class="btn btn-info" id="reFollowBtn">
						</div>
					</div>
					<div id="reContext">
						<div>
							<img src="./img/huIcon.png" id="trImg">
						</div>
						<div>
							<h4>호남대학교</h4>
							<p>@Honam_Univ</p>
						</div>
						<div class="reFollow">
							<input type="button" value="팔로우" class="btn btn-info" id="reFollowBtn">
						</div>
					</div>
					<div id="reContextF">
						<div>
							<img src="./img/gjIcon.png" id="trImg">
						</div>
						<div>
							<h4>광주광역시</h4>
							<p>@GwangJu</p>
						</div>
						<div class="reFollow">
							<input type="button" value="팔로우" class="btn btn-info" id="reFollowBtn">
						</div>
					</div>
				</div>
			</div>
		</aside>
		
		<div class="modal fade" id="ImgModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
			  		<div class="modal-content">
			      		<div class="modal-header" id="modalExit">
			      			<h4 class="modal-title" id="myModalLabel">이미지 원본보기</h4>
			        		<button type="reset" data-dismiss="modal" id="modalCloseBtn"><img src="./img/exit.png" id="wtExitButton"></button>
			     	 	</div>
			     	 	<% if(info.getTwitCount() != 0) { %>
					      	 <div class="modal-body" id="modalImageContainer">
					        	<img id="modalImagePrint" >
					      	 </div>
			      		<% } %>
			    	</div>
			  	</div>
			</div>
		
	</div>
</body>
</html>