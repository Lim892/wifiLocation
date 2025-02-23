package OpneApi;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookmarkListService {
    private static final String URL = "jdbc:mariadb://192.168.0.6:3306/wifidb";
    private static final String USER = "testuser";
    private static final String PASSWORD = "zerobase";

    static {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void insertBookmark(BookmarkListInfo bookmark) throws SQLException {
        String sql = "INSERT INTO bookmark_list (bookmark_id, management_number, bookmarkname, wifiname, listregisterdate) VALUES (?, ?, ?, ?, NOW())";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, bookmark.getBookmark_Id());
            pstmt.setString(2, bookmark.getManagement_Number());
            pstmt.setString(3, bookmark.getBookmarkName());
            pstmt.setString(4, bookmark.getWifiName());
            pstmt.executeUpdate();
        }
    }

    public BookmarkListInfo selectBookmark(int bookmarkId, String managementNumber) throws SQLException {
        String sql = "SELECT * FROM bookmark_list WHERE bookmark_id = ? AND management_number = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, bookmarkId);
            pstmt.setString(2, managementNumber);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    BookmarkListInfo bookmark = new BookmarkListInfo();
                    bookmark.setBookmark_Id(rs.getInt("bookmark_id"));
                    bookmark.setManagement_Number(rs.getString("management_number"));
                    bookmark.setBookmarkName(rs.getString("bookmarkname"));
                    bookmark.setWifiName(rs.getString("wifiname"));
                    bookmark.setListRegisterDate(rs.getString("listregisterdate"));
                    return bookmark;
                }
            }
        }
        return null;
    }

    public void updateBookmark(BookmarkListInfo bookmark) throws SQLException {
        String sql = "UPDATE bookmark_list SET bookmarkname = ?, wifiname = ?, listregisterdate = NOW() WHERE bookmark_id = ? AND management_number = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, bookmark.getBookmarkName());
            pstmt.setString(2, bookmark.getWifiName());
            pstmt.setInt(3, bookmark.getBookmark_Id());
            pstmt.setString(4, bookmark.getManagement_Number());
            pstmt.executeUpdate();
        }
    }

    public void deleteBookmark(int bookmarkId, String managementNumber) throws SQLException {
        String sql = "DELETE FROM bookmark_list WHERE bookmark_id = ? AND management_number = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, bookmarkId);
            pstmt.setString(2, managementNumber);
            pstmt.executeUpdate();
        }
    }

    public List<BookmarkListInfo> getAllBookmarks() throws SQLException {
        List<BookmarkListInfo> bookmarks = new ArrayList<>();
        String sql = "SELECT * FROM bookmark_list";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                BookmarkListInfo bookmark = new BookmarkListInfo();
                bookmark.setBookmark_Id(rs.getInt("bookmark_id"));
                bookmark.setManagement_Number(rs.getString("management_number"));
                bookmark.setBookmarkName(rs.getString("bookmarkname"));
                bookmark.setWifiName(rs.getString("wifiname"));
                bookmark.setListRegisterDate(rs.getString("listregisterdate"));
                bookmarks.add(bookmark);
            }
        }
        return bookmarks;
    }
}
