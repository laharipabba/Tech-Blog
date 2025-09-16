package com.tech.blog.dao;

import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;

public class postDao {
	Connection con;

	public postDao(Connection con) {
		super();
		this.con = con;
	}
	public ArrayList<Category> getAllCategories(){
		ArrayList<Category> l=new ArrayList<>();
		try {
			String q="select * from categories";
			Statement st=this.con.createStatement();
			ResultSet set=st.executeQuery(q);
			while(set.next()) {
				int cid=set.getInt("cid");
				String name=set.getString("name");
				String desc=set.getString("description");
				Category c=new Category(cid,name,desc);
				l.add(c);
				
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return l;
	}
	public boolean savePost(Post p) {
		boolean f=false;
		try {
			String q="insert into posts(pTitle,pContent,pCode,pPic,catId,uid) values(?,?,?,?,?,?)";
			PreparedStatement pstm=con.prepareStatement(q);
			pstm.setString(1,p.getpTitle());
			pstm.setString(2, p.getPContent());
			pstm.setString(3, p.getPCode());
			pstm.setString(4,p.getpPic());
			pstm.setInt(5, p.getCatId());
			pstm.setInt(6, p.getUid());
			pstm.executeUpdate();
			f=true;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	public List<Post> getAllPosts(){
		List<Post> l=new ArrayList<>();
		//fetch all the posts
		try {
			PreparedStatement p=con.prepareStatement("select * from posts order by pid desc");
			ResultSet set=p.executeQuery();
			while(set.next()) {
				int pid=set.getInt("pid");
				String title=set.getString("pTitle");
				String content=set.getString("pContent");
				String code=set.getString("pCode");
				String pic=set.getString("pPic");
				Timestamp date=set.getTimestamp("pDate");
				int catid=set.getInt("catid");
				int uid=set.getInt("uid");
				Post post=new Post(pid,title,content,code,pic,date,catid,uid);
				l.add(post);
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return l;
	}
	public List<Post> getPostByCatId(int catId){
		List<Post> l=new ArrayList<>();
		//fetch all the post by id
		try {
			PreparedStatement p=con.prepareStatement("select * from posts where catId=?");
			p.setInt(1,catId);
			ResultSet set=p.executeQuery();
			while(set.next()) {
				int pid=set.getInt("pid");
				String title=set.getString("pTitle");
				String content=set.getString("pContent");
				String code=set.getString("pCode");
				String pic=set.getString("pPic");
				Timestamp date=set.getTimestamp("pDate");
				int uid=set.getInt("uid");
				Post post = new Post(pid, title, content, code, pic, date, catId, uid);

				l.add(post);
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return l;
	}
	public List<Post> getPostByUserId(int uid) {
	    List<Post> list = new ArrayList<>();
	    try {
	        PreparedStatement p = con.prepareStatement("SELECT * FROM posts WHERE uid=? ORDER BY pDate DESC");
	        p.setInt(1, uid);
	        ResultSet set = p.executeQuery();
	        while(set.next()) {
	            int pid = set.getInt("pid");
	            String title = set.getString("pTitle");
	            String content = set.getString("pContent");
	            String code = set.getString("pCode");
	            String pic = set.getString("pPic");
	            Timestamp date = set.getTimestamp("pDate");
	            int catId = set.getInt("catId");
	            Post post = new Post(pid, title, content, code, pic, date, catId, uid);

	            list.add(post);
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	public List<Post> getPostByUserAndCategory(int uid, int catId) {
	    List<Post> list = new ArrayList<>();
	    try {
	        PreparedStatement p = con.prepareStatement("SELECT * FROM posts WHERE uid=? AND catId=? ORDER BY pDate DESC");
	        p.setInt(1, uid);
	        p.setInt(2, catId);
	        ResultSet set = p.executeQuery();
	        while(set.next()) {
	            int pid = set.getInt("pid");
	            String title = set.getString("pTitle");
	            String content = set.getString("pContent");
	            String code = set.getString("pCode");
	            String pic = set.getString("pPic");
	            Timestamp date = set.getTimestamp("pDate");
	            Post post = new Post(pid, title, content, code, pic, date, catId, uid);

	            list.add(post);
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	public Post getPostByPostId(int postId) {
	    Post post = null;
	    try {
	        String query = "SELECT * FROM posts WHERE pid = ?"; // Check table name & column
	        PreparedStatement pst = this.con.prepareStatement(query);
	        pst.setInt(1, postId);
	        ResultSet set = pst.executeQuery();
	        if (set.next()) {
	            int pid = set.getInt("pid");        // Make sure column names match DB
	            String title = set.getString("pTitle");
	            String content = set.getString("pContent");
	            String code = set.getString("pCode");
	            String pic = set.getString("pPic");
	            Timestamp date = set.getTimestamp("pDate");
	            int catId = set.getInt("catId");
	            int uid = set.getInt("uid");
	            post = new Post(pid, title, content, code, pic, date, catId, uid);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return post;
	}


}
