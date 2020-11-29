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
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<script type="text/javascript">
		function onEnterLogin(){
			var keyCode = window.event.keyCode;	
			if (keyCode == 13) { //엔테키 이면
				loginForm.submit();
			}
		}
		
		$(function(){
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
		
	</script>
</head>
<body>
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
							<img src="./img/profile.png" id="profileImage">
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
												<%= array.get(i).getText() %>
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
			</form>
		</aside>
		
		<!-- Modal -->
			<div class="modal fade" id="profileModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
			    	<div class="modal-content">
			    		<form action="update.do" method="post" id="modalForm">
			      			<div class="modal-header" id="modalHeader">
			        			<button type="reset" data-dismiss="modal" id="modalCloseBtn"><img src="./img/exit.png" id="pmExitButton"></button>
			        			<p id="pmLabel">프로필 수정</p>
			        			<input type="submit" value="저장" class="btn btn-info" id="profileModalSubmit">
				      		</div>
					      	<div class="modal-body" id="modalBody">
					      		<div class="profileSectionMid">
									<div id="pmBg"></div>
									<div id="pmSetting">
										<img src="./img/profile.png" id="pmImage">
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
	</div>
</body>
</html>