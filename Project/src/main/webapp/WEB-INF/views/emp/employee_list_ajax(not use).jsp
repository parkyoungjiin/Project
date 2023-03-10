<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css" />
 <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<!--  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/select/1.3.3/css/select.dataTables.min.css" /> -->

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>사원목록</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<%--<link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css" /> --%>
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>

<!-- 카테고리별 모아보기 -->
<script type="text/javascript">
	function selectWorkcode() {
		let workcode = $("#workCodeCategory > option:selected").val();
// 		alert(workcode);
		$.ajax({
			type: "GET",
			url: "EmployeeListJson.em?WORK_CD=" + workcode,
// 			data: WORK_CD=workcode,<img id='empImg' src=" + pageContext.request.contextPath + "/resources/"
			dataType: "json"
			
		})
		.done(function(employeeList) {
			$("#datatablesSimple > tbody").html("");
			for(let employee of employeeList) {
				let result = "<tr style='text-align:center'>"
							+ "<td>" + employee.IDX + "</td>"
							+ "<td><img src='${pageContext.request.contextPath}/resources/images/re.gif'>" + + "</td>"
							+ "<td>" + employee.EMP_NUM + "</td>"
							+ "<td><a href='EmployeeDetail.em?EMP_NUM=" + employee.EMP_NUM + "'>" + employee.EMP_NAME  + "</a></td>"
							+ "<td>" + employee.DEPT_CD + "</td>"
							+ "<td>" + employee.GRADE_CD + "</td>"
							+ "<td>" + employee.EMP_TEL + "</td>"
							+ "<td>" + employee.EMP_DTEL + "</td>"
							+ "<td>" + employee.EMP_EMAIL + "</td>"
							+ "<td><input type='button' class='btn btn-secondary btn-sm' value='수정' onclick=\location.href='EmployeeModifyForm.em?EMP_NUM=" 
									+ employee.EMP_NUM + "'\></td>"										
							+ "</tr>"
							
				$("#datatablesSimple > tbody").append(result);
			}
		})
		.fail(function() {
			$("#datatablesSimple> tbody").before("<h5>조회된 정보가 없습니다</h5>");
		});
	}	

</script>
<script type="text/javascript">
	var str = '${priv_cd}' // 세션에 저장된 권한코드
	
	var priv_cd_emp = str.charAt(1); // 사원조회(1) 여부 판별할 값
	var priv_cd_emp2 = str.charAt(2); // 사원관리(2) 여부 판별할 값
	
	//사원조회, 사원관리에 대한 권한이 있는 지 판별
	if(priv_cd_emp == '1' || priv_cd_emp2 == '1'){//권한이 있을 경우
		
	}else{//없을 경우
		alert("조회 권한이 없습니다");
		history.back();
	}
</script>
</head>
<body class="sb-nav-fixed">
<header>
	<!-- top-->
		<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
<main id="main" class="main">

	<div class="pagetitle">
      <h1>사원 목록</h1>
    </div><!-- End Page Title -->
    
            <div class="card mb-4">
                <div class="card-header">
                    <button class="btn btn-secondary" onclick="location.href='EmpInsertForm.em'" style="float: right;">신규등록</button>
					<div class="col-md-2">	
<!-- 					<a href="EmployeeListJson.em?WORK_CD=C1 ">재직</a>	 -->
<!-- 					<a href="EmployeeListJson.em?WORK_CD=C2 ">휴직</a>	 -->
<!-- 					<a href="EmployeeListJson.em?WORK_CD=C3 ">퇴사</a>	 -->
						<select id="workCodeCategory" name="workCodeCategory" class="form-select" onclick="selectWorkcode()">
							<option>재직상태를 선택해주세요</option>
							<option selected value="C1">재직</option>
							<option value="C2">휴직</option>
							<option value="C3">퇴사</option>
						</select>
					</div>
                 </div>
                 <div class="card-body">
                     <table id="datatablesSimple" style="font-size: small;">
                         <thead>
                             <tr>
								<th>인덱스</th>
                                <th width="120">사진</th>
								<th width="90px">사원번호</th>
								<th width="120px">사원명</th>
								<th width="60">부서코드</th>
								<th width="60">직급코드</th>
								<th width="140px">연락처(휴대폰)</th>
								<th width="140px">연락처(내선번호)</th>
								<th width="200px">이메일</th>
								<th width="150">관리하기</th>
                          	</tr>
	                    </thead>
	                    <tbody>
						<!-- ajax로 표시할 위치 -->
						</tbody>
                    </table>
                </div>
            </div>
</main>		


  <!-- 테이블 템플릿 css/js -->
  <script src="${path}/resources/js/scripts.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
  <script src="${path}/resources/js/datatables-simple-demo.js"></script>
<!--   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script> -->
  
</body>
</html>