package dao;

public class FWDTO {
	private int user_num;
	private int follow;
	private int follower;
	
	public FWDTO() {}
	
	public FWDTO(int user_num, int follow, int follower) {
		super();
		this.user_num = user_num;
		this.follow = follow;
		this.follower = follower;
	}
	
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public int getFollow() {
		return follow;
	}
	public void setFollow(int follow) {
		this.follow = follow;
	}
	public int getFollower() {
		return follower;
	}
	public void setFollower(int follower) {
		this.follower = follower;
	}
	
}
