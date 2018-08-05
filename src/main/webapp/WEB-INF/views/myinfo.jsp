<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/common/common-head.jsp"></jsp:include>
<title>Insert title here</title>
<script type="text/javascript">
var ctxpath = '${pageContext.request.contextPath}';

var msg = {
	INVALID_PW : '비밀번호가 맞지 않습니다.',
	NO_LOGIN : '로그인이 필요합니다.'
}
$(document).ready(function(){
	$.ajax ({
		type : 'GET',
		url : ctxpath+'/loadMyInfo',
		success : function (res ) {
			console.log ( res );
			$("#email").val(res.user.email);
			$("#password").val(res.user.password);
			$("#join-date").val(res.user.created);
		}
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
		
		if(confirm('회원탈퇴 하시겠습니까?')) {
			
			var pwd = $("#dPassword").val();
			
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
            
			rows.push ( p.petBreed );
            rows.push (moment(d).format("YYYY-MM-DD HH:mm"));	
            rows.push ( p.title);
            rows.push ( p.desc);
          	rows.push ( numberConvert(p.reward)+"원");
            data.push ( rows );
		});
		return data;
	}
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
	function numberConvert(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/common-nav.jsp"></jsp:include>
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

<div class="container-fluid">
    <!-- Content here -->
    <!-- Nav tabs -->
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
	
	<!-- Tab panes -->
	<div class="tab-content">
		<div class="tab-pane container active" id="myinfo">
			<label>이메일</label>
			<input class="form-control" type="text" id="email" disabled="disabled">
			  
		  	<label>password</label>
		  	<div class="input-group">
			  <input class="form-control" type="password" id="password" disabled="disabled">
			  <div class="input-group-append">
			    <button class="btn btn-success" type="button" id="btnChangePwd">변경</button> 
			  </div>
			</div>
		  	<label>가입일</label>
			<input class="form-control" type="text" id="join-date">  
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
		<div class="tab-pane container fade" id="memberSecession">
		<!-- 회원탈퇴를 신청합니다. -->
			<label for="pwd">비밀번호 확인</label>
			<div class="input-group">
				<input class="form-control" type="password" id="dPassword">
				<div class="input-group-append">
			    	<button class="btn btn-success" type="button" id="btnChk">확인</button> 
			  	</div>
			</div>
		</div>
	</div>

    <div class="row">
    	<div class="col-12">
    	</div>
    </div>
</div>
</body>
</html>