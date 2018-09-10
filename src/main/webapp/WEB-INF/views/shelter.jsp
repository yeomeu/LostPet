<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/common/common-head.jsp"></jsp:include>
<title>${shelter.care_nm}</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/common-nav.jsp"></jsp:include>
<div class="container-fluid">
    <!-- Content here -->
    <div class="row">
    	<div class="col-12">
    	<h3>${shelter.care_nm}</h3>
    	<address>${shelter.care_addr}</address>
    	</div>
    </div>
    <div class="row">
    	<div class="col-12">
    	<div>[Page 1 of 3]</div>
    	<table class="table">
    		<tr>
    			<td>Img</td>
    			<td>보호중</td>
    			<td>[M]<span>푸들</span><br/> <span>2018-09-10</span></td>
    			<td>당진시 면천면 엄치길 38-112(죽동리 138-2)</td>
    			<td>초록색 목줄 착용, 애교 많고 다른 강아지와 잘 지냄</td>
    		</tr>
    		<tr>
    			<td>Img</td>
    			<td>보호중</td>
    			<td>[M]<span>푸들</span><br/> <span>2018-09-10</span></td>
    			<td>당진시 면천면 엄치길 38-112(죽동리 138-2)</td>
    			<td>초록색 목줄 착용, 애교 많고 다른 강아지와 잘 지냄</td>
    		</tr>
    		<tr>
    			<td>Img</td>
    			<td>보호중</td>
    			<td>[M]<span>푸들</span><br/> <span>2018-09-10</span></td>
    			<td>당진시 면천면 엄치길 38-112(죽동리 138-2)</td>
    			<td>초록색 목줄 착용, 애교 많고 다른 강아지와 잘 지냄</td>
    		</tr>
    		<tr>
    			<td>Img</td>
    			<td>보호중</td>
    			<td>[M]<span>푸들</span><br/> <span>2018-09-10</span></td>
    			<td>당진시 면천면 엄치길 38-112(죽동리 138-2)</td>
    			<td>초록색 목줄 착용, 애교 많고 다른 강아지와 잘 지냄</td>
    		</tr>
    	</table>
    	<div id="pagebox">
    		<div class="btn-toolbar mb-3" role="toolbar" aria-label="Toolbar with button groups">
			  <div class="btn-group" role="group" aria-label="First group">
			    <button type="button" class="btn btn-primary">1</button>
			    <button type="button" class="btn btn-primary">2</button>
			    <button type="button" class="btn btn-primary">3</button>
			    <button type="button" class="btn btn-primary">4</button>
			  </div>
			  
			</div>
    	</div>
    	</div>
    </div>
</div>
</body>
</html>

<script type="text/javascript">
/*
 *     /pet/shelter/000-120-324/pets
 
 *     /pet/shelter/000-120-324/pets/1 [0, 5]
 *     /pet/shelter/000-120-324/pets/2 [5, 5]
 */

$(document).ready(function(){
	
	$.ajax({
		type : "GET",
		url  : '${pageContext.request.contextPath}/shelter/${shelter.care_tel}/pets/1',
		success : function( res ) {
			console.log ( res );
		}
	})
});


</script>