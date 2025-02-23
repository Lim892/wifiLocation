package OpneApi;

public class BookmarkListInfo {
    private int bookmark_Id;
    private String bookmarkName;
    private String wifiName;
    private String listRegisterDate;
    private String management_Number;


    public String getManagement_Number() {
        return management_Number;
    }

    public void setManagement_Number(String manegement_Number) {
        this.management_Number = manegement_Number;
    }



    public int getBookmark_Id() {
        return bookmark_Id;
    }

    public void setBookmark_Id(int bookmark_Id) {
        this.bookmark_Id = bookmark_Id;
    }

    public String getBookmarkName() {
        return bookmarkName;
    }

    public void setBookmarkName(String bookmarkName) {
        this.bookmarkName = bookmarkName;
    }

    public String getWifiName() {
        return wifiName;
    }

    public void setWifiName(String wifiName) {
        this.wifiName = wifiName;
    }

    public String getListRegisterDate() {
        return listRegisterDate;
    }

    public void setListRegisterDate(String listRegisterDate) {
        this.listRegisterDate = listRegisterDate;
    }
}
