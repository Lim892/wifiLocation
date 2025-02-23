package OpneApi;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookmarkGroupService {
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

    public void createBookmark(BookmarkGroupInfo bookmark) {
        String sql = "INSERT INTO Bookmark_group (bookmarkname, registerdate, orderint) VALUES (?, NOW(), ?)";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, bookmark.getBookmarkName());
            pstmt.setInt(2, bookmark.getOrderint());
            pstmt.executeUpdate();

            ResultSet rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                int generatedId = rs.getInt(1);
                bookmark.setBookmark_Id(generatedId);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public BookmarkGroupInfo readBookmark(int bookmark_id) {
        String sql = "SELECT * FROM Bookmark_group WHERE bookmark_id = ?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, bookmark_id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                BookmarkGroupInfo bookmark = new BookmarkGroupInfo();
                bookmark.setBookmark_Id(rs.getInt("bookmark_id"));
                bookmark.setBookmarkName(rs.getString("bookmarkname"));
                bookmark.setRegisterDate(rs.getString("registerdate"));
                bookmark.setEditDate(rs.getString("editdate"));
                bookmark.setOrderint(rs.getInt("orderint"));
                return bookmark;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateBookmark(BookmarkGroupInfo bookmark) {
        String sql = "UPDATE Bookmark_group SET bookmarkname = ?, editdate = NOW(), orderint = ? WHERE bookmark_id = ?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, bookmark.getBookmarkName());
            pstmt.setInt(2, bookmark.getOrderint());
            pstmt.setInt(3, bookmark.getBookmark_Id());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteBookmark(int bookmark_id) {
        String sql = "DELETE FROM Bookmark_group WHERE bookmark_id = ?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, bookmark_id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

        public List<BookmarkGroupInfo> getAllBookmarksOrdered() {
            List<BookmarkGroupInfo> bookmarks = new ArrayList<>();
            String sql = "SELECT * FROM Bookmark_group ORDER BY orderint";

            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sql)) {
                while (rs.next()) {
                    BookmarkGroupInfo bookmark = new BookmarkGroupInfo();
                    bookmark.setBookmark_Id(rs.getInt("bookmark_id"));
                    bookmark.setBookmarkName(rs.getString("bookmarkname"));
                    bookmark.setRegisterDate(rs.getString("registerdate"));
                    bookmark.setEditDate(rs.getString("editdate"));
                    bookmark.setOrderint(rs.getInt("orderint"));
                    bookmarks.add(bookmark);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return bookmarks;
        }


}
