package com.example.demo.game2;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Game2DAO {

    @Autowired
    private DataSource dataSource;

    public Connection open() {
        try {
            return dataSource.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to get database connection.");
        }
    }
}
