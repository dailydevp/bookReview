<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags/" %>
<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>내 프로필 수정하기</title>
<na:navbar></na:navbar>
<script type="text/javascript">
$(function() {
	
	
		//닉네임 중복 체크
		
		$("#member-info-nick").keyup(function() {
			var nickVal = $("#member-info-nick").val(); 
			
			if(nickVal == ""){
				$("#nickname-message").text("닉네임을 입력해주세요.");
			}else{
				var data = {nick : nickVal};
				$.ajax({
					type : "get",
					url : "${appRoot}/member/checkNick",
					data : data,
					success : function(data) {
						if(data == "success"){
							console.log("사용가능 닉네임")
							validNick = true;
							$("#nickname-message").empty();
						}
						else if(data == "exist") {
							console.log("사용불가 닉네임")	
							$("#nickname-message").text("이미 사용중인 닉네임입니다.");
						}
					},
					error : function() {
						console.log("확인불가");
					}
				});
			}
		})
		
	$("#modifyBtn").click(function() {		
		$("#infoModify")
		.attr("action","${appRoot}/member/modifyInfo")
		.submit();
		
	});
	
	$("#changeFileBtn").click(function() {
		$("#profileBtn").click();
	});
	
	$("#profileBtn").change(function(e) {
		$("#profile").attr("src", URL.createObjectURL(e.target.files[0]));
	});
	

});
</script>
<style>
.container {
	margin : 100px;
}



.form-group {

	border : solid 1px #E9DDD4;
	border-radius: 3%;
	height: 600px;

}

.info_form {
		margin : 10px;
	 
}

#label {
	width: 60px;
}

#profile {
	margin : 10px;
	height : 150px;
	width : 150px;
	border-radius: 70%;
	display: flex;
}

*:focus {
    outline: none;
}

</style>
</head>
<body>
<div class="container">


	 <div class="form-group col-4">

	 
				    	<h4>내 프로필</h4>
				     	 <div class ="photo_form">
				    <form id="profileUpdate" action="${appRoot }/member/profileUpload" method="post" class="line" enctype="multipart/form-data">
				    
				    		<input value="${pinfo.user.usermail }" type="hidden" class="form-control" name="usermail">
				    		
				    		
						<img class="img-thumbnail" id="profile"
							 <c:if test="${empty users.fileName }">
					    	 	 src="${profile }basicProfile/basicImage.png"
					    	  </c:if>
							
							<c:if test="${not empty users.fileName }">
								src="${profile }${users.usermail }/${users.fileName }"
							</c:if>
						>
						
					<input type="file" hidden class="btn btn-light" id="profileBtn" name="file">
					<button id="changeFileBtn" type="button" class="btn btn-light" name="changeFileBtn">사진 변경</button>
					<button class=" btn btn-light" type="submit" name="changePhoto" id ="changePhoto">적용 </button>
					<button class="btn btn-light" type="submit" id="removePhoto" name="removePhoto">삭제</button>
				    </form> 	 	     
					
						</div>
	
				    	<form action="${appRoot }/member/profileModify" id="infoModify" method="post">
						<div class ="info_form">					
							<label for="member-info-mail" id="label"><strong>이메일</strong></label>
							<input readonly value="${pinfo.user.usermail}"type="email" class="form-control-plaintext" id="member-info-mail" name="usermail" readonly>
						</div>
							<div class ="info_form">
								<label for="member-info-nick" id="label"><strong>닉네임</strong></label>
								<input value="${pinfo.user.nick }" type="text" class="form-control-plaintext" id="member-info-nick" name="nick">
								<small id="nickname-message" class="form-text text-danger"></small>
							</div>	
							
							<div class ="info_form">
								<label for="member-info-phoneNo" id="label"><strong>연락처</strong></label>
								<input value="${pinfo.user.phoneNo }" type="text" class="form-control-plaintext" id="member-info-phoneNo" name="phoneNo">
							</div>		
							
							<div class ="info_form">
								<label for="member-info-phoneNo" id="label"><strong>가입일</strong></label>
								<input value="${pinfo.user.regdate }" type="text" class="form-control-plaintext" id="member-info-regdate" name="regdate" readonly>
							</div>	

						<button class="btn btn-primary" name="modifyBtn" id="modifyBtn" type="submit">정보 수정</button>
				    	</form>
	</div>
</div>
</body>
</html>