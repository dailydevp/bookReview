<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">




.container {
	margin : 100px;
}



.form-group {

	border : solid 1px #E9DDD4;
	border-radius: 3%;
	height: 600px;

}


.form {

	border : solid 1px #E9DDD4;
	border-radius: 3%;
}

#profile {
	margin : 10px;
	height : 150px;
	width : 150px;
	border-radius: 70%;
	display: flex;
}

.info_form {
		margin : 10px;
	 
}

#label {
	width: 60px;
}

.btn {
	text-align: center;
}




*:focus {
    outline: none;
}
.box{
	justify-content: center;
	height: 30px;
	display: flex;
	cursor: pointer;
	padding: 20px;
	background: #fff;
	border-radius: 30px;
	align-items: center;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
}

.box:hover input{
	margin-top: 15px;
	width: 100px;
}

.box input {
	width: 0;
	outline: none;
	border: none;
	font-weight: 500;
	transition : 0.8s;
	background: transparent;
}

.box button .fas {
	color: #1daf;
	font-size: 18px;
}

#search{
	margin-top: 15px;
	outline: none;
	border: none;
	background: transparent;
}



</style>

<script>


$(function() {


		$("#deleteMemberBtn").click(function() {	
			alert("탈퇴하시겠습니까?");
				$("#originPwCheck").modal('show');						
		});
			
		$("#exPasswordConfirm").click(function() {			
				$("#memberInfoForm")
				.attr("action", "${appRoot}/member/delete")
				.submit();						
			});
		
		$("#changePwBtn").click(function() {
			$("#originPwCheck").modal('show');
		});
		
		$("#exPasswordConfirm").click(function() {			
			$("#memberInfoForm")
			.attr("action", "${appRoot}/member/modify")
			.submit();						
		});
	

		
		/* 비밀번호/확인 여부에 따른 수정버튼 활성화*/
		$("#newPw, #newPwCheck").keyup(function() {
			var newPw = $("#newPw").val();
			var newPwCheck = $("#newPwCheck").val();
			var regpw = /(?=.*?[#?!@$%^&*-])(?=.*[a-z])(?=.*[A-Z]).{8}/;
			var modifyBtn = $("#changePwBtn");
			passwordConfirm = false;
			
			if(newPw == ""){
				$("#member-info-password-message").text("비밀번호를 입력해주세요.");	
				modifyBtn.attr("disabled", "disabled");
			} else {
				if(newPw != newPwCheck){
					$("#member-info-password-message").text("비밀번호가 일치하지 않습니다.");
					modifyBtn.attr("disabled", "disabled");
				}else if(!regpw.test(newPw)){
					$("#member-info-password-message").text("숫자+대소문자+특수문자 포함 8자리 이상 조합으로 설정해주세요.")
					modifyBtn.attr("disabled", "disabled");
				}else{
				modifyBtn.removeAttr("disabled");
				$("#member-info-password-message").empty();
				passwordConfirm = true;
				}
			
				
			}
		});
		
		      var inputPw = $("#newPw");
		      var inputPwCheck = $("#newPwCheck");
		$("#toggle-password-btn").click(function() {

		      if(inputPw.attr("type") == "password"){
		         inputPw.attr("type","text");
		         $("#toggle-password-icon").removeClass("fa-eye").addClass("fa-eye-slash");
		      }else{
		         inputPw.attr("type","password");
		         $("#toggle-password-icon").removeClass("fa-eye-slash").addClass("fa-eye");
		      }
	   });
		
		$("#toggle-password-btn2").click(function() {
		      
		      if(inputPwCheck.attr("type") == "password"){
		         inputPwCheck.attr("type","text");
		         $("#toggle-password-icon").removeClass("fa-eye").addClass("fa-eye-slash");
		      }else{
		         inputPwCheck.attr("type","password");
		         $("#toggle-password-icon").removeClass("fa-eye-slash").addClass("fa-eye");
		      }
	   });
		
		
});


</script>

<title>MY INFO</title>
<na:navbar></na:navbar>
</head>
<body>
<div class="container">

	<c:if test="${param.status == 'success' }">
		<script>
	 		alert('회원 정보 수정이 완료되었습니다.')
		</script>	
	</c:if>
	

	<c:if test="${param.status == 'error' }">
		<script>
			alert('회원 정보 수정을 할 수 없습니다.')
		</script>	
	</c:if>
	
	
	<c:if test="${param.status == 'ok' }">
		<script>
	 		alert('비밀번호 변경에 성공했습니다.')
		</script>	
	</c:if>
	

	<c:if test="${param.status == 'fail' }">
		<script>
			alert('비밀번호가 일치하지 않습니다. 다시 확인해주세요.')
		</script>	
	</c:if>
				
			  <div class="row justify-content-around row row-cols-3">
			  	
				    <div class="form-group col-4">
						<form id="memberInfoForm" method="post" action="${appRoot }/member/modify">
				    	<h4>내 프로필</h4>
				    	<div class="info_form">
					      <span class ="photo_form">
							<img id="profile"
								 <c:if test="${empty users.fileName }">
						    	 	 src="${profile }basicProfile/basicImage.png"
						    	  </c:if>
								
								<c:if test="${not empty users.fileName }">
									src="${profile }${users.usermail }/${users.fileName }"
								</c:if>
							>
							</span>
				    	</div>
	
	
						<div class ="info_form">					
							<label for="member-info-mail" id="label"><strong>이메일</strong></label>
							<input readonly value="${users.usermail}"type="email" class="form-control-plaintext" id="member-info-mail" name="usermail">
						</div>
						<div class ="info_form">
							<label for="member-info-nick" id="label"><strong>닉네임</strong></label>
							<input readonly value="${pinfo.user.nick }" type="text" class="form-control-plaintext" id="member-info-nick" name="nick">
						</div>		
						
						<div class ="info_form">
							<label for="member-info-phone" ><strong>연락처</strong></label>
							<input readonly value="${users.phoneNo }"type="text" class="form-control-plaintext" id="member-info-phone" name="phoneNo">
						</div>	
						
						<div class ="info_form">
							<label for="member-info-regdate" id="label"><strong>가입일</strong></label>
							<input readonly value="${pinfo.user.regdate }" type="text" class="form-control-plaintext" id="member-info-regdate" name="regdate">
						</div>		
						
				
						
						<a class="btn btn-primary" href="${appRoot }/member/profileModify">정보 수정</a>
						
				<%-- 		<a class="btn btn-primary" href= "${appRoot }/member/changePw">
						</a> --%>
						
						</form>
					   </div>
				
						<div class="row">
					   <div class="form col-md-12 h-50"> 
					   		<h4>비밀번호 수정</h4>
					   		
					  	  <div class="mb-2 row">
								 <label for="newPw" class="col-sm-5 col-form-label" style="padding-left : 30px;">새 비밀번호</label>
						 </div>
						    <div class="col-sm-10 input-group">
							   	 <input form="memberInfoForm" type="password" class="form-control" id="newPw" name="userpw">	
								   	   <div class="input-group-append">		
									   	   <button class="btn btn-outline-secondary" type="button" id="toggle-password-btn">
											<i id="toggle-password-icon" class = "far fa-eye"></i>
											</button>
								      </div>			
							 </div>
							  <div class="mb-2 row">
								   <label for="newPw" class="col-sm-6 col-form-label" style="padding-left : 30px;">새 비밀번호 확인</label>
							  </div>
						  	  <div class="col-sm-10 input-group">
								<input type="password" class="form-control" id="newPwCheck" >		
									<div class="input-group-append">		
										 <button class="btn btn-outline-secondary" type="button" id="toggle-password-btn2">
											<i id="toggle-password-icon" class = "far fa-eye"></i>
										 </button>
									</div>													
								 </div>				
					   
									 <small id="member-info-password-message" class="form-text text-danger"></small>
						<button type="button" id="changePwBtn" class="btn btn-primary" style="float:rigth" >
								  비밀번호 수정
						</button>
					    </div>
					    
					    <div class="form col-md-12 h-40"> 
					    <h4>회원 탈퇴</h4>
					      <p class="form-text text-danger">*회원 탈퇴 처리를 하게 될 경우, 번복은 불가합니다.<br>신중하게 결정하세요.*</p>
						<button type="button" id="deleteMemberBtn" class="btn btn-danger" style="float:right" >
							회원탈퇴
						</button>
					    </div>

					<%-- 기존 패스워드 입력 모달 --%>
			<div class="modal fade" id="originPwCheck" >
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">
								기존 패스워드 입력
							</h5>
							<button type="button" class="close" data-dismiss="modal">
								<span>&times;</span>
							</button>						
						</div>		
						
						<div class="modal-body">
							<div class="passwordCheckForm">
								<label for="oldPassword">기존 패스워드</label>
								<input form="memberInfoForm" name="oldPassword" type="password" class="form-control" id="oldPassword">
							</div>
					<!-- 		<div class="passwordCheckForm-append">
								<button class="btn btn-outline-info" type="button" id="checkPasswordBtn" name="pwBtn" ><i class="fas fa-check"></i>Check</button>
							</div>							
								 -->
						</div>
						
											  
						<div class="modal-footer">
					<!-- 		<button type="button" class="btn btn-secondary" data-dismiss="modal">
								닫기
							</button> -->
							<button type="submit" id="exPasswordConfirm" class="btn btn-danger">확인</button>
						</div>
					</div>
				</div>
			</div>	
		</div>

</div>
</body>
</html>