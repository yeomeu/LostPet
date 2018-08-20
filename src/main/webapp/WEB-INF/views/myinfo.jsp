<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<jsp:include page="/WEB-INF/views/common/common-nav.jsp"></jsp:include>
<body>
<div class="container-fluid">
	<ul class="nav nav-tabs">
		<li class="nav-item">
	    	<a class="nav-link active" data-toggle="tab" href="#myinfo">내정보</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" data-toggle="tab" href="#mypost">내글</a>
		</li>
		<li class="nav-item">
	    	<a class="nav-link" data-toggle="tab" href="#memberSecession">회원탈퇴</a>
		</li>
	</ul>

	<div class="tab-content">
		<div class="tab-pane active" style="margin:10px;" id="myinfo">
			<table class="table table-bordered">
				<colgroup>
					<col width="25%">
					<col width="75%">
				</colgroup>
				    <tbody>
				        <tr>
				            <th scope="row" class="grey lighten-4">이메일</th>
				          	 <td> <!-- <td colspan="2"> -->
				          	 	<span id="email"></span>
				          	 </td>
				        </tr>
				        <tr>
				            <th scope="row" class="grey lighten-4">비밀번호</th>
				             <td>
				             	<button type="button" class="btn btn-indigo btn-sm m-0" id="btnChangePwd">변경하기</button>
				             </td>
				        </tr>
				        <tr>
				            <th scope="row" class="grey lighten-4">가입일</th>
				            <td>
				            	<span id="join-date"></span>
				            </td>
				        </tr>
				        <tr>
				            <th scope="row" class="grey lighten-4">이메일수신여부</th>
				            <td>
								<div class="custom-control custom-radio custom-control-inline">
									<input type="radio" class="custom-control-input" id="mail-off" name="mailing" value="N">
									<label class="custom-control-label" for="mail-off">거부</label>
								</div>
								<div class="custom-control custom-radio custom-control-inline">
									<input type="radio" class="custom-control-input" id="mail-on" name="mailing" value="Y">
									<label class="custom-control-label" for="mail-on">수신</label>
								</div>
								<div id="notif" style="display:none;">
									<select id="startTime"></select> 부터 <select id="endTime"></select> 까지
									<br/>
									<button id="btn-always">항상 받습니다</button>
									<button id="btn-update" class="btn btn-primary btn-sm">저장</button>
								</div>
				            </td>
				        </tr>
			    </tbody>
			</table>
		    <!-- 
			<label>이메일</label>
			<input class="form-control" type="text" id="email" disabled="disabled">
		  	<label>비밀번호</label>
		  	<div class="input-group">
				<input class="form-control" type="password" id="password" disabled="disabled">
				<div class="input-group-append">
			    	<button class="btn btn-success btn-md mt-0" type="button" id="btnChangePwd">변경</button>
				</div>
			</div>
		  	<label>가입일</label>
			<input class="form-control" type="text" id="join-date" disabled="disabled">
			 -->
			<!-- <div id="notif" style="display:none;">
				<select id="startTime"></select> 부터 <select id="endTime"></select> 까지
				<br/>
				<button id="btn-always">항상 받습니다</button>
			</div> -->
		</div>
		<div class="tab-pane container fade" id="mypost">
		  	<table id="example" class="display dataTable" style="width:100%">
		        <thead>
		            <tr>
		                <th>품종</th>
		                <th>분실시간</th>
		                <th>제목</th>
		                <th>내용</th>
		                <th>사례금</th>
		            </tr>
		        </thead>
		        <tbody>
		            <tr>
		                <td>치와와</td>
		                <td>2018년10월12일 14시경</td>
		                <td>글제목</td>
		                <td>...</td>
		                <td>10000원</td>
		            </tr>
		        </tbody>
	    	</table>
		</div>
		<div class="tab-pane container fade" style="margin:10px;" id="memberSecession">
			<div class="md-form input-group">
				<!-- <i class="fa fa-lock prefix"></i> -->
				<input type="password" id="dPassword" class="form-control" placeholder="비밀번호를 입력해주세요" aria-label="비밀번호를 입력해주세요" aria-describedby="basic-addon2">
				<div class="input-group-append">
					<button class="btn btn-indigo waves-effect m-0" type="button" id="btnChk">확인</button>
				</div>
				<small class="form-text text-black-50">
					탈퇴 신청 즉시 회원탈퇴 처리되며, 해당 아이디의 회원정보는 복원할 수 없습니다.
				</small>
			</div>
		</div>
	</div>

    <div class="row">
    	<div class="col-12">
    	</div>
    </div>
</div>
<!-- The Modal -->
<div class="modal fade" id="loginModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">비밀번호 변경</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
          <label>현재 비밀번호</label>
		  <input class="form-control" type="password" id="password2" placeholder="현재 비밀번호를 입력해 주세요.">
          <label>새 비밀번호</label>
		  <input class="form-control" type="password" id="password3" placeholder="새 비밀번호를 입력해 주세요.">
		<div class="input-group">
		</div>
      </div>
        
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" id="modalEditPw" class="btn btn-danger btn-footer" data-dismiss="modal">변경하기</button>
      </div>
      
    </div>
  </div>
</div>
</body>
<jsp:include page="/WEB-INF/views/common/common-head.jsp"></jsp:include>

<script type="text/javascript">
var ctxpath = '${pageContext.request.contextPath}';

