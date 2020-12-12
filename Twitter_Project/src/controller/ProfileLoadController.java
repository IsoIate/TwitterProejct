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

public class ProfileLoadController implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/json; charset=utf-8");
		
		String userId = (String) session.getAttribute("userId");
		String userPw = (String) session.getAttribute("userPw");
		
		TwitterDAO dao = new TwitterDAO();
		InfoDTO info = dao.signIn(userId, userPw);
		ProfileDTO pro = dao.selectProfile(userId);
		
		ArrayList<TwitDTO> twit = dao.selectTwit(info.getUser_num());
		ObjectMapper objectMapper = new ObjectMapper();
		String obj = objectMapper.writeValueAsString(twit);
//		System.out.println(obj);
		response.getWriter().println(obj);
	}

}
