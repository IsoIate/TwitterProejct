package twitterCommand;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.TwitDTO;
import dao.TwitterDAO;

public class TwitWriteController implements TCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		request.setCharacterEncoding("utf-8");
		
		String twit = request.getParameter("twit");
		String userId = (String) session.getAttribute("userId");
//		int userNum = (int) session.getAttribute("userNum");
		ArrayList<TwitDTO> twits = new ArrayList<>();
		
		TwitterDAO dao = new TwitterDAO();
		session.setAttribute("twitCount", dao.insertTwit(twit, userId));
		
//		if(!session.getAttribute("twitCount").equals(0)) {
//			twits = dao.selectTwit(userNum);
//			session.setAttribute("twits", twits);
//		}
		
		if(session.getAttribute("currentPage").equals("./login.do")) {
			response.sendRedirect("./login.do");
		}
		else if (session.getAttribute("currentPage").equals("./Page.do")) {
			response.sendRedirect("./Page.do");
		}		
	}

}
