<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/WEB-INF/views/common/common-head.jsp"></jsp:include>
<title>Insert title here</title>
<script type="text/javascript">
function loadMap () {
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new daum.maps.LatLng(37.55168402470432, 126.97292180644823), // 지도의 중심좌표
        level: 4 // 지도의 확대 레벨
    };

	map = new daum.maps.Map(mapContainer, mapOption);
}
$(document).ready ( function () {
	loadMap();
});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/common-nav.jsp"></jsp:include>

<div class="container-fluid">
    <!-- Content here -->
    <div class="row">
    	<div class="col-12">
    		<div id="map" style="width:100%;height:350px"></div>
    	</div>
    </div>
    <div class="row">
	    <div class="col-3">
	      1 of 2
	    </div>
	    <div class="col-9">
	      2 of 2
	    </div>
    </div>
</div>
</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a61ea60a0fe95f30f8c6ecd1c1335a42&libraries=services"></script>
</html>