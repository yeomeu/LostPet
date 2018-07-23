<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/common/common-head.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/resources/css/jquery.datetimepicker.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.datetimepicker.full.min.js"></script>
<script type="text/x-template" id="care-content">
<div class="wrap">
	<div class="info">
		<div class="title">{{t}}<div class="close" onclick="closeOverlay()" title="닫기"></div>
	</div>
	<div class="body">
	
	<div class="desc">
	<div class="ellipsis">{{addr}}</div>
	<div class="">{{animals}}</div>
	<div><span class="link" onclick="showDetail();">자세히 </span></div>
	</div>
	</div>
	</div>
</div>
</script>
<title>Insert title here</title>
<style>
.wrap {position: absolute;
	left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;
	z-index: 20;
}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 13px 13px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB; cursor: pointer;}
    .info .desc .breed {
    	border: 1px solid #2361ea;
	    background-color: #edf9ff;
	    margin-right: 4px;
	    padding: 4px;
	    border-radius: 10px;
    }
    
    ul.pet {
	    padding-left: 0;
	    list-style: none;
	    position: relative;
    }
    ul.pet > li {
    	margin-left : 80px;
    }
    ul.pet > li.img {
    	position : absolute;
    	top : 0px;
    	left : -80px;
    }
</style>
</head>
<body style="height:1500px">
<jsp:include page="/WEB-INF/views/common/common-nav.jsp"></jsp:include>

<!-- Content here -->
<!-- 
<div class="wrap">
	<div class="info">
		<div class="title">카카오 스페이스닷원<div class="close" onclick="closeOverlay()" title="닫기"></div>
	</div>
	<div class="body">
	
	<div class="desc">
	<div class="ellipsis">제주특별자치도 제주시 첨단로 242</div>
	<div class="jibun ellipsis">(우) 63309 (지번) 영평동 2181</div>
	<div class=""><span class="animal-name">시츄</span><span class="animal-name">시츄</span><<span class="animal-name">시츄</span><</div>
	<div><a href="http://www.kakaocorp.com/main" target="_blank" class="link">자세히 </a></div>
	</div>
	</div>
	</div>
</div>
 -->

<div class="container-fluid">
    <div class="row">
    	<div class="col-12">
 			<input type="text" class="form-control" id="petBreed"  name="petBreed" placeholder="품종 입력">
 			<input type="text" class="form-control" id="dtime" name="lostTime" placeholder="시간 입력" readonly="readonly">
    	</div>
    	<div class="col-12">
    		<div id="map" style="width:100%;height:350px"></div>
    	</div>
    </div>
    <div class="row">
    	<!--
 		happenDt,
 		happenPlace
 		kindCd,
 		noticeSdt,
 		sexCd : 
    	 -->
    	<div class="col-12" id="pet-list">
    		<!-- 
	    	<ul class="pet">
	   			<li class="img"><img src="http://www.animal.go.kr/files/shelter/2018/07/201807200807394.jpg" width=60"></li>
	   			<li class="date">2000-09-04일</li>
	   			<li class="happen">비봉면 삼화리 삼기빌라</li>
	   			<li class="breed">말티즈</li>
	   			<li class="happen-dt">20180716</li>
	   			<li class="gender">숫컷</li>
	    		
	    	</ul>
    		 -->
	    	<!-- 
	    	<ul class="pet">
	   			<li class="img"><img src="http://www.animal.go.kr/files/shelter/2018/07/201807200807394.jpg" width=60"></li>
	   			<li class="date">2000-09-04일</li>
	   			<li class="happen">비봉면 삼화리 삼기빌라</li>
	   			<li class="breed">말티즈</li>
	   			<li class="happen-dt">20180716</li>
	   			<li class="gender">숫컷</li>
	    		
	    	</ul>
	    	<ul class="pet">
	   			<li class="img"><img src="http://www.animal.go.kr/files/shelter/2018/07/201807200807394.jpg" width=60"></li>
	   			<li class="date">2000-09-04일</li>
	   			<li class="happen">비봉면 삼화리 삼기빌라</li>
	   			<li class="breed">말티즈</li>
	   			<li class="happen-dt">20180716</li>
	   			<li class="gender">숫컷</li>
	    		
	    	</ul>
	    	<ul class="pet">
	   			<li class="img"><img src="http://www.animal.go.kr/files/shelter/2018/07/201807200807394.jpg" width=60"></li>
	   			<li class="date">2000-09-04일</li>
	   			<li class="happen">비봉면 삼화리 삼기빌라</li>
	   			<li class="breed">말티즈</li>
	   			<li class="happen-dt">20180716</li>
	   			<li class="gender">숫컷</li>
	    		
	    	</ul>
	    	 -->
	    	
    	</div>
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

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a61ea60a0fe95f30f8c6ecd1c1335a42&libraries=services,clusterer"></script>
<script type="text/javascript">

