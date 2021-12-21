<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>회원가입</title>
        <!-- Bootstrap -->
        <link href="../plugin/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <!-- font awesome -->
        <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
        <!-- Custom style -->
        <link rel="stylesheet" href="../plugin/bootstrap/css/style.css" media="screen" title="no title" charset="utf-8">

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="../plugin/bootstrap/js/bootstrap.min.js"></script>
        <script src="../config/js/join.js"></script>
	
<style> 
.style__FooterCopyright-sc-7of8vt-21{
-webkit-text-size-adjust: 100%;
    -webkit-font-smoothing: antialiased;
    -webkit-box-direction: normal;
    font-family: 'SF Pro Text', 'Helvetica Neue', 'Segoe UI', Arial, 'NotoSansKR', sans-serif;
    box-sizing: inherit;
    word-break: break-all;
    text-decoration: none;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    display: block;
    width: 100%;
    color: rgb(158, 158, 158);
    font-size: 13px;
    line-height: 20px;
    text-align: center;
}

.update-save{
	width: 55px;
	height: 35px;
	border: none;
	border-radius: 5px;
	background-color: skyblue;
	margin-top: 10px;
	color: white;
	font-weight: bold;
}

</style>	
<script type="text/javascript">
	$(function(){
		
		 
		$("#name").blur(function(){
			
			var name=$(this).val().trim();//입력값
			if(name.trim().length==0){
				$("b.namemsg").html("<font color='red'>닉네임을 입력해주세요</font>");
				return;
			}
			
			$.ajax({
				type:"get",
				dataType:"json",
				data:{"name":name},
				url:"namecheck",
				success:function(data){
					if(data.check==1){
						$("b.namemsg").html("<font color='red'>이미 사용중인 닉네임입니다.</font>");
						$("#name").val("");
						$("#name").focus();
					}else{
						$("b.namemsg").html("");
					}
				}
			});
		});
		
		$("#pass").blur(function(){
			
			var pass=$(this).val().trim();//입력값
			if(pass.trim().length==0){
				$("b.passmsg").html("<font color='red'>패스워드를 입력해주세요</font>");
				return;
			}
			var mbrId = $("#id").val();
			var mbrPwd = $("#pass").val();  // pw 입력
			
			var check1 = /^(?=.*[a-zA-Z])(?=.*[0-9]).{10,12}$/.test(mbrPwd);   //영문,숫자
			var check2 = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{10,12}$/.test(mbrPwd);  //영문,특수문자
			var check3 = /^(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{10,12}$/.test(mbrPwd);  //특수문자, 숫자
			
			
			if(!(check1||check2||check3)){
				$("b.passmsg").html("<font color='red'>10자~12자리의 영문(대소문자)+숫자+특수문자 중 2종류 이상을 조합하여 사용할 수 있습니다.</font>");
				$("#pass").val("");
				$("#pass").focus();
			}else if(/(\w)\1\1/.test(mbrPwd)){
				$("b.passmsg").html("<font color='red'>같은 문자를 3번 이상 사용하실 수 없습니다.</font>");
				$("#pass").val("");
				$("#pass").focus();
			}else{
				$("b.passmsg").html("");
			}
				
			
		});
		
		$("#pass2").blur(function(){
			
			var pass2=$(this).val().trim();//입력값
			if(pass2.trim().length==0){
				$("b.passmsg2").html("<font color='red'>패스워드를 입력해주세요</font>");
				return;
			}
			var pass = $("#pass").val();  // pw 입력
			var pass2 = $("#pass2").val();  // pw 입력
			
			
			
			if(pass!=pass2){
				$("b.passmsg2").html("<font color='red'>비밀번호가 서로 다릅니다.</font>");
				$("#pass2").val("");
				$("#pass2").focus();
			}else{
				$("b.passmsg2").html("");  
			}
				
			
		});
		
		
		$("#email").blur(function(){
			var mbrEmail = $("#email").val();   // email 값 입력
			var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i.test(mbrEmail); // email체크
			
			var email=$(this).val().trim();//입력값
			if(email.trim().length==0){
				$("b.emailmsg").html("<font color='red'>이메일을 입력해주세요</font>");
				return;
			}
			
			if(!(regExp)){
				$("b.emailmsg").html("<font color='red'>이메일 형식으로 작성해주세요</font>");
				$("#email").val("");
				$("#email").focus();
				return;
			}else{
				$("b.emailmsg").html("");
			}
			
			/*$.ajax({
				type:"get",
				dataType:"json",
				data:{"email":email},
				url:"emailcheck",
				success:function(data){
					
					if(data.check==1){
						$("b.idmsg").html("<font color='red'>이미 등록된 이메일입니다</font>");
						$("#email").val("");
						$("#email").focus();
					}else{
						$("b.emailmsg").html("<font color='blue'>사용 가능한 이메일입니다</font>");
					}
				}
			});*/
		});
		
		$("#id").blur(function(){
			var mbrId = $("#id").val();   // id 값 입력
			var regExp=/^[a-zA-z0-9]{4,12}$/.test(mbrId); //아이디 유효성 검사

			var id=$(this).val()//입력값
			if(id.trim().length==0){
				$("b.idmsg").html("<font color='red'>아이디를 입력해주세요</font>");
				return;
			}
			
			if(!(regExp)){
				$("b.idmsg").html("<font color='red'>아이디는 4~12자리로 입력해야합니다!");
				$("#id").val("");
				$("#id").focus();
				return;
			}
			
			$.ajax({
				type:"get",
				dataType:"json",
				data:{"id":id},
				url:"idcheck",
				success:function(data){
					
					if(data.check==1){
						$("b.idmsg").html("<font color='red'>이미 등록된 아이디입니다</font>");
						$("#id").val("");
						$("#id").focus();
					}else{
						$("b.idmsg").html("");
					}
				}
			});
		});
		
		
	});
	

	
	function checkAll(checkAll){
		const checkboxes = document.getElementsByName("check");
		checkboxes.forEach((checkbox)=>{
			checkbox.checked = checkAll.checked;
		})
	}
	
	function checkSelectAll()  {
		  // 전체 체크박스
		  const checkboxes 
		    = document.querySelectorAll('input[name="check"]');
		  // 선택된 체크박스
		  const checked 
		    = document.querySelectorAll('input[name="check"]:checked');
		  // select all 체크박스
		  const checkAll 
		    = document.querySelector('input[name="checkall"]');
		  
		  if(checkboxes.length === checked.length)  {
		    checkAll.checked = true;
		  }else {
			checkAll.checked = false;
		  }

		}
	
	
	function lastcheck(f)
	{
		var check1 = $("#check1").is(":checked");
		var check2 = $("#check2").is(":checked");
		var check3 = $("#check3").is(":checked");
		if(!check1){
			alert("텀블벅 이용 약관 동의 항목을 체크해주세요(필수)");
			$("#check1").focus();
			return false;
		}
		if(!check2){
			alert("개인정보 수집 이용 동의 항목을 체크해주세요(필수)");
			$("#check2").focus();
			return false;
		}
		if(!check3){
			alert("나이 항목을 체크해주세요(필수)");
			$("#check3").focus();
			return false;
		}
		
		return true;
		
	}
	
</script> 


        <div class="container" style="margin-top:150px; width:500px; margin-bottom:150px; border:1px solid silver; padding: 60px 35px 60px 35px; border-radius: 5px 5px 5px 5px;">
            <div>
                <h3>회원 가입</h3>
            </div>
                
                <form action="insert" method="post"  name="memberfrm"
					onsubmit="return lastcheck(this)">
                       <div style="margin-top:50px;">아이디</div>
                        <input type="text" style="height:39px; margin-top:10px;" class="form-control" id="id" placeholder="아이디를 입력해주세요"
                        name="id" maxlength="20" required="required" >
                        <b class="idmsg"></b>
                        
                      <div style="margin-top:20px;">닉네임</div>
                        <input type="text" style="height:39px; margin-top:10px;" class="form-control" id="name" placeholder="닉네임을 입력해주세요"
                        name="name" maxlength="20" required="required" >
                      	<b class="namemsg"></b>
                        
                        <div style="margin-top:20px;">이메일 주소</div>
                        <input type="email" style="height:39px; margin-top:10px;" class="form-control" id="email" placeholder="이메일 주소를 입력해주세요"
                        name="email" maxlength="25" required="required"
                        data-validate="Valid email is:a@b.c">
                        <b class="emailmsg"></b>
                        
                        
                        <div style="margin-top:20px;">비밀번호</div>
                        <span style="font-size:6px; color:gray;">10자~12자리의 영문(대소문자)+숫자+특수문자 중 두 종류 이상을 조합하여 사용할 수 있습니다.</span>
                        <input type="password" style="height:39px; margin-top:10px;" class="form-control" id="pass" name="pass"
                        maxlength="20"  placeholder="비밀번호를 입력해주세요"
                        required="required">
                        <b class="passmsg"></b>
                       
                       
                        <div style="margin-top:10px;">비밀번호 확인</div>
                        <input type="password" style="height:39px; margin-top:10px;" class="form-control" name="pass2" id="pass2"
                        maxlength="20" placeholder="비밀번호 확인을 위해 다시 한 번 입력해 주세요"
                        required="required">
                        <b class="passmsg2"></b>
                   
					   <div style="margin-top:30px;">
					 <label>
					    <input type="checkbox" id="checkall" name="checkall" onclick="checkAll(this);">&nbsp;&nbsp;<b>전체 동의</b>
					 </label>
					 <hr>
					 <br>
					 <label>
					    <input class="position-checkbox" onclick='checkSelectAll()' type="checkbox" name="check" id="check1" value="1">&nbsp;&nbsp;번뜩이 이용 약관 동의(필수)
					 </label> <br>
					  <label>
					    <input class="position-checkbox" style="margin-top:7px;" onclick='checkSelectAll()' type="checkbox" name="check" id="check2" value="2">&nbsp;&nbsp;개인정보 수집 이용 동의(필수)
					   </label> <br>
					  <label> 
					    <input class="position-checkbox" style="margin-top:7px;" onclick='checkSelectAll()' type="checkbox" name="check" id="check3" value="3">&nbsp;&nbsp;만 14세 이상입니다.(필수)
					  </label> <br>
					  <label>  
					    <input class="position-checkbox" style="margin-top:7px;" onclick='checkSelectAll()' type="checkbox" name="check" value="4">&nbsp;&nbsp;마케팅 정보 수신 동의(선택)
					</label>
						</div>

                        <button type="submit" style="margin-top:30px; width:100%; height:50px;" id="join-submit" class="update-save">
                            <b>가입하기</b> &nbsp;<i class="fa fa-check spaceLeft"></i>
                        </button><br>
                        
                        <div class="text-center p-t-115" style="margin-top:20px;">
						<span class="txt1">
							이미 번뜩이 계정이 있으신가요?<br>
						</span>

						<div style="color:blue; cursor:pointer; margin-top:10px;" class="txt2" onclick="location.href='/login/main'">
							<u>기존 계정으로 로그인하기</u>
						</div>
					</div>
                </form>
		</div>
		<div class="style__FooterCopyright-sc-7of8vt-21 kpnzcM"
		style="text-align: center;">© 2021 Bunddeuk Inc.</div>

