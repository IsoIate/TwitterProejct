package dao;
import java.sql.Array;
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
		LoginDTO login = new LoginDTO();
		
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
			login.setUser_num(userNumEx(sql[3], id, password));
			insertNum(sql[4], login.getUser_num());

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
	public InfoDTO signIn(String id, String password){ 	
		InfoDTO info = new InfoDTO();
		BirthdayDTO birthday = new BirthdayDTO();
		FWDTO fw = new FWDTO();
		
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String[] date = null;
			String temp = null;
			int userNum = 0;
			
			String user_num = "SELECT USER_NUM FROM USER_LOGIN WHERE ID=? AND PW = ?";
			String fCount = "SELECT user_fw.follow, user_fw.follower FROM user_fw WHERE user_num=?";
			String madeTime = "SELECT madetime FROM user_info WHERE user_num=?";
			String twitCount = "SELECT count(user_num) twits FROM twit WHERE user_num=?";
			userNum = userNumEx(user_num, id, password);			
			
			if(userNum != 0) {
				info.setUser_num(userNum);
				info.setTwitCount(twitCounter(twitCount, userNum));
				
				pstmt = conn.prepareStatement(fCount);
				pstmt.setInt(1, userNum);
				rs = pstmt.executeQuery(); 
				
				while(rs.next()) {					
					fw.setFollow(rs.getInt(1));
					fw.setFollower(rs.getInt(2));
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
				birthday.setYear(Integer.parseInt(date[0]));
				birthday.setMonth(Integer.parseInt(date[1]));
				birthday.setDay(Integer.parseInt(date[2]));
			}
			info.setBirthdaDto(birthday);
			info.setFwdto(fw);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("로그인 예외");
		}
		
		return info;
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
			String insertTwit = "INSERT INTO twit (user_num, text, twittime) VALUE (?, ?, now())";
			String twitCount = "SELECT count(user_num) twits FROM twit WHERE user_num=?";
			int userNum = userNumExq(user_Num, userId);
			
			insertTwitEx(insertTwit, userNum, twit);	
			twits = twitCounter(twitCount, userNum);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return twits;
	}
	
	int userNumExq(String userId) {
		int user_num = 0;
		
		try {
			String sql = "SELECT USER_NUM FROM USER_LOGIN WHERE ID=?";
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
	
	int twitCounter(String sql, int userNum) {
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
			System.out.println("twitCounter error");
		}
		
		return twits;
	}
	
	// 트윗 게시글 조회
	ArrayList<TwitDTO> selectTwit(int userNum) {
		ArrayList<TwitDTO> twits = new ArrayList<>();

		try {
			String selectTwits = "SELECT TEXT, TWITNUMBER FROM twit WHERE USER_NUM=? ORDER BY twitnumber DESC";
			
			pstmt = conn.prepareStatement(selectTwits);
			pstmt.setInt(1, userNum);
			rs = pstmt.executeQuery(); 
			
			while(rs.next()) {
				TwitDTO dto = new TwitDTO();
				dto.setText(rs.getString(1));
				dto.setTwitnumber(rs.getInt(2));
				twits.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("selectTwit error");
		}
		
		return twits;
	}
	
	// 트윗 삭제
	void deleteTwit(int userNum, int twitnumber) {
		
		try {
			String deleteTwitSql = "DELETE FROM twit WHERE user_num=? and twitnumber=?";
			
			pstmt = conn.prepareStatement(deleteTwitSql);
			pstmt.setInt(1, userNum);
			pstmt.setInt(2, twitnumber);
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("deleteTwit error");
		}
	}
	
	int deleteTwitUser (int userNum) {
		String twitCount = "SELECT count(user_num) twits FROM twit WHERE user_num=?";
		return twitCounter(twitCount, userNum);
	}



}
