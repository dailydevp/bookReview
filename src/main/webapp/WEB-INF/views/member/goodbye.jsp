<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags/" %>
<!DOCTYPE html>
<html>
<head>
<style>
.d_container {
	position : relative;
	width : 520x;
	height : 500px;
	top : 150px;
	border: solid purple 1px;
}

.contents {
	position: absolute;
	width : 500px;
	height : 400px;
	
	color: purple;
	top : 30%;
	left: 30%;

}
</style>

<title>BOOK & ART</title>
<na:navbar></na:navbar>
</head>
<body>
<div class="container">

	<div class="d_container">
		<div class="contents">
			<h1>그동안 BOOK & ART를 <br>
			이용해 주셔서 감사합니다! <br>
			 나중에 또 만나요!</h1>
		</div>
	</div>
</div>
</body>
</html>