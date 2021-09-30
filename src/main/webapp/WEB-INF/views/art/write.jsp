<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<style>

.boardForm{
boder : solid 1px pink;
}

.boardContent{
	width: 930px;
	height: 180px;
	
}

#text{
	resize: none;
}


*:focus {
    outline: none;
}



</style>

<script>

$(function() {

	$("#title","#content").keyup(function() {
		
	
		var title = $("#title").val();
		var content = $("#text").val();
		
	function submit() {
		
		if(title == "" && content == ""){
				alert("내용을 작성하시게나");
			}else{
				$("#writeBtn").attr("action","${appRoot}/art/write").submit();					
			}
		
	}
		}) 
		
	})

</script>

<title>글 쓰기</title>
<na:navbar></na:navbar>
</head>
<body>
<div class="container">

	
<div class="boardForm">
	<div class="boardContent">
		<div class="board-header">
			<form action="${appRoot }/art/write" method="post" enctype="multipart/form-data">
				
				
					  <div class="form-group">
					    <label for="categories"></label>
					      <select class="form-control" id="categories" name ="categorie" style="width : 120px;" onchange="window.open(value,'_blank');">    
					      	<option value="${appRoot }/art/write">ART</option>   
					      	<option value="${appRoot }/board/write">BOOK</option>
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
						<input id ="startDate" class="form-control" name="startDate" type="date">
					</div>
						<span>~</span>
					<div class="form-group col">	
						<label for ="endDate"/>
						<input id ="endDate" class="form-control" name="endDate" type="date">
					</div>
				</div>
				
					<div class="form-group">
						<label for="gallery"></label>
						<input id="gallery" class="form-control" name="galleryName" placeholder="갤러리">
					</div>
				
					<div class="form-group">
						<label for="address"></label>
						<input id="address" class="form-control" name="address" placeholder="주소를 작성해주세요.">
					</div>
			
					<div class="form-group">
						<label for="title"></label>
						<input id="title" class="form-control" name="title" placeholder="제목을 작성해주세요" style="border:0 solid black;" >
					</div>
					
					<hr>
					<div class="form-group">
						<label for="writer"></label>
						<input id="writer" class="form-control" type="hidden" name="writer" value="${pinfo.user.usermail }" >
						<input type="hidden" value="${pinfo.user.nick }" readonly>
					</div>
				</div>
				
				
				<div class="board-container">
					<div class="form-group">
						<label for="text"></label>
						<textarea id="text" class="form-control" name="content" rows="15" style="border:none;"></textarea>
					</div>
					<div class="form-group">
						<label for="file"></label>
						<input id="file" class="form-control" type="file" name="file">
					</div>
					
					<input type="submit" class="btn btn-primary" id="writeBtn" value="작성등록" />
			</form>
		</div>
		
	</div>
</div>
	
</div>
</body>
</html>