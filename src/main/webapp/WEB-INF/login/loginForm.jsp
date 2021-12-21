<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<title>Login V2</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/css/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/css/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/css/fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/css/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/css/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/css/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/css/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/css/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/css/loginutil.css">
	<link rel="stylesheet" type="text/css" href="/css/login.css">
<!--===============================================================================================-->
	
<style>
.update-save{
	width: 55px;
	height: 35px;
	border: none;
	border-radius: 5px;
	background-color: #1e90ff;
	margin-top: 10px;
	color: white;
	font-weight: bold;
}
</style>
	
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<form class="login100-form validate-form" action="loginprocess" method="post">
					<span class="login100-form-title p-b-48">
					<div>
              		 <h2>로그인</h2>
            		</div>
					</span>

					<div class="wrap-input100 validate-input" data-validate="Valid email is:a@b.c">
						<input type="text"  placeholder="아이디 입력" name="id" class = "input100"
						autofocus="autofocus" required="required" 
						style = "width: 120px" value="${sessionScope.saveok==null?"":sessionScope.checkid}">
					</div>

					<div class="wrap-input100 validate-input" data-validate="Enter password">
						<span class="btn-show-pass">
							<i class="zmdi zmdi-eye"></i>
						</span>
						<input type = "password" name="pass" class = "input100"
						required="required"  placeholder="비밀번호 입력" style = "width: 120px">
					</div>
					<div>
					<label>
						<input type = "checkbox" name = "cbsave" ${sessionScope.saveok == null?"":"checked"}>&nbsp;아이디저장
					</label>
					</div>

					<button type="submit" style="margin-top:30px; width:100%; height:50px;"  class="update-save">
                            <b>로그인</b>
                    </button><br><br>
                    <span class="login100-form-title p-b-26">
						<a href="https://kauth.kakao.com/oauth/authorize?client_id=1439861063a7d822757160ad213d4a33&redirect_uri=http://localhost:9002/login/kakao&response_type=code">
						 <img src="../profile_image/kakao_login_medium_wide.png" style="height:50px;">
						</a>
					</span>
					
					<div class="text-center p-t-115">
						<span class="txt1">
							아직 번뜩이 계정이 없으신가요? 
						</span>
						
						<div style="color:blue; cursor:pointer;" class="txt2" onclick="location.href='../member/main'">
							<u>가입하기</u>
						</div>
					</div>
					<div>
						<hr>
						<div style="color:blue; cursor:pointer; text-align:center;" class="txt2" onclick="location.href='../member/findpass'">
							<u>혹시 비밀번호를 잊으셨나요?</u>
						</div>
					</div>
				</form>
			</div>
			<br><br>
			<div class="style__FooterCopyright-sc-7of8vt-21 kpnzcM"
		style="text-align: center;">© 2021 Bunddeuk Inc.</div>
		</div>
	</div>
	
	
	
	
	
	
	
	

	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	<script src="/css/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="/css/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="/css/vendor/bootstrap/js/popper.js"></script>
	<script src="/css/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="/css/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="/css/vendor/daterangepicker/moment.min.js"></script>
	<script src="/css/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="/css/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="/css/js/main.js"></script>
