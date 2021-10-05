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
var file =  "${pinfo.user.fileName}";
var likes = "${board.likesCnt }";
var boardlike = "${board.likes }";
var boardlike2 = "${board.likesCnt }";
var bb = "${board.views }";
</script>

<style>

a{
	padding-top : 17px;
	color : #050A30;

}

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
	width : 300px;
}

#likes{
	position : relative;
	padding : 2px 0px;
	margin-bottom: 120px;
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


#title{
	font-size: 40px;
	position : relative;
	text-align:center;
	padding : 40px 0px;
	}
	
#text{
	resize: none;
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
*:focus {
    outline: none;
    }
</style>
<script>
$(document).ready(function deleteCheck() {
	$("#delete").click(function() {
		var deleteUrl = "${appRoot}/board/delete";
		var readUrl = "${appRoot}/board/read";
		var msg = confirm("글을 삭제하시겠슴둥...?");
		if(msg == true){
			$("#readForm").attr("action", deleteUrl).submit();
		}else{
			return;
		}
	})
})
</script>

<title>Book List</title>
<na:navbar></na:navbar>
</head>
<body>
	
<div class="container">
	<div class="readContent">
		<div class="read-header">
				<div class="title_form">
				<form id="readForm" action="${appRoot }/board/read" method="post" enctype="multipart/form-data">
					<input hidden name="bno" value="${board.bno }">
					<div class="header-info">
						<label for="title"></label>
						<input id="title" class="form-control-plaintext" name="title" value="${board.title }" readonly>
					</div>
						<div class="form-group">
							<div class="articleInfo">
								<div class="writerInfo">
									
											<c:if test="${not empty pinfo.user.fileName }">
												<div>
													<img id="profile" src="${profile}${pinfo.user.usermail }/${pinfo.user.fileName}">
												</div>
											</c:if>
								
									
									<input type = "hidden" id="writer" class="form-control-plaintext" name="writer" value="${board.writer }" readonly>	
									<a href="${appRoot }/member/myinfo"><span>${board.writerName }</span></a>
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
													<a href="${modifyUrl }">수정</a> |
													<input type="submit" id="delete" onclick="deleteCheck()" value="삭제" >
												</c:if>
											</ul>
										</span>																				
									</span>						
				</form>
								</div>
							</div>							
						</div>		
			</div>
			
		
						
				<hr>
				
		
				<div class="photoZone">
					<c:if test="${not empty board.fileName }">
						<div class="photoInfo">
							<img class="img-fluid"
							src ="${imgRoot}book/${board.bno }/${board.fileName }">
						</div>
					</c:if>
				</div>
			<div class="writerInfo">
					
					
			<div class="form-group">
				<label for="text"> </label>
				<textarea id="text" class="form-control-plaintext" name="content" rows="15" readonly> <c:out value="${board.content }"/> </textarea>
			</div>
		
		
			<div class="replyZone">		
			
			<div class="views">kk ${board.views }</div>		
				<div class="replys"><i class="far fa-comment"></i>&nbsp;댓글&nbsp;<strong>${board.replyCnt }</strong></div>
			
				<div id="likes">
					<c:choose>
						<c:when test="${!board.clicked}">
						<span class="likesBtn">
							<i type="button" class="far fa-heart"></i>
						</span>
							<input type="hidden" class="likesCheck" value="${lno }">
						</c:when>					
						<c:when test="${board.clicked}">
						<span class="likesBtn">
							<i type="button" class="fas fa-heart"></i>
						</span>
							<input type="hidden" class="likesCheck" value="${lno }">
						</c:when>					
					</c:choose>
				좋아요&nbsp;<strong>${board.likesCnt }</strong></div>		
			</div>
		
				
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
</div>
</body>
</html>