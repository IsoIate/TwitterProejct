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
	
	// 회원가입
	public void signUp(String id, String password){	 
		try {
			String sql = "INSERT INTO USER_DATABASE (ID, PW) VALUE (?, ?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
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
	
	public void login(){
		try {
			String sql = "select * from a where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 5);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
