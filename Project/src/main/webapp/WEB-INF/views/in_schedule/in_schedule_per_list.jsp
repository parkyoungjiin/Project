<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
<!-- 거래처(기본 등록) 권한 판별 -->
// 	var str = '${priv_cd}' // 세션에 저장된 권한코드
	
// 	var priv_cd_res = str.charAt(0); // 기본등록(0) 여부 판별할 값
// 	var priv_cd_pro = str.charAt(3); // 재고조회(3) 여부 판별할 값
// 	var priv_cd_pro2 = str.charAt(4); // 재고관리(4) 여부 판별할 값
	
// 	//기본등록에 대한 권한이 있는 지 판별
// 	if(priv_cd_res == '1' || priv_cd_pro == '1' || priv_cd_pro2 == '1'){//권한이 있을 경우
		
// 	}else{//없을 경우
// 		alert("권한이 없습니다");
// 		history.back();
// 	}
</script>

<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css" />
 <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<!--  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/select/1.3.3/css/select.dataTables.min.css" /> -->

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>출고 관리</title>
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/styles.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/form_style.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">
// 체크박스 선택 jQuery
	$(document).ready(function() {
		$("#chkAll").click(function() {
			if($("#chkAll").is(":checked")) $("input[name=chk]").prop("checked", true);
			else $("input[name=chk]").prop("checked", false);
		});
	
		$("input[name=chk]").click(function() {
			var total = $("input[name=chk]").length;
			var checked = $("input[name=chk]:checked").length;
		
			if(total != checked) $("#chkAll").prop("checked", false);
			else $("#chkAll").prop("checked", true); 
		});
	});
	
	//-------------입고처리 시 팝업창 ----------------
	
	function in_schedule_process() {
		window.open("In_Per_List_popup", "입고처리", "width=1200, height=750, top=50, left=50")
	}
	
	// ------------재고, 창고조회---------------
	function stock() {
		
		let buyer_keyword = $("#buyer_keyword").val();
		
//	 	alert(buyer_keyword);
		
		$.ajax({
			type: "GET",
			url: "BuyerListJson?keyword=" + buyer_keyword,
			dataType: "json"
		})
		.done(function(buyerList) { // 요청 성공 시
			 
//	 		$(".modal-body").append(buyerList);
			$("#modal-body > table").empty();   
		
			for(let buyer of buyerList) {
				
				
		         let result = "<table class='table table-hover' id='buyer_table' style='margin-left: auto; margin-right:'>"
		                  + "<tr>"
		                  + "<th scope='col'>거래처코드</th>"
		                  + "<th scope='col'>상호명</th>"
		                  + "</tr>"
		                  + "<tr style='cursor:pointer;'>"
		                  + "<td>" + buyer.business_no + "</td>"
		                  + "<td id='cust_name'>" + buyer.cust_name + "</td>"
		                  + "</tr>";
		                  + "</table>"
		                  
		         $("#modal-body > table").append(result);
				
//	 			let result = "<tr style='cursor:pointer;'>"
//	 		                + "<td>" + buyer.business_no + "</td>"
//	 		                + "<td id='cust_name'>" + buyer.cust_name + "</td>"
//	                			+ "</tr>";
	             
//	 			$("#modal-body > table").append(result);
			}
		})
		.fail(function() {
			$("#modal-body > table").append("<h3>요청 실패!</h3>");
		});
	}

	
		function load_PGroupList() {
			
			let pGroup_keyword = $("#pGroup_keyword").val();
			
			alert(pGroup_keyword);
			
			$.ajax({
				type: "GET",
				url: "pGroupListJson?keyword=" + pGroup_keyword,
				dataType: "json"
			})
			.done(function(ProdList) { // 요청 성공 시
//		 			$(".modal-body").append(buyerList);
//		 		$("#modal-body > table").empty();	
			
				if(ProdList.length == 0){
//		 			$("#pGroup_search").append("<div></div>");
					$("#pGroup_search").html("<div>등록된 데이터가 없습니다.</div>");
					$("#pGroup_search").css("color","#B9062F");
				} 
//		 		else {
//		 			$("#pGroup_search").remove();
//		 		}
				for(let list of ProdList) {
					
					let result = "<tr style='cursor:pointer;'>"
				                + "<td>" +list.product_group_bottom_cd+ "</td>"
				                + "<td id='product_group_bottom_name'>" +list.product_group_bottom_name+ "</td>"
		               			+ "</tr>";
		             
					$("#modal-body > table").append(result);
				}
			})
			.fail(function() {
				$("#modal-body > table").append("<h3>요청 실패!</h3>");
			});
		}
		
		$(function() {
			
			$("#buyer_table").on('click','tr',function(){
				   let td_arr = $(this).find('td');
				   console.log(td_arr);
				   
//				   $('#no').val($(td_arr[0]).text());
				   let no = $(td_arr[0]).text();
//				   $('#name').val($(td_arr[1]).text());
				   let cust_name = $(td_arr[1]).text();
				   console.log(cust_name);
				   
				   // td 클릭시 모달 창 닫기
				   $('##modalDialogScrollable_search_product_cd').modal('hide');
				   $("#cust_name").val(cust_name);
			});	   
			
			// td 클릭 시 해당 value 가져오기
			$("#emp_table").on('click','tr',function(){
				   let td_arr = $(this).find('td');
				   console.log(td_arr);
				   
//		 		   $('#no').val($(td_arr[0]).text());
				   let emp_no = $(td_arr[0]).text();
				   let dept_cd = $(td_arr[1]).text();
				   let emp_name = $(td_arr[2]).text();
				   console.log(emp_name);
				   
				   // td 클릭시 모달 창 닫기
				   $('##modalDialogScrollable_search_product_cd').modal('hide');
				   $("#emp_name").val(emp_name);
				   $("#emp_num").val(emp_num);
			});	   
		
		
	});

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
      <h1>출고 관리</h1>
    </div><!-- End Page Title -->
    	
    	<div class="modal fade" id="modalDialogScrollable_complete" tabindex="-1">
                <div class="modal-dialog modal-dialog-scrollable">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body" style="text-align: center;">
