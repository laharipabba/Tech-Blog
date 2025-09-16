package com.tech.blog.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.tech.blog.entities.Message;
import com.tech.blog.entities.user;
import com.tech.blog.helper.connectionProvider;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8"); // Plain text to respond with simple strings
        try (PrintWriter out = response.getWriter()) {

            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Connection con = connectionProvider.getConnection();

            String checkEmailQuery = "SELECT * FROM `user` WHERE email=?";
            PreparedStatement ps = con.prepareStatement(checkEmailQuery);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                // Email not registered
                out.print("not_registered");
                Message msg = new Message("Email not registered. Please sign up.", "error", "alert-warning");
                HttpSession s = request.getSession();
                s.setAttribute("msg", msg);
                response.sendRedirect("register.jsp");
                
                return;
            } else {
                String dbPassword = rs.getString("password");
                if (password.equals(dbPassword)) {
                    // Correct login → store user info in session
                	HttpSession session = request.getSession();

                    // ✅ Create and set user object
                    user u = new user();
                    u.setId(rs.getInt("id"));
                    u.setName(rs.getString("name"));
                    u.setEmail(rs.getString("email"));
                    u.setPassword(rs.getString("password"));
                    u.setGender(rs.getString("gender"));
                    //u.setAbout(rs.getString("about"));
                    u.setRdate(rs.getTimestamp("rdate"));
                    u.setProfile(rs.getString("profile"));

                    session.setAttribute("currentUser", u);

                    response.sendRedirect("profile.jsp");
                } else {
                    // Password incorrect
                    //out.print("wrong_password");
                    Message msg=new Message("Invalid details..","error","alert-danger");
                    HttpSession s=request.getSession();
                    s.setAttribute("msg", msg);
                    response.sendRedirect("login.jsp");
                }
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
