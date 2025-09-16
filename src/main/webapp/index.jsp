<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.tech.blog.helper.connectionProvider" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB Test</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link href="css/style.css" rel="stylesheet" type="text/css" />
<style>
.card i {
    font-size: 2rem;
    color: #e57373;
}
.card {
    border-radius: 10px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.card:hover {
    transform: translateY(-5px);
    box-shadow: 0px 8px 20px rgba(0,0,0,0.15);
}
.banner {
    background-color: #ffcdd2;
}
</style>
</head>
<body>
<%@ include file="Nav_bar.jsp" %>

<!-- Banner Section -->
<section class="py-5 text-center text-dark banner">
  <div class="container">
    <h1 class="display-4 fw-bold">Welcome to My Tech Space</h1>
    <p class="lead mb-4">
      Sharing my journey in coding, web development, and creative tech projects.
    </p>
    <a href="#blog" class="btn btn-dark btn-lg fw-bold me-2">
      <i class="fa-solid fa-book-open-reader me-2"></i> Read My Blog
    </a>
    <a href="login.jsp" class="btn btn-outline-dark btn-lg fw-bold">
      <i class="fa-solid fa-right-to-bracket me-2"></i> Login
    </a>
  </div>
</section>

<!-- Cards Section -->
<div class="container py-5">
  <div class="row g-4">

    <!-- Programming Languages Card -->
    <div class="col-md-4">
      <div class="card h-100 shadow-sm text-center">
        <div class="card-body">
          <i class="fa-solid fa-code mb-3"></i>
          <h5 class="card-title fw-bold">Programming Languages</h5>
          <p class="card-text">
            Knowledge of languages used to develop software and solve computational problems.
Enables writing efficient, readable, and maintainable code across projects.
          </p>
          <a href="login.jsp" class="btn btn-dark btn-sm">View More</a>
        </div>
      </div>
    </div>

    <!-- Projects Card -->
    <div class="col-md-4">
      <div class="card h-100 shadow-sm text-center">
        <div class="card-body">
          <i class="fa-solid fa-lightbulb mb-3"></i>
          <h5 class="card-title fw-bold">Projects</h5>
          <p class="card-text">
            Hands-on projects showcasing practical skills and technical expertise.
Demonstrates problem-solving, development, and real-world application.
          </p>
          <a href="login.jsp" class="btn btn-dark btn-sm">View More</a>
        </div>
      </div>
    </div>

    <!-- Certifications Card -->
    <div class="col-md-4">
      <div class="card h-100 shadow-sm text-center">
        <div class="card-body">
          <i class="fa-solid fa-code-branch mb-3"></i>
          <h5 class="card-title fw-bold">Data Structures</h5>
          <p class="card-text">
            Fundamental concepts for organizing, storing, and managing data efficiently, including arrays, linked lists, stacks, queues, trees, and graphs, essential for problem-solving and algorithm design.
          </p>
          <a href="login.jsp" class="btn btn-dark btn-sm">View More</a>
        </div>
      </div>
    </div>

  </div>
</div>
<!-- Contact Section -->
<section class="py-5 bg-light" id="contact">
  <div class="container">
    <h2 class="text-center mb-4">Contact Me</h2>
    <p class="text-center text-muted mb-5">Have a question or suggestion? Feel free to reach out!</p>

    <div class="row justify-content-center">
      <div class="col-md-8">
        <form action="ContactServlet" method="post">
          <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" id="name" name="name" required>
          </div>
          <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
          </div>
          <div class="mb-3">
            <label for="subject" class="form-label">Subject</label>
            <input type="text" class="form-control" id="subject" name="subject" required>
          </div>
          <div class="mb-3">
            <label for="message" class="form-label">Message</label>
            <textarea class="form-control" id="message" name="message" rows="5" required></textarea>
          </div>
          <div class="text-center">
            <button type="submit" class="btn btn-primary">
              <i class="fa-solid fa-paper-plane me-2"></i> Send Message
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- Footer Section -->
<footer class="bg-dark text-white pt-5 pb-3 mt-5">
  <div class="container">
    <div class="row">

      <!-- About -->
      <div class="col-md-4 mb-4">
        <h5 class="fw-bold">About Tech Blog</h5>
        <p>
          Sharing insights, tutorials, and projects in programming, web development, and technology.
          Stay updated and enhance your coding journey with us!
        </p>
      </div>

      <!-- Quick Links -->
      <div class="col-md-4 mb-4">
        <h5 class="fw-bold">Quick Links</h5>
        <ul class="list-unstyled">
          <li><a href="#blog" class="text-white text-decoration-none">Home</a></li>
          <li><a href="#blog" class="text-white text-decoration-none">Blog</a></li>
          <li><a href="#contact" class="text-white text-decoration-none">Contact</a></li>
          <li><a href="login.jsp" class="text-white text-decoration-none">Login</a></li>
        </ul>
      </div>

      <!-- Social Media -->
      <div class="col-md-4 mb-4">
        <h5 class="fw-bold">Follow Us</h5>
        <div class="d-flex gap-3 mt-2">
          <a href="#" class="text-white fs-4"><i class="fab fa-facebook-f"></i></a>
          <a href="#" class="text-white fs-4"><i class="fab fa-twitter"></i></a>
          <a href="#" class="text-white fs-4"><i class="fab fa-linkedin-in"></i></a>
          <a href="#" class="text-white fs-4"><i class="fab fa-github"></i></a>
        </div>
      </div>

    </div>

    <hr class="bg-secondary">

    <div class="text-center">
      <p class="mb-0">&copy; <%= java.time.Year.now() %> Tech Blog. All Rights Reserved.</p>
    </div>
  </div>
</footer>
  

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


