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



<nav class="navbar navbar-expand-sm navbar-light bg-light" id="navbar">

	<ul class="navbar-nav ml-auto">
	
				<a class="nav-link" href="${appRoot }/main/home">HOME</a>


	          <sec:authorize access="!isAuthenticated()">
				<a class="nav-link" href="${appRoot }/member/signin">SIGN IN</a>
			
  			  </sec:authorize>
  			
  			  <sec:authorize access="isAuthenticated()">
  			  <a class="nav-link" href="${appRoot }/logout" method="post" type="submit">
  			  LOGOUT</a>
		  			<a class="nav-link" href="${appRoot }/member/myinfo">MYINFO</a>
	  		
	 			</form>
  			  </sec:authorize>
  			  
			  <sec:authorize access="hasRole('ROLE_ADMIN')">
  			  	<a class="nav-link" href="${appRoot }/member/list">MEMBERINFO</a>
  			  </sec:authorize>
	        	
	          <a class="nav-link" href="${appRoot }/board/list">BOOK</a>
	          <a class="nav-link" href="${appRoot }/art/list">ART</a>
	   

	      
	      <span class="box">
	        <form class="d-flex">
	        	<select name="type" hidden class="form-control mr-sm-2">
	        		<option value="T" ${cri.type == "T" ? 'selected' : '' }>제목</option>
  					<option value="C" ${cri.type == "C" ? 'selected' : '' }>내용</option>
  					<option value="W" ${cri.type == "W" ? 'selected' : '' }>작성자</option>
	        	</select>
			   <%--    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="keyword" value="${cri.keyword }">
			      <button class="btn btn-outline-success" type="submit">Search</button>
			    --%>
			   	  <input type="search" placeholder="Search" name="keyword" value="${cri.keyword }">
			   	  <a>
			   	  	<button id ="search" type="submit"><i class="fas fa-search" ></i></button>
			   	  </a>			   	  
		    </form>
	      </span>
	</ul>
</nav>










