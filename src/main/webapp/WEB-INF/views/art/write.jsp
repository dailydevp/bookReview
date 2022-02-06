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
					      	<option value="ART">ART</option>   
					      	<option value="BOOK">BOOK</option>
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
						<label for="galleryName"></label>
						<input id="galleryName" class="form-control" name="galleryName" onkeyup="searchPlaces()"placeholder="갤러리">
					</div>
				
					<div class="form-group">
						<label for="sample5_address"></label>
						<input id="sample5_address" class="form-control" name="address" onclick="sample5_execDaumPostcode()" placeholder="주소를 작성해주세요.">
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
						<textarea id="text" class="form-control" name="content" style="border:none;"></textarea>
					</div>


		<div id="map" style="width:350px;height:350px;"></div>
			<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fd156c1a570eab2e059dc842c7970571&libraries=services"></script>
			<script>
			    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
			        mapOption = {
			            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
			            level: 3 // 지도의 확대 레벨
			        };
			
			    //지도를 미리 생성
			    var map = new daum.maps.Map(mapContainer, mapOption);

				// 장소 검색 객체를 생성합니다
				var ps = new kakao.maps.services.Places(); 
				
				var infowindow = new kakao.maps.InfoWindow({zIndex:1});
				//키워드로 장소를 검색합니다
				searchPlaces();
				
				// 키워드 검색을 요청하는 함수입니다
				function searchPlaces() {
				
				    var keyword = document.getElementById('galleryName').value;
				
				    if (!keyword.replace(/^\s+|\s+$/g, '')) {
				        alert('갤러리 이름을 입력해주세요 :)');
				        return false;
				    } 
				
				    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
				    ps.keywordSearch(keyword, placesSearchCB); 
				}
				
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
				        infowindow.setContent('<div style="padding:5px;font-size:12px; ">' + place.place_name +"<br>"+ place.address_name + '</div>');
				        infowindow.open(map, marker);
				    });
				}
			
			    //주소-좌표 변환 객체를 생성
			    var geocoder = new daum.maps.services.Geocoder();
			    //마커를 미리 생성
			    var marker = new daum.maps.Marker({
			        position: new daum.maps.LatLng(37.537187, 127.005476),
			        map: map
			    });
			
			
			    function sample5_execDaumPostcode() {
			        new daum.Postcode({
			            oncomplete: function(data) {
			                var addr = data.address; // 최종 주소 변수
			
			                // 주소 정보를 해당 필드에 넣는다.
			                document.getElementById("sample5_address").value = addr;
			                // 주소로 상세 정보를 검색
			                geocoder.addressSearch(data.address, function(results, status) {

			                });
			            }
			        }).open();
			    }
			</script>
			
					<div class="form-group">
						<label for="file"></label>
						<input multiple="multiple" id="file" class="form-control" type="file" name="file" accept="image/*">
					</div>
					
					
<!-- 
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
				
					</script> -->
					<input type="submit" class="btn btn-primary" id="writeBtn" value="작성등록" />
			</form>
		</div>
		
	</div>
</div>
	
</div>
</body>
</html>