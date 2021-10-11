<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<na:navbar></na:navbar>
<style>


body {
	background-color: pink;
}

 .findpwForm{
	margin : 150px 500px;
	height: 400px;
	width : 500px;
	padding: 20px;
	background: #fff;
	align-items: center;
	text-align: center;
	border : solid 1px #189AB4;
	border-radius: 10%;

}


 .findpwForm input{ 
 	margin : 55px;
	width : 350px;
	font-weight: 100;
	background: transparent;
	text-align: center;
	align-items: center;
	font-size: 18px;

 }
</style>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>비밀번호 찾기</title>

<script type="text/javascript">
$(function() {
	 $("#findmailBtn").click(function(e) {
	 	e.preventDefault();
		var emailVal = $("#find-pw-email").val();
		var regmail = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
		var validMail = false;
		if(emailVal == ""){
			alert("이메일을 입력해주세요.")
		}else if (!regmail.test(emailVal)){
			alert("올바른 형식으로 작성해주세요.")
		}else{
			var data = {email : emailVal};
			$.ajax({
				type : "post",
				url : appRoot+"/member/newpassword",
				data : data,
				success : function (data) {
					if(data[0] == "exist"){	
						alert("해당 이메일 주소로 새로운 임시 비밀번호를 발송 했습니다. 임시 비밀번호로 로그인 후 비밀번호 변경해주세요.");
						console.log("이미 회원 가입되어 있는 이메일")
						validMail = true;
					}else{
						console.log("등록되어 있지 않은 이메일")
						alert("등록되어 있지 않은 이메일입니다. 회원 가입을 진행해주세요.");
					}
				},
				error : function() {
					console.log("이메일 확인 불가")
				}
			})
		}
	})
		
	
});
</script>
</head>
<body>

			<div class="contents">
		 		 <div class="findpwForm">	
					<form action="${appRoot }/member/findpw" method="get">
		  				<h1>비밀번호 찾기</h1>
		  				
		  					<p style="color : #0C2D48">비밀번호를 재설정 할 이메일 주소를 입력하세요.</p>
		  					<hr>
		  					<div>
							  <input type="email" class="form-control" id="find-pw-email" name ="usermail" placeholder="email@gmail.com">	  
						 	 <button type="submit" id="findmailBtn" class="btn btn-outline-primary" >비밀번호 재설정 이메일 보내기</button>	
		  					</div>
					</form>
				</div>	
			</div>	
	


</body>
</html>