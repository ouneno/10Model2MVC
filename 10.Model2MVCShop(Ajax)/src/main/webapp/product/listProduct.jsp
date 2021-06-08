<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	<title>상품 목록 조회</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">

	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${! empty menu && menu == 'manage' ? 'manage' : 'search'}").submit();
	}
	
	
		$(function() {
		 
			// 검색 Event 연결처리부분
			$( "td.ct_btn01:contains('검색')" ).on("click" , function() {
				fncGetList(1);
				});
			
			}); 

		$(function() {
			
			$(".ct_list_pop:nth-child(4n)" ).css("background-color" , "whitesmoke");
			// 10, 14. 18. 22. 26
			
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			
				$(".manage").on("click", function() {
					
					//let prodNo=$(this).attr(product.prodName);
					//let menu=$(this).attr("class");
					//alert(prodNo);
					//alert(menu);
					
					//self.location = "/product/updateProductView?prodNo=${product.prodNo}&menu="+menu;
					self.location = "/product/updateProductView?prodNo="+$(this).attr('menu');
					
				});
				
				$(".search").on("click", function() {
					
					//let menu=$(this).attr("class");
					//alert(menu);
					
					self.location = "/product/getProduct?prodNo="+$(this).attr('menu');
				});
			

		
			
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
	 });
	 
</script>

</head>
<body bgcolor="#ffffff" text="#000000">
<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">					
<!----------------------------------------------------------- 상품관리조회 ------------------------------------------------------------------------->
						<option value="manage">${ ! empty menu && menu=='manage' ? "상품관리" : "상품목록조회"}</option>
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">		
			<select name="searchCondition" class="ct_input_g" style="width:80px">
<!----------------------------------------------------------- inputBox ------------------------------------------------------------------------->				
				<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
				<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
				
				</select>
<!----------------------------------------------------------- SquereBox ------------------------------------------------------------------------->				
				<input 	type="text" name="searchKeyword" 
						value="${! empty search.searchKeyword ? search.searchKeyword : ""}"  
						class="ct_input_g" style="width:200px; height:20px" > 
		</td>
		
<!----------------------------------------------------------- SearchKeyword ------------------------------------------------------------------------->				
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						검색</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	
<!----------------------------------------------------------- 전체 건수, 현재페이지 ------------------------------------------------------------------------->			
	<tr>
		<td colspan="11" >
			전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지
		</td>
	</tr>
	
<!------------------------------------------------- No, 상품명, 가격, 등록일, 현재상태 ------------------------------------------------------------------------->	
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">
			상품명<br>
			<h7>(Name Click : 상세정보)</h7>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	
<!-------------------------------------------------------------------------------------------------------------------------->	
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
<!----------------------------------------- bulletin board part --------------------------------------------->		
	<c:set var="i" value="0"/>
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>			
			<td align="left">
						
				<c:choose>		
					<c:when test = "${menu == 'manage'}">					
						<div class="manage" menu="${product.prodNo}">${product.prodName}</div>
					</c:when>
				
					<c:when test = "${menu == 'search'}">
						<div class="search" menu="${product.prodNo}">${product.prodName}</div>
					</c:when>				
				</c:choose>  
				
			<!--	<c:if test = "${menu == 'manage'}">
					<id="manage">${product.prodName}</button>
				</c:if>
				
				<c:if test = "${menu == 'search'}">
					<id="search">${product.prodName}</button>
				</c:if>-->
			</td>
			<td></td>
			<td align="left">${product.price}</td>
			<td></td>			
			<td align="left">${product.regDate}</td>
			<td></td>				
			<td align="left">${product.proTranCode}</td>	
		</tr>
		
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</c:forEach>
</table>

<!----------------------------------------- 게시물 양 옆 이동 단추 만들기 --------------------------------------------->	
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
			 
			<jsp:include page="../common/pageNavigator.jsp"/>	
			 
    	</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>
</div>
</body>
</html>
