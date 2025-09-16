package com.tech.blog.entities;

import java.sql.Timestamp;

public class Post {
	private int id;
	private String pTitle;
	private String PContent;
	private String PCode;
	private String pPic;
	private Timestamp pDate;
	private int catId;
	private int uid;
	public Post(int id, String pTitle, String pContent, String pCode, String pPic, Timestamp pDate, int catId,int uid) {
		super();
		this.id = id;
		this.pTitle = pTitle;
		this.PContent = pContent;
		this.PCode = pCode;
		this.pPic = pPic;
		this.pDate = pDate;
		this.catId = catId;
		this.uid=uid;
	}
	public Post(String pTitle, String pContent, String pCode, String pPic, Timestamp pDate, int catId,int uid) {
		super();
		this.pTitle = pTitle;
		this.PContent = pContent;
		this.PCode = pCode;
		this.pPic = pPic;
		this.pDate = pDate;
		this.catId = catId;
		this.uid=uid;
	}
	public Post() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getpTitle() {
		return pTitle;
	}
	public void setpTitle(String pTitle) {
		this.pTitle = pTitle;
	}
	public String getPContent() {
		return PContent;
	}
	public void setPContent(String pContent) {
		this.PContent = pContent;
	}
	public String getPCode() {
		return PCode;
	}
	public void setPCOde(String pCode) {
		this.PCode = pCode;
	}
	public String getpPic() {
		return pPic;
	}
	public void setpPic(String pPic) {
		this.pPic = pPic;
	}
	public Timestamp getpDate() {
		return pDate;
	}
	public void setpDate(Timestamp pDate) {
		this.pDate = pDate;
	}
	public int getCatId() {
		return catId;
	}
	public void setCatId(int catId) {
		this.catId = catId;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	

}
