<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false" trimDirectiveWhitespaces="true" %>	 	<!-- ssession 이 안만들어 지도록, trim - 웹에서 source보기에서 빈공간 없게 보이게 함. -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<!DOCTYPE html>
<html lang="ko" data-ng-app="employeeApp">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">

<%@ include file="/WEB-INF/view/common.jspf" %><!-- jspf는 조각 부분을 의미함. -->

<title>main.jsp</title>

<!-- URL Resolve -->
<c:url var="URL_GET_LIST"					value="/city/"/>
<c:url var="URL_GET_ITEM_BASE" 				value="/city/"/>				<!-- /city/{id} -->
<c:url var="URL_GET_PAGE_BASE" 				value="/city/page/"/>			<!-- /city/page/{pageNo} -->

<c:url var="URL_POST_LIST_APPEND" 			value="/city/"/>
<c:url var="URL_POST_ITEM_APPEND" 			value="/city/"/>				

<c:url var="URL_PUT_LIST_MODIFY" 			value="/city/"/>
<c:url var="URL_PUT_ITEM_MODIFY_BASE" 		value="/city/"/>				<!-- /city/{id} -->

<c:url var="URL_DELETE_ITEM_DELETE_BASE" 	value="/city/"/>				<!-- /city/{id} -->

<script type="text/javascript">
	
	var urls = {
			GET_LIST : 						"${URL_GET_LIST}",
			GET_PAGE_BASE : 				"${URL_GET_PAGE_BASE}",
			GET_ITEM_BASE : 				"${URL_GET_ITEM_BASE}",
			
			POST_LIST_APPEND : 				"${URL_POST_LIST_APPEND}",
			POST_ITEM_APPEND : 				"${URL_POST_ITEM_APPEND}",
			
			PUT_LIST_MODIFY : 				"${URL_PUT_LIST_MODIFY}",
			PUT_ITEM_MODIFY_BASE : 			"${URL_PUT_ITEM_MODIFY_BASE}",
			
			DELETE_ITEM_DELETE_BASE : 		"${URL_DELETE_ITEM_DELETE_BASE}"
			
	};
	
	
	
	var depts = ['ngRoute',
				 'ngAnimate',
				 'ngTouch',
				 'angular-loading-bar'           
				];            
	var app = angular.module("employeeApp", depts);
	app.config(function($routeProvider) {
		$routeProvider.otherwise({						
			redirectTo:  "/list"							/* 앵커 테그에서 아무것도 지정 되지 않거나 #으로 되어 있을경우 디폴트로 지정된 곳으로 간다. */
		});
	});
	
	
	app.constant("URL", urls);
	
	app.controller("mainController", function($scope,$http, $location) {		/* $location이 있어야 아래의 location기능 */
		console.log("mainController...");
// 		 $location.path("/list"); 							 listController의 $routeProvider.when("/list" 이 수행됨. 이건 #이 필요 없음...위에서 routeproviser가 지정되서 필요 없게 됐음.
		/* 아래의 data-ng-view로 정보가 들어간다. */
	
		$scope.staticOrFixed = "navbar-static-top";
		$scope.setMenuStyle = function(str) {
			$scope.staticOrFixed = str;
		}
		
		var ajax = $http.get("/Employee/user/logincheck");
		ajax.then(function(value) {
			$scope.loginstatus = value.data;
		});
		
	});														
			
</script>

<c:url var="listController" value="/js/city/listController.js"/>
<c:url var="detailController" value="/js/city/detailController.js"/>
<c:url var="appendController" value="/js/city/appendController.js"/>
<c:url var="modifyController" value="/js/city/modifyController.js"/>
<c:url var="deleteController" value="/js/city/deleteController.js"/>

<script type="text/javascript" src="${listController}"></script>
<script type="text/javascript" src="${detailController}"></script>
<script type="text/javascript" src="${appendController}"></script>
<script type="text/javascript" src="${modifyController}"></script>
<script type="text/javascript" src="${deleteController}"></script>


</head>
<body data-ng-controller="mainController" class="container">	
<!-- bootstrap의 grid system을 사용 하기 위해 container 필요. -->
<!-- 현재 Employee에서 작동하는 최상단 container는 sitemesh부분 임. main, main의 부분page에도 container가 있는데, main은 sitemesh가, 부분 페이지는 angular가 container 부분을 빼준다. main에서 요소 검사 하면 container가 한개인것을 볼수 있다. -->
	<pre>{{loginstatus}}</pre>
	<h1>{{title}}</h1>
	<div data-ng-view>

	</div>

</body>
</html>