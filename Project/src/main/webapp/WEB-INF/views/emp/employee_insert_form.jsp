<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- css 경로 설정 -->
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
<!-- css -->
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<!-- js -->
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<meta charset="UTF-8">

<!-- 카카오 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("emp_address_kakao").value = data.address; // 주소 넣기
                document.getElementById("emp_address_zonecode").value = data.zonecode; // 우편번호 넣기
                document.querySelector("input[id=emp_address_kakao2]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}
</script>
<!-- 이미지 썸네일 -->
<script>
	function changeImage(event) {
		var reader = new FileReader();

        reader.onload = function(event) {
          var img = document.createElement("img");
          img.setAttribute("src", event.target.result);
          img.setAttribute("style", "width: 200px; height: 200px; padding:10px;  object-fit: cover;");
          document.querySelector("div#image_container").innerHTML = '';
          document.querySelector("div#image_container").appendChild(img);
        };

        reader.readAsDataURL(event.target.files[0]);
}// changeImage 끝
</script>

<!-- 이메일 클릭 시 자동입력 -->
<script type="text/javascript">

</script>
<!-- 권한 체크 : 1 / 권한 미체크 : 0 -->
<script type="text/javascript">
$(document).ready(function(){
	 $('input:checkbox[name="PRIV_CD"]').change(function(){
		if(document.getElementById("priv_cd1").checked) {
			$('#priv_cd1_hidden').prop('disabled', true);
		}
		if(document.getElementById("priv_cd2").checked){
			$('#priv_cd2_hidden').prop('disabled', true);
		}
		if(document.getElementById("priv_cd3").checked){
			$('#priv_cd3_hidden').prop('disabled', true);
		}
		if(document.getElementById("priv_cd4").checked){
			$('#priv_cd4_hidden').prop('disabled', true);
		}
		if(document.getElementById("priv_cd5").checked){
			$('#priv_cd5_hidden').prop('disabled', true);
		}
	 })
});

</script>

<!-- 연락처 숫자만 입력되는 유효성 검사 -->
<script type="text/javascript">
	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	} 
	 
	function inputOnlyNumberFormat(obj) {
	    obj.value = onlynumber(uncomma(obj.value));
	}
	 
	function onlynumber(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g,'$1');
	}
	
	
</script>

<script type="text/javascript">
	//이메일 중복 체크 여부 변수
	var emailStatus =false; 
	
	//===========이메일 입력 시 영어, 숫자만 입력 가능===============
	function onlyEngNumber(str) {
		var regType1 = /^[A-Za-z0-9+]*$/; // regex : 영어, 숫자만 입력
		if (regType1.test(str.value)) { //영어, 숫자만 입력했을 때
		}else{//영어, 숫자를 제외한 값 입력 시
			str.value = ""; // ""으로 초기화
		}
	}//onlyEngNumber 끝
	
	
	//==========이메일 도메인 선택 시 자동입력============
	
$(function() {
	$("#domain").on("change", function() {
		$("#email2").val($(this).val());
		
		if($(this).val() == "") {
			$("#email2").prop("readonly", false);
			$("#email2").css("background-color", "white");
			$("#email2").focus();
		} else {
			$("#email2").prop("readonly", true);
			$("#email2").css("background-color", "lightgray");
		}
	})//change
});//function
	//==========이메일 중복체크 ajax==========
	function checkEmail() {
	
			//이메일 결합
			var email1 = $("#email1").val();
			var email2 = $("#email2").val();
			var check_email = email1 + "@" + email2;
			
// 			alert(check_email);
			$.ajax({
				url: "EmpEmailCheck.em",
				type: "post",
				data: {
					check_email : check_email
					},
				success: function(data) {
					if(data > 0){
						$("#checkResultArea").html("이메일 사용 불가능").css("color", "red");
						emailStatus = false;
						$("#email1").focus();
					}else{
						$("#checkResultArea").html("이메일 사용 가능").css("color", "blue");
						emailStatus = true;
						$("#emp_address_zonecode").focus();
						
					}
				}//success
				
				
			});//ajax 끝
		};//checkEmail 끝
	//==========이메일 사용 불가능일 경우 폼 전송 X	=============
	function fn_insertMember() {
		var insertForm = document.emp;
		
		if(emailStatus == false){
			alert("중복확인 필수")
			event.preventDefault(); // submit 기능 막기
		}
		
	}//fn_insertMember 끝

