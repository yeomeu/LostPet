<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/views/common/common-head.jsp"></jsp:include>
	<title>Insert title here</title>
</head>
<body style="height:1500px">
<jsp:include page="/WEB-INF/views/common/common-nav.jsp"></jsp:include>

<!-- Content here -->
<div class="container-fluid">
    <div class="row">
    	<div class="col-12">
    		<select ><option>견종여기</option></select>
    		<select><option>2018-06-15일 이후</option></select>
    	</div>
    	<div class="col-12">
    		<div id="map" style="width:100%;height:350px"></div>
    	</div>
    </div>
    <div class="row">
    </div>
</div>

<!-- The Modal -->
<div class="modal fade" id="joinModal">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">{{title here}}</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
        <ul>
        	<li><span class="breed">{{ email 위치}}</span>
        	<li><span class="owner">{{ email 위치}}</span>
        	<li><span class="lost-time">{{ email 위치}}</span>
        	<li><span class="reward">{{ email 위치}}</span>
        </ul>
        <p class="desc">{{상세정보}}</p>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
      </div>
      
    </div>
  </div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a61ea60a0fe95f30f8c6ecd1c1335a42&libraries=services"></script>
<script type="text/javascript">

var map ;
var markers = [];
// var animals = [] ;

// var markerMap = [ { marker : object, data : object  } ] ;

function loadMap (list) {
	var i;
	var mapContainer = document.getElementById('map'),			// 지도를 표시할 div 
    mapOption = { 
        center: new daum.maps.LatLng(list[0].lat, list[0].lng), // 지도의 중심좌표
        level: 4 // 지도의 확대 레벨
    };
	map = new daum.maps.Map(mapContainer, mapOption);
	
	// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
	var bounds = new daum.maps.LatLngBounds();    

	// 마커가 표시될 위치입니다
	list.forEach ( ( animal ) => {
		var markerPosition  = new daum.maps.LatLng(animal.lat, animal.lng); 
		
		// LatLngBounds 객체에 좌표를 추가합니다
	    bounds.extend(markerPosition);
		
		// 마커를 생성합니다
		var marker = new daum.maps.Marker({
		    position: markerPosition,
		    data : animal // no!
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		markers.push(marker);
		
		markerClicked (marker, animal );
	});
	/*
	for (i =0 ; i < list.length; i++) {
		
		var markerPosition  = new daum.maps.LatLng(list[i].lat, list[i].lng); 
		
		// LatLngBounds 객체에 좌표를 추가합니다
	    bounds.extend(markerPosition);
		
		// 마커를 생성합니다
		var marker = new daum.maps.Marker({
		    position: markerPosition,
		    list : list[i] // no!
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		markers.push(marker);
	}
	*/
}
function markerClicked ( marker, data ) {
	// var list = animals[idx];
	daum.maps.event.addListener(marker, 'click', function() {
		$('.modal-title').text(data.title);
		$('.modal-body .owner').text(data.email);
		$('.modal-body .breed').text(data.petBreed);
		$('.modal-body .lost-time').text(data.lostTime);
		$('.modal-body .reward').text(data.reward);
		$('.modal-body .desc').text(data.desc);
		$("#joinModal").modal('show');
		
	}); // 변수값 캡쳐가 안됨!
}
$(document).ready ( function () {
	getLostList();
	
	/* setTimeout(() => {
		var i = 0;
		markers.forEach ( m => {
			markerClicked ( m, idx );
			
		});
		
	}, 2000); */
});
function getLostList() {
	$.ajax({
		method: 'GET',
		url	: '${pageContext.request.contextPath}/lostList',
		success: function(res) {
			console.log("success", res);
			loadMap(res.lostList);
			
		}
	});
}
</script>
</body>
</html>