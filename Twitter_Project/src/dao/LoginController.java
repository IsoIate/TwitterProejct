package dao;

import java.io.IOException;
import java.util.ArrayList;

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
		ArrayList<Integer> user = dao.signIn(id, password);
		
		// UserData user = dao.userData(year, month, day, follow, follower);
		
		if(user.get(0) != 0) {
			nextPage = "home.jsp";
			session.setAttribute("userId", id);
			session.setAttribute("userPw", password);
			session.setAttribute("userNum",user.get(1));
			session.setAttribute("twitCount",user.get(2));
			session.setAttribute("follow",user.get(3));
			session.setAttribute("follower",user.get(4));
			session.setAttribute("madeYear",user.get(5));
			session.setAttribute("madeMonth",user.get(6));
			session.setAttribute("madeDay",user.get(7));
			
			session.setAttribute("twits", dao.selectTwit(user.get(1)));	// 트윗 조회 후 가져오기
		}
		else nextPage = "loginError.jsp";
		
		response.sendRedirect(nextPage);
	}

}
