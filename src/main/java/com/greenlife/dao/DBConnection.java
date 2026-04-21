package com.greenlife.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Config SQL Server parameters
    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=GreenLifeDB;encrypt=true;trustServerCertificate=true;";
    private static final String USER = "sa"; // Thay doi thanh user cua ban neu can
    private static final String PASS = "123"; // Thay doi thanh password cua ban

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName(DRIVER);
        return DriverManager.getConnection(URL, USER, PASS);
    }

}
