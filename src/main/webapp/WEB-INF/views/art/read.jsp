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

	 <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=jwwn9kg6n8"></script>

	
<script src="${appRoot }/resources/js/artRead.js"></script>
<script type="text/javascript">
var appRoot = "${appRoot}";
var boardBno = "${board.bno}";
var usermail = "${pinfo.user.usermail}";
var fileName = "${users.fileName}";
var file =  "${pinfo.user.fileName}";

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

#galleryName{
	position : relative;
	text-align:center;
	font-size: 25px;
	color : #67595E;
}

#period{
 	position : relative;
	text-align : center;
	font-size: 18px;
	color : #67595E;
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


#title{
	font-size: 40px;
	position : relative;
	text-align:center;
	padding-top: 30px;
	font-weight: bolder;
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

<title>Art List</title>
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
					
						<input id="galleryName" class="form-control-plaintext" name="galleryName" value="${board.galleryName }" readonly>
				
						<span id = "period" class="form-control-plaintext">${board.startDate } ~  ${board.endDate } </span>
					
			  		
					
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
											
												<c:url value="/art/modify" var="modifyUrl">
													<c:param name="bno" value="${board.bno }"/>
								  					<c:param name="pageNo" value="${cri.pageNo }" />
								  					<c:param name="amount" value="${cri.amount }" />
								  					<c:param name="type" value="${cri.type }"/>
													<c:param name="keyword" value="${cri.keyword }" />		
												</c:url>
											
												<c:if test="${pinfo.user.usermail eq board.writer }" >
													<a href="${modifyUrl }">수정</a> |
													<a href="${appRoot }/art/delete">삭제</a>
												</c:if>
											</ul>
										</span>																				
									</span>						
								</div>
							</div>							
						</div>		
			</div>
			
		
						
				<hr>
				
			<div class="galleryContents">
				<div class="photoZone">
					<c:if test="${not empty board.fileName }">
						<div class="photoInfo">
							<img class="img-fluid"
							src ="${imgRoot}art/${board.bno }/${board.fileName }">
						</div>
					</c:if>
				</div>
					<div class="form-group">
						<label for="text"> </label>
						<textarea id="text" class="form-control-plaintext" name="content" rows="15" readonly> <c:out value="${board.content }"/> </textarea>
					</div>
			</div>
			
	
		<div class="galleryInfo">
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fd156c1a570eab2e059dc842c7970571"></script>
					<script>
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
						  mapOption = { 
						        center: new kakao.maps.LatLng(37.54699, 127.09598), // 지도의 중심좌표
					    	    level: 4 // 지도의 확대 레벨
					   	 };
				
						var map = new kakao.maps.Map(mapContainer, mapOption);
						

						var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
						    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
						    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

						// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
						var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
						    markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다

						// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
						  position: markerPosition,
						  image: markerImage // 마커이미지 설정 
						});

						// 마커가 지도 위에 표시되도록 설정합니다
						marker.setMap(map);  

						// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
						var content = '<div class="customoverlay">' +
						    '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
						    '    <span class="title">구의야구공원</span>' +
						    '  </a>' +
						    '</div>';

						// 커스텀 오버레이가 표시될 위치입니다 
						var position = new kakao.maps.LatLng(37.54699, 127.09598);  

						// 커스텀 오버레이를 생성합니다
						var customOverlay = new kakao.maps.CustomOverlay({
						    map: map,
						    position: position,
						    content: content,
						    yAnchor: 1 
						});
				
					</script>
			
			
			</script>

			<h5>${board.galleryName } </h5>
			<p>"${board.address }"</p>
			
			<a href="https://www.pkmgallery.com/">https://www.pkmgallery.com/</a>
		</div>

		
			<div class="replyZone">		
			
					
				<i class="far fa-comment"></i>&nbsp;댓글&nbsp;<strong><c:out value="${board.replyCnt }" /></strong>
			
				<span id="likes">
					<c:choose>
						<c:when test="${!board.likeClicked}">
						<span class="likesBtn">
							<i type="button" class="far fa-heart"></i>
						</span>
							<input type="hidden" class="likesCheck" value="${lno }">
						</c:when>					
						<c:when test="${board.likeClicked}">
						<span class="likesBtn">
							<i type="button" class="fas fa-heart"></i>
						</span>
							<input type="hidden" class="likesCheck" value="${lno }">
						</c:when>					
					</c:choose>
				좋아요&nbsp;<strong>${board.likesCnt }</strong></span>		
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
