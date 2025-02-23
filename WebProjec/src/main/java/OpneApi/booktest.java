package OpneApi;

public class booktest {
    public static void main(String[] args) {
        BookmarkGroupService bookmarkService = new BookmarkGroupService();

        BookmarkGroupInfo bookmark1 = new BookmarkGroupInfo();
        bookmark1.setBookmarkName("Bookmark 1");
        bookmark1.setOrderint(1);
        bookmarkService.createBookmark(bookmark1);

        // 삽입된 북마크의 ID 확인
        System.out.println("Bookmark inserted with ID: " + bookmark1.getBookmark_Id());

        // 북마크 읽기
        BookmarkGroupInfo readBookmark = bookmarkService.readBookmark(bookmark1.getBookmark_Id());
        if (readBookmark != null) {
            System.out.println("Read Bookmark: " + readBookmark.getBookmarkName());
            System.out.println("Register Date: " + readBookmark.getRegisterDate());
            System.out.println("Edit Date: " + readBookmark.getEditDate());
        } else {
            System.out.println("Bookmark not found.");
        }

//        // 북마크 수정
//        bookmark1.setBookmarkName("Updated Bookmark 1");
//        bookmarkService.updateBookmark(bookmark1);
//
//        // 수정된 북마크 읽기
//        readBookmark = bookmarkService.readBookmark(bookmark1.getBookmark_Id());
//        if (readBookmark != null) {
//            System.out.println("Updated Bookmark: " + readBookmark.getBookmarkName());
//            System.out.println("Register Date: " + readBookmark.getRegisterDate());
//            System.out.println("Edit Date: " + readBookmark.getEditDate());
//        } else {
//            System.out.println("Bookmark not found.");
//        }
//
//        // 북마크 삭제
//        bookmarkService.deleteBookmark(bookmark1.getBookmark_Id());
//
//        // 삭제된 북마크 읽기 시도
//        readBookmark = bookmarkService.readBookmark(bookmark1.getBookmark_Id());
//        if (readBookmark != null) {
//            System.out.println("Deleted Bookmark: " + readBookmark.getBookmarkName());
//        } else {
//            System.out.println("Bookmark not found.");
//        }
    }
}
