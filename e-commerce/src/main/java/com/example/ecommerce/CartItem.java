package com.example.ecommerce;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CartItem {
    private String name;
    private String Ide;
    private String photo;
    private double price;
    private int quantity;
    private String color;

    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521/orclpdb";
    private static final String JDBC_USER = "hr";
    private static final String JDBC_PASSWORD = "hr";

    public CartItem( String Ide, String name, String photo, double price, int quantity, String color) {
        this.Ide = Ide;
        this.name = name;
        this.photo = photo;
        this.price = price;
        this.quantity = quantity;
        this.color = color;
    }


    public String getIde() {
        return Ide;
    }


    public String getName() {
        return name;
    }

    public String getPhoto() {
        return photo;
    }

    public double getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getColor() {
        return color;
    }

    public int getIdFromDatabaseByName(String productName) {
        int productId = -1; // Valeur par défaut si le produit n'est pas trouvé


        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            // Utiliser une requête préparée pour éviter les attaques par injection SQL
            String query = "SELECT REFERENCEPRODUIT FROM PRODUITS WHERE nom = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, productName);

                // Exécuter la requête
                try (ResultSet resultSet = statement.executeQuery()) {
                    // Vérifier si un résultat a été retourné
                    if (resultSet.next()) {
                        productId = resultSet.getInt("REFERENCEPRODUIT");
                    }
                }
            }
        } catch (SQLException e) {
            // Gérer les exceptions appropriées
            e.printStackTrace();
        }

        return productId;
    }
}

