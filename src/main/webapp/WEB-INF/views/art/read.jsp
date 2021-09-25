<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<script src="${appRoot }/resources/js/get.js"></script>
<style>
.form-control{
	background: white;
	border-line
}

#title{
	background-color: white;

	}

*:focus {
    outline: none;
</style>

<title>Art List</title>
<na:navbar></na:navbar>
</head>
<body>
<div class="container">
	<div class="readContent">
		<div class="read-header">
			<div class="form-group">
				<label for="title"> 제목 </label>
				<input id="title" class="form-control-plaintext" name="title" value="${artboard.title }" readonly>
			</div>
			<div class="form-group">
				<label for="text"> 내용 </label>
				<input id="content" class="form-control-plaintext" name="content" <c:out value="${artboard.content }"/> readonly>
			</div>
			
			<div class="writerInfo">
				<div class="profileZone">
					<c:if test="${not empty artboard.fileName }">
						<div class="profileInfo">
							<img class="img-fluid"
							src ="${imgRoot}${board.bno }/${artboard.fileName }">
						</div>
					</c:if>
					<div class="articleInfo">
						<div class="writerInfo">
							<label for="writer">작성자</label>
							<input type = "hidden" id="writer" class="form-control-plaintext" name="writer" value="${artboard.writer }" readonly>	
							<input class="form-control-plaintext" value="${artboard.writerName }" readonly>		
						</div>
					
					<!-- 	<span class="" > 2021.09.06. 20:24</span>
						<span class="">조회 777</span> 
				<a><img alt="imgß" src=""></a>
						-->
					</div>
				</div>
			</div>
		</div>
		
			<hr>
		
			
			
			<div class="read-container">
				<div class="form-group">
					<label for="text"></label>
					<textarea id="text" class="form-control-plaintext" name="text" rows="10" readonly>이것이 댓글 
					일세</textarea>
				</div>
			
			<div class="replyZone">
				<label for="좋아요" ></label>
				<label for="댓글" ></label>
			</div>
		
			</div>
	</div>
</div>
</body>
</html>