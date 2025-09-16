<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tech.blog.entities.Message" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
body {
    background-color: #ffcdd2;
}
.login-container {
    max-width: 400px;
    margin: 80px auto;
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0px 8px 20px rgba(0,0,0,0.1);
}
</style>
</head>
<body>

<div class="login-container">
    <h3 class="text-center mb-4"><i class="fa-solid fa-right-to-bracket me-2"></i>Login</h3>
    <%
    Message m=(Message)session.getAttribute("msg");
    if(m!=null){
    	%>
    	<div class="alert alert-danger text-center" role="alert">
    	<%=m.getContent() %>
    	</div>
    	<%
    	session.removeAttribute("msg");
    }
    %>
    <form action="LoginServlet" method="post">
        <div class="mb-3">
            <label class="form-label"><i class="fa-solid fa-envelope me-2"></i>Email</label>
            <input type="email" class="form-control" name="email" placeholder="Enter your email" required>
        </div>
        <div class="mb-3">
            <label class="form-label"><i class="fa-solid fa-lock me-2"></i>Password</label>
            <input type="password" class="form-control" name="password" placeholder="Enter your password" required>
        </div>
        <button type="submit" class="btn btn-dark w-100">Login</button>
        <p class="mt-3 text-center">Don't have an account? <a href="register.jsp">Register</a></p>
    </form>
</div>

<!-- jQuery must come first -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>




</body>
</html>
