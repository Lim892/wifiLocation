package OpneApi;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class WifiService {
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

    public List<WifiInfo> getNearbyWifi(double latitude, double longitude) {
        List<WifiInfo> wifiList = new ArrayList<>();

        try {
            Connection dbConn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "SELECT *, " +
                    "(6371 * acos(cos(radians(?)) * cos(radians(y_coordinate)) * cos(radians(x_coordinate) - radians(?)) + sin(radians(?)) * sin(radians(y_coordinate)))) AS distance " +
                    "FROM wifi_information_TABLE " +
                    "ORDER BY distance " +
                    "LIMIT 10";
            PreparedStatement pstmt = dbConn.prepareStatement(sql);
            pstmt.setDouble(1, latitude);
            pstmt.setDouble(2, longitude);
            pstmt.setDouble(3, latitude);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                WifiInfo wifi = new WifiInfo();
                wifi.setDistance(rs.getDouble("distance"));
                wifi.setManagementNumber(rs.getString("management_number"));
                wifi.setGugun(rs.getString("gugun"));
                wifi.setWifiName(rs.getString("wifiname"));
                wifi.setDoroAddress(rs.getString("doroaddress"));
                wifi.setDetailAddress(rs.getString("detailaddress"));
                wifi.setFloor(rs.getString("floor"));
                wifi.setInstallType(rs.getString("install_type"));
                wifi.setOrganization(rs.getString("organization"));
                wifi.setService(rs.getString("service"));
                wifi.setNetType(rs.getString("net_type"));
                wifi.setInstallYear(rs.getInt("install_year"));
                wifi.setOutindivision(rs.getString("outindivision"));
                wifi.setWifiConnect(rs.getString("wifi_connect"));
                wifi.setY_coordinate(rs.getDouble("y_coordinate"));
                wifi.setX_coordinate(rs.getDouble("x_coordinate"));
                wifi.setWorkDate(rs.getString("workdate"));
                wifiList.add(wifi);
            }

            rs.close();
            pstmt.close();
            dbConn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return wifiList;
    }
}
