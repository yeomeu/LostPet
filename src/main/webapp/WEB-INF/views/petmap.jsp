<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<style>
	.wrap {position: absolute;
		left: 0;bottom: 40px;width: 288px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;
		z-index: 20;
	}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative; white-space: normal; line-height: 1.9;}
    .info .desc {position: relative;margin: 13px 0 13px 13px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB; cursor: pointer;}
    /* .info .desc .breed {
    	border: 1px solid #2361ea;
	    background-color: #edf9ff;
	    margin-right: 4px;
	    padding: 2px;
	    border-radius: 10px;
    } */
    .info .desc .breed {
	    margin-right: 4px;
	    padding: 2px;
    }
    #pet-area {
    	position: absolute;
	    top: 64px;
	    width: 100%;
	    height: 100%;
	    z-index: 10;
	    display:none;
    }
    #shelter {
	    height: 70px;
	    background-color: #fff;
	    opacity: 1.0;
	    z-index: 200;
    }
    #shelter h3 {
        margin: 0;
    	font-size: 1.25em;
    }
    #shelter address {
   	    margin-bottom: 0;
    }
    #pet-list {
    	position: absolute;
        z-index: 20;
        top: 70px;
        left: 0px;
        bottom: 0px;
        width: 100%;
        background-color: #fff;
    }
    #pet-list > .close {
        position: fixed;
        top : 66px;
        right: 10px;
        background-color: #fff;
        opacity: 0.5;
        border: 1px solid #000;
        border-radius: 8px;
        font-size : 14px;
        z-index: 40;
        padding : 10px;
    }
    @media screen and (max-width: 767px) {
	    #pet-list .column-sizer {
	    	width: 33.333%;
	    }
	    #pet-list ul.pet {
		    width: 33.333%;
	    }    
    }
    @media screen and (min-width: 768px) {
	    #pet-list .column-sizer {
	    	width: 20%;
	    }
	    #pet-list ul.pet {
		    width: 20%;
	    }    
    }
    
    #pet-list ul.pet {
	    list-style: none;
	    padding-left: 0;
        margin:0;
        position: relative;
        float:left;
    }
    
    ul.pet {
        padding-left: 0;
        margin:0;
        list-style: none;
        position: relative;
        float:left;
        /*width: 33.333%;*/
    }
    ul.pet > li {
        margin:0;
    }
    ul.pet > li > img.pet {
        width: 100%;
        height: auto;
    }
    ul.pet > li.date {
	    position: absolute;
	    bottom: 4px;
	    font-size: 0.75em;
	    background-color: #fff;
	    border: 1px solid #000;
	    opacity: 0.6;
	    padding: 2px;
	    left: 4px;
    }
    
    ul.pet > li.breed {
	    position: absolute;
	    bottom: 4px;
	    font-size: 0.75em;
	    background-color: #fff;
	    border: 1px solid #000;
	    opacity: 0.6;
	    padding: 2px;
	    right: 4px;
    }
    
	ul.pet > li.no {
		display:none;
    }
    
    body {font-family: Arial, Helvetica, sans-serif;}
	#myImg {
	    border-radius: 5px;
	    cursor: pointer;
	    transition: 0.3s;
	}
	#myImg:hover {opacity: 0.7;}
	/* The Modal (background) */
	#detail-info {
	    bottom: 0px;
	    left: 10px;
	    width: 100%;
	    background-color: #fff;
	    border: 1px solid #cfc;
	    opacity: 0.7;
	    position: fixed;
	}
	
