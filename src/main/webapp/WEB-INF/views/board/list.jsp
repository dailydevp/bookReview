<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>


<title>책 게시판</title>
<na:navbar></na:navbar>

<script type="text/javascript">
$(function() {
	
	$("#list_pagenation a").click(function (e) {
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
<!-- 
 -->
	<div class="container">
		<table class="table table-hover">
		
		  <thead>
		    <tr>
		      <th scope="col" style="width : 50px;">#</th>
		      <th scope="col">카테고리</th>
		      <th scope="col">책제목</th>
		      <th scope="col">작성자</th>
		      <th scope="col" style="width : 240px;">작성일</th>	
		      <th scope="col"> 조회수</th>
		      <th scope="col"> 좋아요 </th>	      
		    </tr>
		  </thead>
		
		  <tbody>
		  	<c:forEach items = "${list }" var = "board">
		  		<tr>
		  			<td>${board.bno }</td>
		  			<td>${board.categorie }</td>
		  			<td>
		  				<c:url value="/board/read" var="readUrl">
		  					<c:param name="bno" value="${board.bno }"/>
		  					<c:param name="pageNo" value="${pageMaker.cri.pageNo }" />
		  					<c:param name="amount" value="${pageMaker.cri.amount }" />		  				
		  				</c:url>
		  				
		  				<a href="${readUrl }">
		  					${board.title }
		  				</a>
		  				<c:if test="${board.replyCnt > 0 }">
		  					<i class="far fa-comments"></i><strong>[${board.replyCnt }]</strong>
		  				</c:if>
		  			</td>	
		  			<td>${board.writerName }</td>
		  			<td>
		  				<fmt:formatDate value="${board.regDate }" pattern="yyyy-MM-dd"/>
		  			</td>
		  			<td>${board.views }</td>
		  			<td>${board.likesCnt }</td>
		  		</tr>
		  	</c:forEach>
		  </tbody>
		</table>
	</div>	
		
		
		<!-- Pagination  -->
		<nav aria-label="Page navigation example">
		  <ul id="list_pagination" class="pagination justify-content-center">
		  
		  <c:if test="${pageMaker.prev }">
		    <li class="page-item">
		    	<a class="page-link" href="${pageMaker.starPage - 1 }">Previous</a>
		    </li>
		  </c:if>
		  
		  <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var = "num">
		    <li class="page-item ${num == cri.pageNo ? 'active' : '' }">
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
				<form id="actionForm" action="${appRoot }/board/list" method="get">
					<input name="pageNo" value="${cri.pageNo }" />
					<input name="amount" value="${cri.amount }" />
					<input name="type" value="${cri.type }" />
					<input name="keyword" value="${cri.keyword }" />
				</form>
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