</script>

<!-- 권한 여부 판별하여 인사부서인지 판별 -->
<script type="text/javascript">
	var str = '${priv_cd}' // 세션에 저장된 권한코드
	
	var priv_cd_emp = str.charAt(1); // 사원조회(1) 여부 판별할 값
	var priv_cd_emp2 = str.charAt(2); // 사원관리(2) 여부 판별할 값
	
	//사원조회, 사원관리에 대한 권한이 있는 지 판별
	if(priv_cd_emp == '1' || priv_cd_emp2 == '1'){//권한이 있을 경우
		
	}else{//없을 경우
		alert("사원등록 권한이 없습니다");
		history.back();
	}
</script>
<style type="text/css">
	#title_label{
		font-weight: bold;
	}
</style>
<title>사원 등록</title>
</head>
<body>
	<header>
	<!-- top-->
		<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
<main id ="main" class="main">
   <div class="pagetitle">
     <h1>사원 관리</h1>
   </div>
	<div class="card-header">
            사원 등록
        </div>
			<div></div>
		<div class="card mb-4">
		<!-- Profile Edit Form -->
		       <div class="card-body">
			
                  <form action="EmpInsertPro.em" method="post" enctype="multipart/form-data" id="emp">
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">사원명</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="EMP_NAME" type="text" class="form-control" id="fullName">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">부서명</label>
                      <div class="col-md-8 col-lg-2">
 	                     <select name ="DEPT_CD" required="required" class="form-select">
							<option value="">===부서 선택===</option>
							<option value="A1">자재팀</option>
							<option value="A2">구매관리팀</option>
							<option value="A3">창고관리팀</option>
							<option value="A4">인사팀</option>
							</select>
						</div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">직급명</label>
                      <div class="col-md-8 col-lg-2">
							<select name="GRADE_CD" required="required" class="form-select">
								<option value="">===직급 선택===</option>
								<option value="B1">사원</option>
								<option value="B2">대리</option>
								<option value="B3">과장</option>
								<option value="B4">부장</option>
								<option value="B5">이사</option>
								<option value="B6">대표</option>
							</select>
						</div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">연락처(개인)</label>
  	                    <div class="col-md-8 col-lg-3">
       	                  <div class="input-group mb-6">
  	                    	<input type="text" class="form-control" name="EMP_TEL" value="010" onkeyup="inputOnlyNumberFormat(this)" maxlength="3">
                      		<span class="input-group-text">-</span>
                      		<input type="text" class="form-control" name="EMP_TEL" onkeyup="inputOnlyNumberFormat(this)" maxlength="4">
                      		<span class="input-group-text">-</span>
                      		<input type="text" class="form-control" name="EMP_TEL" onkeyup="inputOnlyNumberFormat(this)" maxlength="4">
     					   </div>                 
     					</div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">연락처(사무실)</label>
   	                    <div class="col-md-8 col-lg-3">
       	                  <div class="input-group mb-6">
  	                    	<input type="text" class="form-control" name="EMP_DTEL" value="051" onkeyup="inputOnlyNumberFormat(this)" maxlength="3">
                      		<span class="input-group-text">-</span>
                      		<input type="text" class="form-control" name="EMP_DTEL" onkeyup="inputOnlyNumberFormat(this)" maxlength="3">
                      		<span class="input-group-text">-</span>
                      		<input type="text" class="form-control" name="EMP_DTEL" onkeyup="inputOnlyNumberFormat(this)" maxlength="4">
     					   </div>                 
     					</div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">이메일</label>
                		  <div class="col-md-8 col-lg-7">
                		
		                	<div class="input-group mb-5">
		                      <input type="text" class="form-control" id="email1" name="EMP_EMAIL" onkeyup="onlyEngNumber(this)" required="required">
		                      <span class="input-group-text">@</span>
		                      <input type="text" class="form-control" id="email2" name="EMP_EMAIL" required>
		                      	<select class="form-select" name="selectDomain" id="domain" >
			                      	<option value="">직접 입력</option>
									<option value="naver.com">naver.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="daum.net">daum.net</option>
									<option value="nate.com">nate.com</option>
		                   		 </select>
		                   		 <button type="button" onclick="checkEmail();" class="btn btn-secondary" style="margin-left: 30px">이메일 중복 확인</button>
