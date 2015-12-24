/**
 * @author java
 */

app.config(function($routeProvider) {
	console.log("/list config...")
	
	$routeProvider.when("/list", {
		templateUrl: "list.html",
		controller: "listController"
	});
	
});

app.controller('listController', function($scope, $http, URL) {
	console.log("listController...");
	console.log("URL.GET_PAGE_BASE = " + URL.GET_PAGE_BASE);
	
	$scope.$parent.title = "List City View";
	
	$scope.pageNo = 1;
	$scope.citys = [];
	$scope.paging = {};
	
	$scope.selectPage = function() {
		$http.get(URL.GET_PAGE_BASE + $scope.pageNo).success(function(data, status, headers, config) {
			console.dir(data);
			$scope.citys = data.citys;
			$scope.paging = data.paging;
//	 			alert("success...");
		});
	};
	
	$scope.selectPage();
	
	$scope.prevClick = function(pageNo) {
		console.log("prevClick()... pageNo = " + pageNo);
		$scope.pageNo = pageNo
		$scope.selectPage();
// 			alert("pageNo=" + pageNo);
	};
	
	$scope.pageClick = function(pageNo) {
		console.log("pageClick()... pageNo = " + pageNo);
		$scope.pageNo = pageNo
		$scope.selectPage();
// 			alert("pageNo=" + pageNo);
	};
	
	$scope.nextClick = function(pageNo) {
		console.log("nextClick()... pageNo = " + pageNo);
		$scope.pageNo = pageNo
		$scope.selectPage();
// 			alert("pageNo=" + pageNo);
	};
	
});
