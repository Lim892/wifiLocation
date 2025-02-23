package OpneApi;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

public class apicode {

    static {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static int datainsert(int start, int end) throws IOException {
        int recordCount = 0;

        StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088"); /*URL*/
        urlBuilder.append("/" + URLEncoder.encode("41514c474762726537357353527552", "UTF-8")); /*인증키 (sample사용시에는 호출시 제한됩니다.)*/
        urlBuilder.append("/" + URLEncoder.encode("xml", "UTF-8")); /*요청파일타입 (xml,xmlf,xls,json) */
        urlBuilder.append("/" + URLEncoder.encode("TbPublicWifiInfo", "UTF-8")); /*서비스명 (대소문자 구분 필수입니다.)*/
        urlBuilder.append("/" + URLEncoder.encode(String.valueOf(start), "UTF-8")); /*요청시작위치 */
        urlBuilder.append("/" + URLEncoder.encode(String.valueOf(end), "UTF-8")); /*요청종료위치 */


        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/xml");
        System.out.println("Response code: " + conn.getResponseCode()); /* 연결 자체에 대한 확인이 필요하므로 추가합니다.*/
        BufferedReader rd;

        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }

        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();

        String xmlData = sb.toString();

        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new java.io.ByteArrayInputStream(xmlData.getBytes("UTF-8")));

            NodeList nodeList = doc.getElementsByTagName("row");

            String dbUrl = "jdbc:mariadb://192.168.0.6:3306/wifidb";
            String user = "testuser";
            String password = "zerobase";

            Connection dbConn = DriverManager.getConnection(dbUrl, user, password);

            String sql = "INSERT INTO wifi_information_TABLE (" +
                    "management_number, gugun, wifiname, doroaddress, detailaddress, floor, " +
                    "install_type, organization, service, net_type, install_year, outindivision, " +
                    "wifi_connect, y_coordinate, x_coordinate, workdate) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = dbConn.prepareStatement(sql);

            for (int i = 0; i < nodeList.getLength(); i++) {
                pstmt.setString(1, doc.getElementsByTagName("X_SWIFI_MGR_NO").item(i).getTextContent());
                pstmt.setString(2, doc.getElementsByTagName("X_SWIFI_WRDOFC").item(i).getTextContent());
                pstmt.setString(3, doc.getElementsByTagName("X_SWIFI_MAIN_NM").item(i).getTextContent());
                pstmt.setString(4, doc.getElementsByTagName("X_SWIFI_ADRES1").item(i).getTextContent());
                pstmt.setString(5, doc.getElementsByTagName("X_SWIFI_ADRES2").item(i).getTextContent());
                pstmt.setString(6, doc.getElementsByTagName("X_SWIFI_INSTL_FLOOR").item(i).getTextContent());
                pstmt.setString(7, doc.getElementsByTagName("X_SWIFI_INSTL_TY").item(i).getTextContent());
                pstmt.setString(8, doc.getElementsByTagName("X_SWIFI_INSTL_MBY").item(i).getTextContent());
                pstmt.setString(9, doc.getElementsByTagName("X_SWIFI_SVC_SE").item(i).getTextContent());
                pstmt.setString(10, doc.getElementsByTagName("X_SWIFI_CMCWR").item(i).getTextContent());
                pstmt.setString(11, doc.getElementsByTagName("X_SWIFI_CNSTC_YEAR").item(i).getTextContent());
                pstmt.setString(12, doc.getElementsByTagName("X_SWIFI_INOUT_DOOR").item(i).getTextContent());
                pstmt.setString(13, doc.getElementsByTagName("X_SWIFI_REMARS3").item(i).getTextContent());
                pstmt.setString(14, doc.getElementsByTagName("LAT").item(i).getTextContent());
                pstmt.setString(15, doc.getElementsByTagName("LNT").item(i).getTextContent());
                pstmt.setString(16, doc.getElementsByTagName("WORK_DTTM").item(i).getTextContent());
                pstmt.addBatch();
                recordCount++;
            }

            pstmt.executeBatch();

            pstmt.close();
            dbConn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return recordCount;
    }

    public static void main(String[] args) throws IOException {
        int totalRecordCount = 0;
        int start = 1;
        int batchSize = 1000;
        int totalDataSize = 26000;

        while (start <= totalDataSize) {
            int end = start + batchSize - 1;
            if (end > totalDataSize) {
                end = totalDataSize;
            }
            int recordCount = apicode.datainsert(start, end);
            totalRecordCount += recordCount;
            start = end + 1;
        }

        System.out.println("Total records inserted: " + totalRecordCount);
    }
}
