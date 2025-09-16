package com.tech.blog.helper;

import java.sql.Connection;   // ✅ Correct import
import java.sql.DriverManager;
import java.sql.SQLException;

public class connectionProvider {
    private static Connection con;

    public static Connection getConnection() {
        try {
            if (con == null) {
                Class.forName("com.mysql.cj.jdbc.Driver");

                String url = "jdbc:mysql://localhost:3307/techblog";
                String username = "root";
                String password = "lahari";

                con = DriverManager.getConnection(url, username, password);

                if (con.isClosed()) {
                    System.out.println("Connection is closed");
                } else {
                    System.out.println("Connection is Created...");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}
