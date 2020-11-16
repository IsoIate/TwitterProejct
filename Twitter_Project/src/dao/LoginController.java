package dao;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public LoginController() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("loginId");
		String password = request.getParameter("loginPw");
		String nextPage = null;
		HttpSession session = request.getSession();

		TwitterDAO dao = new TwitterDAO();
		int user = dao.signIn(id, password);
		
		// UserData user = dao.userData(year, month, day, follow, follower);
		
		if(user == 1) {
			nextPage = "home.jsp";
			session.setAttribute("userId", id);
			session.setAttribute("userPw", password);
		}
		else nextPage = "loginError.jsp";
		
		response.sendRedirect(nextPage);
	}

}
