package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.Command;
import dao.TwitterDAO;
import dto.InfoDTO;

public class HomeController implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		HttpSession session = request.getSession();
//		TwitterDAO dao = new TwitterDAO();
//		InfoDTO info = InfoDTO.getInstance();
//		
//		int user_num = info.getUser_num();
//		System.out.println(user_num);
//		session.setAttribute("twits", dao.selectTwit(user_num));
//		
//		RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
//		dispatcher.forward(request, response);
	}

}
