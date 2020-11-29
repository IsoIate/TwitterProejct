package dto;

import java.util.Date;

public class InfoDTO {
	private int user_num;
	private String email;
	private int twitCount;
	private Date madeTime;
	private BirthdayDTO birthdaDto;
	private FWDTO fwdto;
	
	public InfoDTO() {}
	
	public InfoDTO(int user_num, String email, int twitCount, Date madeTime) {
		super();
		this.user_num = user_num;
		this.email = email;
		this.twitCount = twitCount;
		this.madeTime = madeTime;
	}
	
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getTwitCount() {
		return twitCount;
	}
	public void setTwitCount(int twitCount) {
		this.twitCount = twitCount;
	}
	public Date getMadeTime() {
		return madeTime;
	}
	public void setMadeTime(Date madeTime) {
		this.madeTime = madeTime;
	}

	public BirthdayDTO getBirthdaDto() {
		return birthdaDto;
	}

	public void setBirthdaDto(BirthdayDTO birthdaDto) {
		this.birthdaDto = birthdaDto;
	}

	public FWDTO getFwdto() {
		return fwdto;
	}

	public void setFwdto(FWDTO fwdto) {
		this.fwdto = fwdto;
	}
		
}
