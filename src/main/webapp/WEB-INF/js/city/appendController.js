/**
 * @author java
 */


app.config(function($routeProvider) {			/* maingController가 실행되고 부분 화면을 넣기 위해 route가 실행 된다. */
		console.log("/append config...");		
		
		$routeProvider.when("/append",{					/* http://localhost:8080/Employee/city/main.html#/list */
			controller: "appendController",			/* var detailController 객체 호출 */
			templateUrl: "append.html"				
	/*http://localhost:8080/Employee/city/main.html 의 상대 경로에서 불러온다.즉 같은 경로 city/detail.html을 불러온다.*/
		});		
	});
	
app.controller('appendController', function($scope, $http, $location, URL) { /* listController 호출 */
	console.log("appendController...");
	console.log("URL.POST_ITEM_APPEND = " + URL.POST_ITEM_APPEND);
	
	$scope.$parent.title = "Append City View";			//이것의 부모의 title 설정
	
	$scope.city = {};									//city객체 밑에 자동으로 binding시킨다. append.jsp내의 ng-model 내용
	
	$scope.submit = function () {
		var ajax = $http.post(URL.POST_ITEM_APPEND,{	
			//포스트 방식으로 보냄.CityController에서 city/로 받는데 post(insert)로 받는다.get으로 넘기면 조회가 된다.
			name : $scope.city.name,
			district : $scope.city.district,
			countryCode : $scope.city.countryCode,
			population : $scope.city.population
		});
		
		ajax.then(function(value) {						/*3개 뜨는데 마지막 function은 필요 없다.value는 위의 ajax로 실행시킨 쿼리의 return값이 자동으로 입력 된다.*/
			$location.path("/list");
		}, function(reason) {
			console.dir(reason);
			$scope.city = reason.data;
		});
	};
	
});
