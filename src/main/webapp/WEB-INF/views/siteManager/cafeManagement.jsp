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
		<title>카페어디가-사이트관리자</title>
		<link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
	    
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
			.cafeDeleteButton{
				background-color:#E50F0F;
				font-family: 'Jua', sans-serif;
			    font-size:15px;
			    color:white;
			    border: none;
			    border-radius:5px;
			}
			.cafeReturnButton{
				background-color:#00ff80;
				font-family: 'Jua', sans-serif;
			    font-size:15px;
			    color:white;
			    border: none;
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
				margin-bottom:5px;
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
			#selectedElementCancelButton{
				
				background-color:#E50F0F;
				font-family: 'Jua', sans-serif;
			    font-size:17px;
			    color:white;
			    border: 1px solid white;
			    border-radius:5px;
			}
		</style>
		
		<script>
			
		</script>
	</head>
	<body>
		<section id="register_section">
			<div class="content_wrapper">
				<h1 class="page_title">사이트관리자</h1>
				<div id="content_wrapper_inner">
					<div id="nav-left-menu-wrapper">
						<ul id="left-nav-ul">
							<li class="list-style-none"><a class="a-no-text-decoration a-color-black left-nav_font-style" href="${contextPath}/siteManager/userManagement.do">회원관리</a></li>
							<li class="list-style-none"><a class="a-no-text-decoration a-color-black left-nav_font-style" href="${contextPath}/siteManager/cafeManagerManagement.do">점주관리</a></li>
							<li class="list-style-none"><a class="a-no-text-decoration a-color-black left-nav_font-style" href="${contextPath}/siteManager/cafeManagement.do">점포관리</a></li>
							<%-- <li class="list-style-none"><a class="a-no-text-decoration a-color-black left-nav_font-style" href="${contextPath}/siteManager/mainPageManagement.do">메인페이지관리</a></li> --%>
						</ul>
					</div>
					<div class="form_wrapper">
						<div class="searchFormWrapper">
							<label>정렬</label>
							<select id="orderOptionSelector">
								<!-- <option value="recent">최근등록순</option> -->
								<option value="username">점포명순</option>
								<option value="cafename">점주명순</option>
							</select>
							<label>등록현황</label>
							<select id="businessStateSelector">
								<option>전체</option>
								<option value="open">영업</option>
								<option value="close">휴업</option>
								<option value="banned">강제휴업</option>
							</select>
							<label>검색</label>
							<select id="searchConditionSelector">
								<option value="all">전체</option>
								<option value="cafename">점포명</option>
								<option value="username">점주명</option>
								<option value="business_number">사업자번호</option>
							</select>
							<input id="searchInputBox" type="text">
							<button id="searchButton">검색</button>
						</div>
						<div style="float:left;">
							<button id="selectedElementCancelButton">선택점포삭제</button>
						</div>
						<div class="tableWrapper">
						<table id="orderListTable">
							<tr>
								<th></th>
								<th>No.</th>
								<th>점포명</th>
								<th>점주명</th>
								<th>주소</th>
								<th>전화번호</th>
								<th>사업자번호</th>
								<!-- <th width="160px">등록일</th> -->
								<th width="110px">등록현황</th>
								<th></th>
								<th></th>
							</tr>
							<c:forEach var="cafe" items="${cafeList}">
								<tr>
								<td style="text-align:center;"><input type="checkbox"></td>
								<td><fmt:formatNumber type="number" value="${cafe.rownum}"></fmt:formatNumber></td>
								<td><a href="${contextPath}/cafe/cafe_detail.do?cafe_id=${cafe.cafe_id}">${cafe.cafe_name}</a></td>
								<td>${cafe.user_name}</td>
								<td>${cafe.cafe_location1} ${cafe.cafe_location2}</td>
								<td>${cafe.phonenum1}-${cafe.phonenum2}-${cafe.phonenum3}</td>
								<td>${cafe.company_registration_number}</td>
								<%-- <td><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${cafe.orderDate}" /></td> --%>
								<td>점포등록</td>
								<td class="cancelbutton_td"><a href="#"><button class="cafeDeleteButton">삭제</button></a></td>
								<td class="cancelbutton_td"><a href="#"><button class="cafeReturnButton">복귀</button></a></td>
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