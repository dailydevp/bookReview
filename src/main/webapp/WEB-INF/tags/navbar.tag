<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:url value = "/board/list" var="listUrl">
	<c:if test="${not empty cri.pageNo }">
		<c:param name="pageNo" value="${cri.pageNo }" />
	</c:if>
	<c:if test="${not empty cri.amount }">
		<c:param name="amount" value="${cri.amount }" />
	</c:if>
		<c:param name="keyword" value="${cri.keyword }"></c:param>
		<c:param name="type" value="${cri.type }"></c:param>
</c:url>



<nav class="navbar navbar-expand-sm navbar-light bg-light" >

	<ul class="navbar-nav ml-auto">
	 <li class="nav-item dropdown">	
	        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"  style=""role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	          <i class="fas fa-bars"></i>
	        </a>
	        <div class="dropdown-menu dropdown-menu" aria-labelledby="navbarDropdown" >
	        
	          <sec:authorize access="!isAuthenticated()">
				<a class="dropdown-item" href="${appRoot }/member/signin">SIGN IN</a>
			
  			  </sec:authorize>
  			  
  			  <sec:authorize access="isAuthenticated()">
	  			<form action="${appRoot }/logout" method="post">
		  			<input type="submit" class="dropdown-item" value="LOGOUT">
		  			<a class="dropdown-item" href="${appRoot }/member/myinfo">MYINFO</a>
	  		
	 			</form>
  			  </sec:authorize>
	        	      
	        
	          <a class="dropdown-item" href="${appRoot }/board/list">BOOK</a>
	          <a class="dropdown-item" href="${appRoot }/art/list">ART</a>
	          <div class="dropdown-divider"></div>
	          <a class="dropdown-item" href="${appRoot }/board/write">글 작성하기</a>
	        </div>
	      </li>
	      
	        <form class="d-flex">
	        	<select name="type"  class="form-control mr-sm-2">
	        		<option value=""></option> 
	        		<option value="T" ${cri.type == "T" ? 'selected' : '' }>제목</option>
  					<option value="C" ${cri.type == "C" ? 'selected' : '' }>내용</option>
  					<option value="W" ${cri.type == "W" ? 'selected' : '' }>작성자</option>
	        	</select>
			      <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="keyword" value="${cri.keyword }">
			      <button class="btn btn-outline-success" type="submit">Search</button>
		    </form>
	</ul>
</nav>

