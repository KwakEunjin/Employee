<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<!DOCTYPE html>
<html lang="ko">
<head>
<title>append.jsp</title>

</head>
<body class="container">
<a class="btn btn-primary" href="#/list">list...</a>
<div class="panel panel-default">
	<div class="panel-heading">도시 입력</div>
	
	<div class="panel-body">
	<form>
		<!-- Name -->
		<div class="form-group">
		<label for="name">Name : </label>
		<input id="name"
			   type="text" 
			   class="form-control"/>
		</div>
		<!-- CountryCode -->
		<div class="form-group">
		<label for="countryCode">CountryCode : </label>
		<input id="countryCode"
			   type="text" 
			   class="form-control"/>
		</div>
		<!-- District -->
		<div class="form-group">
		<label for="district">District : </label>
		<input id="district"
			   type="text" 
			   class="form-control"/>
		</div>
		<!-- Population -->
		<div class="form-group">
		<label for="population">Population : </label>
		<input id="population"
			   type="number" 
			   class="form-control"/>
		</div>
		
		<!-- Submit -->
		<div class="form-group">
		<input type="submit" 
			   value="확인"
			   class="btn btn-primary"/>
		</div>

		
	</form>
	</div>
</div>

</body>
</html>




