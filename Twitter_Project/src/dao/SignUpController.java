package dao;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SignUpController")
public class SignUpController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SignUpController() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("createId");
		String pw = request.getParameter("createPw");
		String email = request.getParameter("createEmail");
		String date = request.getParameter("createDate");
		
		System.out.println("con date : " + date);
		String splitDate[] = date.split("\\."); 
		String year = splitDate[0];
		String month = splitDate[1];
		String day = splitDate[2];

		TwitterDAO dao = new TwitterDAO();
		dao.signUp(id, pw, email, year, month, day);
		
		RequestDispatcher disp = request.getRequestDispatcher("signUpComplete.jsp");
		disp.forward(request, response);
	}

}
