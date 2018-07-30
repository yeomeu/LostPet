<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/common/common-head.jsp"></jsp:include>
<title>Insert title here</title>
<script type="text/javascript">
var msg = {
	INVALID_PW : '비밀번호가 맞지 않습니다.',
	NO_LOGIN : '로그인이 필요합니다.'
}
$(document).ready(function(){
	$.ajax ({
		type : 'GET',
		url : '${pageContext.request.contextPath}/loadMyInfo',
		success : function (res ) {
			console.log ( res );
			$("#email").val(res.user.email);
			$("#password").val(res.user.password);
			$("#join-date").val(res.user.created);
		}
	});
	
	$("#btnEditPw").click(function(){
		$("#loginModal").modal('show');
	});
	
	$("#modalEditPw").click(function(){
		var p1 = $("#password2").val();
		var p2 = $("#password3").val();
		$.ajax ({
			type : 'POST',
			data : {curpw: p1, newpw : p2} ,
			url : '${pageContext.request.contextPath}/updatePwd',
			success : function (res ) {
				if ( res.success ) {
					swal("비번수정", "성공했습니다", "success");
				} else {
					// alert( msg[res.cause] );
					swal("ERROR!", msg[res.cause], "error");
				}
			}
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
                <th>사례금</th>*/
                
			rows.push ( p.petBreed );
            rows.push ( new Date(parseInt(p.lostTime)));
            rows.push ( p.title);
            rows.push ( p.desc);
            rows.push ( p.reward);
            
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
				        ]
					});
					
				} else {
					// alert( msg[res.cause] );
					swal("ERROR!", msg[res.cause], "error");
				}
			}
		});
	});
	
	
	
	
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
        <h4 class="modal-title">비밀번호수정</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
          <label>현재 패스워드</label>
		  <input class="form-control" type="password" id="password2">
          <label>새로운 패스워드</label>
		  <input class="form-control" type="password" id="password3">
		<div class="input-group">
		</div>
      </div>
        
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" id="modalEditPw" class="btn btn-danger btn-footer" data-dismiss="modal">비번수정</button>
      </div>
      
    </div>
  </div>
</div>

<div class="container-fluid">
    <!-- Content here -->
    <!-- Nav tabs -->
	<ul class="nav nav-tabs">
	  <li class="nav-item">
	    <a class="nav-link active" data-toggle="tab" href="#home">기본정보</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" data-toggle="tab" href="#mypost">내글</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" data-toggle="tab" href="#menu2">탈퇴하기</a>
	  </li>
	</ul>
	
	<!-- Tab panes -->
	<div class="tab-content">
	  <div class="tab-pane container active" id="home">
	  	<label>이메일</label>
		<input class="form-control" type="text" id="email" disabled="disabled">
		  
	  	<label>password</label>
	  	<div class="input-group">
		  <input class="form-control" type="password" id="password">
		  <div class="input-group-append">
		    <button class="btn btn-success" type="button" id="btnEditPw">수정</button> 
		  </div>
		</div>
		  
	  	<label>가입일</label>
		<input class="form-control" type="text" id="join-date">  
	  </div>
	  <div class="tab-pane container fade" id="mypost">
	  
	  	<table id="example" class="display dataTable" style="width:100%">
        <thead>
            <tr>
                <th>축종</th>
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
        <tfoot>
           <tr>
                <th>축종</th>
                <th>분실시간</th>
                <th>제목</th>
                <th>내용</th>
                <th>사례금</th>
            </tr>
        </tfoot>
    </table>
	  </div>
	  <div class="tab-pane container fade" id="menu2">
	</div>
	</div>

    <div class="row">
    	<div class="col-12">
    		
    	</div>
    </div>
</div>
</body>
</html>