var map ;
var markers = [];
var grouped ;
var overlay = null;
var animals ;

// var animals = [] ;
// var markerMap = [ { marker : object, data : object  } ] ;
function loadMap (list) {

	var mapContainer = document.getElementById('map'),			// 지도를 표시할 div 
    mapOption = { 
        center: new daum.maps.LatLng(list[0].lat, list[0].lng), // 지도의 중심좌표
        level: 14 // 지도의 확대 레벨
    };
	
	map = new daum.maps.Map(mapContainer, mapOption);
	
    // 마커 클러스터러를 생성합니다 
    var clusterer = new daum.maps.MarkerClusterer ({
    	map : map,
		averageCenter: true,									// 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
		minLevel: 10											// 클러스터 할 최소 지도 레벨 
    });
    
	// 마커셋팅 초기
	markers.forEach ( function ( mk ) {
		mk.setMap(null);
	});
	markers.length = 0;
	
	// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
	var bounds = new daum.maps.LatLngBounds();    

	// 마커가 표시될 위치입니다
	grouped = groupBy(list, animal => animal.careTel);
	console.log ( grouped );
	grouped.forEach ( function(entry, key) {
		
		// console.log ( entry ); // array
		var animal = entry[0];
		
		if ( animal.lat === 0 || animal.lng === 0 ) {
			// console.log ( 'invalid animal :', animal);
			return;
		}
		// FIXME 동물 사진 얻어와서 서버에서 보내줘야 함
		entry.forEach ( a => a.pic = 'http://www.animal.go.kr/files/shelter/2018/07/201807200807394.jpg');
		var markerPosition  = new daum.maps.LatLng(animal.lat, animal.lng); 
		
		// LatLngBounds 객체에 좌표를 추가합니다
	    bounds.extend(markerPosition);
		
		// 마커를 생성합니다
		var marker = new daum.maps.Marker({
		    position: markerPosition,
		    title : key // no!
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		clusterer.addMarker(marker); //marker.setMap(map);
		markers.push(marker);
		markerClicked (marker, entry, 'ok?' );
		
	});
	/*
	list.forEach ( ( animal ) => {
		
		if ( animal.lat === 0 || animal.lng === 0 ) {
			// console.log ( 'invalid animal :', animal);
			return;
		}
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
	*/
	map.setBounds ( bounds );
}

function dataMap (list) {

	// 마커셋팅 초기
	markers.forEach ( function ( mk ) {
		mk.setMap(null);
	} ) ;
	markers.length = 0;

	map.setCenter(new daum.maps.LatLng(list[0].lat, list[0].lng));
	map.setLevel(4);
	
	// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
	var bounds = new daum.maps.LatLngBounds();    

	// 마커가 표시될 위치입니다
	grouped = groupBy(list, animal => animal.careTel);
	console.log ( grouped );

	grouped.forEach ( entry => {
		
		var animal = entry[0];
		
		if ( animal.lat === 0 || animal.lng === 0 ) {
			return;
		}
		var markerPosition = new daum.maps.LatLng(animal.lat, animal.lng); 
		
		// LatLngBounds 객체에 좌표를 추가합니다
	    bounds.extend(markerPosition);
		
		// 마커를 생성합니다
		var marker = new daum.maps.Marker({
		    position: markerPosition,
		    data : animal // no!
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(null);
		marker.setMap(map);
		markers.push(marker);
		markerClicked(marker, entry, 'ok1' );
	});
	map.setBounds ( bounds );
}

function markerClicked ( marker, aa) {
	// var list = animals[idx];
	// var animals = aa;
	
	var callback = function() {
		var content =  $('#care-content').text();
		var tel = marker.getTitle();
		animals = grouped.get(tel);
		// {{t}} =>
		content = content.replace('{{t}}', animals[0].careNm);
		content = content.replace('{{addr}}', animals[0].careAddr);
		
		var txt = '';
		animals.forEach( function ( elem ) {
			txt += '<span class="breed">' + elem.kindCd + '</span>';
		});
		content = content.replace('{{animals}}', txt);
		
		if ( overlay != null) {
			closeOverlay();
		}
		
		overlay = new daum.maps.CustomOverlay({
		    content: content,
		    map: map,
		    position: marker.getPosition()       
		});
	};
	
	daum.maps.event.addListener(marker, 'click', callback );
}

$(document).ready ( function () {
	
	getInitData();
	
    $( "#petBreed" ).autocomplete({
    	select : function ( event, ui ) {
			// console.log ( ui );
			getPetData();
		},
    	source: function( request, response ) {
    		$.ajax ({
    			type : 'GET',
    			url : '${pageContext.request.contextPath}/query/breeds',
    			data : { keyword : request.term},
    			success : function (res ) {
    				response ( res );
    			}
    		});
		}
    });
    $('#dtime').datetimepicker({
		timepicker:false,
		format:"Y-m-d" ,
		onSelectDate:function(ct,$i){
			  getPetData();
		}
	});
});

function groupBy(list, keyGetter) {
    var map = new Map();
    list.forEach((item) => {
        var key = keyGetter(item);
        if (!map.has(key)) {
            map.set(key, [item]);
        } else {
            map.get(key).push(item);
        }
    });
    return map;
}

function today() {
	var d = new Date();
	var yyyy = d.getFullYear(); // 2018
	var m = d.getMonth() + 1;
	if ( m < 10 ) { m = '0' + m ;}
	var date = d.getDate() ; //
	if ( date < 10 ) { date = '0' + date; }
	
	return '' + yyyy + '-' + m + '-' + date;
}

// 페이지 로드시 지도 호출
function getInitData() {
	var uri = '${pageContext.request.contextPath}/petdata?since=';
		uri += today();
	
	$.ajax({
		method: 'GET',
		url	: uri ,
		success: function(res) {
			
			console.log("getInitData success", res);
			
			if ( res.success ){
				if (res.data.length != 0) {
					loadMap(res.data);
				} else {
					alert("검색 결과가 없습니다.");
				}
			}
		}
	});
}

// 조건(품종,날짜)을 포함한 지도 호출  
function getPetData() {
	var uri = '${pageContext.request.contextPath}/petdata?since=';
	
	var dt = $("#dtime").val();
	if (dt.length > 0) {
		uri += dt;
	} else {
		uri += today();
	}
	
	var petType = $("#petBreed").val();
	if ( petType.length > 0 ) {
		uri += '&petType=' + petType;
	}

	$.ajax({
		method: 'GET',
		url	: uri ,
		success: function(res) {
			console.log("getPetData success", res);
			if ( res.success ){
				if (res.data.length != 0) {
					dataMap(res.data);
				} else {
					alert("검색 결과가 없습니다.");
				}
			}
		}
	});
}

//커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay( ) {
	
	if ( overlay ) {
    	overlay.setMap(null);   
    	overlay = null;
	}
}

function showDetail() {
	
	const template = `<ul class="pet">
			<li class="img"><img src="{img}" width=60></li>
			<li class="date">{d} 일</li>
			<li class="happen">{h}</li>
			<li class="breed">{b}</li>
			<li class="gender">{g}</li>
	</ul>`;
	
	$('#pet-list').empty();
	
	animals.forEach ( function ( elem ){
		var html = template.replace('{img}', elem.pic)
		                    .replace('{d}', elem.happenDt)
		                    .replace('{h}', elem.happenPlace)
		                    .replace('{b}', elem.kindCd)
		                    .replace('{g}', elem.sexCd)
		
		$('#pet-list').append(html);
	});
	
	console.log('OKOKOKOKOKOK');
}

</script>
</body>
</html>