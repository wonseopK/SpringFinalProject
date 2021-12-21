<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.page{
	width: 1080px;
	margin: 0px auto;
}
ul.list>li{
	width: 120px;
	text-align: center;
	margin-top: 35px;
}
.menu{
	font-size: 13px;
	cursor: pointer;
	font-weight: bold;
	color: #dcdcdc;
}
ul.list{
    margin: 0px auto;
    margin-left: 100px;
    webkit-box-align: center;
    align-items: center;
    white-space: nowrap;
}
.area{
	z-index:10;
}

/* layout */
.media {
	display: flex;
	justify-content: space-between;
}
.border_line{
	border: 1px solid #cccccc;
	border-radius: 5px;
	
}
.editor_line{
	margin-bottom: 30px; 
	padding: 20px;
	width: 100%
}
.layout1 {
	width: 600px;
	margin-bottom: 100px;
}

.textform, .sel {
	width: 100%;
	padding: 11px 0px;
	border: 1px solid #cccccc;
	border-radius: 5px;
}

.file_box {
	width: 100%;
	height: 400px;
	padding: 50px;
	border: 1px dashed #cccccc;
	border-radius: 5px;
	background-color: white;
}

.textform {
	margin: 0px;
}

.sub_title {
	margin-left: 30px;
	display: flex;
}

.groundBorder {
	border: 1px solid #cccccc;
	padding: 20px 5px;
	border-radius: 5px;
	background-color: white;
}

.img {
	width: 80%;
	margin-left: 50px;
}

.main_title {
	margin: 0px 0px auto;
	display: block;
	width: 380px;
}

.sub_text {
	color: #696969
}

.sub_font {
	font-weight: bold;
	font-size: 13px;
}

.filebox label {
	display: inline-block;
	padding: .5em .75em;
	color: #999;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
}

.filebox input[type="file"] { /* 파일 필드 숨기기 */
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}
.label_box{
	width: 300px; 
	background-color: white; 
	border: 0px solid white; 
	text-align: center;
}
.final-btn,.save{
	float: right;
	display: flex;
	z-index: 999;
	margin-left: 20px;
}
.passbtn_box{
	width: 1080px;
	margin: 0px auto;
}
.present_box{
	background-color: width; 
	border: 1px solid #cccccc; 
	padding: 20px 50px; 
	height: 10%; 
	margin-top: 10px;
	display: flex;
}
.strong_font{
	font-size: 1.5em;
}
.present_del_btn{
	margin-left: 50px; 
	font-size: 1.3em; 
	background-color: white; 
	border: 1px solid silver; 
	color: gray;
}
.playPay{
	float: right;
}
.searchclear{
	cursor: pointer;
}
.project_back{
 background-color: white;
}
</style>
<script type="text/javascript">
$(function() {
	$(".top_fix_zone").hide();
	projectData();		
	$(".page").hide();
	$("#default").show();
	$(".menu").click(function() {
		if($("button#save0").prop("disabled") == false || $("button#save2").prop("disabled") == false || 
				$("button#save3").prop("disabled") == false || $("button#save4").prop("disabled") == false){
			return;
		}else{
		//alert("dd");
		$(".menu").css({"color" : "#dcdcdc"});
		$(this).css({"color" : "black"});
		}
		
	});

	$(".menu").click(function() {
		if($("button#save0").prop("disabled") == false || $("button#save2").prop("disabled") == false || 
				$("button#save3").prop("disabled") == false || $("button#save4").prop("disabled") == false){
			alert("저장 후 페이지를 이동하세요");
			return;
		}else{
		$(".page").hide();
		var page = $(this).attr("data_page");
		$(page).show();
		$('html').scrollTop(0);
		}
	});
	
});


</script>
<div style="background-color: rgb(252, 252, 252);">
<div style="height: 100px;">
</div>
<div id="default" class="page">
	<jsp:include page="default.jsp?idx=${idx }"></jsp:include>
</div>
<div id="funding" class="page">
	<jsp:include page="funding.jsp?idx=${idx }"></jsp:include>
</div>
<div id="reward" class="page">
	<jsp:include page="reward.jsp?idx=${idx }"></jsp:include>
</div>
<div id="story" class="page">
	<jsp:include page="story.jsp?idx=${idx }"></jsp:include>
</div>
<div id="policy" class="page">
	<jsp:include page="policy.jsp?idx=${idx }"></jsp:include>
</div>
</div>


<div class="header_area" style="margin-top: 60px;">

	
	<div class="" style="background-color: white;">
		<!-- Classy Menu -->
		<nav class="classy-navbar" id="essenceNav">

				
			<!-- Menu -->
			<div class="classy-menu">
				<!-- close btn -->
				<div class="classycloseIcon">
					<div class="cross-wrap">
						<span class="top"></span><span class="bottom"></span>
					</div>
				</div>
				<div style="width: 30px;"></div>
				<!-- Nav Start -->
				<div class="classynav" style="padding-left: 150px; width: 500px;">
					<ul class="list">
						<li><span class="menu default" style="color: black;" data_page="#default">기본정보</span></li>
						<li><span class="menu funding" data_page="#funding">펀딩계획</span></li>
						<li><span class="menu reward" data_page="#reward">선물구성</span></li>
						<li><span class="menu story" data_page="#story">프로젝트계획</span></li>
						<li><span class="menu policy" data_page="#policy">신뢰와 안전</span></li>
					</ul>
				</div>
				<!-- Nav End -->
			</div>
		</nav>
	</div>
</div>  