<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<%@ page import="com.tech.blog.entities.user"%>
<%@ page import="com.tech.blog.entities.Message"%>
<%@ page import="com.tech.blog.dao.postDao"%>
<%@ page import="com.tech.blog.entities.Category"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.tech.blog.helper.connectionProvider"%>

<%
    user currentUser = (user) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
 // Single DB call to get all categories
    postDao dao = new postDao(connectionProvider.getConnection());
    ArrayList<Category> categories = dao.getAllCategories();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link href="css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>

	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-bg">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">Tech blog</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active" href="./Home.jsp">Home</a></li>
					
					<li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                    Categories
                  </a>
                  <ul class="dropdown-menu">
                    <% for (Category c : categories) { %>
                      <li>
                       <a class="dropdown-item" href="#"
   onclick="getUserPosts(<%= c.getCid() %>, this, true)">
   <%= c.getName() %>
</a>

</a>

                      </li>
                    <% } %>
                  </ul>
                </li>
					<li class="nav-item"><a class="nav-link" href="#"
						data-bs-toggle="modal" data-bs-target="#addPostModal"><span><i
								class="fa-solid fa-plus"></i></span> POST</a></li>
				</ul>
				<ul class="navbar-nav mr-right">
					<li class="nav-item"><a class="nav-link" href="#"
						data-bs-toggle="modal" data-bs-target="#exampleModal"> <i
							class="fa-solid fa-user"></i> <%= currentUser.getName() %>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%= request.getContextPath() %>/LogoutServlet"> <i
							class="fa-solid fa-right-from-bracket"></i> Logout
					</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header primary-bg text-white">
					<h1 class="modal-title fs-5" id="exampleModalLabel">User
						Profile</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<div class="modal-body">
					<div class="container text-center mb-3">
						<img src="<%= request.getContextPath() %>/pics/<%= 
    (currentUser.getProfile() != null && !currentUser.getProfile().trim().isEmpty()) 
    ? currentUser.getProfile() 
    : "default.png" %>"
     alt="Profile"class="rounded-circle"
    style="width: 250px; height: 250px; object-fit: cover;"><br>
						<h5 class="mt-3"><%=currentUser.getName() %></h5>
					</div>

					<div id="profile-details">
						<table class="table table-bordered">
							<tbody>
								<tr>
									<th>ID</th>
									<td><%= currentUser.getId() %></td>
								</tr>
								<tr>
									<th>Name</th>
									<td><%= currentUser.getName() %></td>
								</tr>
								<tr>
									<th>Email</th>
									<td><%= currentUser.getEmail() %></td>
								</tr>
								<tr>
									<th>Gender</th>
									<td><%= currentUser.getGender() %></td>
								</tr>
								<tr>
									<th>Password</th>
									<td><%= currentUser.getPassword() %></td>
								</tr>
								<tr>
									<th>Registration Date</th>
									<td><%= currentUser.getRdate() %></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div id="profile-edit" style="display: none;">
						<h2 class="mt-2">Please Edit Carefully</h2>
						<form action="EditServlet" method="post"
							enctype="multipart/form-data">
							<table class="table">
								<tr>
									<td>ID</td>
									<td><%= currentUser.getId() %></td>
								</tr>
								<tr>
									<td>Name</td>
									<td><input type="text" class="form-control" name="name"
										value="<%= currentUser.getName() %>"></td>
								</tr>
								<tr>
									<td>Email</td>
									<td><input type="email" class="form-control" name="email"
										value="<%= currentUser.getEmail() %>"></td>
								</tr>
								<tr>
									<td>ID</td>
									<td><%= currentUser.getGender().toUpperCase() %></td>
								</tr>
								<tr>
									<td>Password</td>
									<td><input type="text" class="form-control"
										name="password" value="<%= currentUser.getPassword() %>"></td>
								</tr>
								<tr>
									<td>New Profile</td>
									<td><input type="file" name="image" class="form-control"></td>
								</tr>
							</table>
							<div class="container">
								<button type="submit" class="btn btn-outline-primary">Save</button>
							</div>
						</form>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button id="edit-profile-button" type="button"
						class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>
	<%
Message msg = (Message) session.getAttribute("msg");
if (msg != null) {
%>
	<div class="alert <%= msg.getCssClass() %>">
		<%= msg.getContent() %>
	</div>
	<%
    session.removeAttribute("msg");
}
%>



	<!-- post modal -->
	<div class="modal fade" id="addPostModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">Provide
						post details..</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="add-post-form" method="post" 
      enctype="multipart/form-data"
      >
    <div class="form-group">
        <select class="form-control" name="cid" id="category">
        <option selected disabled>Select</option>
    <%
    postDao postd = new postDao(connectionProvider.getConnection());
    ArrayList<Category> l = postd.getAllCategories();
    for (Category c : l) {
    %>
        <option value="<%= c.getCid() %>"><%= c.getName() %></option>
    <%
    }
    %>
