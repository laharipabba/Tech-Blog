<%@ page errorPage="error_page.jsp" %>
<%@ page import="com.tech.blog.entities.user" %>
<%@ page import="com.tech.blog.entities.Post" %>
<%@ page import="com.tech.blog.dao.postDao" %>
<%@ page import="com.tech.blog.dao.userDao" %>
<%@ page import="com.tech.blog.dao.likeDao" %>
<%@ page import="com.tech.blog.helper.connectionProvider" %>
<%@ page import="java.text.DateFormat" %>
<%
    user currentUser = (user) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int postId = Integer.parseInt(request.getParameter("post_id"));
    postDao d = new postDao(connectionProvider.getConnection());
    Post p = d.getPostByPostId(postId);

    if (p == null) {
        out.println("<div class='alert alert-warning text-center mt-4'>Post not found!</div>");
        return; // Stop further processing
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Blog</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="css/style.css" rel="stylesheet" type="text/css" />
	<div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v23.0"></script>
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
                
                
                
            </ul>
            <ul class="navbar-nav mr-right">
                <li class="nav-item">
                    <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#exampleModal">
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

<!-- Post Content -->
<div class="container mt-4">
    <div class="card shadow-sm mx-auto" style="max-width:720px;">
        <!-- Title on top with primary-bg -->
        <div class="card-header primary-bg text-white">
            <h2 class="card-title mb-0"><%= p.getpTitle() %></h2>
        </div>

        <!-- Post image -->
        <% if (p.getpPic() != null && !p.getpPic().isEmpty()) { %>
            <img src="blog_pics/<%= p.getpPic() %>" alt="Post Image" class="card-img-top" 
                 style="width:100%; height:500px; border-top-left-radius:10px; border-top-right-radius:10px; box-shadow:0 2px 8px rgba(0,0,0,0.1);">
        <% } %>

        <!-- Post content -->
        <div class="card-body">
            <div class="row mb-2">
                <div class="col-md-8">
                    <%
                    userDao ud = new userDao(connectionProvider.getConnection());
                    String author = (p != null) ? ud.getUserByUserId(p.getUid()).getName() : "Unknown";
                    %>
                    <p><a href="#"><%= author %></a></p>
                </div>
            </div>

            <p class="text-muted"><small><%= DateFormat.getDateTimeInstance().format(p.getpDate()) %></small></p>
            
            <p class="card-text"><%= p.getPContent() %></p>
            <% if (p.getPCode() != null && !p.getPCode().isEmpty()) { %>
                <pre class="bg-light p-3 rounded"><code><%= p.getPCode() %></code></pre>
            <% } %>
        </div>

        <!-- Card footer -->
        <div class="card-footer d-flex justify-content-between align-items-center primary-bg mt-auto">
            <div class="d-flex gap-2">
                
                <%
                likeDao dl=new likeDao(connectionProvider.getConnection());
                %>
                <button onclick="doLike(<%=p.getId() %>,<%=currentUser.getId() %>)" 
    class="btn btn-outline btn-sm rounded-circle p-2" title="Like" style="border-color:#fff; color:#000;">
    <i class="fa-solid fa-thumbs-up"></i><span class="like-counter"><%=dl.countLikes(p.getId()) %></span>
</button>

<button onclick="doDislike(<%=p.getId() %>,<%=currentUser.getId() %>)"
    class="btn btn-outline btn-sm rounded-circle p-2" title="Dislike" style="border-color:#fff; color:#000;">
    <i class="fa-solid fa-thumbs-down"></i>
</button>
                <button class="btn btn-outline btn-sm rounded-circle p-2" title="Comment" style="border-color:#fff; color:#000;">
                    <i class="fa-solid fa-comment"></i>
                </button>
            </div>
        </div>
        <div class="card-footer">
        <div class="fb-comments" data-href="http://localhost:8081/Blog/show_blog_page.jsp?post_id=3" data-width="" data-numposts="20"></div>
        </div>
    </div>
</div>



<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/myjs.js"></script>
</body>
</html>
