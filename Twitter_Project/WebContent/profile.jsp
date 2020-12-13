<%@page import="dto.ProfileDTO"%>
<%@page import="dto.TwitDTO"%>
<%@ page import="dto.InfoDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	page import = "java.util.ArrayList" %>
<%
	request.setCharacterEncoding("euc-kr");
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
	<title>
		<%
			if(session.getAttribute("userId") != null) {
				out.print(pro.getNickname()) ;
			} 
		%>
	</title>
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="./css/style.css?ver=4">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<script type="text/javascript">
	var list = null;
	/* body 실행 시 load.do 요청 */
	function proLoadData(){
		$.ajax({
			url:"proLoad.do",
			type:"post",
			success: function(temp) { /* 호출에 성공하면 response로 받은  ArrayList를 list에 삽입 */
// 				console.log(temp);
				list = temp;
			}
		});
	}

		$(function(){
			/* homeImagePrint 클릭 시 */
			$(".homeImagePrint").on('click', function() {
				var img;
				var data = $(this).attr('data-id');		/* data-id(twitnumber) 를 가져옴 */
// 				console.log('data ' + data);
// 				console.log('list ' + list.length);
				for(var i = 0; i < list.length; i++) {	/* 클릭한 twitnumber와 일치하는지 비교 */
					if(list[i].twitnumber == data) {
						img = list[i].image;
					}
				}
				
				$("#modalImagePrint").attr("src", img);	/* 모달에 해당 이미지 주소를 삽입 */
				$("#ImgModal").modal('show');
			});
			$("#pmInputName").on('input', function() {
				if($("#pmInputName").val() == ''){
					$("#profileModalSubmit").prop("disabled", true);
				}else{
					$("#profileModalSubmit").attr("disabled", false);
				}
			});
			$("#profileModalSubmit").submit(function(){
				document.form_chk.action = "${ProfileUpdateController}";
				document.form_chk.submit();				 
			});
			$('#profileModal').on('hidden.bs.modal', function (e) {
			  $(this).find('#modalForm')[0].reset();
			});
			
			$('#profileSettingBtn').click(function(){
				var contentName = $('#pmInputName').val();
				var contentProfile = $('#pmInputProfile').val();
			    $('#counter').html("("+ contentName.length + " / 최대 40자)");
			    $('#counter_1').html("("+ contentProfile.length + " / 최대 140자)");
			});
			
			$('#pmInputName').keyup(function (e){
			    var content = $(this).val();
			    $('#counter').html("("+ content.length + " / 최대 40자)");    //글자수 실시간 카운팅

			    if (content.length > 40){
			        alert("최대 40자까지 입력 가능합니다.");
			        $(this).val(content.substring(0, 40));
			        $('#counter').html("(40 / 최대 40자)");
			    }
			});
			$('#pmInputProfile').keyup(function (e){
			    var content = $(this).val();
			    $('#counter_1').html("("+ content.length + " / 최대 140자)");    //글자수 실시간 카운팅

			    if (content.length > 140){
			        alert("최대 140자까지 입력 가능합니다.");
			        $(this).val(content.substring(0, 140));
			        $('#counter_1').html("(140 / 최대 140자)");
			    }
			});
		});
		
		function onEnterLogin(){
			var keyCode = window.event.keyCode;	
			if (keyCode == 13) { //엔테키 이면
				loginForm.submit();
			}
		}
		
		var ProInputImage = 
			 (function loadImageFile() {
			    if (window.FileReader) {
					var ImagePre; 
			        var ImgReader = new window.FileReader();
			        var fileType = /^(?:image\/bmp|image\/gif|image\/jpeg|image\/png|image\/x\-xwindowdump|image\/x\-portable\-bitmap)$/i; 
			 
			        ImgReader.onload = function (Event) {
			        	if (!ImagePre) {
			                var newPreview = document.getElementById("proImgPreview");
			                ImagePre = new Image();
			                
			                newPreview.appendChild(ImagePre);
			            }
			            ImagePre.src = Event.target.result;  
			        };
			 
			        return function () {
			        	var img = document.getElementById("pmImgInput").files; 
			        	
			            ImgReader.readAsDataURL(img[0]);
			        }
			    }
			        document.getElementById("proImgPreview").src = document.getElementById("pmImgInput").value;
			})();
		
	</script>
</head>
<body onLoad="proLoadData()">
	<%
