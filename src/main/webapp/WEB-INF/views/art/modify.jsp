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
	
#map {
	
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
	  

</script>

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
					      <select class="form-control" id="categories" name ="categorie" style="width : 120px;" hidden>    
					      	<option>ART</option>   
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
				
					<div class="place">
						<label for="galleryName"></label>
						<input type="text" id="galleryName" class="form-control" name="galleryName" value="${board.galleryName }" onclick="searchPlaces()">
						
					</div>
					
				
					<div class="form-group">
						<label for="address"></label>
						<input id="address" class="form-control" name="address" value="${board.address }" onclick="sample5_execDaumPostcode()">
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
			
		
			
<div id="map" style="width:350px;height:350px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fd156c1a570eab2e059dc842c7970571&libraries=services">
</script>

<!-- 	<div class="place">
	  <form onsubmit="searchPlaces(); return false;">
		<input type="text" id="keyword" name="keyword">
		<button type="submit">검색</button>
		</form>
	</div>
 -->
<script>
// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

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
</script>

			<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
			
		
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
			                    // 정상적으로 검색이 완료됐으면
			                    if (status === daum.maps.services.Status.OK) {
			
			                        var result = results[0]; //첫번째 결과의 값을 활용
			
			                        // 해당 주소에 대한 좌표를 받아서
			                        var coords = new daum.maps.LatLng(result.y, result.x);
			                        // 지도를 보여준다.
			                        mapContainer.style.display = "block";
			                 /*        map.relayout();
			                        // 지도 중심을 변경한다.
			                        map.setCenter(coords);
			                        // 마커를 결과값으로 받은 위치로 옮긴다.
			                        marker.setPosition(coords)  */
			                    }
			                });
			            }
			        }).open();
			    }
			</script>
				
				<div class="board-container">
				
						<c:if test="${not empty board.fileName }">
							<c:forEach items="${board.fileName }" var="imgs">
								<div>
									<img class="img-fluid" 
									src="${imgRoot}art/${board.bno }/${imgs}">
								</div>
							</c:forEach>
						</c:if>
				
					<div class="form-group">
						<label for="text"></label>
						<textarea id="text" class="form-control" name="content" rows="15" value="${board.content }"style="border:none;"> <c:out value="${board.content }"/></textarea>
					</div>
					<div class="form-group">
						<label for="file"></label>
						<%-- <input id="file" class="form-control" type="file" name="file" value="${board.fileName }"> --%>
						<input id="file" class="form-control" type="file" name="file" multiple="multiple"> 
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