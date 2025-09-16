package com.tech.blog.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.likeDao;
import com.tech.blog.helper.connectionProvider;

/**
 * Servlet implementation class LikeServlet
 */
@WebServlet("/LikeServlet")
public class LikeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LikeServlet() {
        super();
    }

    // Common method for both GET and POST
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
        	
        	String operation=request.getParameter("operation");
        	int uid=Integer.parseInt(request.getParameter("uid"));
        	int pid=Integer.parseInt(request.getParameter("pid"));
        	
//        	out.println("data form server");
//        	out.println(operation);
//        	out.println(uid);
//        	out.println(pid);
        	likeDao ldao=new likeDao(connectionProvider.getConnection());
        	if(operation.equals("like")) {
        	    if(!ldao.alreadyLiked(pid, uid)) { // check first
        	        boolean f = ldao.insertLike(pid, uid);
        	        out.println(f);
        	    } else {
        	        out.println(false); // already liked, no insert
        	    }
        	}
        	else if(operation.equals("dislike")) {
        		boolean f=ldao.deleteLike(pid, uid);
        		out.println(f);
        	}
        	
        	
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
