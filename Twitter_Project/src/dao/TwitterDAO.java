package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class TwitterDAO {
	
	private static TwitterDAO twitterDAO = null;
	private Connection conn;
	private Statement st;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private UserData userdata;
	
	public TwitterDAO() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/twitterdb?characterEncoding=UTF-8&serverTimezone=UTC", "root", "root");
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 회원가입
	public void signUp(String id, String password, String email, String year, String month, String day){	 
		try {
			SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			
			String[] time = format1.format(date).split("-");
			String login = "INSERT INTO user_login (ID, PW) VALUE (?, ?)";
			String info = "INSERT INTO user_info (EMAIL, NICKNAME, PROFILEIMG) VALUE (?, ?, ?)";
			String birthday = "INSERT INTO user_birthday (YEAR, MONTH, DAY) VALUE (?, ?, ?)";
			String img = "./img/profile.png";
			
			pstmt = conn.prepareStatement(login);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(info);
			pstmt.setString(1, email);
			pstmt.setString(2, id);
			pstmt.setString(3, img);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(birthday);
			pstmt.setString(1, year);
			pstmt.setString(2, month);
			pstmt.setString(3, day);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("회원가입 오류");
		}

	}
	
	
	
	// 로그인
	public ArrayList<Integer> signIn(String id, String password){ 	

		ArrayList<Integer> userInfo = new ArrayList<>();
		
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String[] date = null;
			String temp = null;
			
			
			String user_num = "SELECT user_num FROM user_login WHERE id=?";
			int userNum = userNumEx(user_num, id);
			String isUser = "SELECT COUNT(*) CNT FROM USER_LOGIN WHERE ID=? AND PW=?";
			System.out.println("isuser : " + isUserEx(isUser, id, password));
			userInfo.add(isUserEx(isUser, id, password));
			String fCount = "SELECT twitcount, follow, follower FROM twitterdb.user_info where user_num=?";
			String madeTime = "SELECT madetime FROM user_info WHERE user_num=?";
	
			pstmt = conn.prepareStatement(user_num);
			while(rs.next()) {
				System.out.println("userNumCheck : " + rs.getInt(1));
			}
			
			
			
//			pstmt = conn.prepareStatement(isUser);
//			pstmt.setString(1, id); 
//			pstmt.setString(2, password);
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()) userInfo.add(rs.getInt(1));
//			rs.close();
			
			pstmt = conn.prepareStatement(fCount);
			pstmt.setInt(1, userNum);
			rs = pstmt.executeQuery(); 
			
			while(rs.next()) {
				userInfo.add(rs.getInt(1));
				userInfo.add(rs.getInt(2));
				userInfo.add(rs.getInt(3));
			}
			rs.close();
			
			pstmt = conn.prepareStatement(madeTime);
			pstmt.setInt(1, userNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Date tempDate = rs.getDate(1);
				temp = format.format(tempDate);
				date = temp.split("-");
			}
			
			for (int i = 0; i < 3; i++) {
				System.out.println(date);
				userInfo.add(Integer.parseInt(date[i]));
				System.out.println("date : " + userInfo.get(i));
			}
		
			userInfo.add(3);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("로그인 예외");
		}
		return userInfo;
	}
	
	int userNumEx(String sql, String id) {
		int user_num = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				user_num = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("userNumEx error");
		}
		
		return user_num;
	}
	
	int isUserEx(String sql, String id, String password) {
		int isUser = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id); 
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();
			
			while(rs.next())
				isUser = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("isUserEx Error");
		}
		return isUser;
	}
	
	
	// 회원정보 조회
	public UserData userData(int year, int month, int day, int follow, int follower){
		try {
			String sql = "SELECT * FROM USER_DATABASE WHERE YEAR = ? MONTH = ? DAY = ? FOLLOW = ? FOLLOWER = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, year);
			pstmt.setInt(2, month);
			pstmt.setInt(3, day);
			pstmt.setInt(4, follow);
			pstmt.setInt(5, follower);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("회원정보 조회 오류");
		}
		return userdata;
	}



}
