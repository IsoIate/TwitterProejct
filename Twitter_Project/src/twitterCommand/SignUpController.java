package twitterCommand;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.TwitterDAO;

public class SignUpController implements TCommand {
	private static final long serialVersionUID = 1L;
	String nextPage = null;
	boolean check = false;

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");		
		String id = request.getParameter("createId");
		String pw = request.getParameter("createPw");
		String email = request.getParameter("createEmail");
		String date = request.getParameter("createDate");
		String get[] = {id, pw, email, date};
		
		check = errorCheck(get);
		if(check == false) {
			response.sendRedirect("signUpError.jsp");
		}
		else {
			String splitDate[] = date.split("\\."); 
			String year = splitDate[0];
			String month = splitDate[1];
			String day = splitDate[2];

			TwitterDAO dao = new TwitterDAO();
			dao.signUp(id, pw, email, year, month, day);
			
			response.sendRedirect("signUpComplete.jsp");
		}
		
	}
	
	// 입력 값이 공백인지 판별하는 메소드
		public boolean errorCheck(String[] args) {
			for(int i = 0; i < args.length; i++) {
				System.out.println(args[i]);
				if(args[i] == null || args[i].trim().isEmpty()) {
					return false;
				}
			}
			return true;
		}

}
