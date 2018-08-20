<%@ page import ="gmail.yeomeu.pet.dto.User" %>  
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar sticky-top navbar-expand-sm navbar-dark default-color scrolling-navbar">
    <a class="navbar-brand" href="${pageContext.request.contextPath}">LostPet</a>

    <!-- Collapse button -->
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#basicExampleNav" aria-controls="basicExampleNav"
        aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="basicExampleNav">
        <ul class="navbar-nav mr-auto">
			<c:if test="${ empty loginUser }">
	            <li class="nav-item active">
	                <a class="nav-link" href="${pageContext.request.contextPath}/join">
	                <i class="fa fa-user-plus" aria-hidden="true"></i>가입하기
	                    <span class="sr-only">(current)</span>
	                </a>
	            </li>
	            <li class="nav-item">
	                <a class="nav-link" href="${pageContext.request.contextPath}/login">
	                <i class="fa fa-sign-in" aria-hidden="true"></i>로그인</a>
	            </li>
			</c:if>
			<c:if test="${ !empty loginUser }">
	            <li class="nav-item">
	                <a class="nav-link" href="${pageContext.request.contextPath}/myinfo">
	                <i class="fa fa-user-circle" aria-hidden="true"></i>내정보</a>
	                <!-- <i class="fa fa-user" aria-hidden="true"></i> -->
	            </li>
	            <li class="nav-item">
	                <a class="nav-link" href="${pageContext.request.contextPath}/register/lost">
	                <i class="fa fa-pencil-square-o" aria-hidden="true"></i>분실등록</a>
	            </li>
			</c:if>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/lostMap">
                <i class="fa fa-paw" aria-hidden="true"></i>찾아요</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/petmap">
                <i class="fa fa-map-marker" aria-hidden="true"></i>습득공고</a>
            </li>
            <c:if test="${ !empty loginUser }">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                <i class="fa fa-sign-out" aria-hidden="true"></i>로그아웃</a>
            </li>
            </c:if>
            <!-- Dropdown 
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown</a>
                <div class="dropdown-menu dropdown-primary" aria-labelledby="navbarDropdownMenuLink">
                    <a class="dropdown-item" href="#">Action</a>
                    <a class="dropdown-item" href="#">Another action</a>
                    <a class="dropdown-item" href="#">Something else here</a>
                </div>
            </li>-->
        </ul>
    </div>
</nav>
<!--/.Navbar-->

<%-- <nav class="navbar sticky-top navbar-expand-sm bg-info navbar-dark">
<!-- <nav class="navbar fixed-top navbar-expand-sm bg-info navbar-dark">  -->
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
				<a class="nav-link" href="${pageContext.request.contextPath}/myinfo"><i class="far fa-user"></i> 내정보</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="far fa-user"></i> 로그아웃</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/register/lost">분실등록</a>
			</li> 
			</c:if>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/lostMap">찾아요</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/petmap">습득공고</a>
			</li>
		</ul>
	</div> 
</nav> --%>