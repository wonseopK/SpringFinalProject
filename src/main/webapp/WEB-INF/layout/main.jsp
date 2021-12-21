<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(function() {
	//current position
	var pos = 0;
	//number of slides
	var totalSlides = $('#slider-wrap ul li').length;
	//get the slide width
	var sliderWidth = $('#slider-wrap').width();
	$(document).ready(function(){
	  
	  
	  /*****************
	   BUILD THE SLIDER
	  *****************/
	  //set width to be 'x' times the number of slides
	  $('#slider-wrap ul#slider').width(sliderWidth*totalSlides);
	  
	    //next slide  
	  $('#next').click(function(){
	    slideRight();
	  });
	  
	  //previous slide
	  $('#previous').click(function(){
	    slideLeft();
	  });
	  
	  
	  
	  /*************************
	   //*> OPTIONAL SETTINGS
	  ************************/
	  //automatic slider
	  var autoSlider = setInterval(slideRight, 3000);
	  
	  //for each slide 
	  $.each($('#slider-wrap ul li'), function() { 
	     //create a pagination
	     var li = document.createElement('li');
	     $('#pagination-wrap ul').append(li);    
	  });
	  //counter
	  countSlides();
	  
	  //pagination
	  pagination();
	  
	  //hide/show controls/btns when hover
	  //pause automatic slide when hover
	  $('#slider-wrap').hover(
	    function(){ $(this).addClass('active'); clearInterval(autoSlider); }, 
	    function(){ $(this).removeClass('active'); autoSlider = setInterval(slideRight, 3000); }
	  );
	  
	});//DOCUMENT READY
	  
	/***********
	 SLIDE LEFT
	************/
	function slideLeft(){
	  pos--;
	  if(pos==-1){ pos = totalSlides-1; }
	  $('#slider-wrap ul#slider').css('left', -(sliderWidth*pos));  
	  //*> optional
	  countSlides();
	  pagination();
	}
	/************
	 SLIDE RIGHT
	*************/
	function slideRight(){
	  pos++;
	  if(pos==totalSlides){ pos = 0; }
	  $('#slider-wrap ul#slider').css('left', -(sliderWidth*pos)); 
	  //*> optional 
	  countSlides();
	  pagination();
	}
	  
	/************************
	 //*> OPTIONAL SETTINGS
	************************/
	function countSlides(){
	  $('#counter').html(pos+1 + ' / ' + totalSlides);
	  $('#counter2').val(pos+1);
	}
	function pagination(){
	  $('#pagination-wrap ul li').removeClass('active');
	  $('#pagination-wrap ul li:eq('+pos+')').addClass('active');
	}
	
	
	/************************
	//*>SUB BENNER
	/************************
	/* hidden타입의 input에 값 변경시 감지하는 함수 */
	function survey(selector, callback) {
	    var input = $(selector);
	    var oldvalue = input.val();
	    setInterval(function(){
	       if (input.val()!=oldvalue){
	           oldvalue = input.val();
	           callback();
	       }
	    }, 80);
	}	
	
	  survey('#counter2', function(){ 
		var num = $('#counter2').val();
		var listText = '';
		if(num == '1'){
			$("#slider2").css("background-color","rgb(29, 50, 102)");
			list = "<h2>유기동물이 행복한</h2><h2>크리스마스를</h2><p>포인핸드X마리몽 <유기동물의 꿈을 이뤄줄게> </p>";
			$("#slider2").html(list);
				
		}
		if(num == '2'){
			$("#slider2").css("background-color","rgb(229, 89, 89)");
			list = "<h2>가장 나다운</h2><h2>2022를 찾아보세요 </h2><p>200가지 역대 최대 달력*다이어리 기획전 </p>";
			$("#slider2").html(list);
		}
		if(num == '3'){
			$("#slider2").css("background-color","rgb(115, 103, 166)");
			list = "<h2>나의 첫 자취방</h2><h2>구하려니 막막하다면? </h2><p>한 권으로 끝내는 자취 만렙 가이드북</p>";
			$("#slider2").html(list);	
		}
		if(num == '4'){
			$("#slider2").css("background-color","rgb(62, 112, 76)");
			list = "<h2>작업생활:</h2><h2>경기상상캠퍼스 </h2><p>도전과 실험이 돋보이는 신진 창작자의 프로젝트</p>";
			$("#slider2").html(list);	
		}
		if(num == '5'){
			$("#slider2").css("background-color","rgb(229, 89, 89)");
			list = "<h2>Bunddeuk</h2><h2>개발팀을 소개합니다 </h2><p>번뜩이를 탄생시킨 다섯명의 히어로를 소개합니다</p>";
			$("#slider2").html(list);	
		}
	});
})
</script>
<!-- Start Banner Hero -->
<input type="hidden" id="counter2">
<div id="wrapper" style="margin-top: 30px;">
        <!-- 1/5 -->
        <div id="counter"></div>
    <div id="slider-wrap" class="bannerWallpaper">
		<ul id="slider">
         	<li>
         	<a href="/listchul/listChul?category=no&state=no&percent=no&search=강아지">
			<img src="${root }/img/bg-img/pawinhandxmarimong.png">
			</a>
          	</li>
          
         	<li>
			<a href="/listchul/listChul?category=no&state=no&percent=no&search=달력">
			<img src="${root }/img/bg-img/hello2022-8.png">
			</a>
          	</li>
          
         	<li>
			<a href="/listchul/listChul?category=no&state=no&percent=no&search=">
			<img src="${root }/img/bg-img/roomfriends_2.png">
            </a>
            </li>
           
         	<li>
         	<a href="/listchul/listChul?state=new&category=no">         	
			<img src="${root }/img/bg-img/sscampus2021.png">
			</a>
            </li>
           
         	<li>
         	<a href="/listchul/listChul?category=no&state=no&percent=no&search=">
			<img src="${root }/img/bg-img/hello2022-8.png">
            </a>
            </li>
		</ul>
	</div>
    <div id="" class="testLayout">
    		<div class="sub_benner" id="slider2">
