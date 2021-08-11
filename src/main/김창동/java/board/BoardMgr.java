package board;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import jakarta.servlet.jsp.JspWriter;
import jakarta.servlet.jsp.PageContext;


public class BoardMgr {

	private DBConnectionMgr pool;

	public BoardMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	public int getTotalCount() {
		int total=0;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=pool.getConnection();
			pstmt=conn.prepareStatement("select count(*) from BoardTbl");
			rs=pstmt.executeQuery();
			if(rs.next()) {
				total=rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt);
		}
		
		return total; 
	}

	public Vector<BoardBean> getBoardList(int start, int end)
	{
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=null;
		Vector<BoardBean> blist=new Vector();
		try {
			conn=pool.getConnection();
			sql="select * from BoardTbl order by num desc limit ?,?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardBean bean=new BoardBean();
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				blist.add(bean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return blist;
	}
		

	public void upCount(int num) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql=null;
		try {
			conn=pool.getConnection();
			sql="update BoardTbl set count=count+1 where num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt);
		}
	}	
	

	public BoardBean getBoard(int num) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=null;
		BoardBean bean=new BoardBean();
		try {
			conn=pool.getConnection();
			sql="select * from BoardTbl where num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setPass(rs.getString("pass"));
				bean.setIp(rs.getString("ip"));
				bean.setCount(rs.getInt("count"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt,rs);
		}
		//완성하기
		return bean;
	}
	

	public void insertBoard(HttpServletRequest req) throws IOException, ServletException {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql=null;
		try {
			conn=pool.getConnection();
			sql="insert into BoardTbl(name,subject,content,regdate,pass,ip,count) values(?,?,?,now(),?,?,0)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,req.getParameter("name"));
			pstmt.setString(2,req.getParameter("subject"));
			pstmt.setString(3,req.getParameter("content"));
			pstmt.setString(4,req.getParameter("pass"));
			pstmt.setString(5,req.getParameter("ip"));
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt);
		}
		//완성하기
	}

	public void updateBoard(BoardBean bean) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql=null;
		try {
			conn=pool.getConnection();
			sql="update BoardTbl set name=?,subject=?,content=? where num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getSubject());
			pstmt.setString(3, bean.getContent());
			pstmt.setInt(4, bean.getNum());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt);
		}
	}
	
	public void deleteBoard(int num) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql=null;
		try {
			conn=pool.getConnection();
			sql="delete from BoardTbl where num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt);
		}
	}
	 
	public static void main(String[] args) {
		new BoardMgr();
		
		System.out.println("SUCCESS");
	}
}