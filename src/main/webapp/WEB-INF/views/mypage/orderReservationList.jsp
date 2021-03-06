<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"  
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  /> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>카페어디가-마이페이지</title>
		
		<!-- google font -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
	    
		<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	    
	    <!-- user defined -->
	    <script type="text/javascript" src="${contextPath}/resources/js/mypage/orderHistory.js"></script>
	    
		<style>
			#register_section{
				margin-left:150px;
				margin-right:150px;
			}
			.page_title{
				font-family:'Malgun Gothic';
				font-weight: bold;
			    font-size:40px;
			    color:black;		
			}
			.register_label{
				font-family: 'Jua', sans-serif;
			    font-size:20px;
			    color:black;		
			}
			.authority_level_select_label{
				font-family: 'Jua', sans-serif;
			    font-size:18px;
			    color:black;		
			}
			.phonenum-input{
				width: 50px;
				border: 1px solid #b9b9b9;
				border-radius:5px;
			}
			
			.input_box{
				width:100%;
				height:25px;
				border: 1px solid #b9b9b9;
				border-radius:5px;
			}
			.input_box:disabled{
				background-color: #ebebeb;
			}
			.input_box_mileage{
				width:100px;
				height:25px;
				border: 1px solid #b9b9b9;
				border-radius:5px;
			}
			.profile_photo_preview{
				width: 140px;
				height: 140px;
			}
			.submit_button{
				width:300px;
				background-color:#1F364B;
				font-family: 'Jua', sans-serif;
			    font-size:20px;
			    color:white;
			    border: 1px solid white;
			    border-radius:5px;
			}
			.form_wrapper{
				width:1200px;		
				margin-top:50px;
				margin-bottom:0px;
				margin-left:0px;
				margin-right:0px;
				

			}
			.form_wrapper-inner{
			
				width:500px;
				
			}
			.input_container{
				display:flex;
				justify-content:center;
				width:95%;
				border: 1px solid #b9b9b9;
				border-radius:5px;
				margin-top:10px;
			}
			.content_wrapper{
				margin-top:20px;
				margin-bottom:50px;
			}
			
			
			.image_container{
				display:flex;
				justify-content: center
			}
			#submit_button_wrapper{
				display:flex;
				justify-content:center;
				margin-top:10px;
			}
			.input_container_inner{
				width:95%;
				margin-bottom:10px;
			}
			.input_container_outer{
				width:100%;
				display:flex;
				justify-content:center;
			}
			.a-no-text-decoration{
				text-decoration:none;
			}
			.a-color-black{
				color:black;
			}
			.a-color-black:hover, .a-color-black:visited {
				color:black;
			}				
			.list-style-none{
				list-style: none;
			}
			#content_wrapper_inner{
				display:flex;
				margin-top:50px;
			}
			.left-nav_font-style{
				font-family:'Malgun Gothic';
				font-weight: bold;
				font-size:20px;
			}
			#left-nav-ul{
				width:320px;
				margin-left:40px;
			}
			.orderlistDeleteButton{
				background-color:#E50F0F;
				font-family: 'Jua', sans-serif;
			    font-size:15px;
			    color:white;
			    border: 1px solid white;
			    border-radius:5px;
			}
			#orderListTable{
				width:100%;
				margin-bottom:20px;
			}
			#orderListTable tr,#orderListTable th, #orderListTable td{
				border: 1px solid #b9b9b9;
			}
			#orderListTable th, #orderListTable td{
				margin:0px; 
			}
			#orderListTable th{
				background-color: #6e7580;
				color:white;
			}
			#orderListTable td *{
				
				
			}
			.cancelbutton_td{
				width:60px;
				text-align:center;
			}
			.pagination_wrapper{
				display:flex;
				justify-content:center;
			}
			.searchFormWrapper{
				float:right;
				margin-bottom:20px;
			}
			#searchButton{
				background-color:#1F364B;
				font-family: 'Jua', sans-serif;
			    font-size:17px;
			    color:white;
			    border: 1px solid white;
			    border-radius:5px;
			}
			#searchInputBox{
				width:200px;
				height:25px;
			}
			.orderLink{
				margin-left:3px;
			}
			.orderPriceIndicator{
				margin-left:3px;
				margin-bottom:0px;
			}
			.orderDateIndicator{
				margin-left:3px;
				margin-bottom:0px;
			}
		</style>
		
		<script>
			function select_profile_photo(){
				var profile_preview = document.getElementById("profile_photo_preview");
				var profile_photo = document.getElementById("profile_photo");
				profile_photo.click();
			}
		</script>
	</head>
	<body>
		<section id="register_section">
			<div class="content_wrapper">
				<h1 class="page_title">마이페이지</h1>
				<div id="content_wrapper_inner">
					<div id="nav-left-menu-wrapper">
						<ul id="left-nav-ul">
							<li class="list-style-none"><a class="a-no-text-decoration a-color-black left-nav_font-style" href="${contextPath}/mypage/userinfo.do">회원정보</a></li>
							<li class="list-style-none"><a class="a-no-text-decoration a-color-black left-nav_font-style" href="${contextPath}/mypage/wishlist.do">찜한카페목록</a></li>
							<li class="list-style-none"><a class="a-no-text-decoration a-color-black left-nav_font-style" href="${contextPath}/mypage/cartList.do">장바구니조회</a></li>
							<li class="list-style-none"><a class="a-no-text-decoration a-color-black left-nav_font-style" href="${contextPath}/mypage/orderReservationList.do">주문/예약내역조회</a></li>
						</ul>
					</div>
					<div class="form_wrapper">
						<div class="searchFormWrapper">
							<label>정렬</label>
							<select id="sortingOptionSelector">
								<option>최근순</option>
							</select>
							<label>주문현황</label>
							<select id="orderStatusSelector">
								<option>전체</option>
								<option>결제완료</option>
								<option>주문처리중</option>
								<option>주문처리완료</option>
							</select>
							<input id="searchInputBox" type="text">
							<button id="searchButton">검색</button>
						</div>
						<div class="tableWrapper">
						<table id="orderListTable">
							<tr>
								<th>No.</th>
								<th>주문/예약명</th>
								<th width="110px">결제금액</th>
								<th width="170px">결제시각</th>
								<th width="110px">주문현황</th>
								<th></th>
							</tr>
							<c:forEach var="orderMap" items="${orderMapList}" varStatus="status">
								<tr>
									<!-- <td>1</td> -->
									<td>${status.count}</td>
									<td><a class="orderLink" href="${contextPath}/orderAndReservation/OrderAndReservationDetail.do?orderAndReservation_id=${orderMap.order_id}">${orderMap.representedOrderName}</a></td>
									<td><p class="orderPriceIndicator">${orderMap.totalPrice}</p></td>
									<td><p class="orderDateIndicator"><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${orderMap.orderDate}" /></p></td>
									<td>
										<c:if test="${orderMap.orderStatus=='completed'}">
											결제완료
										</c:if>
										<c:if test="${orderMap.orderStatus=='canceled'}">
											주문취소
										</c:if>
									</td>
									<td class="cancelbutton_td"><button class="orderlistDeleteButton" onclick="cancelOrderAndReservation('${contextPath}', ${orderMap.order_id})">취소</button></td>
								</tr>
							</c:forEach>
						</table>
						</div>
						<div class="pagination_wrapper">
							<ul class="pagination pagination-sm">
							    <li class="page-item"><a class="page-link" href="#">Previous</a></li>
							    <li class="page-item"><a class="page-link" href="#">1</a></li>
							    <li class="page-item"><a class="page-link" href="#">2</a></li>
							    <li class="page-item"><a class="page-link" href="#">3</a></li>
							    <li class="page-item"><a class="page-link" href="#">4</a></li>
							    <li class="page-item"><a class="page-link" href="#">5</a></li>
							    <li class="page-item"><a class="page-link" href="#">Next</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</section>
	</body>
</html>