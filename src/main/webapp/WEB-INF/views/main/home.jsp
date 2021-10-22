<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
  

<title>BOOK & ART</title>
<na:navbar></na:navbar>
<style>

    .carousel-inner > .item > img {
      top: 0;
      left: 0;
      min-width: 100%;
      min-height: 350px;
    } 
    
     .container-fluid {
    padding-top: 70px;
    padding-bottom: 70px;
  }
  
li {
	 list-style:none;
	 text-align: -webkit-center;
	 position: 10px;
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
  <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
      <div class="item active">
        <img src="${appRoot }/resources/images/책.jpeg" alt="Los Angeles" style="width:80%; height : 50%;">
      </div>

      <div class="item">
        <img src="${appRoot }/resources/images/전시회.jpeg" alt="Chicago" style="width:80%; height : 50%;">
      </div>
    
      <div class="item">
        <img src="${appRoot }/resources/images/다이어리.png" alt="New york" style="width:80%; height : 50%;">
      </div>
    </div>
<script>
var approot ="${appRoot}";
var fileName ="${board.fileName}";
var id = "${board.writer}";
var bno = "${board.bno }";
</script>
<div class="book">
	<div class="container-fluid bg-3 text-center" style=" display: inline;">    
	  <h3 class="margin">내가 읽은 책 리스트</h3><br>
	  <div class="row">
	    <div class="col" style="flex : left;"  >
	    	<ul id="clearfix"> 
		    		
		    	<c:forEach items="${list }" var="board" >
		    			<c:url value="/board/read" var="readUrl">
			  				<c:param name="bno" value="${board.bno }"/>
			  				<c:param name="fileName" value="${board.fileName }"/>
			  				<c:param name="pageNo" value="${pageMaker.cri.pageNo }" />
			  				<c:param name="amount" value="${pageMaker.cri.amount }" />		  				
						</c:url>
						
		    		<li class="item col-sm-4" id="item">
		    	 		<c:forEach items="${board.fileName }" var="imgs"> 
							<span class="photoInfo">
		    				<img class="img-responsive margin"
								src ="${imgRoot}book/${board.bno }/${imgs}"  style="width:50%" alt="Image">
										</span>
						 </c:forEach> 

		    	<a href="${readUrl }">
		    
		      <h3>${board.title }</h3></a>
		      <span>
		      		<img style="width: 30px; height: 30px; border-radius: 70%; "
								 <c:if test="${empty board.profile }">
						    	 	 src="${profile }basicProfile/basicImage.png"
						    	  </c:if>
								
								<c:if test="${not empty board.profile }">
									src="${profile }${board.writer }/${board.profile }"
								</c:if>
							></span>
		      <span>${board.writerName }</span>
		    
		    		</li>
		    	</c:forEach>
	    	</ul>
	    </div>
	    
<%-- 	    
	   <h1>bookss</h1> 
	   <div class="row">
	   	 <div class="col-sm-4">
		    <div class="card" style="width: 18rem;">
			  <img src="${appRoot }/resources/images/방타니.jpeg" class="card-img-top" alt="...">
			  <div class="card-body">
			    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
			  </div>
			</div>
		</div>
		 <div class="col-sm-4">
		    <div class="card" style="width: 18rem;">
			  <img src="${appRoot }/resources/images/방타니.jpeg" class="card-img-top" alt="...">
			  <div class="card-body">
			    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
			  </div>
			</div>
		</div>
		<div class="col-sm-4">
		    <div class="card" style="width: 18rem;">
			  <img src="ww" class="card-img-top" alt="...">
			  <div class="card-body">
			    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
			  </div>
			</div>
		</div>
	   </div> --%>
	    
<%-- 	    
	      <div class="col-sm-4"> 
	      <img src="${appRoot }/resources/images/방탄.jpeg" class="img-responsive margin" style="width:100%" alt="Image">
	      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
	    </div>
	    
	    <c:set var="i" value="0" />
	     <c:set var="j" value="3" />
	      <table border="1"> 
	      <c:forEach items="${list }" var="board"> 
	         <img src="${appRoot }/resources/images/방탄.jpeg" class="img-responsive margin" style="width:100%" alt="Image">
	      	<a href="${readUrl }">
	      <h3>${board.title }</h3></a>
	      <p>${board.writerName }</p>
	      <c:if test="${i%j == 0 }">
	       <tr>
	        </c:if>
	         <td>${list }</td>
	          <c:if test="${i%j == j-1 }"> 
	          </tr>
	           </c:if>
	            <c:set var="i" value="${i+1 }" />
	             </c:forEach> 
	             </table>
 --%>

	    
	    
	    
	    
	  </div>
	</div>
</div>



<div class="gallery">
	<div class="container-fluid bg-3 text-center">    
	  <h3 class="margin">내가 다녀온 전시회들</h3><br>
	  <div class="row">
	    <div class="col-sm-4">
	      <img src="${appRoot }/resources/images/방타니.jpeg" class="img-responsive margin" style="width:100%" alt="Image">
	      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
	    </div>
	    <div class="col-sm-4"> 
	      <img src="${appRoot }/resources/images/방탄.jpeg" class="img-responsive margin" style="width:100%" alt="Image">
	      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
	    </div>
	    <div class="col-sm-4"> 
	      <img src="${appRoot }/resources/images/방탄이.jpeg" class="img-responsive margin" style="width:100%" alt="Image">
	      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
	    </div>
	    <div class="col-sm-4">
	    	
	    </div>
	  </div>
	</div>
</div>

	<!-- Footer -->
	<footer class="container-fluid bg-4 text-center">
	  <p>BOOK AND ART Made By <a href="">ME</a></p> 
	  <p>© Copyright © 2021 BOOK AND ART Inc. All rights reserved</p>
	</footer>


	
	
</div>
</body>
</html>