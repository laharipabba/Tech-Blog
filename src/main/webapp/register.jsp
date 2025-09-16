<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
body {
    background-color: #ffcdd2;
}
.register-container {
    max-width: 450px;
    margin: 60px auto;
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0px 8px 20px rgba(0,0,0,0.1);
}
</style>
</head>
<body>

<div class="register-container">
    <h3 class="text-center mb-4"><i class="fa-solid fa-user-plus me-2"></i>Register</h3>
    <form id="reg_form" action="${pageContext.request.contextPath}/RegisterServlet" method="post">
        <!-- Full Name -->
        <div class="mb-3">
            <label class="form-label"><i class="fa-solid fa-user me-2"></i>Full Name</label>
            <input type="text" class="form-control" name="name" placeholder="Enter your full name" required>
        </div>

        <!-- Email -->
        <div class="mb-3">
            <label class="form-label"><i class="fa-solid fa-envelope me-2"></i>Email</label>
            <input type="email" class="form-control" name="email" placeholder="Enter your email" required>
        </div>

        <!-- Gender -->
        <div class="mb-3">
            <label class="form-label"><i class="fa-solid fa-venus-mars me-2"></i>Gender</label>
            <select class="form-select" name="gender" required>
                <option value="">Select Gender</option>
                <option value="Female">Female</option>
                <option value="Male">Male</option>
                <option value="Other">Other</option>
            </select>
        </div>

        <!-- Password -->
        <div class="mb-3">
            <label class="form-label"><i class="fa-solid fa-lock me-2"></i>Password</label>
            <input type="password" class="form-control" name="password" placeholder="Enter a password" required>
        </div>

        <!-- Confirm Password -->
        <div class="mb-3">
            <label class="form-label"><i class="fa-solid fa-lock me-2"></i>Confirm Password</label>
            <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm your password" required>
        </div>

		<div class="container text-center" id="loader" style="display:none;">
		<span class=fa fa-regresh fa-spin fa-3x></span>
		<h4>Please wait...</h4>
		</div>
		
        <!-- Submit -->
        <button id="submit-btn" type="submit" class="btn btn-dark w-100">Register</button>
        <p class="mt-3 text-center">Already have an account? <a href="login.jsp">Login</a></p>
    </form>
</div>


<!-- jQuery must come first -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- Your custom script -->
<script>
$(document).ready(function(){
    console.log("loaded...");
    $('#reg_form').on('submit', function(event){
        event.preventDefault();
        
        let form = new FormData(this);
        $("#submit-btn").hide();
        $("#loader").show();
        $.ajax({
            url: "RegisterServlet",
            type: 'post',
            data: form,
            success: function(data) {
                console.log(data);
                $("#submit-btn").show();
                $("#loader").hide();
                if(data.trim()=='Registration Successful!'){
                swal("Done..!", "We are redirecting to login page", "success").then((value)=>{
                	window.location="login.jsp"
                });
            }
            else{
            	swal(data);
            	}
            },
            error: function(jqXHR) {
                console.log(jqXHR);
                $("#submit-btn").show();
                $("#loader").hide();
                swal("Error!", "Registration failed. Please try again.", "error");

            },
            processData: false,
            contentType: false
        });
    });
});
</script>

</body>
</html>
