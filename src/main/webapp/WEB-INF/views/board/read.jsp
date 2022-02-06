<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<script src="${appRoot }/resources/js/read.js"></script> 


<script>
var appRoot = "${appRoot}";
var boardBno = "${board.bno}";
var usermail = "${pinfo.user.usermail}";
var fileN = "${user.fileName }"
var likes = "${board.likesCnt }";
var boardlike = "${board.likes }";
var boardlike2 = "${board.likesCnt }";
var bb = "${board.views }";
var filesss = "${imgRoot}book/${board.bno }/${board.fileName}";


$(function() {
		$("#title").ready(function() {
				  $.ajax({
					  method: "GET",
					  url:"https://dapi.kakao.com/v3/search/book?target=title",
			          headers: {Authorization: "KakaoAK fbe438ce8e023b64b82b9eb13c6ea2a3"},
			          data: { 
			        	  query: $("#title").val()
			        	  }
				  })
				  .done(function(info) {
					console.log(info);
					if(info != null && info != ""){
						$("#coverimg").append("<img src='" + info.documents[0].thumbnail + "'/><br>");
						$("h4").append(info.documents[0].title);
						$(".card-text").append(info.documents[0].contents);
						$(".card-author").append(info.documents[0].authors);
					
					}
						});
				  

	});	
				 
});

</script>

<style>

a{
	padding-top : 17px;
	color : #050A30;
    text-decoration:none;

}

 a:hover { color: #050A30; text-decoration:none;}

span{
	font-size:15px;
	padding : 10px;
    display: inline-block;
    margin-top:10px;
   

}

.replyZone{
	display: flex;
	height: 20px;
}

.form-control{
	background: white;

}


.hearder-info{
	color : #F9F1F0;
	background-color: #81B622;
}
.modeForm{
	padding-bottom: 0px;
}

	


img {
	width : 180px; 
	height : 250px;
	margin-top: 25px;
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
#profile {
	margin-top : 10px;
	height : 40px;
	width : 40px;
	border-radius: 70%;
	float : left;


}

#delete{
	color : red;
	border-color: transparent;
	background-color: white;
}

#likes{
	border-color: transparent;
	background: transparent;
}

#title{
	font-size: 40px;
	position : relative;
	text-align:center;
	padding : 40px 0px;
	}
	
#text{
	resize: none;
	border:none;
}
	
#replyText {
	border : solid 1px #B9B7BD;
	resize: none;
}

#replyNick{
	background-color: white;
	border : none;
}

#replyTextModify{
	resize: none;
	}
	
#search{
	margin-top: 15px;
	outline: none;
	border: none;
	background: transparent;
}

*:focus {
    outline: none;
    }
</style>
<script>

</script>

<title>Book List</title>
<na:navbar></na:navbar>
</head>
<body>

<bd:navbar></bd:navbar>

