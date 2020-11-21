package dao;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/TwitWriteController")
public class TwitWriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public TwitWriteController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		request.setCharacterEncoding("utf-8");
		
		String twit = request.getParameter("twit");
		String userId = (String) session.getAttribute("userId");
		int userNum = (int) session.getAttribute("userNum");
		ArrayList<String> twits = new ArrayList<>();
		
		TwitterDAO dao = new TwitterDAO();
		session.setAttribute("twitCount", dao.insertTwit(twit, userId));

		if(!session.getAttribute("twitCount").equals(0)) {
			twits = dao.selectTwit(userNum);
			session.setAttribute("twits", twits);
		}
		
		if(session.getAttribute("currentPage").equals("home.jsp")) {
			response.sendRedirect("home.jsp");
		}
		else if (session.getAttribute("currentPage").equals("profile.jsp")) {
			response.sendRedirect("profile.jsp");
		}
	}

}
