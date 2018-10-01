<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/common/common-head.jsp"></jsp:include>
<title>${shelter.care_nm}</title>
<style type="text/css">
table td.sm {
	border-top : 1px solid #fff;
	padding-top: 0;
}
</style>
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
    	<div>[Page <span id="pgnum">1</span> of <span id="totalPg">${totalPage}</span>]</div>
    	<table class="table">
    	<tbody id="pet-list">
    		<tr>
    			<td rowspan="2">Img</td>
    			<td>보호중</td>
    			<td>[M]<span>푸들</span><br/> <span>2018-09-10</span></td>
    			<td>당진시 면천면 엄치길 38-112(죽동리 138-2)</td>
    			<td>초록색 목줄 착용, 애교 많고 다른 강아지와 잘 지냄</td>
    		</tr>
    	</tbody>
    	<!-- 
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
    	 -->
    	</table>
    	<div>
    		<div class="btn-toolbar mb-3" role="toolbar" aria-label="Toolbar with button groups">
			  <div id="pagebox" class="btn-group" role="group" aria-label="First group">
			    <!-- 
			    <button type="button" class="btn btn-primary">1</button>
			    <button type="button" class="btn btn-primary">2</button>
			    <button type="button" class="btn btn-primary">3</button>
			    <button type="button" class="btn btn-primary">4</button>
			     -->
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
function goPage( pgnum ) {
	
	$.ajax({
		type : "GET",
		url  : '${pageContext.request.contextPath}/shelter/${shelter.care_tel}/pets/' + pgnum,
		success : function( res ) {
			console.log ( res.pets );
			var row = `<tr>
    			<td rowspan="2"><img src="{url}" width="90"></td>
    			<td><span>{hd}</span></td>
    			<td>{state}</td>
    			<td>[{g}]<span>{kindCd}</span></td>
    			<td>{addr}</td>
    		</tr>
    		<tr>
    			<td class="sm" colspan="4">{sm}</td>
    		</tr>`;
			$("#pet-list").empty();
			
			res.pets.forEach (function (pet){
				//P:보호중 R:종료반환 A:종료입양 E:종료안락사 D:종료자연사 N:종료기증 X:종료미포획
				var state = {
					P:'보호중',
					R:'종료반환',
					A:'종료입양',
					E:'종료안락사',
					D:'종료자연사',
					N:'종료기증',
					X:'종료미포획'
				};
				// state['P']
				
				var tr = row.replace('{state}', state[pet.processState])
				             .replace('{g}', pet.sexCd)
				             .replace('{kindCd}', pet.kindCd)
				             .replace('{hd}', pet.happenDt)
				             .replace('{addr}', pet.happenPlace)
				             .replace('{sm}', (pet.specialMark == null ? "특이사항 없음" : pet.specialMark) )
				             .replace('{url}', pet.popfile);
				$("#pet-list").append( tr );
			});
			
			//<button type="button" class="btn btn-primary">1</button>
			var button = `<button type="button" class="btn btn-primary" onclick=goPage("{n}") {d}>{num}</button>`
			
			$("#pagebox").empty();
			$("#pagebox").append(
					button.replace('{num}', 'Prev')
					       .replace('{n}', res.navstart-1)
					       .replace('{d}', (res.navstart == 1 ? 'disabled' : '' ) ) );
			for (var num = res.navstart; num <= res.navend; num++) {
				$("#pagebox").append(button.replace('{num}', num).replace('{n}', num));
			}
			$("#pagebox").append(
					button.replace('{num}', 'Next')
					      .replace('{n}', res.navend+1)
					      .replace('{d}', (res.navend == res.totalPage ? 'disabled' : '' ) ) );
			
			$("#pgnum").text(pgnum);
			$('#totalPg').text(res.totalPage);
		}
	})	
}

$(document).ready(function(){
	goPage(1);
});


</script>