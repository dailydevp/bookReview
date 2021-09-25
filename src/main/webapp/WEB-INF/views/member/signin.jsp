<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<%@ taglib prefix="na" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<style>

@import url('https://fonts.googleapis.com/css?family=Montserrat:400,800');

* {
	box-sizing: border-box;
}

body {
	background: #f6f5f7;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	font-family: 'Montserrat', sans-serif;
	height: 100vh;
	margin: -20px 0 50px;
}

h1 {
	font-weight: bold;
	margin: 5px;
}

h2 {
	text-align: center;
}

p {
	font-size: 14px;
	font-weight: 100;
	line-height: 20px;
	letter-spacing: 0.5px;
	margin: 20px 0 30px;
}

span {
	font-size: 12px;
}

a {
	color: #333;
	font-size: 14px;
	text-decoration: none;
	margin: 15px 0;
}

button {
	border-radius: 20px;
	border: 1px solid #FF4B2B;
	background-color: #FF4B2B;
	color: #FFFFFF;
	font-size: 12px;
	font-weight: bold;
	padding: 12px 45px;
	letter-spacing: 1px;
	text-transform: uppercase;
	transition: transform 80ms ease-in;
}

button:active {
	transform: scale(0.95);
}

button:focus {
	outline: none;
}

button.ghost {
	background-color: transparent;
	border-color: #FFFFFF;
}

form {
	background-color: #FFFFFF;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	padding: 0 50px;
	height: 100%;
	text-align: center;
}

input {
	background-color: #eee;
	border: none;
	padding: 12px 15px;
	margin: 8px 0;
	width: 100%;
}

.container {
	background-color: #fff;
	border-radius: 10px;
  	box-shadow: 0 14px 28px rgba(0,0,0,0.25), 
			0 10px 10px rgba(0,0,0,0.22);
	position: relative;
	overflow: hidden;
	width: 768px;
	max-width: 100%;
	min-height: 480px;
}

.form-container {
	position: absolute;
	top: 0;
	height: 100%;
	transition: all 0.6s ease-in-out;
}

.sign-in-container {
	left: 0;
	width: 50%;
	z-index: 2;
}

.container.right-panel-active .sign-in-container {
	transform: translateX(100%);
}

.sign-up-container {
	left: 0;
	width: 50%;
	opacity: 0;
	z-index: 1;
}

.container.right-panel-active .sign-up-container {
	transform: translateX(100%);
	opacity: 1;
	z-index: 5;
	animation: show 0.6s;
}

@keyframes show {
	0%, 49.99% {
		opacity: 0;
		z-index: 1;
	}
	
	50%, 100% {
		opacity: 1;
		z-index: 5;
	}
}

.overlay-container {
	position: absolute;
	top: 0;
	left: 50%;
	width: 50%;
	height: 100%;
	overflow: hidden;
	transition: transform 0.6s ease-in-out;
	z-index: 100;
}

.container.right-panel-active .overlay-container{
	transform: translateX(-100%);
}

