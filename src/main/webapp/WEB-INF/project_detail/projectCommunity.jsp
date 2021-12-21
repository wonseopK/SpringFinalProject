<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/project-community.css">
<div class="container2">
	<input type="hidden" id="pnum" name="pnum" value="${dto.idx}"> 
	<c:choose>
		<c:when test="${sessionScope.loginok == 'yes'}">
			<div class="comment-container">
				<form id="comment" action="../comment/insert" method="post">
					<input type="hidden" name="pnum" value="${dto.idx}"> 
					<input type="hidden" id="loginUser"name="writer" value="${sessionScope.id}">
					<textarea name="content" class="comment" placeholder="커뮤니티가 더 훈훈해지는 댓글을 남겨주세요."></textarea>
					<div class="btn-container">
						<span class="count-content countLength">0</span><span class="countLength">/500</span><button type="button" class="base-btn btn-loc send-btn">등록</button>
					</div>
				</form>
			</div>
		</c:when>
		<c:otherwise>
			<div class="comment-container logout-comment" style="color:gray; padding-top:25px;">
				따뜻한 댓글 작성을 위해 <a id='loginLink' href='../login/main'>로그인</a>을 해주세요 <span class='heart'><i class="fa fa-heart"></i></span>
			</div>
		</c:otherwise>
	</c:choose>
	<div id = 'option-container'>
		<span class ='cnt-comment'><i class="fa fa-commenting-o" aria-hidden="true"></i>  댓글 <span class="cnt-comment commentCount">0</span>개 </span>
		<span class ='order-asc'>등록순</span>
		<span class = 'order-desc'>최신순</span>
		<input type="hidden" class='comment-order' value='1'>
	</div>
	<div class = "comment-list"></div>
	<form class="to-profile" action="/profile2" method = "post">
		<input id="profileId" type="hidden" name="id">
	</form>
</div>

