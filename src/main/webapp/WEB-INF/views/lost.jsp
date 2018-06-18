<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/common/common-head.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/resources/css/jquery.datetimepicker.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.datetimepicker.full.min.js"></script>
<script type="text/javascript">
function loadMap () {
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new daum.maps.LatLng(37.55168402470432, 126.97292180644823), // 지도의 중심좌표
        level: 4 // 지도의 확대 레벨
    };
	map = new daum.maps.Map(mapContainer, mapOption);
	
	// 지도에 클릭 이벤트를 등록합니다
	// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
	daum.maps.event.addListener(map, 'click', function(mouseEvent) {        
	    
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng;
	    
	    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
	    message += '경도는 ' + latlng.getLng() + ' 입니다';
	    console.log ( message );
	    
	    $("#lat").val(latlng.getLat());
	    $("#lng").val(latlng.getLng());
	    
	});
}

function renderSelect  ( data ) {
	
	var html = "";
	for (var i=0; i < data.length; i++) {
		html += '<optgroup label="'+data[i].name+'">';
		for (var k=0; k < data[i].types.length; k++) {
			html += '<option value="'+data[i].types[k]+'">'+data[i].types[k]+'</option>';
		}
		html += '</optgroup>';
	}
	$("#pettype").append(html);
	/*
	 <optgroup label="German Cars">
    <option value="mercedes">Mercedes</option>
    <option value="audi">Audi</option>
  </optgroup>
	*/
	;
}
function sendReq ( ) {
	$.ajax({
		type : 'POST',
		url : '${pageContext.request.contextPath}/register/losts',
		data : $("#lostForm").serialize() ,
		success : function( res ) {
			console.log ( res );
		}
	});;
}
function loadPetType() {
	$.ajax({
		type : 'GET',
		url : '${pageContext.request.contextPath}/pettype',
		success : function( res ) {
			renderSelect ( res.data );
		}
	});
	/*
	res = {success : true };
	res.data = [
			 { name : 'dog', types : ['말라뮤트', '허스키']},
			{ name : 'cat', types:  ['스핑크스', '시베리안블루', '고등어']}
			]
	renderSelect ( res.data );
	*/
}
function centerOf ( locs ) {
	var xsum = 0;
	var ysum = 0;
	
	locs.forEach ( function ( loc) {
		xsum += parseFloat(loc.x );
		ysum += parseFloat(loc.y );
	});
	
	return { x : xsum/locs.length, y : ysum/locs.length };
}
var marker = null ;
var circle = null;

$(document).ready ( function() {
	$('#dtime').datetimepicker();
	loadPetType();
	loadMap();
	$('#btnSubmit').click ( function (e) {
		e.preventDefault();
		sendReq ();
	});
	
	$(window).keydown(function(event){
	    if(event.keyCode == 13) {
	      event.preventDefault();
	      return false;
	    }
	});
	
	$('#btnAddr').click ( function(){
		var addr = $('#addr').val();
		console.log( addr );
		
		var geocoder = new daum.maps.services.Geocoder();
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(addr, function(result, status) {
			console.log ( result );
			
		     if (status === daum.maps.services.Status.OK) {
				var avgCenter = centerOf ( result );
		        if ( marker ) {
		        	marker.setMap( null );
		        	circle.setMap( null );
		        }
		        
				marker = new daum.maps.Marker({
		            map: map,
		           	draggable : true, 
		            position: new daum.maps.LatLng(avgCenter.y, avgCenter.x)
		        });
		        circle = new daum.maps.Circle({
		            center : marker.getPosition() , 
		            radius: 100, // 미터 단위의 원의 반지름입니다 
		            strokeWeight: 2, // 선의 두께입니다 
		            strokeColor: '#75B8FA', // 선의 색깔입니다
		            strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
		            strokeStyle: 'dashed', // 선의 스타일 입니다
		            fillColor: '#CFE7FF', // 채우기 색깔입니다
		            fillOpacity: 0.5  // 채우기 불투명도 입니다   
		        }); 
		        
		        circle.setMap(map);
		        map.setCenter(marker.getPosition());
		    } 
		});    
	} );
	
});

$( function() {
    $( "#tags" ).autocomplete({
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
  } );
</script>
<title>찾아요</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/common-nav.jsp"></jsp:include>

<div class="container-fluid">
    <!-- Content here -->
    <div class="row">
    	<div class="col-12">
    		<form id="lostForm">
			  <div class="form-group">
			  <!-- 
			    <label for="exampleInputEmail1">동물 종류</label>
			    <select class="form-control" id="pettype" name="petBreed">
				  <option>종류선택</option>

				</select>
			   -->
			   <label for="tags">품종</label>
  				<input type="text" class="form-control" id="tags"  name="petBreed">
			  </div>
			  <div class="form-group">
			    <label for="exampleInputEmail1">실종 시간</label>
			    <input type="text" class="form-control" id="dtime" name="lostTime" placeholder="시간 입력" readonly="readonly">
			  </div>
			  <div class="form-group">
			    <label for="exampleInputEmail1">제목</label>
			    <input type="text" class="form-control" id="title" name="title" placeholder="제목 입력">
			  </div>
			  <div class="form-group">
			    <label for="exampleInputPassword1">상세내용</label>
			    <textarea rows="5" class="form-control" name="desc"></textarea>
			  </div>
			  <div class="form-group">
			    <label for="exampleInputFile">실종 장소 지정</label>
			    <div class="input-group">
				    <input type="text" id="addr" class="form-control" placeholder="실종 위치 주소">
				    <span class="input-group-btn">
				        <button class="btn btn-default" type="button" id="btnAddr">위치찾기</button>
					</span>
			    </div>
			    <!--  위도, 경도 :=> 주소-->
			    <input type="hidden" name="lat" id="lat">
			    <input type="hidden" name="lng" id="lng">
			    <div id="map" style="width:100%;height:350px"></div>
			  </div>
			  
			  <!-- 
			  <div class="form-group">
			    <label for="exampleInputFile">사진 업로드</label>
			    <input type="file" id="exampleInputFile">
			    <p class="help-block">여기에 블록레벨 도움말 예제</p>
			  </div>
			  <div class="checkbox">
			    <label>
			      <input type="checkbox"> 입력을 기억합니다
			    </label>
			  </div>
			   -->
			  <button type="submit" class="btn btn-default" id="btnSubmit">제출</button>
			</form>
    	</div>
    </div>
</div>
<div class="ui-widget">
  
</div>
</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a61ea60a0fe95f30f8c6ecd1c1335a42&libraries=services"></script>
</html>