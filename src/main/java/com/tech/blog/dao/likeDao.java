package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class likeDao {
	Connection con;
	
	public likeDao(Connection con) {
		super();
		this.con = con;
	}

	public boolean insertLike(int pid,int uid) {
		boolean f=false;
		try {
			String q="insert into liked (pid,uid) values(?,?)";
			PreparedStatement pstm=con.prepareStatement(q);
			pstm.setInt(1,pid);
			pstm.setInt(2, uid);
			pstm.executeUpdate();
			f=true;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	public int countLikes(int pid) {
		int count=0;
		String q="select count(*) from liked where pid=?";
		try {
			PreparedStatement pstm=con.prepareStatement(q);
			pstm.setInt(1, pid);
			ResultSet set=pstm.executeQuery();
			if(set.next()) {
				count=set.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	public boolean alreadyLiked(int pid,int uid) {
		boolean f=false;
		String q="select * from liked where pid=? and uid=?";
		try {
			PreparedStatement p=con.prepareStatement(q);
			p.setInt(1, pid);
			p.setInt(2, uid);
			ResultSet rs=p.executeQuery();
			while(rs.next()) {
				f=true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	public boolean deleteLike(int pid,int uid) {
		boolean f=false;
		String q="delete from liked where pid=? and uid=?";
		try {
			PreparedStatement p=con.prepareStatement(q);
			p.setInt(1, pid);
			p.setInt(2, uid);
			p.executeUpdate();
			f=true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}
}
