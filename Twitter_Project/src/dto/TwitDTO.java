package dto;

import java.util.Date;

public class TwitDTO {
	private int user_num;
	private String text;
	private Date twittime;
	private int twitnumber;
	private LoginDTO loginDTO;
	
	public TwitDTO () {}
	
	public TwitDTO(int user_num, String text, Date twittime, int twitnumber) {
		super();
		this.user_num = user_num;
		this.text = text;
		this.twittime = twittime;
		this.twitnumber = twitnumber;
	}
	
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public Date getTwittime() {
		return twittime;
	}
	public void setTwittime(Date twittime) {
		this.twittime = twittime;
	}
	public int getTwitnumber() {
		return twitnumber;
	}
	public void setTwitnumber(int twitnumber) {
		this.twitnumber = twitnumber;
	}

	public LoginDTO getLoginDTO() {
		return loginDTO;
	}

	public void setLoginDTO(LoginDTO loginDTO) {
		this.loginDTO = loginDTO;
	}
	
}
