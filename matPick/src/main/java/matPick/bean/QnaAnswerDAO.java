package matPick.bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class QnaAnswerDAO {
	private QnaAnswerDAO() {} 
	private static QnaAnswerDAO instance = new QnaAnswerDAO();
	public static QnaAnswerDAO getInstance() {
		return instance;
	}
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;
	
	private Connection getConn() throws Exception{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String user = "cjh";
		String pw = "tiger";
		
		conn = DriverManager.getConnection(url,user,pw);
		return conn;
	}
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {if (conn != null) {conn.close();}} catch(SQLException e) {e.printStackTrace();}
		try {if (pstmt != null) {pstmt.close();}} catch(SQLException e) {e.printStackTrace();}
		try {if (rs != null) {rs.close();}} catch(SQLException e) {e.printStackTrace();}
		
	}
	
	
	// 답변 하기
	public int answerInsert(QnaAnswerDTO dto,int num) {
		int result = 0;
		try {
			conn = getConn();
			sql = "insert into qnaAnswer(qnaNum,num,writer,content,reg) values(qnaAnswer_seq.nextval,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getContent());
			result = pstmt.executeUpdate();
			
			sql = "update qna set ask=2 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
		    pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn,pstmt,rs);
		}
		return result;
	}
	
	// 답변 내용
	public QnaAnswerDTO answerInfo(int num) {
		QnaAnswerDTO dto = new QnaAnswerDTO();
		try {
			conn = getConn();
			sql = "select * from qnaAnswer where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setContent(rs.getString("content"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setQnaNum(rs.getInt("qnaNum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn,pstmt,rs);
		}
		return dto;
	}
	
	// 답변 상태 완료
	public int answerStatus(int num) {
		int result = 0;
		try {
			conn = getConn();
			sql = "update qna set ask=2 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn,pstmt,rs);
		}
		return result;
	}
	
	// 답변 삭제
	public int deleteAnswer(int num,int qnaNum) {
		int result = 0;
		try {
			conn = getConn();
			// 답변 상태 대기중으로 변경
			sql = "update qna set ask=1 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			// 답변 삭제
			sql = "delete from qnaAnswer where qnaNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qnaNum);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn,pstmt,rs);
		}
		return result;
	}
	
}
