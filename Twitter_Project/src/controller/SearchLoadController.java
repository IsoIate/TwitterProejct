package controller;

import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import command.Command;
import dao.TwitterDAO;
import dto.TwitDTO;

public class SearchLoadController implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/json; charset=utf-8");
		
		TwitterDAO dao = new TwitterDAO();
		String searchInput = request.getParameter("searchContext");
		
		ArrayList<TwitDTO> searchResult = dao.searchPop(searchInput);
		
		ObjectMapper objectMapper = new ObjectMapper();
		String obj = objectMapper.writeValueAsString(searchResult);
		System.out.println(obj);
		response.getWriter().println(obj);
		
	}

}
