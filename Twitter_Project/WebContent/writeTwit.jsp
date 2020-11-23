<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="./css/style.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#wtArea").on('keydown keyup', function () {
				  $(this).height(1).height( $(this).prop('scrollHeight')+20 );
			});
			
			$("#wtArea").on('input', function() {
				if($("#wtArea").val() == ''){
					$("#wtButton").prop("disabled", true);
				}else{
					$("#wtButton").attr("disabled", false);
				}
			}); 
			
			$("#wtButton").submit(function(){
				document.form_chk.action = "${TwitWriteController}";
				document.form_chk.submit();
				 /* $("#wtDiv").dialog("close"); */
				window.open("about:blank","_self").close();
				 
			});
			
		});
		
	</script>
</head>
<body>
	<div class="wtDiv">
		<section class="wtTop">
			<img src="./img/arrow.png" id="wtExitButton">
		</section>
		<div id="wtFlex">
			<section class="wtLeft">
				<div id="wtProfile">
					<img src="./img/profile.png" id="wtProfileImg">
				</div>
			</section>
			<section class="wtRight">
				<form action="write.do" method="post">
					<div id="wtTwit">
						<textarea id="wtArea" name="twit" placeholder="무슨 일이 일어나고 있나요?"></textarea>				
					</div>
					<section id="wtBot">
						<div class="wtTwitIcon">
							<img src="./img/img.png" id="icon">
							<img src="./img/gif.png" id="icon">
							<img src="./img/barchart.png" id="icon">
							<img src="./img/smile.png" id="icon">
							<img src="./img/event.png" id="icon">
						</div>	
						<div>
							<input type="submit" value="트윗" class="btn btn-info" id="wtButton" disabled="disabled">
						</div>
					</section>
				</form>
			</section>
		</div>
	</div>
</body>
</html>