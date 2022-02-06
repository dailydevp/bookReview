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

#delete{
	border-color:transparent;
	background-color: white;
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
				<form id="readForm" action="${appRoot }/art/read" method="post" enctype="multipart/form-data">
				<input hidden name="bno" value="${board.bno }">
					<div class="header-info">
						<label for="title"></label>
						<input id="title" class="form-control-plaintext" name="title" value="${board.title }" readonly>
					</div>
					
						<input id="galleryName" class="form-control-plaintext" name="galleryName" value="[${board.region }]${board.galleryName }" readonly>
				
						<span id = "period" class="form-control-plaintext">${board.startDate } ~  ${board.endDate } </span>
					
			  		
					
						<div class="form-group">
							<div class="articleInfo">
								<div class="writerInfo">
									
									<img id="profile"
										 <c:if test="${empty board.profile }">
								    	 	 src="${profile }basicProfile/basicImage.png"
								    	  </c:if>
										
										<c:if test="${not empty board.profile }">
											src="${profile }${board.writer }/${board.profile }"
										</c:if>
									>
		
								
									
									<input type = "hidden" id="writer" class="form-control-plaintext" name="writer" value="${board.writer }" readonly>	
									<a href="${appRoot }/member/viewInfo"><span>${board.writerName }</span></a>
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
													<input type="submit" id="delete" onclick="deleteCheck()" value="삭제">
													<%-- <a href="${appRoot }/art/delete">삭제</a> --%>
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
					<c:if test="${not empty board.fileName }" >
						<c:forEach items="${board.fileName }" var="imgs">
							<div class="photoInfo">
								<img class="img-fluid"
								src ="${imgRoot}art/${board.bno }/${imgs }">
							</div>
						</c:forEach>
					</c:if>
				</div>
					<div class="form-group">
						<label for="sample5_address"> </label>
						<textarea id="sample5_address" class="form-control-plaintext" name="content" rows="15" readonly> <c:out value="${board.content }"/> </textarea>
					</div>
			</div>
			
	
		<div class="galleryInfo">
			<div class="form-group">
				<label for="address"></label>
				<input id="address" class="form-control-plaintext" name="address" value="${board.address }"readonly>
			</div>
		<aside>
	<div id="map" style="width:350px;height:350px;"></div>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fd156c1a570eab2e059dc842c7970571&libraries=services"></script>
	<script>
	// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
	
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places(); 
	// 키워드로 장소를 검색합니다
	ps.keywordSearch('${board.galleryName}', placesSearchCB); 
	// 키워드 검색 완료 시 호출되는 콜백함수 입니다
	function placesSearchCB (data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        var bounds = new kakao.maps.LatLngBounds();
	        for (var i=0; i<data.length; i++) {
	            displayMarker(data[i]);    
	            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
	        }       
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	        map.setBounds(bounds);
	    } 
	}
	// 지도에 마커를 표시하는 함수입니다
	function displayMarker(place) {
	    
	    // 마커를 생성하고 지도에 표시합니다
	    var marker = new kakao.maps.Marker({
	        map: map,
	        position: new kakao.maps.LatLng(place.y, place.x) 
	    });
	    // 마커에 클릭이벤트를 등록합니다
	    kakao.maps.event.addListener(marker, 'click', function() {
	        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
	        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name +"<br>"+ place.address_name + '</div>');
	        infowindow.open(map, marker);
	    });
	}
	
	</script>
		</aside>	
		
		</div>
		
		</form>
	
			<div class="replyZone">		
			
					
				<td><i class="far fa-comment"></i>&nbsp;댓글&nbsp;<strong><c:out value="${board.replyCnt }" /></strong></td>
			
				<td><span id="likes">
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
				좋아요&nbsp;<strong>${board.likesCnt }</strong></span>	</td>	
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
