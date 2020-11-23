package twitterCommand;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static HashMap<String, TCommand> hashmap = new HashMap<String, TCommand>();
    public FrontController() {
        super();
    }

    static {
    	hashmap.put("/login.do", new LoginController());
    	hashmap.put("/logout.do", new LogoutController());
    	hashmap.put("/SignUp.do", new SignUpController());
    	hashmap.put("/TwitDelete.do", new TwitDeleteController());
    	hashmap.put("/TwitWrite.do", new TwitWriteController());
    	hashmap.put("/Page.do", new PageController());
    }
    
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requestURI.substring(contextPath.length());
		String cmd = command.substring(1, command.length() - 3);

		try {
			TCommand tc = hashmap.get(command);
			tc.execute(request, response);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	

}
