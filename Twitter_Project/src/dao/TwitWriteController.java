package dao;

import java.io.IOException;
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
		
		String twit = request.getParameter("twit");
		String userId = (String) session.getAttribute("userId");
		
		TwitterDAO dao = new TwitterDAO();
		session.setAttribute("twitCount", dao.insertTwit(twit, userId));
		
		response.sendRedirect("home.jsp");
	}

}
