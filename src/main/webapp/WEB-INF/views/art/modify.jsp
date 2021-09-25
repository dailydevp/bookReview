<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title> 수정 / 삭제 </title>
</head>
<body>
<div class="container">
				<div class="board-header">
					<div class="form-group">
						<form action="${appRoot }/art/write" method="post" enctype="multipart/form-data">
						<label for="title"></label>
						<input id="title" class="form-control" name="title" placeholder="제목을 작성해주세요" style="border:0 solid black;" >
					</div>
					
					<hr>
					
					<div class="form-group">
						<label for="writer"></label>
						<input id="writer" class="form-control" type="hidden" name="writer" value="${pinfo.user.usermail }" >
					</div>
				</div>
				
				
				<div class="board-container">
					<div class="form-group">
						<label for="text"></label>
						<textarea id="text" class="form-control" name="content" rows="15" style="border:none;"></textarea>
					</div>
					<div class="form-group">
						<label for="file">파일</label>
						<input id="file" class="form-control" type="file" name="file">
					</div>
					
					<input disabled type="submit" class="btn btn-primary" id="writeBtn" value="작성등록" />
			</form>	
	</div>

	
</div>
</body>
</html>