package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import command.Command;
import dto.TwitDTO;
import dao.TwitterDAO;

public class TwitWriteController implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();	
		request.setCharacterEncoding("utf-8");
		
		// 파일 업로드 관련
		// String savePath = "C:/Users/50405/git/TwitterProject/Twitter_Project/WebContent/upload";
		String savePath = request.getServletContext().getRealPath("upload");
		int sizeLimit = 1024*1024*15;
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());;
		
		ArrayList<TwitDTO> twits = new ArrayList<>();
		TwitterDAO dao = new TwitterDAO();
		String userId = (String) session.getAttribute("userId");
		
		if(multi.getFilesystemName("inputImage") != null) {		
			String fileName = multi.getFilesystemName("inputImage");
			String filePathName = "./upload/" + fileName;
			
			System.out.println("file : " + "./upload/" + fileName);
			
			// 트윗 작성 관련
			String twit = multi.getParameter("twit");
			session.setAttribute("twitCount", dao.insertTwit(twit, userId, filePathName));
		}
		else {
			// 트윗 작성 관련
			String twit = multi.getParameter("twit");
			
			session.setAttribute("twitCount", dao.insertTwit(twit, userId));
		}
		
		

		if(session.getAttribute("currentPage").equals("home")) {
			response.sendRedirect("login.do");
		}
		else if (session.getAttribute("currentPage").equals("profile")) {
			response.sendRedirect("profile.do");
		}		
	}

}
