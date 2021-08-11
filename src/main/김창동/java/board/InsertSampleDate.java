package board;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class InsertSampleDate {

	public static void main(String[] args) {
		DBConnectionMgr pool = DBConnectionMgr.getInstance();
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql=null;
		try {
			conn=pool.getConnection();
			for(int i=1;i<=1000;i++)
			{
			sql="insert into BoardTbl(name,subject,content,regdate,pass,count,ip)";
			sql+=" values('aaa"+i+"','bbb"+i+"','ccc"+i+"',now(),'1234',0,'127.0.0.1');";
			pstmt=conn.prepareStatement(sql);
			pstmt.executeUpdate();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt);
		}


	}

}
