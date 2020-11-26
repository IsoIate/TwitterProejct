package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.Command;
import dto.InfoDTO;
import dao.TwitterDAO;

public class LoginController implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String id = request.getParameter("loginId") == null ? (String) session.getAttribute("userId") : request.getParameter("loginId");
		String password = request.getParameter("loginPw") == null ? (String) session.getAttribute("userPw") : request.getParameter("loginPw");
		
		
		String nextPage = null;

		TwitterDAO dao = new TwitterDAO();
		InfoDTO info = dao.signIn(id, password);
		
		
		// UserData user = dao.userData(year, month, day, follow, follower);
		
		if(info.getUser_num() != 0) {
			nextPage = "home.jsp";
			session.setAttribute("userId", id);
			session.setAttribute("userPw", password);
			
			request.setAttribute("info", info);
//			session.setAttribute("userNum",user.get(0));
//			session.setAttribute("twitCount",user.get(1));
//			session.setAttribute("follow",user.get(2));
//			session.setAttribute("follower",user.get(3));
//			session.setAttribute("madeYear",user.get(4));
//			session.setAttribute("madeMonth",user.get(5));
//			session.setAttribute("madeDay",user.get(6));
			
			session.setAttribute("twits", dao.selectTwit(info.getUser_num()));	// 트윗 조회 후 가져오기
		}
		else nextPage = "loginError.jsp";
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
	}

}
