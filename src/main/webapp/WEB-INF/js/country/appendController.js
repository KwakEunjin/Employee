/**
 * @author java
 */

app.config(function($routeProvider) {
	console.log("/append config...")
	
	$routeProvider.when("/append", {
		templateUrl: "append.html",
		controller: "appendController"
	});
	
});

app.controller('appendController', function($scope, $http, URL) {
	console.log("appendController...");
	console.log("URL.POST_ITEM_APPEND = " + URL.POST_ITEM_APPEND);
	
	$scope.$parent.title = "Append City View";
	
	
	
});