<script>
$(function () {
	//출력되는 댓글의 정렬 순서 
	//등록순
	$(".order-asc").click(function() {
		$(".comment-order").val("1")
		$(".order-desc").css({
			"color":"#b7b7b7"
		})
		$(".order-asc").css({
			"color":"#333"
		})
		getCommentList()
	})
	//최신순
	$(".order-desc").click(function() {
		$(".comment-order").val("2")
		$(".order-asc").css({
			"color":"#b7b7b7"
		})
		$(".order-desc").css({
			"color":"#333"
		})
		getCommentList()
	})
	//댓글 갯수
	countComment()
	
	//해당 회원 프로필페이지로 이동
	$(document).on("click",".profile-photo", function() {
		if($(this).attr("id") == 'admin'){
			alert("관리자 프로필로는이동이 불가능합니다.")
			return;
		}
		let profileId = $(this).attr("id");
		let check = confirm(profileId+"님의 프로필 페이지로 이동하시겠습니까?");
		if(check == true){
			$("#profileId").val("");
			$("#profileId").val($(this).attr("id"));
			$(".to-profile").submit();
		}
	})
	getCommentList();
	//댓글 내역 가져오기
	function getCommentList() {
		let loginCheck = '${sessionScope.loginok}';
	    let loginUser = '${sessionScope.id}';	
		let num = $("#pnum").val();
		let order = $(".comment-order").val();
       	$.ajax({
               url : "../comment/list",
               type : 'get', 
               dataType: 'json',
               data: {pnum:num, order:order},
               success : function(data) {
            	countComment();
               	let projectWriter = '${dto.id}'
                let s = ''; 
               	for(i=0; i<data.length; i++){
               		//댓글 출력
               		s+="<hr>"
               		//grps값에 따라 왼쪽 여백 값 설정
                	s += "<div class='show-comment' style='padding-left:"+data[i].grps*52+"px;'>";
                	//임시 삭제일 경우
               		if(data[i].tempdel == 1){
                		s +="<span class ='delete-msg'>댓글이 삭제되었습니다.</span>"
               		}else{
               			//대댓글 표시 이미지
	                	if(data[i].grph != 0){
						s += "<img class='re-image' src='../profile_image/re.png'> ";
	                	}
               			//프로필 사진
	                	if(data[i].photo == null){
						s += "<img class='profile-photo' title='"+data[i].writer+"님의 프로필페이지로 이동합니다.' src='../profile_image/basic.jpg' id='"+data[i].writer+"'>";
		                }else{
                		s += "<img class='profile-photo' title='"+data[i].writer+"님의 프로필페이지로 이동합니다.' src='../profile_image/"+data[i].photo+"' id='"+data[i].writer+"'>";
		                }
               			//작성자
	                	s += "<span class='re-writer-name'>&nbsp;"+data[i].writer+"</span>";
	                	//프로젝트 작성자의 댓글일 경우 표시
	                	if(data[i].writer == projectWriter){
	                	s += "<span class='project-writer'>작성자</span>";
	                	}
	                	//고정표시
	                	if(data[i].fix == 1 && data[i].grph == 0){
		                	s += "&nbsp;<span class='fix-msg'><i class='fa fa-thumb-tack'></i> "+projectWriter+"님이 고정함</span>";	
		                }
	                	//프로젝트 작성자일 경우만 고정 기능사용가능
	                	if(data[i].grph == 0 && loginCheck=='yes' && loginUser == projectWriter){
		                	if(data[i].fix != 1){
		                		s += "<button class='fix-style fix'><i class='fa fa-thumb-tack'></i></button><br>";	
		                	}else{
		                		s += "<button class='fix-style cancel-fix'><i class='fa fa-times'></i></button><br>";	
		                	}
	                	}
	                	//부모글 작성자표시하고 num값 저장
	                	if(data[i].parent != 'no' && data[i].parent != data[i].writer){
	                	s += "<div class='parent-writer'>@"+data[i].parent+"</div>"
	                	s += "<input type='hidden' id='parentNum' value='"+data[i].parent_num+"'>"
	                	}
	                	//댓글 대댓글 여부에 따라 댓글 컨테이너 사이즈 수정
	                	if(data[i].grps > 0){
		                	s += "<pre style ='width:475px;' class='re-content'>"+data[i].content+"</pre>";
	                	}else{
		                	s += "<pre style ='width:530px;' class='re-content'>"+data[i].content+"</pre>";
	                	}
	                	s += "<span id='time'>"+data[i].writetime+"</span>";
	                	//로그인 했을 경우에만 답글, 본인글 수정,삭제 가능
	                	if(loginCheck == 'yes'){
	                	s += "<button class='fix-style reply'><span style='color:gray;'>답글</span></button>";
		                	if(data[i].writer == loginUser){
	                			s += "<button class='re-del-option'><span><i class='fa fa-ellipsis-v'></i></span></button>";
				                s += "<button class='fix-style up-loc re-update'><span><i class='fa fa-pencil'></i> 수정</span></button>";
								s += "<button class='fix-style del-loc delete-btn'><span><i class='fa fa-trash-o'></i> 삭제</span></button>";              	
		                	}
	                	}
	                	s += "<input type='hidden' id='parent' value='"+data[i].writer+"'>";
		    			s += "<input type='hidden' id='pnum' value='"+data[i].pnum+"'>";
	                	s += "<input type='hidden' id='writer' value='"+data[i].writer+"'>"
	                	s += "<input type='hidden' id='num' value='"+data[i].num+"'>"
	                	s += "<input type='hidden' id='grp' value='"+data[i].grp+"'>"
	                	s += "<input type='hidden' id='grph' value='"+data[i].grph+"'>"
	                	s += "<input type='hidden' id='grps' value='"+data[i].grps+"'>";
	                	s += "<input type='hidden' id='content' value='"+data[i].content+"'>"
	                	s += "<input type='hidden' id='tempdel' value='"+data[i].tempdel+"'>"
                	s += "</div>";
               		}
                	//수정폼 출력
                	s += "<div class='update-form'></div>";
                	//답글폼 출력
                	s += "<div class='reply-form'></div>";
	                	
               	}
               	$(".comment-list").html(s);
               	$(".re-update").hide();
               	$(".delete-btn").hide();
               	$(".re-del-option").hide();
               	
               }, 
               error : function(xhr, status) {
                   alert(xhr + " : " + status);
               }
           }); 
	}
	
	//댓글작성
	$(".send-btn").click(function() {
		let comment = $(".comment").val()
		if(comment.trim().length == 0){
			alert("댓글 내용을 입력하지 않았습니다.")
			$(".comment").focus()
			return;
		}
		let formData = $("#comment").serialize();

        $.ajax({
            cache : false,
            url : "../comment/insert",
            type : 'POST', 
            data : formData, 
            success : function() {
            	getCommentList();
            	$(".comment").val("")
            	$(".count-content").text('0')
            }, 
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        }); 
	})
	//댓글 글자수 체크
	$(".comment").keyup(function(){
		let content = $(this).val()
		let contentSize = (content.length+content.split('\n').length-1);
		$(".count-content").html(contentSize)
		if(contentSize > 500){
			alert("500자 이하로 입력해주세요")
			$(this).val(content.substring(0, 500));
			$(".count-content").html('500')
			return;
		}
	})
	
	//답글폼 숨기기
	$(document).on("click",".hide-btn", function() {
		$(this).parent().siblings(".reply-comment").val("")
		$(".reply-form").hide()
		
	})
	//답글폼 보이기
	$(document).on("click",".reply", function() {
		$(".reply-form").hide()
		$(".update-form").hide()
		$(this).parent().next().next(".reply-form").show()
		let parent = $(this).siblings("#parent").val()
		let parentNum = $(this).siblings("#num").val()
		let pnum = $(this).siblings("#pnum").val() 
		let grp = $(this).siblings("#grp").val()
		let grph = $(this).siblings("#grph").val()
		let grps = $(this).siblings("#grps").val()
		let s = ""
		s += "<form action='../comment/reply' class='reply-form' method='post'>";
			s += "<div class='reply-container'>";
				s += "<input type='hidden' name='writer' value='${sessionScope.id}'>";
				s += "<input type='hidden' name='parent' value='"+parent+"'>";
				s += "<input type='hidden' name='parent_num' value='"+parentNum+"'>";
				s += "<input type='hidden' name='pnum' value='"+pnum+"'>";
				s += "<input type='hidden' name='grp' id='grp' value='"+grp+"'>";
				s += "<input type='hidden' name='grph' id='grph' value='"+grph+"'>";
				s += "<input type='hidden' name='grps' id='grps' value='"+grps+"'>";
				s += "<textarea required name='content' class='reply-comment' placeholder='"+parent+"님에게 답글 쓰기'></textarea>"
				s += "<div class='btn-container'>";
					s += "<span class='countLength count-reply'>0</span><span class='countLength'>/500</span><br>"
					s += "<button type='button' class='base-btn hide-btn'>취소</button>";			    			
	    			s += "<button type='button' class='base-btn reply-btn'>등록</button>"
				s += "</div>";
			s += "</div>";
		s += "</form>";
		$(this).parent().siblings('.reply-form').html(s)
	})
	//답글작성
	$(document).on("click",".reply-btn", function() {
		let comment = $(this).parent().siblings(".reply-comment")
		if(comment.val().length == 0){
			alert("댓글 내용을 입력하지 않았습니다.")
			comment.focus()
			return;
		}
		let formData2 = $(this).parent().parent().parent().serialize();
        $.ajax({
            cache : false,
            url : "../comment/reply",
            type : 'POST',
            data : formData2, 
            success : function() {
            	getCommentList();
            }, 
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        }); 	 
	})
	//답글글자수 체크
	$(document).on("keyup",".reply-comment", function() {
		let content = $(this).val()
		let contentSize = ($(this).val().length+$(this).val().split('\n').length-1);
		$(".count-reply").html(contentSize)
		if(contentSize > 500){
			alert("500자 이하로 입력해주세요")
			$(this).val(content.substring(0, 500));
			$(".count-reply").html('500')
			return;
		}
		
		
	})
	
	//부모글의 컨텐트 내용확인
	$(document).on("click",".parent-writer", function() {
		let parentName = $(this).text().replace(/^./, "");
		let check = confirm(parentName+"님이 작성한 상위 댓글의 내용을 확인하시겠습니까?")
		if(check != true){
			return;
		}
		let num = $(this).next("#parentNum").val();
        $.ajax({
            url : "../comment/getComment",
            type : 'POST', 
            data : {num:num},
            success : function(data) {
            	if(data.length == 0){
            		alert("해당상위 댓글은 삭제되었습니다.")
            	}else{
	            	alert(data)
            	}
            }, 
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        });
	})
	
	
	
	
	//본인글일경우 마우스를 컨테이너에 가져다대면 기능버튼 보이기
	$(document).on("mouseenter",".show-comment", function() {
		$(this).children(".re-del-option").show();
	})
	$(document).on("mouseleave",".show-comment", function() {
		$(this).children(".re-del-option").hide();
		$(this).children(".re-update").hide()
		$(this).children(".delete-btn").hide()
	})
	//기능버튼 클릭시 수정,삭제버튼 보이기
 	$(document).on("click",".re-del-option", function() {
		$(this).parent().siblings().children(".re-update").hide()
		$(this).parent().siblings().children(".delete-btn").hide()

		$(this).siblings(".re-update").toggle()
		$(this).siblings(".delete-btn").toggle()
		
	});
	//댓글삭제버튼
	$(document).on("click",".delete-btn", function() {
		let check = confirm("삭제하시겠습니까?")
		if(check != true){
			return;
		}
		let num = $(this).siblings("#num").val();
		let grp = $(this).siblings("#grp").val();
		let grph = $(this).siblings("#grph").val();
		let tempDel = $(this).siblings("#tempdel").val();
        $.ajax({
            url : "../comment/delete",
            type : 'POST', 
            data : {num:num, grp:grp, grph:grph, tempdel:tempDel},
            success : function() {
            	getCommentList();
            }, 
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        }); 
	})
	
	//수정폼 숨기기
	$(document).on("click",".hide-updatefrm", function() {
		$(".update-container").hide()
	})
	//수정폼 보이기
	$(document).on("click",".re-update", function() {
		let content = $(this).siblings(".re-content")
		$(".reply-form").hide()
		$(".update-form").html('')
		$(".update-form").show()
		let s = '';
		s += "<div class='update-container'>";
			s += "<textarea name='content' class='update-comment'>"+content.text()+"</textarea>"
			s += "<div class='btn-container'>";
				s += "<span class='count-update countLength'>"+(content.text().length+(content.text().split('\n').length-1))+"</span><span class='countLength'>/500</span><br>"
				s += "<button type='button' class='base-btn hide-updatefrm'>취소</button>";			    			
				s += "<button type='button' class='base-btn update-btn'>수정</button>"
				s += "<input type='hidden' id='update-num' value='"+$(this).siblings("#num").val()+"'>"
			s += "</div>";
		s += "</div>";
		$(this).parent().next('.update-form').html(s)
		$(this).hide();
		$(this).next().hide();
	}) 
	//수정폼글자수 체크
	$(document).on("keyup",".update-comment", function() {
		let content = $(this).val()
		let contentSize = ($(this).val().length+$(this).val().split('\n').length-1);
		$(".count-update").html(contentSize)
		if(contentSize > 500){
			alert("500자 이하로 입력해주세요")
			$(this).val(content.substring(0, 500));
			$(".count-update").html('500')
			return;
		}
		
	})
	//수정버튼
	$(document).on("click",".update-btn", function() {
		let check = confirm("수정하시겠습니까?")
		if(check == true){
			let num = $(this).next("#update-num").val()
			let comment = $(this).parent().siblings(".update-comment").val()
			if(comment.trim().length == 0){
				alert("댓글 내용을 입력하지 않았습니다.")
				$(".update-comment").focus()
				return;
			}
			$.ajax({
	            url : "../comment/update",
	            type : 'POST', 
	            data : {num:num, comment:comment},
	            success : function() {
	            	getCommentList();
	            }, 
	            error : function(xhr, status) {
	                alert(xhr + " : " + status);
	            }
	        }); 
			
		}
	}) 
	//고정버튼 보이게하기
	$(document).on("click",".fix", function() {
		let check = confirm("댓글을 고정하시겠습니까? 이전에 고정한 댓글이 있으면 현제 글로 변경됩니다.")
		if(check != true){
			return;
		}
		let grp = $(this).siblings("#grp").val()
		$.ajax({
            url : "../comment/fix",
            type : 'POST', 
            data : {grp:grp},
            success : function() {
            	getCommentList();
            }, 
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        }); 
	})
	//고정취소버튼
	$(document).on("click",".cancel-fix", function() {
		let check = confirm("고정을 취소하시겠습니까?")
		if(check != true){
			return;
		}
		let grp = $(this).siblings("#grp").val()
		$.ajax({
            url : "../comment/cancelFix",
            type : 'POST', 
            data : {grp:grp},
            success : function() {
            	getCommentList();
            }, 
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        }); 
	})
	//댓글 갯수
	function countComment() {
		let pnum = $("#pnum").val();
		$.ajax({
            url : "../comment/countComment",
            type : 'post', 
            data : {pnum:pnum},
            success : function(data) {
            	$(".commentCount").text(data)
            }, 
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        }); 
	}
	
})	
</script>