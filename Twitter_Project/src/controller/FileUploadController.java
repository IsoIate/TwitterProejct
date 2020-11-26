package controller;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import command.Command;

public class FileUploadController implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("euc-kr");
		// 저장 경로 
		String path = "C:/Users/50405/git/TwitterProject/Twitter_Project/WebContent/upload";
		
		int size = 1024 * 1024 * 10; // 저장가능한 파일 크기
		String file = ""; // 업로드 한 파일의 이름(이름이 변경될수 있다)
		String originalFile = ""; // 이름이 변경되기 전 실제 파일 이름
		
		// 실제로 파일 업로드하는 과정
		try{
		    MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
		
		    Enumeration files = multi.getFileNames();
		    String str = (String)files.nextElement(); // 파일 이름을 받아와 string으로 저장
		
		    file = multi.getFilesystemName(str); // 업로드 된 파일 이름 가져옴
		    originalFile = multi.getOriginalFileName(str); // 원래의 파일이름 가져옴
		    System.out.println(file);
		} catch (Exception e) {
		    e.printStackTrace();
		}
		
	}
	
}
