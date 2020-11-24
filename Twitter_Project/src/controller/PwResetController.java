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

public class PwResetController implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String email = request.getParameter("searchE");
		
		TwitterDAO dao = new TwitterDAO();
		if(email == null || request.getParameter("searchY").equals("년") || request.getParameter("searchM").equals("월") || request.getParameter("searchD").equals("일")) {
			request.setAttribute("isID", "no");
			RequestDispatcher dispatcher = request.getRequestDispatcher("pwReset.jsp");
			dispatcher.forward(request, response);
		}
		else {
			int year = Integer.parseInt(request.getParameter("searchY"));
			int month = Integer.parseInt(request.getParameter("searchM"));
			int day = Integer.parseInt(request.getParameter("searchD"));
		
			if(dao.searchInfo(email, year, month, day) == 1) {
				request.setAttribute("correct", "yes");
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

}