</style>
<jsp:include page="/WEB-INF/views/common/common-head.jsp"></jsp:include>
<style type="text/css">
	.modal {
	    display: none; /* Hidden by default */
	    z-index: 5000; /* Sit on top */
	    padding-top: 0; /* Location of the box */
	    left: 0;
	    top: 0 !important;
	    width: 100%; /* Full width */
	    height: 100%; /* Full height */
	    overflow: auto; /* Enable scroll if needed */
	    background-color: rgb(0,0,0); /* Fallback color */
	    background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
	    position: absolute;
	    
	}
	/* Modal Content (image) */
	.modal-content {
	    margin: auto;
	    display: block;
	    width: 80%;
	    max-width: 700px;
	}
	/* Caption of Modal Image */
	#caption {
	    margin: auto;
	    display: block;
	    width: 80%;
	    max-width: 700px;
	    text-align: center;
	    color: #ccc;
	    padding: 10px 0;
	    height: 150px;
	}
	
	/* Add Animation */
	.modal-content, #caption {    
	    -webkit-animation-name: zoom;
	    -webkit-animation-duration: 0.6s;
	    animation-name: zoom;
	    animation-duration: 0.6s;
	}
	    to {-webkit-transform:scale(1)}
	}
	@keyframes zoom {
	    from {transform:scale(0)} 
	    to {transform:scale(1)}
	}
	/* The Close Button */
	.modalClose {
	    position: absolute;
	    top: 15px;
	    right: 35px;
	    color: #f1f1f1;
	    font-size: 40px;
	    font-weight: bold;
	    transition: 0.3s;
	}
	.modalClose:hover,
	.modalClose:focus {
	    color: #bbb;
	    text-decoration: none;
	    cursor: pointer;
	}
	/* 100% Image Width on Smaller Screens */
	@media only screen and (max-width: 700px){
	    .modal-content {
	        width: 100%;
	    }
	}
</style>
</head>
<body>
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
	<div class="row" id="form">
		<div class="col-12">
			<div class="md-form input-group">
				<div class="input-group-prepend dropright">
					<button id="myDropdown" class="btn btn-primary m-0 dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">지역</button>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="#">전체</a>
						<a class="dropdown-item" href="#">서울</a>
					    <a class="dropdown-item" href="#">부산</a>
					    <a class="dropdown-item" href="#">대구</a>
					    <a class="dropdown-item" href="#">인천</a>
					    <a class="dropdown-item" href="#">광주</a>
					    <a class="dropdown-item" href="#">대전</a>
					    <a class="dropdown-item" href="#">울산</a>
					    <a class="dropdown-item" href="#">세종</a>
					    <a class="dropdown-item" href="#">경기</a>
					    <a class="dropdown-item" href="#">강원</a>
					    <a class="dropdown-item" href="#">충북</a>
					    <a class="dropdown-item" href="#">충남</a>
					    <a class="dropdown-item" href="#">전북</a>
					    <a class="dropdown-item" href="#">전남</a>
					    <a class="dropdown-item" href="#">경북</a>
					    <a class="dropdown-item" href="#">경남</a>
					    <a class="dropdown-item" href="#">제주</a>
			    	</div>
			  	</div>
			  	<input id="petBreed" name="petBreed" type="text" class="form-control" placeholder="품종입력">
			  	<input id="dtime" name="lostTime" type="text" class="form-control" placeholder="시간입력" readonly="readonly">
			</div>	
		</div>
	</div>
    <div class="row">
    	<div class="col-12">
    		<div id="map" style="width:100%;height:350px"></div>
    	</div>
    </div>
</div>

<div id="pet-area">
	<div id="shelter">
		<h3></h3>
		<address></address>
		<span></span>
	</div>
	<div id="pet-list">

		<div class="column-sizer"></div>
	    		<!-- 
		    	<ul class="pet">
		   			<li class="img"><img src="http://www.animal.go.kr/files/shelter/2018/07/201807251307602.jpg" width=100"></li>
		   			<li class="happen">비봉면 삼화리 삼기빌라</li>
		   			<li class="breed">말티즈</li>
		   			<li class="happen-dt">20180716</li>
		   			<li class="gender">숫컷</li>
		    	</ul>
	    		 -->
	</div>
</div>

<!-- The Modal -->
<div id="myModal" class="modal">

  <!-- The Close Button -->
  <span class="modalClose">&times;</span>

  <!-- Modal Content (The Image) -->
  <img class="modal-content" id="img01">
  <div id="detail-info">
  	<div><span class="kincd">치와와</span><span class="weight">5kg</span> <i class="fa fa-venus fa-lg"></i> <i class="fa fa-mars fa-lg"></i></div>
  	<div><span class="happen-dt">2018-09-03일 발생</span>( <span class="end-date">2018-09-13일 까지</span> )</div>
  	<div><span class="feature">약 5개월. 스피츠 체형. 주둥이가 여우처럼 생겼음</span></div>
  </div>
