

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.tech.blog.entities.Post" %>
<%@ page import="com.tech.blog.entities.Category" %>
<%@ page import="com.tech.blog.dao.postDao" %>
<%@ page import="com.tech.blog.helper.connectionProvider" %>
<%@ page import="com.tech.blog.entities.user" %>

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
    <title>Home - Tech Blog</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark primary-bg">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Tech blog</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">

            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" href="./Home.jsp">Home</a>
                </li>

                <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                    Categories
                  </a>
                  <ul class="dropdown-menu">
                    <% for (Category c : categories) { %>
                      <li>
                        <a class="dropdown-item" href="#" onclick="getPosts(<%= c.getCid() %>, this)">
                          <%= c.getName() %>
                        </a>
                      </li>
                    <% } %>
                  </ul>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#addPostModal">
                        <span><i class="fa-solid fa-plus"></i></span> POST
                    </a>
                </li>
            </ul>

            <ul class="navbar-nav mr-right">
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/profile.jsp">
                        <i class="fa-solid fa-user"></i> <%= currentUser.getName() %>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/LogoutServlet">
                        <i class="fa-solid fa-right-from-bracket"></i> Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>
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

<!-- Main Content -->
<main class="mt-4">
    <div class="container">
        <div class="row">

            <!-- Categories Sidebar -->
            <div class="col-md-4 mb-4">
                <div class="list-group shadow-sm">
                    <a href="#" onclick="getPosts(0,this)" class="c-link list-group-item list-group-item-action active">
                        All Posts
                    </a>
                    <% for (Category c : categories) { %>
                        <a href="#" onclick="getPosts(<%= c.getCid() %>,this)" 
                           class="c-link list-group-item list-group-item-action">
                            <%= c.getName() %>
                        </a>
                    <% } %>
                </div>
            </div>

            <!-- Posts Container -->
            <div class="col-md-8">
                <!-- Loader -->
                <div class="text-center mb-3" id="loader" style="display:none;">
                    <i class="fa fa-arrows-rotate fa-3x fa-spin"></i>
                    <h5 class="mt-2 text-muted">Loading posts...</h5>
                </div>

                <!-- Posts will load here via AJAX -->
                <div class="row" id="post-container"></div>
            </div>

        </div>
    </div>
</main>

<!-- JS Scripts -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
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
function getPosts(catId, temp) {
  $("#loader").show();
  $("#post-container").hide();

  $(".c-link").removeClass("active");
  $(".dropdown-item").removeClass("active");

  $.ajax({
    url: "loadPost.jsp",
    data: { cid: catId },
    success: function(data) {
      $("#loader").hide();
      $("#post-container").show().html(data);

      $(temp).addClass("active");

      if ($(temp).hasClass("dropdown-item")) {
        $(".c-link").filter(function() {
          return $(this).text().trim() === $(temp).text().trim();
        }).addClass("active");
      }

      if ($(temp).hasClass("c-link")) {
        $(".dropdown-item").filter(function() {
          return $(this).text().trim() === $(temp).text().trim();
        }).addClass("active");
      }
    },
    error: function() {
      $("#loader").hide();
      $("#post-container").show().html(
        "<p class='text-danger text-center'>Failed to load posts.</p>"
      );
    }
  });
}

// Load all posts initially
$(document).ready(function() {
  let allPostRef = $(".c-link")[0];
  getPosts(0, allPostRef);
});
</script>
</body>
</html>
