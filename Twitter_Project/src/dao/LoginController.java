package dao;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		TwitterDAO dao = new TwitterDAO();
		System.out.println("logincontroller\n id : " + id + " pw : " + password);
		int user = dao.signIn(id, password);
		
		if(user == 1) nextPage = "profile.jsp";
		else nextPage = "loginError.jsp";
		
		RequestDispatcher disp = request.getRequestDispatcher(nextPage);
		disp.forward(request, response);
	}

}