.overlay {
	background: #FF416C;
	background: -webkit-linear-gradient(to right, #FF4B2B, #FF416C);
	background: linear-gradient(to right, #FF4B2B, #FF416C);
	background-repeat: no-repeat;
	background-size: cover;
	background-position: 0 0;
	color: #FFFFFF;
	position: relative;
	left: -100%;
	height: 100%;
	width: 200%;
  	transform: translateX(0);
	transition: transform 0.6s ease-in-out;
}

.container.right-panel-active .overlay {
  	transform: translateX(50%);
}

.overlay-panel {
	position: absolute;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	padding: 0 40px;
	text-align: center;
	top: 0;
	height: 100%;
	width: 50%;
	transform: translateX(0);
	transition: transform 0.6s ease-in-out;
}

.overlay-left {
	transform: translateX(-20%);
}

.container.right-panel-active .overlay-left {
	transform: translateX(0);
}

.overlay-right {
	right: 0;
	transform: translateX(0);
}

.container.right-panel-active .overlay-right {
	transform: translateX(20%);
}

.social-container {
	margin: 5px 0;
}

.social-container a {
	border: 1px solid #DDDDDD;
	border-radius: 50%;
	display: inline-flex;
	justify-content: center;
	align-items: center;
	margin: 0 5px;
	height: 40px;
	width: 40px;
}

footer {
    background-color: #222;
    color: #fff;
    font-size: 14px;
    bottom: 0;
    position: fixed;
    left: 0;
    right: 0;
    text-align: center;
    z-index: 999;
}

footer p {
    margin: 10px 0;
}

footer i {
    color: red;
}

footer a {
    color: #3c97bf;
    text-decoration: none;
}
</style>

<script>

window.onload = function() {
		
	const signUpButton = document.getElementById('signUp');
	const signInButton = document.getElementById('signIn');
	const container = document.getElementById('container');
	
	signUpButton.addEventListener('click', () => {
		container.classList.add("right-panel-active");
	});
	
	signInButton.addEventListener('click', () => {
		container.classList.remove("right-panel-active");
	});
	
	
	//회원가입
	$(function(){


		var validMail = false;
		var validPw = false;
		var validNick = false;
		var validNo = false;


		function toggleEnableSubmit(){
			console.log(validMail, validPw, validNick, validNo)
			if(validMail && validPw && validNick && validNo){
				$("#signupBtn").removeAttr("disabled");
			}else{
				$("#signupBtn").attr("disabled","disabled");
			}
		}
		
		
	 	//이메일 양식 체크 -

		$("#mailBtn").keyup(function(){
			
			var id = $("#mailBtn").val();
			var regmail = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
			
			if(id ==""){
				$("#email-message").text("이메일을 입력해주세요.");
			}else if (!regmail.test(id)){
				$("#email-message").text("올바른 형식의 이메일을 입력해주세요.");
			}else{
				var data = {usermail : id};
				$.ajax({
					type : "get",
					url : "${appRoot}/member/checkMail",
					data : data,
					success : function(data){
						if(data[0] == "success"){
							console.log("사용가능 이메일")
							validMail = true;
							$("#email-message").empty();
		//					$("#email-message").text("사용 가능한 이메일입니다.");
						}
						else if (data[0] == "exist") {
							console.log("사용 불가 아이디");
							$("#email-message").text("이미 가입되어 있는 이메일 입니다.")
						}
			toggleEnableSubmit();
					}
				});
			} 
		})




		//비밀번호 조건 설정
		$("#passwordBtn").keyup(function() {
			var pw = $("#passwordBtn").val();
			var regpw = /(?=.*?[#?!@$%^&*-])(?=.*[a-z])(?=.*[A-Z]).{8}/;
		
				if(pw == ""){
					$("#password-message").text("비밀번호를 입력해주세요.")
				} else if(!regpw.test(pw)){
					$("#password-message").text("적어도 숫자+대문자+소문자+특수문자 포함 8자리 이상으로 설정해주세요.")
				}else{
					validPw = true;
					$("#password-message").empty();
		//			$("#password-message").text("사용 가능한 비밀번호 입니다.");
				}
			toggleEnableSubmit();
		});
		//닉네임 중복 체크
		
		$("#nickBtn").keyup(function() {
			var nickVal = $("#nickBtn").val(); 
			
			if(nickVal == ""){
				$("#nickname-message").text("닉네임을 입력해주세요.");
			}else{
				var data = {nick : nickVal};
				$.ajax({
					type : "get",
					url : "${appRoot}/member/checkNick",
					data : data,
					success : function(data) {
						if(data == "success"){
							console.log("사용가능 닉네임")
							validNick = true;
							$("#nickname-message").empty();
		//					$("#nickname-message").text("사용 가능한 닉네임입니다.");
						}
						else if(data == "exist") {
							console.log("사용불가 닉네임")	
							$("#nickname-message").text("이미 사용중인 닉네임입니다.");
						}
						toggleEnableSubmit();
					},
					error : function() {
						console.log("확인불가");
					}
				});
			}
		})
		
		
		// 연락처 양식 체크
		$("#phoneNoBtn").keyup(function() {
			var phoneNum = $("#phoneNoBtn").val();
			var regNo = /(\d{3}).*(\d{4}).*(\d{4})/;
			if(phoneNum == ""){
				$("#phone-message").text("휴대폰 번호를 입력해주세요")
			}else if(!regNo.test(phoneNum)){
				$("#phone-message").text("유효한 번호를 입력해주세요")
			}else{
				validNo = true;
				$("#phone-message").empty();
			}
			toggleEnableSubmit();
		});
		
		
	})
	
}
</script>

 <!-- Load the JS SDK asynchronously -->
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js"></script>
    <script>
               var checkLoginStatus = function(response){
                 console.log(response);

                 if(response.status === 'connected'){
                     document.querySelector("#authBtn").val = 'Logout';
                 }else{
                     document.querySelector("#authBtn").val = 'Login';
                 }
             }



         window.fbAsyncInit = function() {
            FB.init({
            appId      : '834096750623764',
            cookie     : true,                     // Enable cookies to allow the server to access the session.
            xfbml      : true,                     // Parse social plugins on this webpage.
            version    : 'v11.0'           // Use this Graph API version for this call.
            });



             FB.getLoginStatus(checkLoginStatus);


        };


 
    </script>

<title>BOOK AND ART</title>
</head>
<body>

<div class="container" id="container">
	<div class="form-container sign-up-container">
	
		<c:if test="${param.status == 'success' }">
		<script>
	 		alert('회원가입을 축하드립니다.')
		</script>	
	</c:if>
	
	        <input type="button" id="authBtn" value="checking...." onclick="
        
        if(this.value === 'Login'){
            //now Logout
            FB.login(function(res){
                console.log('login =>',res);
                checkLoginStatus(res);
            });
        }else{
            //now login
            FB.logout(function(res){
                console.log('logout =>',res);
                checkLoginStatus(res);
              });
             }
          ">
	
	
	
	
		<form id="signup" method="post" action="${appRoot }/member/signup">
			<h2>Create Account</h2>
			<div class="social-container">
				<a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
				<a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
				<a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
			</div>
			<span>or use your email for registration</span>
			<input type="email" id="mailBtn" required="required" placeholder="Email" name="usermail" />
			<small id="email-message" class="form-text text-danger"></small>
			<input type="password" id="passwordBtn"required="required" placeholder="Password" name="userpw" />
			<small id="password-message" class="form-text text-danger "></small>
			<input type="text" id="nickBtn" required="required" placeholder="Nickname" name="nick"/>
			<small id="nickname-message" class="form-text text-danger"></small>
			<input type="text" id="phoneNoBtn"required="required" placeholder="PhoneNo" name="phoneNo" />
			<small id="phone-message" class="form-text text-danger"></small>
			<button type="submit" id="signupBtn">Sign Up</button>
		</form>
	</div>
	<div class="form-container sign-in-container">
		<form id="signin" method="post" action="${appRoot }/login">
			<h1>Sign in</h1>
			<div class="social-container">
				<a href="#" class="social" id="authBtn"><i class="fab fa-facebook-f"></i></a>
				<a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
				<a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
			</div>
			<span>or use your account</span>
			<input type="email" id="mailBtn" name="username" required="required" placeholder="Email" />
			<input type="password" id="passwordBtn" name="password" required="required"placeholder="Password" />
			<a href="#">Forgot your password?</a>
			<button type="submit" name="button" id="signinBtn">Sign In</button>
		</form>
	</div>
	<div class="overlay-container">
		<div class="overlay">
			<div class="overlay-panel overlay-left">
				<h1>Welcome Back!</h1>
				<p>To keep connected with us please login with your personal info</p>
				<button class="ghost" id="signIn">Sign In</button>
			</div>
			<div class="overlay-panel overlay-right">
				<h1>Hello, Friend!</h1>
				<p>Enter your personal details and start journey with us</p>
				<button class="ghost" id="signUp">Sign Up</button>
			</div>
		</div>
	</div>
</div>


</body>
</html>