package twitterCommand;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.InfoDTO;
import dao.TwitterDAO;

public class PageController implements TCommand {


	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
