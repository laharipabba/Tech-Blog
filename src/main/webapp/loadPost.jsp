<!-- this is load post page..  -->
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.tech.blog.entities.Post" %>
<%@ page import="com.tech.blog.dao.postDao"%>
<%@ page import="com.tech.blog.entities.user" %>
<%@ page import="com.tech.blog.helper.connectionProvider"%>
<%@ page import="com.tech.blog.dao.likeDao" %>
<link href="css/style.css" rel="stylesheet" type="text/css" />

<%
user currentUser = (user) session.getAttribute("currentUser");
if (currentUser == null) {
    response.sendRedirect("login.jsp");
    return;
}
postDao d = new postDao(connectionProvider.getConnection());
int cid = Integer.parseInt(request.getParameter("cid"));
List<Post> posts = new ArrayList<>();

if(cid == 0){
    posts = d.getAllPosts();
}else{
    posts = d.getPostByCatId(cid);
}

if(posts.size() == 0){
    out.println("<h3 class='display-3 text-center'>No Post in this Category</h3>");
    return;
}

for(Post p: posts){ 
%>
<div class="col-md-6 mt-3">
    <div class="card shadow-sm h-100 d-flex flex-column">
        <% if(p.getpPic() != null && !p.getpPic().isEmpty()) { %>
            <img class="card-img-top post-img" src="blog_pics/<%= p.getpPic() %>" alt="Post Image"
                 style="width:100%; max-height:180px; border-top-left-radius:10px; border-top-right-radius:10px; box-shadow:0 2px 8px rgba(0,0,0,0.1);">
        <% } %>
        <div class="card-body flex-grow-1">
            <h5 class="card-title"><%= p.getpTitle() %></h5>
            <p class="text-muted mb-2"><small><%= p.getpDate() %></small></p>
            <p class="card-text"><%= p.getPContent() %></p>
            <% if(p.getPCode() != null && !p.getPCode().isEmpty()) { %>
                <pre class="bg-light p-2 rounded"><code><%= p.getPCode() %></code></pre>
            <% } %>
        </div>
        <div class="card-footer d-flex justify-content-between align-items-center primary-bg mt-auto">
            <!-- Like & Comment buttons on the left -->
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
                
            </div>

            <!-- Read More on the right -->
            <a href="show_blog_page.jsp?post_id=<%=p.getId()%>">Read More</a>
        </div>
    </div>
</div>
<%
} // close the for loop
%>
<script src="js/myjs.js"></script>
