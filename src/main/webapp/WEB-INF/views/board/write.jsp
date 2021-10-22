<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags/" %>

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
	border:none;
}


*:focus {
    outline: none;
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

#search{
	margin-top: 15px;
	outline: none;
	border: none;
	background: transparent;
}

</style>

<script>

$(function() {
	
	$("#writeBtn").click(function(e) {
		e.preventDefault();
	})

	$("#title","#content").keyup(function() {
		
	
		var title = $("#title").val();
		var content = $("#text").val();
		
		if(title == "" ){
				alert("[제목]을 작성하시게나");
			}else{
				$("#writeBtn").attr("action","${appRoot }/board/write").submit();					
			}

		}) 
		
	})

		$("#changeFileBtn").click(function() {
		$("#profileBtn").click();
	});
	
	$("#profileBtn").change(function(e) {
		$("#profile").attr("src", URL.createObjectURL(e.target.files[0]));
	});
</script>

<title>글 쓰기</title>
<na:navbar></na:navbar>
</head>
<body>
<div class="container">

	
<div class="boardForm">
	<div class="boardContent">
		<div class="board-header">
			<form action="${appRoot }/board/write" method="post" enctype="multipart/form-data">
			
					  <div class="form-group">
					    <label for="categories"></label>
					    <select class="form-control" id="categories" name ="categorie" style="width : 120px;" onchange="window.open(value,'_blank');">    
					      <option value="BOOK">BOOK</option>
					      <option value="ART">ART</option>   
					    </select>
					  </div>
			
					<div class="form-group">
						<label for="title"></label>
						<input id="title" class="form-control-plaintext" name="title" placeholder="제목을 작성해주세요" style="border:0 solid black;" >
					</div>
					
					<hr>
					<div class="form-group">
						<label for="writer"></label>
						<input id="writer" class="form-control-plaintext" type="hidden" name="writer" value="${pinfo.user.usermail }" >
						<input type="hidden" value="${pinfo.user.nick }" readonly>
					</div>
				</div>
				
				<div class="board-container">
				
					<div class="form-group">
						<label for="text"></label>
						<textarea id="text" class="form-control" name="content" rows="5" ></textarea>
					</div>
					<div class="form-group">
						<input multiple="multiple" id="file" class="form-control" type="file" name="file" accept="image/*" hidden>
						<button id="changeFileBtn" type="button" class="btn btn-light" name="changeFileBtn">사진 변경</button>
						<button class=" btn btn-light" type="submit" name="changePhoto" id ="changePhoto">적용 </button>
						<button class="btn btn-light" type="submit" id="removePhoto" name="removePhoto">삭제</button>
					</div>
					
					
					
     <input type="text"  id="bookName">
    <button id="bookSearch" class="btn btn-outline-success">검색</button>

<!--  
     <p></p>
 -->
    <script>
        $(document).ready(function () {
            var pageNum = 1;
            
            $("#bookSearch").click(function() {
				$("#exampleModal").modal('show');				
			})

           $("#bookSearch").click(function () {
                $("p").html("");
 
                $.ajax({
                    method: "GET",
                    url: "https://dapi.kakao.com/v3/search/book?target=title",
                    data: { query: $("#bookName").val(), page: pageNum},
                    headers: {Authorization: "KakaoAK e594a70b66d52efb1fe20ba3fe8b8771"} 
 
                })
                .done(function (msg) {
                    console.log(msg);
                    for (var i = 0; i < 10; i++){
                        $("p").append("<h2><a href='"+ msg.documents[i].url +"'>" + msg.documents[i].title + "</a></h2>");
                        $("p").append("<strong>저자:</strong> " + msg.documents[i].authors + "<br>");
                        $("p").append("<img src='" + msg.documents[i].thumbnail + "'/><br>");
                    }

                });
            }) 
        })
 
  
    </script>

</div>




<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="book">
       <!--      <input type="text"  id="bookName">
 		   <button id="bookSearch" type="button">검색</button> -->
		      <p></p>
		
		    <script>
		        $(document).ready(function () {
		            var pageNum = 1;
		            
		  
		     
		            $("#bookSearch").click(function () {
		            
		                $("p").html("");
		 
		                $.ajax({
		                    method: "GET",
		                    url: "https://dapi.kakao.com/v3/search/book?target=title",
		                    data: { query: $("#bookName").val(), page: pageNum},
		                    headers: {Authorization: "KakaoAK e594a70b66d52efb1fe20ba3fe8b8771"} 
		 
		                })
		                .done(function (msg) {
		                    console.log(msg);
		                    for (var i = 0; i < 10; i++){
		                        $("p").append("<img src='" + msg.documents[i].thumbnail + "'/><br>");
		                        $("p").append("<h3><a href='"+ msg.documents[i].url +"'>" + msg.documents[i].title + "</a></h3>");
		                        $("p").append("<strong>저자:</strong> " + msg.documents[i].authors + "<br>");
		                    }
		                });
		            })
		        })
		 
		  
		    </script>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
	
					
<!-- 					
					  <input type="text" id="bookName">
   					 <button id="search">검색</button>
 
    <p></p>
 
    <script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
 
    <script>
        $(document).ready(function () {
            var pageNum = 1;
 
            $("#search").click(function () {
                $("p").html("");
 
                $.ajax({
                    method: "GET",
                    url: "https://dapi.kakao.com/v3/search/book?target=title",
                    data: { query: $("#bookName").val(), page: pageNum},
                    headers: {Authorization: "KakaoAK e594a70b66d52efb1fe20ba3fe8b8771"} // ########부분에 본인의 REST API 키를 넣어주세요.
 
                })
                .done(function (msg) {
                    console.log(msg);
                    for (var i = 0; i < 10; i++){
                        $("p").append("<h2><a href='"+ msg.documents[i].url +"'>" + msg.documents[i].title + "</a></h2>");
                        $("div").append("<strong>저자:</strong> " + msg.documents[i].authors + "<br>");
                        $("div").append("<img src='" + msg.documents[i].thumbnail + "'/><br>");
                    }
                });
            })
        })
        </script> -->
					
					<input type="submit" class="btn btn-primary" id="writeBtn" value="작성등록" />
			</form>
		</div>
		
	</div>
</div>

	
</div>
</body>
</html>