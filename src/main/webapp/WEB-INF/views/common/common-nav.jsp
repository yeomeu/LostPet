<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/join">가입하기</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/login">로그인</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/register/lost">분실등록</a>
      </li> 
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/regiser/found">습득등록</a>
      </li> 
    </ul>
  </div> 
</nav>