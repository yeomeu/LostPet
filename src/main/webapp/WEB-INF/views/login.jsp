<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/WEB-INF/views/common/common-nav.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/common-head.jsp"></jsp:include>
<title>Insert title here</title>
</head>
<body>
<!-- <div class="jumbotron">
  <h1 class="display-5">로그인</h1>
  <p class="lead">email/password</p>
</div> -->
<div class="container-fluid">
    
   <!--  <div class="row">
    	<div class="col-12">
    		<form id="loginForm">
			  <div class="form-group">
			    <label for="exampleInputEmail1">Email</label>
			    <input type="email" name="email" class="form-control" aria-describedby="emailHelp" placeholder="Enter email">
			    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
			  </div>
			  <div class="form-group">
			    <label for="exampleInputPassword1">Password</label>
			    <input type="password" name="password" class="form-control" placeholder="Password">
			  </div>
			  <button type="submit" id="btnLogin" class="btn btn-primary">로그인</button>
			</form>
    	</div>
    </div> -->
    
	<form id="loginForm" class="text-center border-light p-5">
	    <p class="h4 mb-4">로그인</p>
	    <input type="email" name="email" class="form-control mb-4" placeholder="E-mail">
	    <input type="password" name="password" class="form-control mb-4" placeholder="Password">
	    <div class="d-flex justify-content-around">
	        <div>
	            <div class="custom-control custom-checkbox">
	                <input type="checkbox" class="custom-control-input" id="defaultLoginFormRemember">
	                <label class="custom-control-label" for="defaultLoginFormRemember">로그인 상태 유지</label>
	            </div>
	        </div>
	        <div>
	            <a href="">비밀번호 찾기</a>
	        </div>
	    </div>
	    <button class="btn btn-info btn-block my-4" type="submit" id="btnLogin">로그인</button>
	    <p>회원이 아니신가요?
	        <a href="${pageContext.request.contextPath}/join">회원가입</a>
	    </p>
	</form>
</div>

<!-- The Modal -->
<div class="modal fade" id="loginModal">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">{{title here}}</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger btn-footer" data-dismiss="modal">메인페이지</button>
      </div>
      
    </div>
  </div>
</div>

</body>
</html>

<script type="text/javascript">
var msg = {
	INVALID_ACCOUNT : '아이디 또는 패스워드 확인',
	SERVER_ERROR : '서버오류'
};

var ctxpath = '${pageContext.request.contextPath}';
$(document).ready ( function(){
	$("#btnLogin").click(function(e){
		e.preventDefault(); 
		var $data = $("#loginForm").serialize();
		$.ajax ( {
			method : 'POST',
			url : ctxpath + '/login' , 
			data : $data,
			success : function( res ) { // res = "join"
				console.log ( res );
				if ( res.success ) {
					$('.modal-title').text(res.user.email+"님 안녕하세요");
					$('.btn-footer').text('메인페이지');
					$('#loginModal').on('hidden.bs.modal', function (e) {
						location.href=ctxpath;
					});
					var nextUrl = res.nextUrl;
					if (nextUrl != null) {
						// document.location.href = ctxpath + nextUrl;
						// main -> myinfo 
						document.location.replace( ctxpath + nextUrl);
					} else {
						$("#loginModal").modal('show');					
					}
				} else {
					$('.modal-title').text( msg[res.cause] );
					$('.btn-footer').text('확인');
					$("#loginModal").modal('show');
				}
			}
		});
	});
	
	$('#btnModal').click ( function() {
		$('#loginModal').modal({});
	});
});
</script>