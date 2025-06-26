package matPick.bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CommentsDAO {
	// 인스턴스 객체 생성
	private static CommentsDAO instance = new CommentsDAO();
	// 생성자 접근 불가
	private CommentsDAO() {};
	// 유일한 객체 반환 메서드
	public static CommentsDAO getInstance() {
		return instance;
	}
	
	// 필요 변수 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = null;
	
	// 연결 객체 생성
	private Connection getConn() throws Exception {
		// 드라이버 로딩
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String user = "cjh";
		String pw = "tiger";
		
		conn = DriverManager.getConnection(url,user,pw);
		return conn;
	}
	
	private void close(Connection conn,PreparedStatement pstmt, ResultSet rs) {
		if(conn != null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		if(pstmt != null) {try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
		if(rs != null) {try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
	}
	
	// 댓글 입력
	public int commentInsert(CommentsDTO dto) {
		int result = 0;
		int num = dto.getCommentNum();
		int ref = dto.getRef();
		int re_level = dto.getRe_level();
		int re_step = dto.getRe_step();
		int number = 0;
		
		try {
			conn = getConn();
			// 새 글번호 생성
			sql = "select max(commentNum) from comments";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				number = rs.getInt(1)+1;
			}else {
				number = 1;
			}
			
			// 답글인 경우
			if(num != 0) {
				sql = "update comments set re_step=re_step+1 where ref=? and re_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step+1;
				re_level = re_level+1;
			}else {	// 새글인 경우
				ref = number;
				re_step = 0;
				re_level = 0;
			}
			sql = "insert into comments(commentNum,num,writer,content,ref,re_level,re_step,deleted,reg) values(comments_seq.nextval,?,?,?,?,?,?,'n',sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,dto.getNum());
			pstmt.setString(2,dto.getWriter());
			pstmt.setString(3,dto.getContent());
			pstmt.setInt(4, ref);
			pstmt.setInt(5, re_level);
			pstmt.setInt(6, re_step);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn,pstmt,rs);
		}
		
		return result;
	}
	
	// 댓글 목록
	public ArrayList<CommentsDTO> commentList(int startRow,int endRow, int num){
		ArrayList<CommentsDTO> list = new ArrayList<CommentsDTO>();
		try {
			conn = getConn();
			sql = "select * from(select b.*, rownum r from(select * from comments c"
					+ " join users u on c.writer=u.id"
					+ " where num=? "
					+ " order by"
					+ "  ref asc, re_level asc,re_step desc) b) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CommentsDTO dto = new CommentsDTO();
				dto.setCommentNum(rs.getInt("commentNum"));
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setContent(rs.getString("content"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_level(rs.getInt("re_level"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setDeleted(rs.getString("deleted"));
				dto.setNick(rs.getString("nick"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn,pstmt,rs);
		}
		return list;
	}
	
	// 댓글 삭제
	public int commentDelete(int commentNum) {
		int result = 0;
		try {
			conn = getConn();
			sql = "update comments set deleted='y' where commentNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, commentNum);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn,pstmt,rs);
		}
		return result;
	}
	
	// 댓글 진짜 삭제용
	public int commentDelete1(int commentNum) {
		int result = 0;
		try {
			conn = getConn();
			sql = "delete from comments where commentNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, commentNum);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn,pstmt,rs);
		}
		return result;
	}
	
	// 댓글 갯수
	public int commentCount(int num) {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from comments where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn,pstmt,rs);
		}
		return result;
	}
	
	   // 댓글 활동랭킹
	   public ArrayList<CommentsDTO> commentTopCount(){
	      ArrayList<CommentsDTO> list = new ArrayList<CommentsDTO>();
	      try {
	         conn = getConn();
	         sql = "select u.nick,count(*) as commentCount from comments c "
	         		+ "join users u on c.writer=u.id group by u.nick order by commentCount desc fetch first 5 rows only";
	         pstmt = conn.prepareStatement(sql);
	         rs = pstmt.executeQuery();
	         while(rs.next()) {
	            CommentsDTO dto = new CommentsDTO();
	            dto.setNick(rs.getString("nick"));
	            dto.setCommentCount(rs.getInt("commentCount"));
	            list.add(dto);
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         close(conn, pstmt, rs);
	      }
	      return list;
	   }
	
}