</div>


<!--
    <div class="wrap">
		<div class="info">
			<div class="title">
				카카오 스페이스닷원
				<div class="close" onclick="closeOverlay()" title="닫기"></div>
			</div>
			<div class="body">
				<div class="img">
					<img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">
				</div>
				<div class="desc">
					<div class="ellipsis">제주특별자치도 제주시 첨단로 242</div>
					<div class="jibun ellipsis">(우) 63309 (지번) 영평동 2181</div>
					<div><a href="http://www.kakaocorp.com/main" target="_blank" class="link">홈페이지</a></div>
				</div>
	 		</div>
		</div>
	</div>
 -->
<script type="text/x-template" id="care-content">
<div class="wrap">
	<div class="info">
		<div class="title" ><a href="{{link}}" target="shelter">{{t}}</a>
			<div class="close" onclick="closeOverlay()" title="닫기"></div>
		</div>
		<div class="body">
			<div class="desc">
				<div class="ellipsis">{{addr}}</div>
				<div class="jibun ellipsis">{{tel}}</div>
				<div class="">{{animals}}</div>
				<div><span class="link" onclick="showDetail();">자세히 </span></div>
			</div>
		</div>
	</div>
</div>



</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${daumMapKey}&libraries=services,clusterer"></script>
<script type="text/javascript">

var map ;
var markers = [];
var clusterer ;
var grouped ;
var overlay = null;
var animals ;
var $mason ;
// var animals = [] ;
// var markerMap = [ { marker : object, data : object  } ] ;

$(document).ready ( function () {
	initMap();
	
	$mason = $('#pet-list').masonry({
		itemSelector: 'ul.pet',
		columnWidth: '.column-sizer',
		initLayout: false,
		percentPosition: true,
		containerStyle : {
            position : 'absolute',
            'z-index' : 20,
            top: 56,
            left: 0,
            bottom: 0
        }
	});
	
	// init > petdata?since > loadmap
	getPetData();
	
	$('.dropdown-menu a').click(function() {
		$('#myDropdown').text($(this).text());
	    $(this).addClass('active').siblings().removeClass('active');
    });
	
	$("#petBreed").on("input", function(e) {
		console.log('> ', e.target.value); 
		if ('' == e.target.value) {
			getPetData();
		}
	});
	  
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
    $('#pet-list').click ( function(e) {
    	var t = e.target;
    	var clicked = $(t) ;
    	
    	if ( clicked.is('img') ) {
    		var modal = document.getElementById('myModal');
    	    var modalImg = document.getElementById("img01");
   	        modal.style.display = "block";
   	        // modalImg.src = e.target.src;
   	        // modalImg.src = clicked.attr('src').text();
   	        modalImg.src = clicked[0].src;

    	    // Get the <span> element that closes the modal
    	    var span = document.getElementsByClassName("modalClose")[0];

    	    // When the user clicks on <span> (x), close the modal
    	    span.onclick = function() { 
    	      modal.style.display = "none";
    	    }
    	   
    	    /*
    	    $.ajax ({
    			type : 'GET',
    			url : '${pageContext.request.contextPath}/query/breeds',
    			data : { keyword : no},
    			success : function (res ) {
    				response ( res );
    			}
    		});
    	    */
    	}
    });
    
    $(window).on('resize', resizeMap);
    resizeMap();
});

// var lastUpdate= ;
function resizeMap() {
	// var time = new Date().getTime() ; // ms
	var totalH = $(window).height();
	var nav = $('nav.navbar').outerHeight();
	var form = $('#form').outerHeight();
	var marginBottom = 15;//px
	totalH -= nav + form + marginBottom;
	
	$('#map').css('height', totalH);
	map.relayout();
}

function initMap ( ) {
	var mapContainer = document.getElementById('map'),			// 지도를 표시할 div 
    mapOption = { 
        center: new daum.maps.LatLng(36.481244925222164, 128.21170998546236), // 지도의 중심좌표
        level: 14 // 지도의 확대 레벨
    };
	
	map = new daum.maps.Map(mapContainer, mapOption);
	
    // 마커 클러스터러를 생성합니다 
    clusterer = new daum.maps.MarkerClusterer ({
    	map : map,
		averageCenter: true,									// 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
		minLevel: 10											// 클러스터 할 최소 지도 레벨 
    });
    
}

