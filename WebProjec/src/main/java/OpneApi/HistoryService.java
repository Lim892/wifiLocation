package OpneApi;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class HistoryService {
    private static final String DB_URL = "jdbc:mariadb://192.168.0.6:3306/wifidb";
    private static final String DB_USER = "testuser";
    private static final String DB_PASSWORD = "zerobase";

    static {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // CREATE
    public static void createHistory(double latitude, double longitude) {
        try (Connection dbConn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO history_table (y_coordinate, x_coordinate, checkdate) VALUES (?, ?, NOW())";
            try (PreparedStatement pstmt = dbConn.prepareStatement(sql)) {
                pstmt.setDouble(1, latitude);
                pstmt.setDouble(2, longitude);
                pstmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public List<LocationHistory> readHistory() {
        List<LocationHistory> historyList = new ArrayList<>();
        try (Connection dbConn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT * FROM history_table ORDER BY checkdate";
            try (PreparedStatement pstmt = dbConn.prepareStatement(sql);
                 ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    LocationHistory history = new LocationHistory();
                    history.setYCoordinate(rs.getDouble("y_coordinate"));
                    history.setXCoordinate(rs.getDouble("x_coordinate"));
                    history.setCheckDate(rs.getString("checkdate"));
                    historyList.add(history);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return historyList;
    }

    // DELETE
    public void deleteHistory(String checkdate) {
        try (Connection dbConn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "DELETE FROM history_table WHERE checkdate = ?";
            try (PreparedStatement pstmt = dbConn.prepareStatement(sql)) {
                pstmt.setString(1, checkdate);
                pstmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
