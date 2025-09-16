package com.tech.blog.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.userDao;
import com.tech.blog.entities.user;
import com.tech.blog.helper.connectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            // Fetch form data
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String gender = request.getParameter("gender");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            // Password match check
            if (!password.equals(confirmPassword)) {
                out.print("password_mismatch");
                return;
            }

            // Create user object
            user userObj = new user(name, email, gender, password, null, null);

            // Create DAO object
            userDao dao = new userDao(connectionProvider.getConnection());

            if (dao.saveUser(userObj)) {
                out.print("success");
            } else {
                out.print("registration_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("error");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
