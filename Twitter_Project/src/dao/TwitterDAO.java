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

import dto.BirthdayDTO;
import dto.FWDTO;
import dto.InfoDTO;
import dto.LoginDTO;
import dto.TwitDTO;

public class TwitterDAO {
	
	private static TwitterDAO twitterDAO = null;
	private Connection conn;
	private Statement st;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
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
	
	public int userNumExq(String userId) {
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
	public ArrayList<TwitDTO> selectTwit(int userNum) {
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
	public void deleteTwit(int userNum, int twitnumber) {
		
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
	
	public int deleteTwitUser (int userNum) {
		String twitCount = "SELECT count(user_num) twits FROM twit WHERE user_num=?";
		return twitCounter(twitCount, userNum);
	}

	public int searchId(String id) {
		int isID = 0;
		
		try {
			String sql = "SELECT count(id) id FROM user_login WHERE id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				isID = rs.getInt(1);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("searchId error");
		}
		
		return isID;
	}
	
	public int searchInfo(String email, int year, int month, int day) {
		int correct = 0;
		
		try {
			String sql = "SELECT count(*) cnt "
					+ "FROM user_info, user_birthday "
					+ "WHERE user_info.email=? AND user_birthday.year=? AND user_birthday.month=? AND user_birthday.day=? "
					+ "AND user_info.user_num = user_birthday.user_num;";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setInt(2, year);
			pstmt.setInt(3, month);
			pstmt.setInt(4, day);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				correct = rs.getInt(1);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("searchId error");
		}
		
		return correct;
	}
	
	public void changePw(String newPw, String userId) {		
		try {
			String sql = "UPDATE user_login set pw=? WHERE id=?" ;
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newPw);
			pstmt.setString(2, userId);
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("changePw error");
		}
	}
	
	public ArrayList<TwitDTO> searchPop() {
		String sql = "SELECT user_login.id, text, twittime FROM user_login, twit WHERE user_login.user_num = twit.user_num ORDER BY rand()";
		ArrayList<TwitDTO> searchResult = new ArrayList<TwitDTO>();
		SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd");
		TwitDTO twit = new TwitDTO();
		LoginDTO login = new LoginDTO();
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				login.setId(rs.getString(1));				// 유저 아이디
				twit.setLoginDTO(login);
				twit.setText(rs.getString(2));				// 유저 트윗
				Date to = simple.parse(rs.getString(3));	
				twit.setTwittime(to);						// 트윗 작성일자
				searchResult.add(twit);						// ArrayList타입으로 반환
			}
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("searchPop error");
		}
		return searchResult;
	}
	
	public void searchLate() {
		String sql = "SELECT user_login.id, text, twittime FROM user_login, twit WHERE user_login.user_num = twit.user_num ORDER BY twittime DESC";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				rs.getString(1);
				rs.getString(2);
				rs.getString(3);
			}
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("changePw error");
		}
	}
	
	public void searchUser() {
		String sql = "SELECT user_login.id, user_info.profileImg FROM user_login, user_info WHERE user_login.user_num = user_info.user_num";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				rs.getString(1);
				rs.getString(2);
			}
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("changePw error");
		}
	}
	
	public void searchPhoto() {
		String sql = "SELECT user_login.id, text, twittime FROM user_login, twit WHERE user_login.user_num = twit.user_num ORDER BY rand()";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("changePw error");
		}
	}
	
	public void searchVideo() {
		String sql = "SELECT user_login.id, text, twittime FROM user_login, twit WHERE user_login.user_num = twit.user_num ORDER BY rand()";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("changePw error");
		}
	}

}