function loadMap (list) {
    
    clusterer.clear();
    
	// 마커셋팅 초기
	markers.forEach ( function ( mk ) {
		mk.setMap(null);
	});
	markers.length = 0;
	
	// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
	var bounds = new daum.maps.LatLngBounds();    

	// 마커가 표시될 위치입니다
	grouped = groupBy(list, animal => animal.careTel);
	//console.log ( grouped );
	
	grouped.forEach ( function(entry, key) {
		
		//console.log ( entry ); // array
		var animal = entry[0];
		
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

function markerClicked ( marker, aa ) {
	// var list = animals[idx];
	// var animals = aa;
	
	var callback = function() {
		var content =  $('#care-content').text();
		var tel = marker.getTitle();
		animals = grouped.get(tel);
		// {{t}} /pet/shelter/041-356-8210
		content = content.replace('{{link}}', '/pet/shelter/' + animals[0].careTel);
		content = content.replace('{{t}}', animals[0].careNm);
		content = content.replace('{{addr}}', animals[0].careAddr);
		content = content.replace('{{tel}}', animals[0].careTel);
		
		var tmp = new Map();
		animals.forEach( function ( elem ) {
			var kindcd = elem.kindCd;
	        if (!tmp.has(kindcd)) {
	        	tmp.set(kindcd, [elem]);
	        } else {
	        	tmp.get(kindcd).push(elem);
	        }
		    return tmp;
		});

		var txt ="";
		tmp.forEach(function (item, key, mapObj) {
			//if (item.length > 1) {
				txt += '<span class="badge badge-primary breed">' + key + 
				'<span class="badge badge-pill pink">' + item.length + '</span></span>';
			/* } else {
				txt += '<span class="badge badge-primary breed">' + key + '</span>';
			} */
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

// 페이지 로드시, 조건(품종,날짜)을 포함한 지도 호출  
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
					loadMap(res.data);
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
    /*
        <li class="date">{d}</li>
        <li class="happen">{h}</li>
        <li class="breed">{b}</li>
        <li class="gender">{g}</li>
    */
    const template = `<ul class="pet">
    	<li class="img is-loading"><img class="pet" src="{img}"></li>
    	<li class="date">{d}</li>
    	<li class="breed">{b}</li>
    	<li class="no">{n}</li>
    </ul>`;
    	
	var addr = $('.ellipsis:first').text();
	var tel = $('.jibun').text();
	var title = $('.wrap .info .title').text();
	
	$('#pet-area h3').text(title);
	$('#pet-area address').text(addr);
	$('#pet-area span').text(tel);
	
	$('#pet-area').show();
	
    $('#pet-list').empty()
                  .append(`<div class="close" onclick="hideDetail()">닫기</div><div class="column-sizer"></div>`);

    var content = '';
    animals.forEach ( function ( elem ){
        var html = template.replace('{img}', elem.popfile)
                            //.replace('{d}', elem.happenDt)
                            //.replace('{h}', elem.happenPlace)
                            .replace('{b}', elem.kindCd)
                           //.replace('{g}', elem.sexCd)
                            .replace('{n}', elem.desertionNo);
        content += html;
        // $('#pet-list').append(html);
        // $mason.prepend( $(html) );
        // $mason.imagesLoaded();
    });
    var $content = $(content);
    $mason.append( $content);
    var defered = $mason.imagesLoaded(function() {
        $mason.masonry('reloadItems');
        $mason.masonry();
//        console.log( 'loaded');
    }).always(function() {
        $(window).trigger('resize');
    });
    defered.progress (function(instance, img) {
        // var $img = $(img.img);
        // $mason.append($img).masonry('appended', $img);
        // $mason.masonry('reloadItems');
        // $mason.masonry();
        console.log('ok?');
        // $mason.masonry();
    } );
}
function hideDetail () {
	$('#pet-area').hide();
	$('#pet-list').empty();
}
</script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.9/js/mdb.js"></script>
</body>
</html>