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

public class TabController implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		TwitterDAO dao = new TwitterDAO();
		String searchInput = request.getParameter("searchContext");	// 검색어
		
		String pop = request.getParameter("tabName");
		ArrayList<TwitDTO> searchResult = null;						// 검색 결과 리스트
		
		if(pop.equals("인기")) {
			searchResult = dao.searchPop(searchInput);
		}
		else if(pop.equals("최신")) {
			searchResult = dao.searchLate(searchInput);
		}
		else if(pop.equals("사용자")) {
			searchResult = dao.searchUser(searchInput);
		}
		else if(pop.equals("사진")) {
			searchResult = dao.searchPop(searchInput);
		}
		else if(pop.equals("동영상")) {
			searchResult = dao.searchPop(searchInput);
		}
		request.setAttribute("searchInput", searchInput);
		request.setAttribute("searchResult", searchResult);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("search.jsp");
		dispatcher.forward(request, response);
	}
	
}
