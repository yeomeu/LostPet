<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/WEB-INF/views/common/common-head.jsp"></jsp:include>
<title>Insert title here</title>
<style type="text/css">
.err {
	color : #ff0000;
	font-size: 0.9em;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/common-nav.jsp"></jsp:include>
<div class="jumbotron">
  <h1 class="display-5">가입하기</h1>
  <p class="lead">회원등록</p>
</div>
<div class="container-fluid">
    <!-- Content here -->
    <div class="title"></div>
    <div class="row">
    	<div class="col-12">
    		<div class="col-12">
				<form id="joinForm" name="joinForm">
					<div class="form-group">
					    <label for="exampleInputEmail1">Email</label>
					    <input type="email" name="email" class="form-control" id="userEmail" aria-describedby="emailHelp" placeholder="Enter email">
					    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
					</div>
					<div class="form-group">
				    	<label for="exampleInputPassword1">Password</label>
				    	<input type="password" name="password" class="form-control" id="userPass" placeholder="Password">
				  	</div>
					<div class="form-group">
				    	<label for="exampleInputPassword1">Password Again</label>
				    	<input type="password" class="form-control" id="userPass2" placeholder="Password">
				    	<div class="err"></div>
				  	</div>
				  	<button type="submit" id="btnJoin" class="btn btn-primary">가입하기</button>
				</form>
    		</div>
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
        {{body here}}
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">로그인페이지</button>
      </div>
      
    </div>
  </div>
</div>
  
</body>
</html>

<script type="text/javascript">
var ctxpath = '${pageContext.request.contextPath}';
$(document).ready ( function(){
	
});

function checkPass () {
	// 1 두 개의 input field 값이 같으면 버튼을 활성화 시킴
	// 2. 값이 다르면 비활성화 시킴
	var pass1 = $("#userPass").val();
	var pass2 = $("#userPass2").val();
	if ( pass1 === pass2 && pass1.length > 0 ) {
		$("#btnJoin").prop("disabled",false);
		$('.err').text('');
	} else {
		$("#btnJoin").prop("disabled",true);
		$('.err').text('패스워드 불일치');
	}
}
	$("#btnJoin").click( function(e) {
		var $data = $("#joinForm").serialize();
		e.preventDefault();
		var userEmail = $('#userEmail').val();
		var userPass = $('#userPass').val();

		$.ajax ( {
			method : 'POST',
			url : ctxpath + '/join/member' , 
			data : $data,
			// data : {email : userEmail},
			success : function( res ) { // res = "join"
				console.log ( res );
				if ( res.success ) {
					$('.modal-title').text("가입을 완료했습니다.");
					$('.modal-body').text(res.user.email+"");
					$("#joinModal").modal('show');
				} else {
					
				}
			}
		});
	}).prop("disabled",true);
	
	// input : 입력할때마다 체크 change : 포커스가 떨어질 	
	$('#userPass').on('input', function(e) { 
		//console.log ( e.target.value );
		checkPass();
	});
	$('#userPass2').on('input', function(e) { 
		checkPass();
	});
	$('#joinModal').on('hidden.bs.modal', function (e) {
		location.href=ctxpath+'/login';
	});
</script>