var msg = {
	INVALID_PW : '비밀번호가 맞지 않습니다.',
	NO_LOGIN : '로그인이 필요합니다.'
}

$(document).ready(function(){
	
	for ( var i=0; i <= 24; i++) {
		$('#startTime').append(`<option>${'${i}'}:00</option>`);
		$('#endTime').append(`<option>${'${i}'}:00</option>`);
	}
	
	$.ajax ({
		type : 'GET',
		url : ctxpath+'/loadMyInfo',
		success : function (res ) {
			console.log ( res );
			$("#email").text(res.user.email);
			//$("#password").text(res.user.password);
			$("#join-date").text(moment(res.user.created).format("YYYY-MM-DD HH:mm"));
			
			if (null != res.user.stime) {
				$('#notif').show();
				$("#mail-on").prop('checked', true);
				$("#startTime").val(res.user.stime);
				$("#endTime").val(res.user.etime);
			} else {
				$("#mail-off").prop('checked', true);
			}
		}
	});
	
	$('#mail-on').click( function() {
		$("#notif").show();
	}) ;
	$("#btn-always").click( function() {
		$("#startTime").val($("#startTime option:first").val());
		$("#endTime").val($("#endTime option:last").val());
	});
	$('#mail-off').click(function(){
		$("#notif").hide();
	}) ;
	$('#btn-update').click( function () {
		/*
		 * /myinfo/mailing?accept=Y&s=00:00&e=24:00
		 * /myinfo/mailing?accept=N
		 */
		
		var accept;
		accept = mailing();
		var time = {
			accept : accept,
			s : null,
			e : null
		};
		if ( accept === 'Y') {
			time.s = $("#startTime").val();
			time.e = $("#endTime").val();
		}
		$.ajax({
			type : 'POST',
			data : time,
			url : ctxpath+'/member/mailing',
			success : function ( res ) {
				// console.log ( res );
				if ( res.success ) {
					swal('OK', '변경했습니다', 'success');
				} else {
					swal('실패', '변경 실패, 잠시 후 시도해 주세요', 'error');					
				}
			}
		})
	});
	
	$("#btnChangePwd").click(function(){
		$("#loginModal").modal('show');
	});
	
	$("#modalEditPw").click(function(){
		var p1 = $("#password2").val();
		var p2 = $("#password3").val();
		$.ajax ({
			type : 'POST',
			data : {curpw: p1, newpw : p2} ,
			url : ctxpath+'/member/update',
			success : function (res ) {
				 $("#password2").val("");
				 $("#password3").val("");
				p2 = "";
				if ( res.success ) {
					swal("비번수정", "성공했습니다", "success");
				} else {
					// alert( msg[res.cause] );
					swal("ERROR!", msg[res.cause], "error");
				}
			}
		});
	});
	
	$('#btnChk').click(function() {
		
		var pwd = $("#dPassword").val();
		
		if(pwd == ''){
			alert('비밀번호를 입력해주세요.');
			return;
		}
		
		if(confirm('회원탈퇴 하시겠습니까?')) {
			
			if (pwd != null && pwd != 'undefined') {
				$.ajax({
					type : 'POST',
					data : {password :pwd},
					url : ctxpath+'/member/delete',
					success : function (res) {
						if ( res.success) {
							swal({
								title: "정상적으로 탈퇴처리가 완료되었습니다.",
								text: "이용해주셔서 대단히 감사합니다.",
								button: "확인"
							}).then(function() {
								//location.replace("~~~");
								window.location.href = ctxpath;
							});
						} else {
							$("#dPassword").val("");
							alert("비밀번호를 다시 확인해주세요.");
						}
					},
					error: function() {
						alert("정상적으로 처리되지 않았습니다. 계속 문제가 발생되면 연락 주시기 바랍니다.");
					}
				});
			}
		}
	});
	
	$('.nav-tabs a[href="#mypost"]').on('shown.bs.tab', function(event){
		$.ajax ({
			type : 'GET',
			url : '${pageContext.request.contextPath}/mypost',
			success : function (res ) {
				if ( res.success ) {
					// swal("비번수정", "성공했습니다", "success");
					var ddata = convert ( res.post );
					$('#example').DataTable({
						data : ddata,
						columns: [
				            { title: "축종" },
				            { title: "분실시간" },
				            { title: "제목" },
				            { title: "내용" },
				            { title: "사례금" }
				        ],
				        destroy: true
					});
				} else {
					swal("ERROR!", msg[res.cause], "error");
				}
			}
		});
	});
});
function convert ( posts ) {
	var data = [];
	posts.forEach ( p => {
		var rows = [];
		
		/*
		 <th>축종</th>
		 <th>분실시간</th>
		 <th>제목</th>
         <th>내용</th>
         <th>사례금</th>
        */

        //rows.push ( new Date(parseInt(p.lostTime)));
        var d = moment.utc(p.lostTime).toDate();
        var df = moment(d).format("YYYY-MM-DD HH:mm");
        // df = p.timeStr; // YYYY-MM-dd
		rows.push ( p.petBreed );
        rows.push (df);	
        rows.push ( p.title);
        rows.push ( p.desc);
      	rows.push ( numberConvert(p.reward)+"원");
        data.push ( rows );
	});
	return data;
}
function numberConvert(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function mailing() {
	return $('input[name=mailing]:radio:checked').val();
}
</script>
</html>