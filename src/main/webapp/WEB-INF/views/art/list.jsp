<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>

<title>ART LIST</title>
<na:navbar></na:navbar>
<script src="${appRoot }/resources/js/artRead.js"></script>
<script>
	var appRoot = "${appRoot}";
	var usermail = "${pinfo.user.usermail}";
	var bno = "${artboard.bno }";
	var reply = "${artboard.replyCnt}";
	var likes =" ${artboard.likesCnt } ";
/* var fileName = "${artboard.fileName}";
var fileName2 = "${board.fileName}";
var bno = "${artboard.bno}";
var bno2 = "${board.bno}"; */


	 
$(function() {
	
	$("#listPagination a").click(function (e) {
		e.preventDefault();
		
		console.log("a요소 클릭됨");
		
	var actionForm = $("#actionForm");
	
	actionForm.find("[name=pageNo]").val($(this).attr("href"));
	
	actionForm.submit();
	});
	
});

$(function () {
	if(history.state == null){
		$("#board-modal").modal('show');
		history.replaceState({},null);
	}
})

</script>
<style>
img{
	width : 220px;
	height : 220px;
}

li{
 	border-bottom: 1px solid #dbdbdb;
 	margin-bottom: 20px;
 	list-style : none;
 
}

 td.title{
 	color : black;
 	padding-top: 40px;

}

td.viewInfo {
	padding-top: 120px;

}

.box{
	justify-content: center;
	height: 30px;
	display: flex;
	cursor: pointer;
	padding: 20px;
	background: #fff;
	border-radius: 30px;
	align-items: center;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
}

.box:hover input{
	margin-top: 15px;
	width: 100px;
}

.box input {
	width: 0;
	outline: none;
	border: none;
	font-weight: 500;
	transition : 0.8s;
	background: transparent;
}

.box button .fas {
	color: #1daf;
	font-size: 18px;
}

#search{
	margin-top: 15px;
	outline: none;
	border: none;
	background: transparent;
}

</style>
</head>
<body>
<div class="container">
		<a href="${appRoot}/art/write" class="btn btn-outline-info" role="button" aria-pressed="true" style="float:right;">글 작성</a>
	<table class="table table-hover">
		<div class="artboardList">
			<ul class="clearfix"> 
			  	<c:forEach items = "${list }" var = "artboard">
			  		
			  				<c:url value="/art/read" var="readUrl">
			  					<c:param name="bno" value="${artboard.bno }"/>
			  					<c:param name="pageNo" value="${pageMaker.cri.pageNo }" />
			  					<c:param name="amount" value="${pageMaker.cri.amount }" />
			  					<c:param name="type" value="${pageMaker.cri.type }" />
			  					<c:param name="keyword" value="${pageMaker.cri.keyword }" />
			  				</c:url>
				  			
			  				<tr>
			  				<td><a class="image"  href="${readUrl }">
			  					<img src="${imgRoot }art/${artboard.bno}/${artboard.fileName}">
			  				</a></td>
			  			
			  						<td class="title">		
			  									
			  					 	<span class="listNo" hidden>${artboard.bno }</span>
			  									
			  						<h1>${artboard.title }</h1>
			  						<br>		  					
			  						<h4>${artboard.galleryName }	</h4>		  					
			  						<br>
			  						<fmt:formatDate value="${artboard.startDate  }" pattern="yyyy-MM-dd"/>
			  						~<fmt:formatDate value="${artboard.endDate  }" pattern="yyyy-MM-dd"/></td>
			  			
			  					<td class="viewInfo">
			  					
			  							<i class="far fa-comment-dots"></i>&nbsp;${artboard.replyCnt }
			  						&nbsp;
										<i class="far fa-eye"></i>&nbsp;${artboard.views } ...${lno }
									&nbsp;
					<c:choose>
						<c:when test="${!artboard.likeClicked}">
						<span class="likesBtn">
							<i type="button" class="far fa-heart"></i>
						</span>
							<input type="hidden" class="likesCheck" value="${lno }">
						</c:when>					
						<c:when test="${artboard.likeClicked}">
						<span class="likesBtn">
							<i type="button" class="fas fa-heart"></i>
						</span>
							<input type="hidden" class="likesCheck" value="${lno }">
						</c:when>	
						<c:otherwise>
							0도 아니고 1도 아님.
						</c:otherwise>
					</c:choose>  ${artboard.likesCnt } 
										
									</td>
									
							
						
			  				</tr>

			  			
			  		<%-- 	<div class="registerDate">			  		
			  				<fmt:formatDate value="${artboard.regDate }" pattern="yyyy-MM-dd"/>
			  			</div> --%>
			  	
			  	</c:forEach>		
			</ul>
		</div>
	</table>
		
		<!-- Pagination  -->
		<nav aria-label="Page navigation example">
		  <ul id="listPagination" class="pagination justify-content-center">
		  
		  <c:if test="${pageMaker.prev }">
		    <li class="page-item">
		    	<a class="page-link" href="${pageMaker.prev - 1 }">Previous</a>
		    </li>
		  </c:if>
		  
		  <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var = "num">
		    <li class="page-item" ${num == cri.pageNo ? 'active' : '' }>
		    	<a class="page-link" href="${num }">${num }</a>
		    </li>	  
		  </c:forEach>
		  
		  	<c:if test="${pageMaker.next }">
			    <li class="page-item">
			      <a class="page-link" href="${pageMaker.endPage + 1 }">Next</a>
			    </li>
			 </c:if>
		 	 </ul>
		</nav>
			 
			<%-- 페이지 링크용 Form --%>
			<div style="display: none;">
				<form id="actionForm" action="${appRoot }/art/list" method="get">
					<input name="pageNo" value="${cri.pageNo }" />
					<input name="amount" value="${cri.amount }" />
					<input name="type" value="${cri.type }" />
					<input name="keyword" value="${cri.keyword }" />
				</form>
			</div>
	</div>
	
	<c:if test="${not empty result }">
		<div id="board-modal" class="modal" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">${messageTitle }</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p>${messageBody }</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</c:if>
</body>
</html>