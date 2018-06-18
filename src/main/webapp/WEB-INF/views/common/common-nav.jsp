<%@ page import ="gmail.yeomeu.pet.dto.User" %>  
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-sm bg-info navbar-dark">
	
	<!-- Brand -->
	<a class="navbar-brand" href="${pageContext.request.contextPath}">LostPet</a>
  
	<!-- Toggler/collapsibe Button -->
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>
  
	<!-- Navbar links -->
	<div class="collapse navbar-collapse" id="collapsibleNavbar">
		<ul class="navbar-nav">
			<c:if test="${ empty loginUser }">
			<li class="nav-item">
	        	<a class="nav-link" href="${pageContext.request.contextPath}/join"><i class="fas fa-sign-in-alt"></i> 가입하기</a>
			</li>
	      	<li class="nav-item">
	        	<a class="nav-link" href="${pageContext.request.contextPath}/login"><i class="far fa-user"></i> 로그인</a>
	      	</li>
			</c:if>
			<c:if test="${ !empty loginUser }">
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="far fa-user"></i> 내정보</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="far fa-user"></i> 로그아웃</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/register/lost">분실등록</a>
			</li> 
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/regiser/found">습득등록</a>
			</li> 
			</c:if>
		</ul>
	</div> 
</nav>