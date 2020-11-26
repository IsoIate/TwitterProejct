package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.Command;
import dao.TwitterDAO;
import dto.TwitDTO;


public class SearchController implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		TwitterDAO dao = new TwitterDAO();
		
		if(request.getParameter("popularity") != null) {
			request.setAttribute("searchResult", dao.searchPop());
		}
		else if(request.getParameter("latest") != null) {
			dao.searchPop();
		}
		else if(request.getParameter("user") != null) {
			dao.searchPop();
		}
		else if(request.getParameter("photo") != null) {
			dao.searchPop();
		}
		else if(request.getParameter("video") != null) {
			dao.searchPop();
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("search.jsp");
		dispatcher.forward(request, response);
		
	}

}
