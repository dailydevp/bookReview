<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>

<title>ART LIST</title>
<na:navbar></na:navbar>

<script type="text/javascript">
$(function() {
	
	$("#list-pagenation a").click(function (e) {
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
</head>
<body>
<div class="container">
		<a href="${appRoot }/art/write">글작성!</a>
	<table class="table table-hover">
		<div class="artboardList">
			<ul class="clearfix"> 
			  	<c:forEach items = "${list }" var = "artboard">
			  		<li class="items">
			  				<c:url value="/art/read" var="readUrl">
			  					<c:param name="bno" value="${artboard.bno }"/>
			  					<c:param name="pageNo" value="${pageMaker.cri.pageNo }" />
			  					<c:param name="amount" value="${pageMaker.cri.amount }" />
			  					<c:param name="type" value="${pageMaker.cri.type }" />
			  					<c:param name="keyword" value="${pageMaker.cri.keyword }" />
			  				</c:url>
			  				
			  			
			  				
			  				<a class="image" href="${readUrl }">
			  					<img src="${imgRoot }${artboard.bno}/${artboard.fileName}">
			  				</a>
			  					<a class="title" href="${readUrl }">
			  						<span class="title">${artboard.title }</span>
			  					</a>
			  					
			  					<a class="contents" href="${readUrl }">
			  						<span class="galleryName">${artboard.galleryName }</span>
			  						<span class="openingPeriod">${artboard.period }</span>
			  					</a>
			  					
			  				<div class="writer">${artboard.writerName }</div>
			  					<div class="viewInfo">
			  						<div class="reply">
			  							<i class="far fa-comment-dots"></i>&nbsp;${artboard.replyCnt }
			  						</div>
			  						<div class="view">
										<i class="far fa-eye"></i>&nbsp;${artboard.viewCnt }
									</div>
						
								<c:choose>
									<c:when test="${!artboard.likeClicked }">
										<span class="likeBtn">
											<i class="far fa-heart" type="button"></i>
										</span>
											<input type="hidden" class="likeCheck" value="${likeNo }">
									</c:when>
									
									<c:when test="${artboard.likeClicked }">
										<span class="likeBtn">
											<i class="fas fa-heart" type="button"></i>
										</span>
											<input type="hidden" class="likeCheck" value="${likeNo }">
									</c:when>
									<c:otherwise>
										이건 왜 넣은겨 ...?
									</c:otherwise>
								</c:choose> ${artboard.likeCnt }
								
			  					</div>
			  			
			  			<div class="registerDate">			  		
			  				<fmt:formatDate value="${artboard.regDate }" pattern="yyyy-MM-dd"/>
			  			</div>
			  		</li>
			  	</c:forEach>		
			</ul>
		</div>
	</table>
		
		<!-- Pagination  -->
		<nav aria-label="Page navigation example">
		  <ul id="list_pagination" class="pagination justify-content-center">
		  
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
				<form id="actionForm" action="${appRoot }/board/artlist" method="get">
					<input name="pageNum" value="${cri.pageNo }" />
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