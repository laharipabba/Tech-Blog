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

import com.tech.blog.dao.userDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.user;
import com.tech.blog.helper.Helper;
import com.tech.blog.helper.connectionProvider;



@WebServlet("/EditServlet")
@MultipartConfig // Needed for file upload
public class EditServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	PrintWriter out = response.getWriter();
    	// Fetch updated form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Part profilePart = request.getPart("image"); // file upload
        String imageName=profilePart.getSubmittedFileName();
        

        // Get current user from session
        HttpSession session = request.getSession();
        user currentUser = (user) session.getAttribute("currentUser");

        // Update user details
        currentUser.setName(name);
        currentUser.setEmail(email);
        currentUser.setPassword(password);
        String oldFile=currentUser.getProfile();
        currentUser.setProfile(imageName);
        
        userDao userdao=new userDao(connectionProvider.getConnection());
        boolean ans=userdao.updateUser(currentUser);
        if (ans) {

        	String path = getServletContext().getRealPath("/pics") + File.separator + imageName;
        	String Oldpath = getServletContext().getRealPath("/pics") + File.separator + oldFile;
        	if(!oldFile.equals("default.png")) {
        	Helper.deleteFile(Oldpath);
        	}


            if (Helper.saveFile(profilePart.getInputStream(), path)) {
                
                // ✅ Update session object with new profile photo
                currentUser.setProfile(imageName);
                session.setAttribute("currentUser", currentUser);

                out.println("Profile Updated");
                Message msg = new Message("Profile updated successfully!", "success", "alert-success");
                session.setAttribute("msg", msg);
                response.sendRedirect("profile.jsp");

            } else {
                out.println("File not saved successfully");
                Message msg = new Message("Something went wrong!", "error", "alert-danger");
                session.setAttribute("msg", msg);
                response.sendRedirect("profile.jsp");
            }
        }

        //response.sendRedirect("profile.jsp");
        
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
