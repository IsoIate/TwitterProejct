package dto;

public class LoginDTO {
	private int user_num;
	private String id;
	private String pw;
	
	public LoginDTO() {}
	
	public LoginDTO(int user_num, String id, String pw) {
		super();
		this.user_num = user_num;
		this.id = id;
		this.pw = pw;
	}
	
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	
}
