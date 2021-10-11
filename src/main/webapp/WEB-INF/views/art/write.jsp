<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<style>
.customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}

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
					

					<div id="map" style="width:500px;height:400px;"></div>
					
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
					<input type="submit" class="btn btn-primary" id="writeBtn" value="작성등록" />
			</form>
		</div>
		
	</div>
</div>
	
</div>
</body>
</html>