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
import dao.TwitterDAO;
import dto.TwitDTO;


public class SearchController implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		TwitterDAO dao = new TwitterDAO();
		String searchInput = request.getParameter("searchContext");
		
		request.setAttribute("searchInput", searchInput);
		ArrayList<TwitDTO> searchResult = null;
		
		searchResult = dao.searchPop(searchInput);
		request.setAttribute("searchResult", searchResult);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("search.jsp");
		dispatcher.forward(request, response);
		
	}

}
