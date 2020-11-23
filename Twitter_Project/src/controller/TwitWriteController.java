package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.Command;
import dto.TwitDTO;
import dao.TwitterDAO;

public class TwitWriteController implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
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
		
		if(session.getAttribute("currentPage").equals("home")) {
			response.sendRedirect("login.do");
		}
		else if (session.getAttribute("currentPage").equals("profile")) {
			response.sendRedirect("page.do");
		}		
	}

}
