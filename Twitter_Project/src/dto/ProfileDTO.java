package dto;

public class ProfileDTO {
	private int user_num;
	private String nickname;
	private String img;
	private String profile;
	
	public ProfileDTO() { }
	
	public ProfileDTO(int user_num, String nickname, String img, String profile) {
		super();
		this.user_num = user_num;
		this.nickname = nickname;
		this.img = img;
		this.profile = profile;
	}
	
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
}
