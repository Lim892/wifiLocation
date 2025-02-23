package OpneApi;
import java.sql.SQLException;
import java.util.List;


public class BookmarkListTest {
    public static void main(String[] args) {
        BookmarkListService service = new BookmarkListService();

        try {
            BookmarkListInfo bookmark = new BookmarkListInfo();
            bookmark.setBookmark_Id(6);
            bookmark.setManagement_Number("24서울-0001");
            bookmark.setBookmarkName("My Bookmark");
            bookmark.setWifiName("서울시청 서소문제1청사");

            // Insert 예시
            service.insertBookmark(bookmark);

            // Select 예시
            BookmarkListInfo selectedBookmark = service.selectBookmark(1, "123ABC");
            if (selectedBookmark != null) {
                System.out.println("Selected Bookmark: " + selectedBookmark.getBookmarkName());
            }

            // Update 예시
            bookmark.setBookmarkName("Updated Bookmark");
            bookmark.setWifiName("Updated WiFi");
            service.updateBookmark(bookmark);

            // Delete 예시
            service.deleteBookmark(1, "123ABC");

            // Get All Bookmarks 예시
            List<BookmarkListInfo> bookmarks = service.getAllBookmarks();
            bookmarks.forEach(b -> System.out.println("Bookmark: " + b.getBookmarkName()));

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
