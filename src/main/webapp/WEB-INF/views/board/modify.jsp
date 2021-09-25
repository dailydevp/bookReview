<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>


<title> 수정 / 삭제 </title>
</head>
<body>
<na:navbar></na:navbar>

 <div class="container">
				<div class="board-header">
					<div class="form-group">
						<form id="modifyForm" action="${appRoot }/board/modify" method="post" enctype="multipart/form-data">
						<input hidden name="bno" value="${board.bno }">
					<div class="header-info">
						<label for="title"></label>
						<input id="title" class="form-control" name="title" value="${board.title }" style="border:0 solid black;  outline: none;" >
					</div>
					
					<hr>
					
					<div class="form-group">
						<label for="writer"></label>
						<input id="writer" class="form-control" type="hidden" name="writer" value="${pinfo.user.usermail }" >
					</div>
				
				
						<c:if test="${not empty board.fileName }">
							<div>
								<img class="img-fluid" 
								src="${imgRoot}${board.bno }/${board.fileName}">
							</div>
						</c:if>
			
				
				
				
					<div class="form-group">
						<label for="text"></label>
						<textarea id="text" class="form-control" name="content" rows="15" style="border:none;  outline: none;">
						<c:out value="${board.content }"/>
						</textarea>
					</div>
					<div class="form-group">
						<label for="file">파일</label>
						<input id="file" class="form-control" type="file" name="file" accept="images/*">
					</div>
					
					<input hidden name="pageNo" value="${cri.pageNo }" />
					<input hidden name="amount" value="${cri.amount }" />		
					<input hidden name="type" value="${cri.type }" />
					<input hidden name="keyword" value="${cri.keyword }" />
					
					<c:url value="/board/list" var="listUrl">
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

</body>
</html>