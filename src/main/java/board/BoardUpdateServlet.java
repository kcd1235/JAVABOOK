package board;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/C04boardUpdate")
public class BoardUpdateServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int nowPage=Integer.parseInt(request.getParameter("nowPage"));
		int num=Integer.parseInt(request.getParameter("num"));
		HttpSession session=request.getSession();
		BoardBean bean=(BoardBean)session.getAttribute("bean");
		
		BoardMgr bMgr=new BoardMgr();
		BoardBean upbean=new BoardBean();
		
		upbean.setNum(Integer.parseInt(request.getParameter("num")));
		upbean.setName(request.getParameter("name"));
		upbean.setSubject(request.getParameter("subject"));
		upbean.setContent(request.getParameter("content"));
		upbean.setPass(request.getParameter("pass"));
		upbean.setIp(request.getParameter("ip"));
		
		String afterpwd=upbean.getPass();
		String beforepwd=bean.getPass();
		
		if(afterpwd.equals(beforepwd)) {
			bMgr.updateBoard(upbean);
			response.sendRedirect("/JAVABOOK/read.jsp?nowPage="+nowPage+"&num="+num);
		}
		else {
			PrintWriter out=response.getWriter();
			out.println("<script charset='utf-8>");
			out.println("alert('패스워드가 다릅니다')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		
		
		
		
	}
}