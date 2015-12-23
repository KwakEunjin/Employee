<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>

</head>
<title>append.jsp</title>
<body class="container">
<!-- bootstrap의 grid system을 사용 하기 위해 container 필요. -->
<a class="btn btn-primary" href="#/list">list...</a>			<!-- http://localhost:8080/Employee/city/main.html#/list 로 간다. -->
	<div class="row">								<!-- class="row"  - grid system. 아래에서 col-sm-6 col-sm-offset-3 이런식으로 칸을 주기 위해 설정 -->
		<div class="col-sm-6 col-sm-offset-3">									<!-- small size에서는 6칸, 왼쪽에서 offset은 3칸 -->
		<div class="panel panel-default">
			<div class="panel-heading">도시 입력</div>
			<pre>{{city}}</pre>									<!-- city로 하면 text항목에 친 모든 항목이 뜸.city.name만 하면 name항목만 뜸 -->
			<div class="panel-body">
				<form name="cityForm" novalidate="novalidate" data-ng-submit="submit()">		<!-- novalidate - 입력값에 대해 검사함. -->
					
					
					<!--  Name -->
					<div class="form-group">					<!-- 부트스트랩 이용을 위해 form-group -->
						<label for="name">Name :</label>		<!-- label을 클릭하면 input으로 커서가 간다. -->
						<input id="name"
							   type="text" 
							   class="form-control"
							   name="name" 
							   required="required"	
							   data-ng-model="city.name"		
							   ng-maxlength="35"	
							   > 		
							  <!--  data-ng-model 입력값을 저장함.angular에서 작동 -->
							  <!-- 부트스트랩 이용을 위해  하위 input은 form-control -->
							  <!-- ng-model의 값은 angular를 위해 만든 입력된 값을 칭함 -->
						<div>cityForm.name.$invalid = {{cityForm.name.$invalid}}</div>
						<div>cityForm.name.$error.required = {{cityForm.name.$error.required}}</div>
						<div>cityForm.name.$error.maxlength = {{cityForm.name.$error.maxlength}}</div>
						<div data-ng-show="cityForm.name.$dirty">				<!-- 한번이라도 입력이 된이후 발생 <-> 반대는 $pristine-->
							<div  class="alert alert-warning" data-ng-show="cityForm.name.$error.required">필수 입력 항목입니다.</div>		<!-- ""안의 값이 true면 글자가 보임 -->
							<div class="alert alert-warning" data-ng-show="cityForm.name.$error.maxlength">35자리까지 입력가능합니다.</div>
						</div>
					</div>
					
					
					<!-- CountryCode -->
					<div class="form-group">	
						<label for="countryCode">CountryCode :</label>		
						<input id="countryCode" 
							   type="text" 
							   class="form-control" 
							   name="countryCode" 
							   required="required"	
							   data-ng-model="city.countryCode"
							   ng-maxlength="3"
							   ng-minlength="3"
							   >  
						<div>cityForm.countryCode.$invalid = {{cityForm.countryCode.$invalid}}</div>
						<div>cityForm.countryCode.$error.required = {{cityForm.countryCode.$error.required}}</div>
						<div>cityForm.countryCode.$error.maxlength = {{cityForm.countryCode.$error.maxlength}}</div>
						<div>cityForm.countryCode.$error.maxlength = {{cityForm.countryCode.$error.minlength}}</div>
						<div data-ng-show="cityForm.countryCode.$dirty">				
							<div class="alert alert-warning" data-ng-show="cityForm.countryCode.$error.required">필수 입력 항목입니다.</div>		
							<div class="alert alert-warning" 
								 data-ng-show="cityForm.countryCode.$error.maxlength || cityForm.countryCode.$error.minlength">3자리만 입력가능합니다.</div>
						</div>
					</div>
					
					
					<!-- District -->
					<div class="form-group">	
						<label for="district">District :</label>		
						<input id="district" 
							   type="text" 
							   class="form-control" 
							   name="district" 
							   required="required"	
							   data-ng-model="city.district"
							   ng-maxlength="20"
							   >
						<div>cityForm.district.$invalid = {{cityForm.district.$invalid}}</div>
						<div>cityForm.district.$error.required = {{cityForm.district.$error.required}}</div>
						<div>cityForm.district.$error.maxlength = {{cityForm.district.$error.maxlength}}</div>
						<div data-ng-show="cityForm.district.$dirty">				
							<div class="alert alert-warning" data-ng-show="cityForm.district.$error.required">필수 입력 항목입니다.</div>		
							<div class="alert alert-warning" data-ng-show="cityForm.district.$error.maxlength">20자리까지 입력가능합니다.</div>
						</div>		    
					</div>
					
					
					<!-- Population -->
					<div class="form-group">	
						<label for="population">Population :</label>		
						<input id="population" 
							   type="number" 
							   class="form-control"
							   name="population" 
							   required="required"	
							   data-ng-model="city.population"
							   data-ng-min="0"
							   data-ng-max="2147483647"
							   >  
							   <!-- 타입이 숫자라서 min or max로 설정해야 함.2147483647은 int 최대값 -->
						<div>cityForm.population.$invalid = {{cityForm.population.$invalid}}</div>
						<div>cityForm.population.$error.required = {{cityForm.population.$error.required}}</div>
						<div>cityForm.population.$error.number = {{cityForm.population.$error.number}}</div>	<!-- 숫자만 입력 하게 함 -->
						<div>cityForm.population.$error.max = {{cityForm.population.$error.max}}</div>			<!-- 숫자라서 max,min으로 변경 -->
						<div>cityForm.population.$error.min = {{cityForm.population.$error.min}}</div>
						<div data-ng-show="cityForm.population.$dirty">				
							<div class="alert alert-warning" data-ng-show="cityForm.population.$error.required">필수 입력 항목입니다.</div>	
							<div class="alert alert-warning" data-ng-show="cityForm.population.$error.number">숫자만 입력 가능합니다.</div>	
							<div class="alert alert-warning" data-ng-show="cityForm.population.$error.max">최대값을 초과하였습니다.</div>
							<div class="alert alert-warning" data-ng-show="cityForm.population.$error.min">최소값은 0입니다.</div>
						</div>
					</div>
					
					<!-- Submit -->
					<div class="form-group">	
						<input type="submit" 
							   class="btn btn-primary" 
							   value="확인" 
							   ng-disabled="cityForm.$invalid"
							   >  <!-- invalid면 submit 불가능  -->
							   <div>cityForm.$invalid = {{cityForm.$invalid}}</div>
					</div>
						
					
				</form>
			
			</div>
		</div>
		</div>
	</div>
</body>
</html>