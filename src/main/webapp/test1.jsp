<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" trimDirectiveWhitespaces="true"%>
<!-- ssession 이 안만들어 지도록, trim - 웹에서 source보기에서 빈공간 없게 보이게 함. -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko" data-ng-app="employeeApp">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">

<%@ include file="/WEB-INF/view/common.jspf"%><!-- jspf는 조각 부분을 의미함. -->



<!-- https://angular-ui.github.io/bootstrap/ -->


<title>template.jsp</title>
<script type="text/javascript">
	var depts = [ 'ngRoute', 'ngAnimate', 'ngTouch', 'angular-loading-bar',
			'ui.bootstrap' ];
	var app = angular.module("employeeApp", depts);

	app.controller("mainController", function($scope, $http) {
		console.log("mainController...");

		$scope.rate = 3;
		$scope.max = 5;
		$scope.isReadonly = false;

		$scope.hoveringOver = function(value) {
			$scope.overStar = value;
			$scope.percent = 100 * (value / $scope.max);
		};

		$scope.ratingStates = [ {
			stateOn : 'glyphicon-ok-sign',
			stateOff : 'glyphicon-ok-circle'
		}, {
			stateOn : 'glyphicon-star',
			stateOff : 'glyphicon-star-empty'
		}, {
			stateOn : 'glyphicon-heart',
			stateOff : 'glyphicon-ban-circle'
		}, {
			stateOn : 'glyphicon-heart'
		}, {
			stateOff : 'glyphicon-off'
		} ];

	});
</script>
</head>
<body data-ng-controller="mainController" class="container">
	<!-- bootstrap의 grid system을 사용 하기 위해 container 필요. 최상단은 sitemesh의 container-->
	<div>
		<h4>Default</h4>
		<uib-rating ng-model="rate" max="5" readonly="isReadonly"
			on-hover="hoveringOver(value)" on-leave="overStar = null"
			titles="['one','two','three']" aria-labelledby="default-rating"></uib-rating>
		<span class="label"
			data-ng-class="{'label-warning': percent<30, 'label-info': percent>=30 && percent<70, 'label-success': percent>=70}"
			data-ng-show="overStar && !isReadonly">{{percent}}%</span>

		<pre style="margin: 15px 0;">Rate: <b>{{rate}}</b> - Readonly is: <i>{{isReadonly}}</i> - Hovering over: <b>{{overStar || "none"}}</b>
		</pre>

		<button type="button" class="btn btn-sm btn-danger"
			data-ng-click="rate = 0" ng-disabled="isReadonly">Clear</button>
		<button type="button" class="btn btn-sm btn-default"
			data-ng-click="isReadonly = ! isReadonly">Toggle Readonly</button>
		<hr />



		<h4>Custom icons</h4>
		<div data-ng-init="x = 5">
			<uib-rating ng-model="x" max="15" state-on="'glyphicon-ok-sign'"
				state-off="'glyphicon-ok-circle'" aria-labelledby="custom-icons-1"></uib-rating>
			<b>(<i>Rate:</i> {{x}})
			</b>
		</div>
		<div data-ng-init="y = 2">
			<uib-rating ng-model="y" rating-states="ratingStates"
				aria-labelledby="custom-icons-2"></uib-rating>
			<b>(<i>Rate:</i> {{y}})
			</b>
		</div>
	</div>


</body>
</html>