</select>

    </div>
    <div class="form-group mt-3">
        <input name="title" type="text" placeholder="Enter post Title"
            class="form-control" />
    </div>
    <div class="form-group mt-3">
        <textarea name="content" class="form-control" style="height: 150px;"
            placeholder="Enter your content"></textarea>
    </div>
    <div class="form-group mt-3">
        <textarea name="code" class="form-control" style="height: 100px;"
            placeholder="Enter your code(if any)"></textarea>
    </div>
    <div class="form-group mt-3">
        <label>Select your pic</label> <br>
        <input name="picture" type="file" accept="images/*"/>
    </div>
    <div class="container text-center mt-5">
        <button type="submit" class="btn btn-success">POST</button>
    </div>
</form>

				</div>
				
			</div>
		</div>
	</div>


	<!-- Profile Card on Main Page -->
<!-- Profile Card -->
<div class="container mt-4">
    <div class="card shadow-lg p-4 border-0">
        <div class="text-center">
            <img src="<%= request.getContextPath() %>/pics/<%= 
    (currentUser.getProfile() != null && !currentUser.getProfile().trim().isEmpty()) 
    ? currentUser.getProfile() 
    : "default.png" %>"
    alt="Profile"
    class="rounded-circle"
    style="width: 250px; height: 250px; object-fit: cover;">

            <h4 class="fw-bold"><%= currentUser.getName() %></h4>
            <p class="text-muted">Welcome back!</p>
        </div>

        <div class="mt-4">
            <table class="table table-striped table-hover">
                <tbody>
                    <tr><th>User ID</th><td><%= currentUser.getId() %></td></tr>
                    <tr><th>Name</th><td><%= currentUser.getName() %></td></tr>
                    <tr><th>Email</th><td><%= currentUser.getEmail() %></td></tr>
                    <tr><th>Gender</th><td><%= currentUser.getGender() %></td></tr>
                    <tr><th>Registration Date</th><td><%= currentUser.getRdate() %></td></tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Main Section -->
<main class="mt-5">
    <div class="container">
        <div class="row">
            <!-- Categories Sidebar -->
            <div class="col-md-4 mb-4">
                <div class="list-group shadow-sm">
                    <%
                        postDao d = new postDao(connectionProvider.getConnection());
                        ArrayList<Category> categ = d.getAllCategories();
                    %>
                    <a href="#" onclick="getUserPosts(0,this)" class="c-link list-group-item list-group-item-action active">All Posts</a>
                    <%
                        for(Category c : categ){
                    %>
                        <a href="#" onclick="getUserPosts(<%= c.getCid() %>, this)" class="c-link list-group-item list-group-item-action">
                            <%= c.getName() %>
                        </a>
                    <%
                        }
                    %>
                </div>
            </div>

            <!-- User Posts Container -->
            <div class="col-md-8">
                <div class="text-center" id="loader" style="display:none;">
                    <i class="fa fa-refresh fa-4x fa-spin mb-3"></i>
                    <h5 class="text-muted">Loading posts...</h5>
                </div>
                <div class="row" id="post-container"></div>
            </div>
        </div>
    </div>
</main>

	<!-- JS -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

	<script>
$(document).ready(function(e){
    let editStatus = false;

    $("#edit-profile-button").click(function(){
        if(editStatus === false){
            $("#profile-details").hide();
            $("#profile-edit").show();
            editStatus = true;
            $(this).text("Back");
        } else {
            $("#profile-details").show();
            $("#profile-edit").hide();
            editStatus = false;
            $(this).text("Edit");
        }
    });
});
</script>

<script>
$(document).ready(function() {
    $("#add-post-form").on("submit", function(event) {
        event.preventDefault();
        console.log("Form submitted");
        
        let form = new FormData(this); // 'this' must be the <form> element
        
        $.ajax({
            url: "<%= request.getContextPath() %>/AddPostServlet",
            type: "POST",
            data: form,
            processData: false,
            contentType: false,
            success: function(data,textStatus,jqXHR) {
                //console.log("Server Response:", data);
            	console.log("Server Response:", data);
    $("#addPostModal").modal("hide"); // close the modal
    swal("Success", "Post added successfully!", "success"); // optional
            },
            error: function(jqXHR, textStatus, errorThrown) {
                //console.error("Error:", textStatus, errorThrown);
            },
            processData:false,
            contentType:false
        });

    });
});


</script>
<script>
function getUserPosts(catId, temp, fromDropdown = false){
    $("#post-container").hide();
    $("#loader").show();
    $(".c-link").removeClass("active");

    // If clicked from dropdown, activate sidebar link too
    if(fromDropdown){
        $('.c-link').each(function(){
            if($(this).attr("onclick") && $(this).attr("onclick").includes("(" + catId + ",")){
                $(this).addClass("active");
            }
        });
    }

    $.ajax({
        url: "loadUserPost.jsp",
        data: { cid: catId, uid: <%= currentUser.getId() %> },
        success: function(data){
            $("#loader").hide();
            $("#post-container").html(data).show();
            if(!fromDropdown){
                $(temp).addClass("active");
            }
        },
        error: function(){
            $("#loader").hide();
            $("#post-container").html("<p class='text-danger text-center'>Failed to load posts.</p>").show();
        }
    });
}

</script>

</body>
</html>
