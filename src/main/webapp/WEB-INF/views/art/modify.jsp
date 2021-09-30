<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<style>

img {
	width : 300px;
	}
	
	
#text{
	resize: none;
	border:none;
	}
	
*:focus {
    outline: none;
    }
	
</style>

<title> 수정 / 삭제 </title>
</head>
<body>
<na:navbar></na:navbar>
<div class="container">
				
<div class="boardForm">
	<div class="boardContent">
		<div class="board-header">
			<form action="${appRoot }/art/modify" method="post" enctype="multipart/form-data">
				<input hidden name="bno" value="${board.bno }">
					  <div class="form-group">
					    <label for="categories"></label>
					      <select class="form-control" id="categories" name ="categorie" style="width : 120px;">    
					      	<option>ART</option>   
					      	<option>BOOK</option>
					      </select>
					  </div>
					  <div class="form-group">
					    <label for="region"></label>
					    <select class="form-control" id="region" name ="region" style="width : 120px;">
					    
					      <option>서울</option>
					      <option>부산</option>
					      <option>제주</option>
					    </select>
					  </div>
			
				<div class ="date row">
					<div class="form-group col-3">
						<label for ="startDate"/>
						<input id ="startDate" class="form-control" name="startDate" type="date" value="${board.startDate }">
					</div>
						~
					<div class="form-group col">	
						<label for ="endDate"/>
						<input id ="endDate" class="form-control" name="endDate" type="date" value="${board.endDate }">
					</div>
				</div>
				
					<div class="form-group">
						<label for="gallery"></label>
						<input id="gallery" class="form-control" name="galleryName" value="${board.galleryName }">
					</div>
				
					<div class="form-group">
						<label for="address"></label>
						<input id="address" class="form-control" name="address" value="${board.address }">
					</div>
			
					<div class="form-group">
						<label for="title"></label>
						<input id="title" class="form-control" name="title" value="${board.title }" style="border:0 solid black;" >
					</div>
					
					<hr>
					<div class="form-group">
						<label for="writer"></label>
						<input id="writer" class="form-control" type="hidden" name="writer" value="${pinfo.user.usermail }" >
						<input type="hidden" value="${pinfo.user.nick }" readonly>
					</div>
				</div>
				
				
				<div class="board-container">
				
						<c:if test="${not empty board.fileName }">
							<div>
								<img class="img-fluid" 
								src="${imgRoot}${board.bno }/${board.fileName}">
							</div>
						</c:if>
				
					<div class="form-group">
						<label for="text"></label>
						<textarea id="text" class="form-control" name="content" rows="15" value="${board.content }"style="border:none;"> <c:out value="${board.content }"/></textarea>
					</div>
					<div class="form-group">
						<label for="file"></label>
						<input id="file" class="form-control" type="file" name="file">
					</div>
					
							<input hidden name="pageNo" value="${cri.pageNo }" />
					<input hidden name="amount" value="${cri.amount }" />		
					<input hidden name="type" value="${cri.type }" />
					<input hidden name="keyword" value="${cri.keyword }" />
					
					<c:url value="/art/list" var="listUrl">
						<c:if test="${not empty cri.pageNo }">
							<c:param name="pageNum" value="${cri.pageNo }"></c:param>
						</c:if>
						<c:if test="${not empty cri.amount }">
							<c:param name="amount" value="${cri.amount }"></c:param>
						</c:if>
							<c:param name="keyword" value="${cri.keyword }"></c:param>
							<c:param name="type" value="${cri.type }"></c:param>
					</c:url>
					
					
					<input class="btn btn-warning" type="submit" value="수정">
					<input class="btn btn-danger" id="deleteBtn" type="button" value="삭제">
			</form>
		</div>
		
	</div>
</div>
	
</div>
</body>
</html>