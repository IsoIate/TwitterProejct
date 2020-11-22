package dao;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/TwitDeleteController")
public class TwitDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public TwitDeleteController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int userNum = (int) session.getAttribute("userNum");
		int twitnumber = Integer.parseInt(request.getParameter("twitnumber"));
		ArrayList<TwitDTO> twits = new ArrayList<>();
		
		TwitterDAO dao = new TwitterDAO();
		dao.deleteTwit(userNum, twitnumber);
		session.setAttribute("twitCount", dao.deleteTwitUser(userNum));
		
		if(!session.getAttribute("twitCount").equals(0)) {
			twits = dao.selectTwit(userNum);
			session.setAttribute("twits", twits);
		}
		
		response.sendRedirect((String) session.getAttribute("currentPage"));
	}

}
