<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<style>

img {
	width : px;
	}
	
	
#text{
	resize: none;
	border:none;
	}
	
*:focus {
    outline: none;
    }
	
</style>
						
<script>

$(document).ready(function(e) {
	 $("input[type='file']").change(function(e){
	      //div 내용 비워주기
	      $('#preview').empty();

	      var files = e.target.files;
	      var arr =Array.prototype.slice.call(files);
	      
	      //업로드 가능 파일인지 체크
	      for(var i=0;i<files.length;i++){
	        if(!checkExtension(files[i].name,files[i].size)){
	          return false;
	        }
	      }	      
	      preview(arr);		
});

	 function checkExtension(fileName,fileSize){

	      var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	      var maxSize = 20971520;  //20MB
	      
	      if(fileSize >= maxSize){
	        alert('파일 사이즈 초과');
	        $("input[type='file']").val("");  //파일 초기화
	        return false;
	      }
	      
	      if(regex.test(fileName)){
	        alert('업로드 불가능한 파일이 있습니다.');
	        $("input[type='file']").val("");  //파일 초기화
	        return false;
	      }
	      return true;
	    }
	    
	    function preview(arr){
	      arr.forEach(function(f){
        
	        //파일명이 길면 파일명...으로 처리
	        var fileName = f.name;
	        if(fileName.length > 200){
	          fileName = fileName.substring(0,200)+"...";
	        }

	        //div에 이미지 추가
	        var str = '<div style="display: inline-flex; padding: 10px;"><li>';
	        str += '<span>'+fileName+'</span><br>';
	        
	        //이미지 파일 미리보기
	        if(f.type.match('image.*')){
	          var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
	          reader.onload = function (e) { //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
	            //str += '<button type="button" class="delBtn" value="'+f.name+'" style="background: red">x</button><br>';
	            str += '<img src="'+e.target.result+'" title="'+f.name+'" width=200 height=200 />';
	            str += '</li></div>';
	            $(str).appendTo('#preview');
	          } 
	          reader.readAsDataURL(f);
	        }else{
	          str += '<img src="/resources/img/fileImg.png" title="'+f.name+'" width=200 height=200 />';
	          $(str).appendTo('#preview');
	        }
	      });//arr.forEach
	    }
	  });
	  
	  
	  $(function() {
			$("#bookSearch").click(function() {
				$("#exampleModal").modal('show');				
			})
				
				e.preventDefault();
					  $.ajax({
						  method: "GET",
						  url:"https://dapi.kakao.com/v3/search/book?target=title",
				          headers: {Authorization: "KakaoAK e594a70b66d52efb1fe20ba3fe8b8771"},
				          data: { 
				        	  query: $("#bookName").val()
				        	  }
					  })
					  .done(function(info) {
						console.log(info);
						if(info != null && info != ""){
							 for (var i = 0; i < documents.length; i++){
							$("#coverimg").append("<img src='" + info.document[i].thumbnail + "'/><br>");
							$("h5").append(info.documents[i].title);
							$(".card-text").append(info.documents[i].contents);
							$(".card-author").append(info.documents[i].authors);
						
						}
						}
							});
					  

		});	
					  alert("제목을 입력해주세요");
	});
	
	 
</script>



<title> 수정 </title>
</head>
<body>
<na:navbar></na:navbar>

 <div class="container">
				<div class="board-header">
					<div class="form-group">
						<form id="modifyForm" action="${appRoot }/board/modify" method="post" enctype="multipart/form-data">
						<input hidden name="bno" value="${board.bno }">
					<div class="form-group">
					    <label for="categories"></label>
					      <select class="form-control" id="categories" name ="categorie" style="width : 120px;" hidden>    
					      	<option>BOOK</option>
					      </select>
					  </div>
					<div class="header-info">
						<label for="title"></label>
						<input id="title" class="form-control" name="title" value="${board.title }" style="border:0 solid black;  outline: none;" >
					</div>
					<hr>		
					<div class="form-group">
						<label for="writer"></label>
						<input id="writer" class="form-control" type="hidden" name="writer" value="${board.writer }" >
					
					</div>
				
					
					<div class="form-group">
						<c:if test="${not empty board.fileName }">
							<c:forEach items="${board.fileName }" var="imgs">
								<span class="photoInfo">
									<img class="img-fluid"
									src ="${imgRoot}book/${board.bno }/${imgs}">
								</span>
							</c:forEach>
						</c:if>
					</div>

				   <input type="text"  id="bookName">
    			<button role="click" id="bookSearch" class="btn btn-outline-success">검색</button>
					
					<div class="form-group">
						<div class="card mb-3" style="max-width: 60%; border: none;">
							<div class="row g-0">
								<div class="col-md-4" id="coverimg" ></div> 
								<div class="col-md-8">
									<div class="card-body">
										<h5 class="card-title"><input hidden name="title"/></h5>
										<p class="card-author"><input hidden class="author" id="author" name="author" ></p>
										<p class="card-text"></p>
									</div>
								</div>
							
							</div>
						</div>
						
						<hr>
						<label for="text"></label>
						<textarea id="text" class="form-control" name="content" rows="15"> <c:out value="${board.content }"/></textarea>
						
						
					</div>
					<div class="form-group">
					<input id="uploadFile" type="file" name="file" accept="images/*" multiple="multiple">

				
					</div>
					<div>
						<div id="preview"></div>
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
					</form>
					</div>	
				</div>
			</div>
		</div>
</body>
</html>