<!--                      	<div class="input-group mb-6"> -->
<!-- 			        	 </div> -->
			        	 <table class='table table-hover' id="buyer_table" style="margin-left: auto; margin-right: ">
				                <tr>
				                	<th scope="col">품목코드</th>
				                	<th scope="col">품목명[규격]</th>
				                	<th scope="col">출고예정수량</th>
				                	<th scope="col">미출고수량</th>
				                </tr>
<%-- 				                <c:forEach items="${outProdList }" var="outProdList"> --%>
<!-- 					                <tr> -->
<%-- 					                	<td>${outProdList.out_product_cd }</td> --%>
<%-- 					                	<td>${outProdList.out_product_name }</td>  --%>
<%-- 					                	<td>${outProdList.out_shedule_qty }</td> --%>
<%-- 					                	<td>${outProdList.out_shedule_qty - outProdList.out_qty }</td> --%>
<!-- 					                </tr> -->
<%-- 				                </c:forEach> --%>
			        	 </table>

                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
              </div><!-- End Modal Dialog Scrollable-->
    	
            <div class="card mb-4">
                <div class="card-header">
                     입고 예정 목록
                     <button class="btn btn-primary" onclick="location.href='OutRegisterForm'" style="float: right;">신규등록</button>
                 </div>
                 <div class="card-body">
                 <table class="table table-hover" style="padding: 20px;">
		                <thead>
		                  <tr>
		                    <th scope="col">#</th>
		                    <th scope="col"><input type="checkbox" id="chkAll"></th>
		                    <th scope="col">입고예정번호</th>
		                    <th scope="col">보낸곳명</th>
		                    <th scope="col">품목명</th>
		                    <th scope="col">납기일자</th>
		                    <th scope="col">입고예정수량</th>
		                    <th scope="col">입고수량</th>
		                    <th scope="col">미입고수량</th>
		                    <th scope="col">적요</th>
		                  </tr>
		                </thead>
		                <tbody>
		                <c:forEach items="${list }" var="list"> 
		                  <tr>
		                    <th scope="row"></th>
		                    <td><input type="checkbox" name="chk"></td>
		                    <td>${list.IN_SCHEDULE_CD }</td>
		                    <td>${list.PRODUCT_CD }</td>
		                    <td>${list.PRODUCT_NAME }</td>
		                    <td>${list.IN_DATE }</td>
		                    <td>${list.IN_SCHEDULE_QTY }</td>
		                    <td>${list.IN_QTY }</td>
		                    <td>${list.IN_SCHEDULE_QTY - list.IN_QTY}</td>
		                    <td>${list.REMARKS }</td>
		                  </tr>
		                </c:forEach>
		                </tbody>
		              </table>
		              <button class="btn btn-primary" onclick="in_schedule_process()">입고처리</button>
		             </div>
            </div>
            
</main>		
  
</body>
</html>