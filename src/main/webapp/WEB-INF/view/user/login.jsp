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


<!-- login은 싱글 페이지 이기 떄문에 단독으로 mainController를 사용한다. -->
<title>login.jsp</title>

<c:url var="LOGIN_URL" value="/user/login" />
<c:url var="REDIRECT_URL" value="/city/main.html" />

<script type="text/javascript">
	// 	var LOGIN_URL = "${LOGIN_URL}";
	// 	var REDIRECT_URL = "${REDIRECT_URL}";

	var depts = [ 'ngRoute', 'ngAnimate', 'ngTouch', 'angular-loading-bar' ];
	var app = angular.module("employeeApp", depts);

	app.controller("mainController", function($scope, $http) {
		console.log("mainController...");
		
		
		$scope.$watch("loginstatus", function() {
			console.log("$watch... loginstatus");
			if ($scope.loginstatus == true)
				location.href = '<c:url value ="/user/logout"/>';
		})
		/* 로그인 하고 다음 화면에서 뒤로 가기 누르면 로그아웃 되는 구문. */
		/* 해당 jsp에서 해당 변수가 변경되는 것을 감지. */
		/* 작동 순서 = mainController(1) - navController - ajax - mainController(2)에 적용.
		최종 mainController(2) 이후에 login.jsp가 작동 되어야 하는데
		nav가 끝난 시점에 ajax가 서버로 데이터를 보내는 시간이 걸린다.그래서 nav가 끝난시점에 먼저 login.jsp가 작동됨.
		menu_sider.jsp를 보면 mainController에는 loginstatus변수가 없다. nav에서 지정 했을뿐.
		login.jsp가 실행 되는 시점에는 mainController안의  loginstatus 변수 지정이 없어서 undefined라고 뜸.
		그래서 watch 기능을 써서 loginstatus가 undefined -> true또는 false로 바뀌는 시점(ajax이후)을 계속 watch 하여
		해당 $scope 실행. */
		
		
		
// 		$scope.login = {};				자동으로 만들어 주기떄문에 이항목은 없어도 된다.

		$scope.submit = function() {
			alert("submit...");
			console.log("submit()....");

			var ajax = $http.post("${LOGIN_URL}", {
				email : $scope.login.email,
				password : $scope.login.password
			});
// 			email,password에 입력값을 저장하고,post 방식으로 ${LOGIN_URL}을 실행.
			ajax.then(function(value) {
				/*3개 뜨는데 마지막 function은 필요 없다.value는 위의 ajax로 실행시킨 쿼리의 return값이 자동으로 입력 된다.*/
				/* 성공시 */
				console.dir(value);
				location.href = "${REDIRECT_URL}"; /* 자바 자체의  location 이동 코드 */
			}, function(reason) {
				/* 실패시 */
				console.dir(reason);
				$scope.error = reason.data;
			});
		};
	});
</script>
</head>
<body data-ng-controller="mainController" class="container">
	<!-- bootstrap의 grid system을 사용 하기 위해 container 필요. -->
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<div class="login-panel panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Please Sign In</h3>
					
					<pre>{{login}}</pre>
					<div>{{error.message}}</div>
					
				</div>
				<div class="panel-body">
					<form name="loginForm" novalidate="novalidate"
						data-ng-submit="submit()">
						<!-- novalidate - 입력값에 대해 검사함. -->
						<fieldset>
							<div class="form-group">
								<input class="form-control" placeholder="E-mail" name="email"
									type="email" autofocus required="required"
									data-ng-model="login.email">
								<div
									data-ng-show="loginForm.email.$dirty && loginForm.email.$invalid">
									<div data-ng-show="loginForm.email.$error.required">필수 입력
										항목 입니다.</div>
									<div data-ng-show="loginForm.email.$error.email">이메일 형식이
										아닙니다.</div>
								</div>
							</div>
							<div class="form-group">
								<input class="form-control" placeholder="Password"
									name="password" type="password" required="required"
									data-ng-model="login.password">
								<div
									data-ng-show="loginForm.password.$dirty && loginForm.password.$invalid">
									<div data-ng-show="loginForm.password.$error.required">
										필수 입력 항목 입니다.</div>
								</div>

							</div>
							<div class="checkbox">
								<label> <input name="remember" type="checkbox"
									value="Remember Me">Remember Me
								</label>
							</div>
							<!-- Change this to a button or input when using this as a form -->
							<button type="submit" class="btn btn-lg btn-success btn-block"
								data-ng-disabled="loginForm.$invalid">Login</button>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>