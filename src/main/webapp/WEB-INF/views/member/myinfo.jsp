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




</style>

<script>


$(function() {

		$("#deleteMemberBtn").click(function() {	
			alert("탈퇴하시겠습니까?");
				$("#deleteMem").modal('show');						
		});
			
		$("#modaldeleteBtn").click(function() {			
				$("#memberInfoForm")
				.attr("action", "${appRoot}/member/delete")
				.submit();						
			});
		
		$("#changePwBtn").click(function() {
			$("#originPwCheck").modal('show');
		});
		
		$("#exPasswordConfirm").click(function() {
			$("#changePwModal").modal('show');
			$("#originPwCheck").modal('hide');
		})
		$("#updatePw").click(function() {
			$("#memberInfoForm2")
			.attr("action", "${appRoot}/member/modify")
			.submit();	
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
	 		alert('회원정보 수정이 완료되었습니다.')
		</script>	
	</c:if>
	

	<c:if test="${param.status == 'error' }">
		<script>
			alert('회원 정보 수정을 할 수 없습니다.')
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
						<button type="button" id="changePwBtn" class="btn btn-primary" style="float:rigth" >
								  비밀번호 수정
						</button>
						<button type="button" id="deleteMemberBtn" class="btn btn-danger" style="float:right" >
							회원탈퇴
						</button>
						
						</form>
						
				
				
				
			
							
							
								 			 <!-- 비밀번호 수정 모달창 -->
								
								
								<!-- Modal -->
								<div class="modal fade" id="changePwModal" tabindex="-1" aria-labelledby="changePassword" aria-hidden="true">
								  <div class="modal-dialog">
								    <div class="modal-content">
								      <div class="modal-header">
								        <h5 class="modal-title" id="changePassword">비밀번호 수정</h5>
								        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
								          <span aria-hidden="true">&times;</span>
								        </button>
								      </div>
								      <div class="modal-body">
									 
											  <div class="modalPw">
											    <label for="newPw">새 비밀번호</label>
											    <input form="memberInfoForm2" type="password" class="form-control" id="newPw">						
											  </div>
										
								      </div>
								      <div class="modal-footer">
								        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
								        <button type="submit" name="changPw" id="updatePw" class="btn btn-primary">변경하기</button>
								      </div>
								    </div>
								  </div>
								</div>
								
								
								 			 <!-- 회원탈퇴 모달창 -->
								
								<div class="modal fade" id="deleteMem" tabindex="-1" aria-labelledby="deleteMem" aria-hidden="true">
								  <div class="modal-dialog">
								    <div class="modal-content">
								      <div class="modal-header">
								        <h5 class="modal-title">회원탈퇴</h5>
								        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
								          <span aria-hidden="true">&times;</span>
								        </button>
								      </div>
								      <div class="modal-body">				       
											  <div class="modalDelete">
											    <label for="ex-Password">기존 비밀번호</label>
											    <input form="memberInfoForm" type="password" class="form-control" id="ex-Password" name="oldPassword" aria-describedby="oldPassword">									   
											    <small class="form-text text-danger">*현재 회원탈퇴 페이지입니다. 신중하게 결정하세요.</small>
											  </div>										
								      </div>
								      <div class="modal-footer">
								        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
								        <button type="submit" id="modaldeleteBtn" class="btn btn-danger">탈퇴</button>
								      </div>
								    </div>
								  </div>
								</div>
							<!-- Modal 	-->
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
								<input form="memberInfoForm2" name="oldPassword" type="password" class="form-control" id="oldPassword">
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">
								닫기
							</button>
							<button type="submit" id="exPasswordConfirm" class="btn btn-danger">확인</button>
						</div>
					</div>
				</div>
			</div>	
								
								
								
								
								
						    </div>
					</div>
				     
		
			 

							
	
</div>
</body>
</html>