package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.tech.blog.entities.user;

public class userDao {
    private Connection con;

    public userDao(Connection con) {
        this.con = con;
    }

    public boolean saveUser(user userObj) {
        boolean success = false;
        try {
            String q = "INSERT INTO `user` (name, email, gender, password) VALUES (?,?,?,?)";
            PreparedStatement pstm = this.con.prepareStatement(q);
            pstm.setString(1, userObj.getName());
            pstm.setString(2, userObj.getEmail());
            pstm.setString(3, userObj.getGender());
            pstm.setString(4, userObj.getPassword());

            pstm.executeUpdate();
            success = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public user getUserByEmailAndPassword(String email, String password) {
        user userObj = null;
        try {
            String q = "SELECT * FROM user WHERE email=? AND password=?";
            PreparedStatement pstm = con.prepareStatement(q);
            pstm.setString(1, email);
            pstm.setString(2, password);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                userObj = new user();
                userObj.setId(rs.getInt("id"));
                userObj.setName(rs.getString("name"));
                userObj.setEmail(rs.getString("email"));
                userObj.setGender(rs.getString("gender"));
                userObj.setPassword(rs.getString("password"));
                userObj.setRdate(rs.getTimestamp("rdate"));
                userObj.setProfile(rs.getString("profile"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userObj;
    }
    public user getUserById(int uid){
        user u = null;
        try{
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE id=?");
            ps.setInt(1, uid);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                u = new user();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setGender(rs.getString("gender"));
                u.setPassword(rs.getString("password"));
                u.setProfile(rs.getString("profile"));
                u.setRdate(rs.getTimestamp("rdate"));
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return u;
    }


    public boolean updateUser(user userObj) {
    	boolean f=false;
    	try {
    		
    		String q="update user set name=?,email=?,gender=?,password=?,profile=? where id=?";
    		PreparedStatement p=con.prepareStatement(q);
    		p.setString(1,userObj.getName());
    		p.setString(2, userObj.getEmail());
    		p.setString(3, userObj.getGender());
    		p.setString(4, userObj.getPassword());
    		p.setString(5,userObj.getProfile());
    		p.setInt(6,userObj.getId());
    		p.executeUpdate();
    		f=true;
    		
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	return f;
    }
    public user getUserByUserId(int userId) {
    	user u=new user();
    	
    	String q="select * from user where id=?";
    	try {
			PreparedStatement pstm=this.con.prepareStatement(q);
			pstm.setInt(1, userId);
			ResultSet set=pstm.executeQuery();
			if(set.next()) {
				ResultSet rs = pstm.executeQuery();
	            if (rs.next()) {
	                u = new user();
	                u.setId(rs.getInt("id"));
	                u.setName(rs.getString("name"));
	                u.setEmail(rs.getString("email"));
	                u.setGender(rs.getString("gender"));
	                u.setPassword(rs.getString("password"));
	                u.setRdate(rs.getTimestamp("rdate"));
	                u.setProfile(rs.getString("profile"));
	            }
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	
    	
    	return u;
    }
}
