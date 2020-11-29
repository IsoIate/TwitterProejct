package controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.Command;
import dao.TwitterDAO;
import dto.InfoDTO;
import dto.ProfileDTO;

public class ProfileUpdateController implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String userId = (String) session.getAttribute("userId");
		String userPw = (String) session.getAttribute("userPw");
		String nick = request.getParameter("inputName");
		String profile = request.getParameter("inputProfile");

		TwitterDAO dao = new TwitterDAO();
		dao.profileUpdater(userId, nick, profile);
		
		InfoDTO info = dao.signIn(userId, userPw);
		ProfileDTO pro = dao.selectProfile(userId);
		
		request.setAttribute("info", info);
		request.setAttribute("profile", pro);
		request.setAttribute("twits", dao.selectTwit(info.getUser_num()));
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
		dispatcher.forward(request, response);
	}

}
