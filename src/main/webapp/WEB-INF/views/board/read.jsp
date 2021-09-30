<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<script src="${appRoot }/resources/js/read.js"></script> 

<script>

var boardBno = "${board.bno}";
var usermail = "${pinfo.user.usermail}";
</script>

<style>

a{
	padding : 10px;
	color : #050A30;
}

span{
	font-size:15px;
	padding : 10px;
    display: inline-block;
    margin-top:10px;
   

}
.img-thumbnail {
	height : 50px;
	width : 50px;
	border-radius: 70%;
	display: flex;
	float : left;
	vertical-align:middle;
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

*:focus {
    outline: none;
    }
</style>
<script type="text/javascript">
var appRoot = "${appRoot}";
var boardBno = "${board.bno}";
</script>
<title>Book List</title>
<na:navbar></na:navbar>
</head>
<body>
	
<div class="container">
	<div class="readContent">
		<div class="read-header">
				<div class="title_form">
					<div class="header-info">
						<label for="title"></label>
						<input id="title" class="form-control-plaintext" name="title" value="${board.title }" readonly>
					</div>
						<div class="form-group">
							<div class="articleInfo">
								<div class="writerInfo">
									<span class="profile">
										<img src="${appRoot }/resources/images/cookie.JPG" class="img-thumbnail" >
								
									
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
											
												<c:if test="${pinfo.user.usermail eq board.writer }" >
													<a href="${modifyUrl }">수정</a>
													<a href="${appRoot }/board/delete">삭제</a>
												</c:if>
											</ul>
										</span>																				
									</span>						
								</div>
							</div>							
						</div>		
			</div>
			
		
						
				<hr>
				
		
			
			<div class="writerInfo">
				<div class="photoZone">
					<c:if test="${not empty board.fileName }">
						<div class="photoInfo">
							<img class="img-fluid"
							src ="${imgRoot}${board.bno }/${board.fileName }">
						</div>
					</c:if>
					
			<div class="form-group">
				<label for="text"> </label>
				<textarea id="text" class="form-control-plaintext" name="content" readonly> <c:out value="${board.content }"/> </textarea>
			</div>
		
		
			<div class="replyZone">					
				<a><i class="far fa-comment"></i>댓글<strong>${board.replyCnt }</strong></a>
	
				<a><i class="far fa-heart"></i>좋아요 <strong>${board.likes }</strong></a>							
			</div>
		
		
			<hr>
		
			<h5>댓글</h5>
				
			<div class="reply-container">
				<div class="form-group">	
					<input type="text"  id="replyBno" value="${board.bno }" hidden>	
								
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