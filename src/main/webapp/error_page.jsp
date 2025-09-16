<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sorry!😞</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link href="css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="container text-center">
<img src="images/user.png" class="img-fluid" alt="User Image">
<h3 class="display-3">Sorry! Something went wrong....</h3>
<%=exception %>
<br>
<a href="Home.jsp" class="btn primary-bg btn-lg text-white mt-4">Home</a>
</div>
</body>
</html>