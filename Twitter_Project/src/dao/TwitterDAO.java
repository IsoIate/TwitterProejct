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

import com.mysql.cj.Session;

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
			String sql[] = {"INSERT INTO user_login (ID, PW) VALUE (?, ?)",					// login
					"INSERT INTO user_info (EMAIL, NICKNAME, PROFILEIMG) VALUE (?, ?, ?)",	// info
					"INSERT INTO user_birthday (YEAR, MONTH, DAY) VALUE (?, ?, ?)",			// birthday
					"SELECT USER_NUM FROM USER_LOGIN WHERE ID=? AND PW = ?",				// userNum
					"INSERT INTO user_fw (user_num) VALUE (?)"								// insertNum
			};
			String img = "./img/profile.png";
			
			insertLogin(sql[0], id, password);
			insertInfo(sql[1], email, id, img);
			insertBirthday(sql[2], year, month, day);
			int userNum = userNumEx(sql[3], id, password);
			insertNum(sql[4], userNum);
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("회원가입 오류");
		}

	}
	
	void insertLogin(String sql, String id, String password) {
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("insertLogin error");
		}
	}
	
	void insertInfo(String sql, String email, String id, String img) {
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, id);
			pstmt.setString(3, img);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("insertInfo error");
		}
	}
	
	void insertBirthday(String sql, String year, String month, String day) {
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, year);
			pstmt.setString(2, month);
			pstmt.setString(3, day);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("insertBirthday error");
		}
	}
	
	void insertNum(String sql, int userNum) {
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("insertNum error");
		}
	}
	
	// 로그인
	public ArrayList<Integer> signIn(String id, String password){ 	

		ArrayList<Integer> userInfo = new ArrayList<>();
		
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String[] date = null;
			String temp = null;
			int userNum = 0;
			
			String user_num = "SELECT USER_NUM FROM USER_LOGIN WHERE ID=? AND PW = ?";
			String fCount = "SELECT user_info.twitcount,  user_fw.follow, user_fw.follower FROM user_info, user_fw "
					+ "where user_info.user_num=? AND user_info.user_num = user_fw.user_num";
			String madeTime = "SELECT madetime FROM user_info WHERE user_num=?";
	
			userInfo.add(userNum = userNumEx(user_num, id, password));
			
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
				userInfo.add(Integer.parseInt(date[i]));
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("로그인 예외");
		}
		return userInfo;
	}
	
	int userNumEx(String sql, String id, String pw) {
		int user_num = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
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
	
	// 트윗 작성
	public int insertTwit(String twit, String userId) {
		int twits = 0;
		
		try {
			
			String user_Num = "SELECT USER_NUM FROM USER_LOGIN WHERE ID=?";
			String insertTwit = "INSERT INTO twit_write (user_num, text, twittime) VALUE (?, ?, now())";
			String twitCount = "SELECT count(user_num) twits FROM twit_write WHERE user_num=?";
			int userNum = userNumExq(user_Num, userId);
			
			insertTwitEx(insertTwit, userNum, twit);	
			twits = selectTwits(twitCount, userNum);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return twits;
	}
	
	int userNumExq(String sql, String userId) {
		int user_num = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				user_num = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("userNumExq error");
		}
		
		return user_num;
	}

	void insertTwitEx(String sql, int userNum, String text) {
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			pstmt.setString(2, text);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("insertTwitEx error");
		}
	}
	
	int selectTwits(String sql, int userNum) {
		int twits = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				twits = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("insertTwitEx error");
		}
		
		return twits;
	}
	
	
	
	
//	public UserData userData(int year, int month, int day, int follow, int follower){
//		try {
//			String sql = "SELECT * FROM USER_DATABASE WHERE YEAR = ? MONTH = ? DAY = ? FOLLOW = ? FOLLOWER = ?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, year);
//			pstmt.setInt(2, month);
//			pstmt.setInt(3, day);
//			pstmt.setInt(4, follow);
//			pstmt.setInt(5, follower);
//		}catch(Exception e) {
//			e.printStackTrace();
//			System.out.println("회원정보 조회 오류");
//		}
//		return userdata;
//	}



}
