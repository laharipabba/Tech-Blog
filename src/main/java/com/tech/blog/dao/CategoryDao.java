package com.tech.blog.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Category;

public class CategoryDao {
    private Connection con;

    public CategoryDao(Connection con) {
        this.con = con;
    }

    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM categories";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int cid = rs.getInt("cid");
                String name = rs.getString("name");
                String description = rs.getString("description");
                Category c = new Category(cid, name, description);
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

