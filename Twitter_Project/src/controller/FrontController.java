package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandHandler;


@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CommandHandler handler = null;
	
    public FrontController() {
        super();
        handler = new CommandHandler();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requestURI.substring(contextPath.length());
		String cmd =  command.substring(1, command.length() - 3);
		System.out.println(cmd);
		try {
			handler.getCommand(cmd).execute(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
//		String nextPage = handler.getCommand(cmd).execute(request, response);
//		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
//		dispatcher.forward(request, response);
	}

}
