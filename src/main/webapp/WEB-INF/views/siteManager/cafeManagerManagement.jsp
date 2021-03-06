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
	    <script src="${contextPath}/resources/js/jquery-3.6.0.min.js"></script>
	    <script src="${contextPath}/resources/js/siteManager/cafeManagerManagement.js"></script>
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
			.memberDeleteButton{
				background-color:#E50F0F;
				font-family: 'Jua', sans-serif;
			    font-size:15px;
			    color:white;
			    border: none;
			    border-radius:5px;
			}
			.memberReturnButton{
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
			var prevSearchWords = "${userSearchParameter.searchWords}";
			var prevSearchCondition = "${userSearchParameter.searchCondition}";
			var prevJoin_stateOption = "${userSearchParameter.join_state}";
			var sortingOption = "${userSearchParameter.sortingOption}";
			
			window.onload= function(){
				initSearchWords();
				initSearchCondition();
				initJoin_stateOption();
				initSortingOption();
			}
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
							<select id="sortingOptionSelector">
								<option>최근가입순</option>
								<option>이름순</option>
								<option>ID순</option>
							</select>
							<label>가입현황</label>
							<select id="joinStateSelector">
								<option>전체</option>
								<option>회원가입</option>
								<option>회원탈퇴</option>
								<option>강퇴</option>
							</select>
							<label>검색</label>
							<select id="searchOptionSelector">
								<option>전체</option>
								<option>ID</option>
								<option>이름</option>
								<option>이메일</option>
								<option>전화번호</option>
								<option>사업자번호</option>
							</select>
							<input id="searchInputBox" type="text">
							<button id="searchButton" onclick="searchUser('${contextPath}')">검색</button>
						</div>
						<div style="float:left;">
							<button id="selectedElementCancelButton">선택회원강퇴</button>
						</div>
						<div class="tableWrapper">
						<table id="orderListTable">
							<tr>
								<th width="20px"></th>
								<th width="30px">No.</th>
								<th width="90px">ID</th>
								<th width="50px">이름</th>
								<th width="100px">이메일</th>
								<th width="90px">전화번호</th>
								<th width="60px">사업자번호</th>
								<th width="120px">가입일</th>
								<th width="50px">가입상태</th>
								<th width="60px"></th>
								<th width="60px"></th>
							</tr>
							<c:forEach var="cafeManager" items='${cafeManagerList}'>
								<tr>
									<td style="text-align:center;"><input type="checkbox"></td>
									<td><fmt:formatNumber type="number" value="${cafeManager.rownum}"></fmt:formatNumber></td>
									<td>${cafeManager.user_id}</td>
									<td>${cafeManager.user_name}</td>
									<td>${cafeManager.user_email}</td>
									<td>${cafeManager.phonenum1}-${cafeManager.phonenum2}-${cafeManager.phonenum3}</td>
									<td>${cafeManager.company_registration_number}</td>
									<td>
										<fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${cafeManager.join_date}" />
										<input type="hidden" name="user_id" value="${cafeManager.user_id}">
									</td>
									<td class="join_status_td">
										<c:if test="${cafeManager.join_state=='joined'}">
											회원가입
										</c:if>
										<c:if test="${cafeManager.join_state=='quited'}">
											회원탈퇴
										</c:if>
										<c:if test="${cafeManager.join_state=='banned'}">
											강제탈퇴
										</c:if>
										
									</td>
									<td class="cancelbutton_td"><button class="memberDeleteButton" onclick="banUser('${contextPath}', this.parentNode.parentNode)">강제탈퇴</button></td>
									<td class="cancelbutton_td"><button class="memberReturnButton" onclick="reRegisterUser('${contextPath}', this.parentNode.parentNode)">상태복귀</button></td>
								</tr>
							</c:forEach>
						</table>
						</div>
						<div class="pagination_wrapper">
							<ul class="pagination pagination-sm">
							   <c:if test="${searchCondition.chapter<=1}">
							    	<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
							    </c:if>
							    <c:if test="${searchCondition.chapter>1}">
							    	<li class="page-item"><a class="page-link" onclick="searchUser('${contextPath}', ${searchCondition.chapter-1}, 5)">Previous</a></li>
							    </c:if>
							    <c:forEach begin="1" end="5" step="1" varStatus="status">
							   		<li class="page-item"><a class="page-link" onclick="searchUser('${contextPath}', 1, ${status.index})">${status.index}</a></li>
							    </c:forEach>
							    <li class="page-item"><a class="page-link" onclick="searchUser('${contextPath}', ${searchCondition.chapter+1}, 1)">Next</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</section>
	</body>
</html>