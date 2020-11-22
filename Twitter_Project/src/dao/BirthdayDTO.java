package dao;

public class BirthdayDTO {
	private int user_num;
	private int year;
	private int month;
	private int day;
	
	public BirthdayDTO() {}
	
	public BirthdayDTO(int user_num, int year, int month, int day) {
		super();
		this.user_num = user_num;
		this.year = year;
		this.month = month;
		this.day = day;
	}
	
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	
}
