package com.tech.blog.entities;

import java.sql.*;

public class user {
	private int id;
	private String name;
	private String email;
	private String gender;
	private String password;
	private Timestamp rdate;
	private String profile;
	
	public user(int id, String name, String email, String gender, String password, Timestamp rdate) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.gender = gender;
		this.password = password;
		this.rdate = rdate;
	}
	public user() {
		super();
	}
	public user(String name, String email, String gender, String password, Timestamp rdate, String profile) {
		super();
		this.name = name;
		this.email = email;
		this.gender = gender;
		this.password = password;
		this.rdate = rdate;
		this.profile=profile;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Timestamp getRdate() {
		return rdate;
	}
	public void setRdate(Timestamp rdate) {
		this.rdate = rdate;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
}