<div class="container">
	<div class="readContent">
		<div class="read-header">
				<div class="title_form">
				<form id="readForm" action="${appRoot }/board/read" method="post" enctype="multipart/form-data">
					<input hidden name="bno" value="${board.bno }">
					<input hidden name="fileName" value="${board.fileName }">
					<div class="header-info">
						<label for="title"></label>
						<input id="title" class="form-control-plaintext" name="title" value="${board.title }" readonly>
						<input name="reply" id="replyeCnt" class="form-control-plaintext">
					</div>
						<div class="form-group">
							<div class="articleInfo">
								<div class="writerInfo">
								
										    
							<img id="profile"
								 <c:if test="${empty board.profile }">
						    	 	 src="${profile }basicProfile/basicImage.png"
						    	  </c:if>
								
								<c:if test="${not empty board.profile }">
									src="${profile }${board.writer }/${board.profile }"
								</c:if>
							>
		
									<input type = "hidden" id="writer" class="form-control-plaintext" name="writer" value="${board.writer }" readonly>	
									<a href="${appRoot }/member/viewInfo"><span>${board.writerName }</span></a>
										<span class="regdate">
											<fmt:formatDate value="${board.regDate }" pattern="yyyy-MM-dd HH:mm"/>
										</span>		
						
	
										
										<span class="modeForm">
											<ul class="changeMode">
											
												<c:url value="/board/modify" var="modifyUrl">
													<c:param name="bno" value="${board.bno }"/>
								  					<c:param name="pageNo" value="${cri.pageNo }" />
								  					<c:param name="amount" value="${cri.amount }" />
								  					<c:param name="type" value="${cri.type }"/>
													<c:param name="keyword" value="${cri.keyword }" />		
												</c:url>
												
												<c:url value="/board/delete" var="deleteUrl">
													<c:param name="bno" value="${board.bno }"/>
								  					<c:param name="pageNo" value="${cri.pageNo }" />
								  					<c:param name="amount" value="${cri.amount }" />
								  					<c:param name="type" value="${cri.type }"/>
													<c:param name="keyword" value="${cri.keyword }" />		
												</c:url>
												
												
											
												<c:if test="${pinfo.user.usermail eq board.writer }" >
													<a href="${modifyUrl }">수정&nbsp;</a>|
													<input type="submit" id="delete" onclick="deleteCheck()" value="삭제" >
												</c:if>
											</ul>
										</span>																													
								</div>
							</div>							
						</div>		
			</div>
			
		
						
				<hr>
				
		
				<div class="photoZone">
					<c:if test="${not empty board.fileName }">
						<c:forEach items="${board.fileName }" var="imgs">
							<span class="photoInfo">
								<img class="img-fluid"
								src ="${imgRoot}book/${board.bno }/${imgs}">
							</span>
						</c:forEach>
					</c:if>
				</div>
									</form>
		
					
			<div class="form-group">
						<div class="card mb-3" style="max-width: 60%; border: none;">
							<div class="row g-0">
								<div class="col-md-4" id="coverimg" ></div> 
								<div class="col-md-8">
									<div class="card-body">
										<h4 class="card-title"><input hidden name="title"/></h4>
										<p class="card-author"><input hidden class="author" id="author" name="author" ></p>
										<p class="card-text"></p>
									</div>
								</div>
							
							</div>
						</div>
						<hr>
				<label for="text"> </label>
				<textarea id="text" class="form-control-plaintext" name="content" rows="5" readonly> ${board.content } </textarea>
			</div>
		
		
			<div class="form-groups">		

				<i class="far fa-comment"></i>&nbsp;댓글&nbsp;<strong>${board.replyCnt }</strong>
			
				<button id="likes" >
					<c:choose>
						<c:when test="${!board.getLikeClick}">
						<span class="likesBtn">
							<i class="far fa-heart"></i>
						</span>
							<input type="hidden" value="${lno }">
						</c:when>					
						<c:when test="${board.getLikeClick}">
						<span class="likesBtn">
							<i class="fas fa-heart"></i>
						</span>
							<input type="hidden" value="${lno }">
						</c:when>					
					</c:choose>
				좋아요&nbsp;<strong>${board.likesCnt }</strong></button>		
			</div>

			<br>
			<hr>
		
			<h5>댓글</h5>
				
			<div class="reply-container">
				<div class="form-group">	
					<input type="text" value="${board.bno }" hidden>	
								
				      <div class="form-group" hidden>
			            <label for="recipient-name" class="col-form-label">작성자</label>
			            <input type="text" class="form-control" value="${pinfo.user.nick}" readonly />
			            <input type="text" value="${pinfo.user.usermail }" class="form-control" id="replyWriter" >
			          </div>

					<label for="replyText"></label>
					<textarea id="replyText" class="form-control-plaintext" name="text" rows="3" placeholder="댓글을 작성해주세요." ></textarea>
				</div>
				
				<sec:authorize access="isAuthenticated()">
					<input type="submit" class="btn btn-primary" id="replyInsert" data-toggle="modal" data-target="#replyInsert" value="댓글작성"/>
				</sec:authorize>
				<ul class="list-unstyled" id="replyList-container"></ul>
			</div>	
	 	

			
		<%-- 댓글 수정, 삭제 모달 --%>
<div class="modal fade" id="reply-modifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">댓글 수정/삭제</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <input type="text" value="" readonly hidden id="replyRno" >
          <input type="text" value="${board.bno }" readonly hidden id="replyBno">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">작성자</label>
            <input id="replyNick" class="form-control" readonly type="text" />
            <input type="hidden" class="form-control" id="replyer" readonly>
          </div>
          <div class="form-group">
            <label for="replyTextModify" class="col-form-label">댓글</label>
            <textarea class="form-control" id="replyTextModify"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <span id="replyModify-deleteWrapper">
	        <button id="replyModifyBtn" type="button" class="btn btn-primary">댓글 수정</button>
	        <button id="replyDeleteBtn" type="button" class="btn btn-danger">댓글 삭제</button>
        </span>
      </div>
    </div>
  </div>
</div>
        
 				
		
	</div>
</div>
</body>
</html>