// 		if(session.getAttribute("userId") == null) {
// 			response.sendRedirect("index.jsp");
// 		}
		session.setAttribute("currentPage", "profile");
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
						<span id="profileTwitId"><%= pro.getNickname() %></span>
						<span id="profileTwitCount"><%= info.getTwitCount() %> 트윗</span>
					</div>
				</div>
				<div class="profileSectionMid">
					<div id="profileBg"></div>
					<div id="profileSetting">
						<div id="profileSettool">
							<img src="<%= pro.getImg() %>" id="profileImage">
							<button type="button" id="profileSettingBtn" class="btn btn-default" data-toggle="modal" data-target="#profileModal">프로필 설정하기</button>
						</div>
						<div id="profileInfo">
							<span id="profileTwitId"><%= pro.getNickname() %></span>
							<span id="profileText2">@<%= session.getAttribute("userId") %></span>
							<div id="profileFw">
								<img src="./img/event.png" style="width: 18px; height: 18px; margin-left: 5px;">
								<span id="profileText2" style="margin: 0 auto;"> 
								가입일: 	<%= info.getBirthdaDto().getYear() %>년 
										<%= info.getBirthdaDto().getMonth() %>월
										<%= info.getBirthdaDto().getDay() %>일 
								</span>
							</div>
							<div id="profileValue">
								<%= pro.getProfile() %>
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
									<form action="delete.do" method="post">
									<input type="hidden" name="twitnumber" value="<%= array.get(i).getTwitnumber() %>">
										<div id="TLTwitContainer">
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
												<p id="twitContents"><%= array.get(i).getText() %></p>
												<% if(array.get(i).getImage() == null || array.get(i).getImage().trim().isEmpty()) { %>
												<% } else {%>
													<img data-id=<%= array.get(i).getTwitnumber() %> class="homeImagePrint" src="<%=array.get(i).getImage()%>"> 
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
										</div>
									</form>
								</div>
							</div>
						</section>
					<% } %>
			<% } %>
			
		</section>
		
		<aside class="hnAside" onkeydown="javascript:onEnterLogin();">
			<form action="search.do" method="post" name="searchEnter">
			<div id="hnSearch">
				
					<i id="hnSearchImg" class="fa fa-search fa-2x"></i>
					<input type="text" class="form-control" id="hnSearchText" name="searchContext" placeholder="트위터 검색" autocomplete=off>
					<input type="submit" hidden="hidden">
			</div>
			<div class="searchSide">
				<div id="recommend">
					<div id="trHeader">
						<h3>팔로우 추천</h3>
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
					<div id="reContext">
						<div>
							<img src="./img/profile.png" id="trImg">
						</div>
						<div>
							<h4>김용일</h4>
							<p>@ylkim</p>
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
							<h4>전현준</h4>
							<p>@hjJeon</p>
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
						<h4>#오늘날씨</h4>
						<p>2,440 트윗</p>
					</div>
					<div id="trContext">
						<p>광주광역시에서 트렌드 중</p>
						<h4>#광주첫눈</h4>
						<p>2,100 트윗</p>
					</div>
					<div id="trContextF">
						<p>전세계에서 트렌드 중</p>
						<h4>#Java Servlet</h4>
						<p>1,020 트윗</p>
					</div>
				</div>
			</div>
			</form>
		</aside>
		
		<!-- 프로필 설정 클릭시 나오는 모달 -->
			<div class="modal fade" id="profileModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
			    	<div class="modal-content">
			    		<form action="update.do" method="post" id="modalForm" enctype="multipart/form-data">
			      			<div class="modal-header" id="modalHeader">
			        			<button type="reset" data-dismiss="modal" id="modalCloseBtn"><img src="./img/exit.png" id="pmExitButton"></button>
			        			<p id="pmLabel">프로필 수정</p>
			        			<input type="submit" value="저장" class="btn btn-info" id="profileModalSubmit">
				      		</div>
					      	<div class="modal-body" id="modalBody">
					      		<div class="profileSectionMid">
									<div id="pmBg"></div>
									<div id="pmSetting">
									
									<div class="button" onclick="onclick=document.all.pmImgInput.click()">
										<img src="./img/profile.png" id="pmImage">
<!-- 프로필사진 변경 구현하기 -->
										<div id="proImgPreview"></div>
										<label>
								        	<input id="pmImgInput" type="file" name="inputImage" onchange="ProInputImage();" style="display: none;">
								        </label>	
								    </div>
								    
									</div>
								</div>
						        <div class="pmInputContainer">
						        	<div id="pmNameCont">
						        		<p>이름</p>
						        		<input type="text" id="pmInputName" name="inputName" value="<%= pro.getNickname() %>" autocomplete=off>
						        	</div>
						        </div>
						        <div id="counter">(0 / 최대 40자)</div>
						        <div class="pmInputContainer">
						        	<div id="pmNameCont">
						        		<p>자기소개</p>
						        		<input type="text" id="pmInputProfile" name="inputProfile" value="<%= pro.getProfile() %>" autocomplete=off> 
						        	</div>
						        </div>
						        <div id="counter_1">(0 / 최대 140자)</div>
				      		</div>
			      		</form>
			    	</div>
			  	</div>
			</div>
			
			<!-- 이미지 클릭시 나오는 모달 -->
			<div class="modal fade" id="ImgModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
			  		<div class="modal-content">
			      		<div class="modal-header" id="modalExit">
<!-- 			        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
			        		<h4 class="modal-title" id="myModalLabel">이미지 원본보기</h4>
			        		<button type="reset" data-dismiss="modal" id="modalCloseBtn"><img src="./img/exit.png" id="wtExitButton"></button>
			     	 	</div>
			     	 	<% if(info.getTwitCount() != 0) { %>
					      	 <div class="modal-body" id="modalImageContainer">
					        	<img id="modalImagePrint">
					      	 </div>
			      		<% } %>
			    	</div>
			  	</div>
			</div>
	</div>
</body>
</html>