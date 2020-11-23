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

public class TwitDeleteController implements TCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");

		int twitnumber = Integer.parseInt(request.getParameter("twitnumber"));
		ArrayList<TwitDTO> twits = new ArrayList<>();
		
		TwitterDAO dao = new TwitterDAO();
		
		int userNum = dao.userNumExq(userId);
		dao.deleteTwit(userNum, twitnumber);
		session.setAttribute("twitCount", dao.deleteTwitUser(userNum));
		
		if(!session.getAttribute("twitCount").equals(0)) {
			twits = dao.selectTwit(userNum);
			session.setAttribute("twits", twits);
		}
		
		response.sendRedirect((String) session.getAttribute("currentPage"));
		
	}

}
