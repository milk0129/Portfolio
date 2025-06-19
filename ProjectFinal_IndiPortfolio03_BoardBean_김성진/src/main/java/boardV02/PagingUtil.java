package boardV02;

public class PagingUtil {
    private int nowPage, nowBlock, totalRecord, recPerPage, pagePerBlock;

    public PagingUtil(int nowPage, int nowBlock, int totalRecord, int recPerPage, int pagePerBlock) {
        this.nowPage = nowPage;
        this.nowBlock = nowBlock;
        this.totalRecord = totalRecord;
        this.recPerPage = recPerPage;
        this.pagePerBlock = pagePerBlock;
    }

    public int getNowPage() { return nowPage; }
    public int getNowBlock() { return nowBlock; }
    public int getTotalPage() {
        return (int)Math.ceil((double)totalRecord / recPerPage);
    }
    public int getTotalBlock() {
        return (int)Math.ceil((double)getTotalPage() / pagePerBlock);
    }
    public int getStartPage() {
        return nowBlock * pagePerBlock;
    }
    public int getEndPage() {
        return Math.min(getStartPage() + pagePerBlock - 1, getTotalPage() - 1);
    }
    public int getRecOfBeginPage() {
        return nowPage * recPerPage + 1;
    }
    public int getRecOfEndPage() {
        return getRecOfBeginPage() + recPerPage - 1;
    }
    public int getPagePerBlock() {
        return pagePerBlock;
    }

}
