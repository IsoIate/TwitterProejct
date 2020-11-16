package dao;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SignUpController")
public class SignUpController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String nextPage = null;
	boolean check = false;
    public SignUpController() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
