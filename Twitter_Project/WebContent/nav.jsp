<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! String[] src = {"./img/home.png", "./img/sharp.png", "./img/alarm.png", "./img/message.png", "./img/bookmark.png",
					"./img/list.png", "./img/profile_1.png", "./img/ellipsis.png"};
	String[] href = {"./login.do", "", "", "", "", "", "./profile.do", ""};
	String[] text = {"홈", "탐색하기", "알림", "쪽지", "북마크", "리스트", "프로필", "더보기"};
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(function(){
			/* $("#wtArea").on('keydown keyup', function () {
				  $(this).height(1).height( $(this).prop('scrollHeight')+20 );
			}); */
			
			$('#wtTwit').ready(function() {								// 스크롤 크기 자동조절
				$('#wtTwit').on( 'keyup', '#wtArea', function (e){
			    	$(this).css('height', 'auto' );
			    	$(this).height( this.scrollHeight );
				});
			    	$('#wtTwit').find('wtArea').keyup();
				});

			$("#wtArea").on('input', function() {
				if($("#wtArea").val() == ''){
					$("#wtButton").prop("disabled", true);
				}else{
					$("#wtButton").attr("disabled", false);
				}
			}); 
			
			$('#myModal').on('hidden.bs.modal', function (e) {
				$(this).find('#navModal')[0].reset();
			});
			
			$('#navButton').click(function(){							// 클릭시 글자 수 0부터 시작
				var content = $('#wtArea').val();
			    $('#navCounter').html("("+ content.length + " / 최대 140자)");    
			});

			$("#wtButton").submit(function(){							
				document.form_chk.action = "${TwitWriteController}";
				document.form_chk.submit();				 
			});

			$('#wtArea').keyup(function (e){							// 글자수 실시간 카운팅
			    var content = $(this).val();
			    $('#navCounter').html("("+ content.length + " / 최대 140자)");    

			    if (content.length > 140){
			        alert("최대 140자까지 입력 가능합니다.");
			        $(this).val(content.substring(0, 140));
			        $('#navCounter').html("(140 / 최대 140자)");
			    }
			});
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
			        	var img = document.getElementById("navImage").files; 
			        	if (!fileType.test(img[0].type)) { 
				        	alert("이미지 파일을 업로드 하세요"); 
				            return; 
			        	}
			            ImgReader.readAsDataURL(img[0]);
			        }
			    }
			        document.getElementById("imagePreview").src = document.getElementById("navImage").value;
			})();
	</script>
</head>
<body style="width:100%; height:100%;">
	<div class="navDiv">
		<div id="navBird">
			<img src="./img/twitter_logo.png" id="navLogoImg">
		</div>
		<div id="navList">
			<ul class="navUl">
				<% 
					for(int i = 0; i < src.length; i++) {
				%>
					<li id="navLi"><a id="navA" href= <%= href[i] %>><img id="navImg" 
					<% if(src[i] == "./img/bookmark.png") { %>
						style="padding-left: 3px;"
					<% } %>
					src=<%= src[i] %>><%= text[i] %></a></li>
				<%		
					}
				%>
			</ul>
		</div>
		<div id="navButtons">
			<input type="button" onClick="" class="btn btn-info btn-block" value="트윗" id="navButton" data-toggle="modal" data-target="#myModal">
			
			<form action="logout.do" method="post">
				<input type="submit" value="로그아웃" class="btn btn-info btn-block" id="navButton">
			</form>
			
			<!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
			    	<div class="modal-content">
			      		<div class="modal-header">
			        		<button type="reset" data-dismiss="modal" id="modalCloseBtn"><img src="./img/exit.png" id="wtExitButton"></button>
			      		</div>
				      	<div class="modal-body" id="wtFlex">
					        <section class="wtLeft">
								<div id="wtProfile">
									<img src="./img/profile.png" id="wtProfileImg">
								</div>
							</section>
							<section class="wtRight">
								<form action="write.do" method="post" id="navModal" enctype="multipart/form-data">
									<div id="wtTwit">
										<textarea id="wtArea" name="twit" placeholder="무슨 일이 일어나고 있나요?"></textarea>
										<div id="imagePreview"></div>
										<div id="navCounter">(0 / 최대 40자)</div>				
									</div>
									<div id="wtBot">
								        <div class="wtTwitIcon">
											<div class="button" onclick="onclick=document.all.navImage.click()">
												<img src="./img/img.png" id="icon">
												<label>
										        	<!-- <input type="file" name="file" style="display: none;"> -->
										        	<input id="navImage" type="file" name="inputImage" onchange="InputImage();" style="display: none;">
										        </label>	
										    </div>
											<img src="./img/gif.png" id="icon">
											<img src="./img/barchart.png" id="icon">
											<img src="./img/smile.png" id="icon">
											<img src="./img/event.png" id="icon">
										</div>	
										<div>
											<input type="submit" value="트윗" class="btn btn-info" id="wtButton" disabled="disabled">
										</div>
						      		</div>
					      		</form>
				      		</section>
			      		</div>
			    	</div>
			  	</div>
			</div>
		</div>
	</div>
</body>
</html>