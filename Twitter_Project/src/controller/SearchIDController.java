package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.Command;
import dao.TwitterDAO;

public class SearchIDController implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("searchId");

		TwitterDAO dao = new TwitterDAO();
		if(dao.searchId(id) == 1) {
			request.setAttribute("isID", "yes");
			RequestDispatcher dispatcher = request.getRequestDispatcher("pwReset.jsp");
			dispatcher.forward(request, response);
		}
		else {
			request.setAttribute("isID", "no");
			RequestDispatcher dispatcher = request.getRequestDispatcher("pwReset.jsp");
			dispatcher.forward(request, response);
		}
		
	}

}