<!--     		<h2>가장 나다운</h2><h2>2022를 찾아보세요 </h2>
    		<p>200가지 역대 최대 달력*다이어리 기획전 </p> -->
    		</div>
    </div>
         <!--controls-->
        <div class="btns" id="next"><i class="fa fa-arrow-right"></i></div>
        <div class="btns" id="previous"><i class="fa fa-arrow-left"></i></div>
</div>

<!-- End Banner Hero -->
		
		
<div class="totalLayout">	
	<div class="totalLayout-title">
		<a class="list-titles" title="모든 프로젝트" href="/listchul/listChul?state=no&category=no">모든 프로젝트</a>
	</div>
	<div class="main-lists">
		<c:forEach var="dto" items="${alist}">
			<div class="project-list-mini">
				<a href="/project/detail?idx=${dto.idx}&key=detail"class="list-thumbnail">
					<div class="thumbnail-image">
						<img src="${root}/thumbnail_image/${dto.thumbnail}">
					</div>
					<div class="category-name">
						${dto.category } ㅣ ${dto.name }
					</div>
					<div class="main-project-title">
						${dto.title}
					</div>
				</a>
				<div class="percentageAchieved">
					<fmt:formatNumber value="${dto.total_amount div dto.target_amount * 100}" pattern="0" />% 달성
				</div>
			</div>
		</c:forEach>
	</div>
	<hr>
	<div class="totalLayout-title">
		<a class="list-titles" title="인기 프로젝트" href="/listchul/listChul?state=pop&category=no">인기 프로젝트</a>
	</div>
	<div class="main-lists">
		<c:forEach var="dto" items="${plist}">
			<div class="project-list-mini">
				<a href="/project/detail?idx=${dto.idx}&key=detail"class="list-thumbnail">
					<div class="thumbnail-image">
						<img src="${root}/thumbnail_image/${dto.thumbnail}">
					</div>
					<div class="category-name">
						${dto.category } ㅣ ${dto.name }
					</div>
					<div class="main-project-title">
						${dto.title}
					</div>
				</a>
				<div class="percentageAchieved">
					<fmt:formatNumber value="${dto.total_amount div dto.target_amount * 100}" pattern="0" />% 달성
				</div>
			</div>
		</c:forEach>
	</div>
	<hr>
	<div class="totalLayout-title">
		<a class="list-titles" title="마감임박 프로젝트" href="/listchul/listChul?state=endsoon&category=no">마감임박 프로젝트</a>
	</div>
	<div class="main-lists">
		<c:forEach var="dto" items="${elist}">
			<div class="project-list-mini">
				<a href="/project/detail?idx=${dto.idx}&key=detail"class="list-thumbnail">
					<div class="thumbnail-image">
						<img src="${root}/thumbnail_image/${dto.thumbnail}">
					</div>
					<div class="category-name">
						${dto.category } ㅣ ${dto.name }
					</div>
					<div class="main-project-title">
						${dto.title}
					</div>
				</a>
				<div class="percentageAchieved">
					<fmt:formatNumber value="${dto.total_amount div dto.target_amount * 100}" pattern="0" />% 달성
				</div>
			</div>
		</c:forEach>
	</div>
	<hr>
	<div class="totalLayout-title">
		<a class="list-titles" title="신규 프로젝트" href="/listchul/listChul?state=new&category=no">신규 프로젝트</a>
	</div>
	<div class="main-lists">
		<c:forEach var="dto" items="${nlist}">
			<div class="project-list-mini">
				<a href="/project/detail?idx=${dto.idx}&key=detail"class="list-thumbnail">
					<div class="thumbnail-image">
						<img src="${root}/thumbnail_image/${dto.thumbnail}">
					</div>
					<div class="category-name">
						${dto.category } ㅣ ${dto.name }
					</div>
					<div class="main-project-title">
						${dto.title}
					</div>
				</a>
				<div class="percentageAchieved">
					<fmt:formatNumber value="${dto.total_amount div dto.target_amount * 100}" pattern="0" />% 달성
				</div>
			</div>
		</c:forEach>
	</div>
	<div>
		<img src="${root}/image/bottom-logo-img.png">
	</div>
</div>