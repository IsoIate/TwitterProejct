package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

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
	
	/*
		데이터베이스 -> 추후 세분화
		
		CREATE TABLE `user_database` (
		  `id` varchar(30) NOT NULL,
		  `pw` varchar(45) NOT NULL,
		  `number` int NOT NULL AUTO_INCREMENT,
		  `nickname` varchar(45) DEFAULT NULL,
		  `email` varchar(40) NOT NULL,
		  `year` int DEFAULT NULL,
		  `month` int DEFAULT NULL,
		  `day` int DEFAULT NULL,
		  PRIMARY KEY (`number`)
		);
	*/
	

	// 회원가입
	public void signUp(String id, String password, String email, String year, String month, String day){	 
		try {
			String sql = "INSERT INTO USER_DATABASE (ID, PW, EMAIL, YEAR, MONTH, DAY) VALUE (?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			pstmt.setString(3, email);
			pstmt.setString(4, year);
			pstmt.setString(5, month);
			pstmt.setString(6, day);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("회원가입 오류");
		}

	}
	
	// 로그인
	public int signIn(String id, String password){ 	
		int cnt = 0;
		try {
			String sql = "SELECT COUNT(*) CNT FROM USER_DATABASE WHERE ID=? AND PW=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id); 
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();
			
			while(rs.next()) cnt = rs.getInt(1);
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("로그인 예외");
		}
		return cnt;
	}
	
	// 회원정보 조회
	public UserData userData(int year, int month, int day, int follow, int follower){
		try {
			String sql = "SELECT * FROM USER_DATABASE WHERE YEAR = ? MONTH = ? DAY = ? FOLLOW = ? FOLLOWER = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, year);
			pstmt.setInt(1, month);
			pstmt.setInt(1, day);
			pstmt.setInt(1, follow);
			pstmt.setInt(1, follower);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("회원정보 조회 오류");
		}
		return userdata;
	}



}
