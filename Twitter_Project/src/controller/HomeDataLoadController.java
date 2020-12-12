package controller;

import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import command.Command;
import dao.TwitterDAO;
import dto.InfoDTO;
import dto.ProfileDTO;
import dto.TwitDTO;

public class HomeDataLoadController implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/json; charset=utf-8");

		HttpSession session = request.getSession();
		String id = request.getParameter("loginId") == null ? (String) session.getAttribute("userId")
				: request.getParameter("loginId");
		String password = request.getParameter("loginPw") == null ? (String) session.getAttribute("userPw")
				: request.getParameter("loginPw");
		

		TwitterDAO dao = new TwitterDAO(); 
		InfoDTO info = dao.signIn(id, password);
		 
		ArrayList<TwitDTO> twit = dao.selectTwit(info.getUser_num());
		ObjectMapper objectMapper = new ObjectMapper();
		String obj = objectMapper.writeValueAsString(twit);
//		System.out.println(obj);
		response.getWriter().println(obj);
	}

}
