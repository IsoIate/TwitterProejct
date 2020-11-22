package dao;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/PageController")
public class PageController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public PageController() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String userId = (String) session.getAttribute("userId");
		String userPw = (String) session.getAttribute("userPw");
		
		TwitterDAO dao = new TwitterDAO();
		InfoDTO info = dao.signIn(userId, userPw);
		
		request.setAttribute("info", info);
		
		request.setAttribute("twits", dao.selectTwit(info.getUser_num()));
		RequestDispatcher dispatcher = request.getRequestDispatcher("./profile.jsp");
		dispatcher.forward(request, response);
	}
}
