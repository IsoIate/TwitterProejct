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

public class PwChangeController implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		
		String userId = (String) session.getAttribute("userId");
		String newPw = request.getParameter("newPw");
		String newPwRepeat = request.getParameter("newPwRepeat");
		
		if(newPw.equals(newPwRepeat)) {
			TwitterDAO dao = new TwitterDAO();
			dao.changePw(newPw, userId);
			request.setAttribute("pwRepeat", "yes");
			RequestDispatcher dispatcher = request.getRequestDispatcher("pwReset.jsp");
			dispatcher.forward(request, response);
		}
		else {
			request.setAttribute("pwRepeat", "no");
			RequestDispatcher dispatcher = request.getRequestDispatcher("pwReset.jsp");
			dispatcher.forward(request, response);
		}
		
	}
	
}
