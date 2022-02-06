<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>


<title>회원 목록</title>
<na:navbar></na:navbar>
</head>
<body>
<div class="container">


	<table class="table">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">아이디</th>
      <th scope="col">닉네임</th>
      <th scope="col">연락처</th>
      <th scope="col">가입일</th>
      <th scope="col">등급</th>
      
    </tr>
  </thead>
  <tbody>
  	<c:forEach items="${list }" var = "member"  varStatus ="status" >	
	    <tr>
	      <td>${status.count}</td>
	      <td>${member.usermail }</td>
	      <td>${member.nick }</td>
	      <td>${member.phoneNo }</td>
	      <td>${member.regdate }</td>
 	      <td>${member.role}</td>  
	    </tr>
	</c:forEach> 
  </tbody>
</table>

	
</div>
</body>
</html>