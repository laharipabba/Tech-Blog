package com.tech.blog.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.postDao;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.user;
import com.tech.blog.helper.Helper;
import com.tech.blog.helper.connectionProvider;

@WebServlet("/AddPostServlet")
@MultipartConfig
public class AddPostServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Get parameters
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String code = request.getParameter("code");
            int cidStr = Integer.parseInt(request.getParameter("cid"));
            Part part = request.getPart("picture");
            HttpSession s = request.getSession(false); // Don't create a new one
            if (s == null || s.getAttribute("currentUser") == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
                return;
            }

            user u = (user) s.getAttribute("currentUser");

            
            out.println("Title: " + title);
            out.println("Content: " + content);
            out.println("Code: " + code);
            out.println("CID: " + cidStr);
            out.println(part.getSubmittedFileName());
            
           // Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            Post p = new Post(
                title,
                content,
                code,
                part.getSubmittedFileName(),
                null,
                cidStr,
                u.getId()
            );
            postDao dao=new postDao(connectionProvider.getConnection());
            if(dao.savePost(p)) {
            	out.println("done");
            	String path = getServletContext().getRealPath("/blog_pics") + File.separator + part.getSubmittedFileName();
            	Helper.saveFile(part.getInputStream(), path);
            }
            else {
            	out.println("error");
            }

            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            out.println("Invalid category ID");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error adding post");
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
