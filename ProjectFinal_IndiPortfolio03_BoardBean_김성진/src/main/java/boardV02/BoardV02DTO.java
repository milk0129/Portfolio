package boardV02;

public class BoardV02DTO {
	
	private int bod_no;
	
	private String bod_writer;
	private String bod_email;
	private String bod_subject;
	private String bod_pwd;
	private String bod_logtime;
	private String bod_content;
	private int bod_readCnt;
	private String bod_connIp;
	
	public BoardV02DTO() {
	   
	}

	public BoardV02DTO(int bod_no, String bod_writer, String bod_email, String bod_subject, String bod_pwd,
			String bod_logtime, String bod_content, int bod_readCnt, String bod_connIp) {
		super();
		this.bod_no = bod_no;
		this.bod_writer = bod_writer;
		this.bod_email = bod_email;
		this.bod_subject = bod_subject;
		this.bod_pwd = bod_pwd;
		this.bod_logtime = bod_logtime;
		this.bod_content = bod_content;
		this.bod_readCnt = bod_readCnt;
		this.bod_connIp = bod_connIp;
	}
	
	public int getBod_no() {
		return bod_no;
	}
	
	public void setBod_no(int bod_no) {
		this.bod_no = bod_no;
	}
	public String getBod_writer() {
		return bod_writer;
	}
	public void setBod_writer(String bod_writer) {
		this.bod_writer = bod_writer;
	}
	public String getBod_email() {
		return bod_email;
	}
	public void setBod_email(String bod_email) {
		this.bod_email = bod_email;
	}
	public String getBod_subject() {
		return bod_subject;
	}
	public void setBod_subject(String bod_subject) {
		this.bod_subject = bod_subject;
	}
	public String getBod_pwd() {
		return bod_pwd;
	}
	public void setBod_pwd(String bod_pwd) {
		this.bod_pwd = bod_pwd;
	}
	public String getBod_logtime() {
		return bod_logtime;
	}
	public void setBod_logtime(String bod_logtime) {
		this.bod_logtime = bod_logtime;
	}
	public String getBod_content() {
	    return bod_content == null ? "" : bod_content;
	}
	public void setBod_content(String bod_content) {
		this.bod_content = bod_content;
	}
	public int getBod_readCnt() {
		return bod_readCnt;
	}
	public void setBod_readCnt(int bod_readCnt) {
		this.bod_readCnt =  bod_readCnt;
	}
	public String getBod_connIp() {
		return bod_connIp;
	}
	public void setBod_connIp(String bod_connIp) {
		this.bod_connIp = bod_connIp;
	}

}
