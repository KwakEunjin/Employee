<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>

</head>
<body class="container">
<!-- bootstrap의 grid system을 사용 하기 위해 container 필요. -->

	<div class="tabel-responsive">
		<ul class="pagination">
			<li><a href="" data-ng-click="prevClick(paging.firstPage-1)">Prev</a></li>
			<li data-ng-repeat="city in citys">
				<a href=""data-ng-click="pageClick(paging.firstPage + $index)">{{paging.firstPage	+ $index}}</a></li>
			<li><a href="" data-ng-click="nextClick(paging.lastPage+1)">Next</a></li>
		</ul>
		
		<table class="table table-striped table-hover">
			<!-- table-hover는 마우스 움직이면 리스트 색이 변한다. -->
			<thead>
				<tr><td><a href="#/append" class="btn btn-primary">Append</a></td></tr>
			
				<tr>
					<th>No</th>
					<th>ID</th>
					<th>Name</th>
					<th>CountryCode</th>
					<th>District</th>
					<th>Population</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<tr data-ng-repeat="city in citys">
					<td>{{$index+1}}</td>
					<td><a href="#/detail/{{city.id}}"> {{city.id}}</a></td>	
					<!-- detailController의 $routeProvider.when("/detail"에서 대응.  -->
					<!-- 상대 경로로써 http://localhost:8080/Employee/city/main.html의 뒤에 #/detail이 붙는다. 기존URL에 #xxxx가 붙어 있어도 자동으로 인식 되나 봄 -->
					<td>{{city.name}}</td>
					<td>{{city.countryCode}}</td>
					<td>{{city.district}}</td>
					<td>{{city.population}}</td>
					<td><a href="#/modify/{{city.id}}" class="btn btn-success">Modify</a></td>
					<td><a href="#/delete/{{city.id}}" class="btn btn-info">Delete</a></td>
				</tr>
			</tbody>
		</table>
	</div>

	<hr>
	<div class="form-group">
		<textarea rows="20" class="form-control">
					{{citys}}
					{{paging}}
				</textarea>
	</div>
	<!-- 위에 form-group을 주고 form-control -> width를 전체 차지함. -->
</body>
</html>