<!-- 		                   		 <input type="text" id="checkResultArea" class="form-control"> -->
		                   		 <span id ="checkResultArea" class="input-group-text" style="width:133px "></span>
		                    </div>
	                    </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">우편번호</label>
                      <div class="col-md-8 col-lg-2">
	                	<div class="input-group mb-6">
                        <input name="EMP_POST_NO" type="text" class="form-control" id="emp_address_zonecode" >
	                    <button id="address_kakao" class="btn btn-secondary" type="button">우편번호 찾기</button>
	                    </div>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">주소</label>
                      <div class="col-md-8 col-lg-3">
                        <input name="EMP_ADDR" type="text" class="form-control" id="emp_address_kakao" required>
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">상세주소</label>
                      <div class="col-md-8 col-lg-3">
                        <input name="EMP_ADDR" type="text" class="form-control" id="emp_address_kakao2" >
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label" >입사일</label>
                      <div class="col-md-8 col-lg-2">
                        <input name="HIRE_DATE" type="date" class="form-control" id="Twitter">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">재직여부</label>
                       <div class="col-md-8 col-lg-2">
		                      	<select class="form-select" name="WORK_CD" required>
									<option value="">===재직여부 선택===</option>
									<option value="C1">재직</option>
									<option value="C2">휴직</option>
									<option value="C3">퇴사</option>
								</select>
	                    </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">권한</label>
                       <div class="col-md-8 col-lg-5">
		                	<div class="input-group mb-6">
		                        <label class="form-check-label" style="margin-right: 30px">
		                        	<input type="checkbox" class="form-check-input" id="priv_cd1" name="PRIV_CD" value="1" style="margin-right: 10px">
		                        	기본등록
		                        </label>
								<input type="hidden" id="priv_cd1_hidden"  name="PRIV_CD" value="0">
								
								<label class="form-check-label" style="margin-right: 30px">
									<input type="checkbox" class="form-check-input" id="priv_cd2" name="PRIV_CD" value="1" style="margin-right: 10px">
									사원조회
								</label>
								<input type="hidden" id="priv_cd2_hidden"  name="PRIV_CD" value="0">
								
								<label class="form-check-label" style="margin-right: 30px">
									<input type="checkbox" class="form-check-input" id="priv_cd3" name="PRIV_CD" value="1" style="margin-right: 10px">
									사원관리
								</label>
								<input type="hidden" id="priv_cd3_hidden"  name="PRIV_CD" value="0">
								
								<label class="form-check-label" style="margin-right: 30px">
									<input type="checkbox" class="form-check-input" id="priv_cd4" name="PRIV_CD" value="1" style="margin-right: 10px">
									재고조회
								</label>
								<input type="hidden" id="priv_cd4_hidden"  name="PRIV_CD" value="0">
								
								<label class="form-check-label" style="margin-right: 30px">
									<input type="checkbox" class="form-check-input" id="priv_cd5" name="PRIV_CD" value="1" style="margin-right: 10px">
									재고관리
								</label>
								<input type="hidden" id="priv_cd5_hidden"  name="PRIV_CD" value="0">
		                    </div>
	                    </div>
                    </div>

                    <div class="row mb-3">
                      <label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">사진 업로드</label>
                       <div class="col-md-8 col-lg-3">
                        <input name="file" type="file" class="form-control" id="input_image" onchange="changeImage(event);">
                      </div>
               		 <div></div>
					<div class="row mb-3">
						<label for="th" id="title_label" class="col-md-4 col-lg-3 col-form-label">사진 미리보기</label>
                     	 <div id="image_container" style="padding:10px; height=200px; width=200px; text-align: center;"></div>
					</div>
                    </div>
					
					<div>
					</div>
                    <div class="text-left">
                      <button type="submit" class="btn btn-primary">사원 등록</button>
                    </div>
                  </form><!-- End Profile Edit Form -->
                </div>
		</div>
</main>
</body>
</html>