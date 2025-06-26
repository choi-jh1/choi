package matPick.bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class NoticeDAO {
	// 인스턴스 객체 생성
	private static NoticeDAO instance = new NoticeDAO();
	// 생성자 접근 불가
	private NoticeDAO() {};
	// 유일한 객체 반환 메서드
	public static NoticeDAO getInstance() {
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
	
	// 공지사항 쓰기
	public int insertNotice(NoticeDTO dto) {
		int result = 0;
		try {
			conn = getConn();
			sql = "insert into notice values(notice_seq.nextval,?,?,?,'공지',sysdate,0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getWriter());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn,pstmt,rs);
		}
		return result;
	}
	
	// 공지사항 목록
	public ArrayList<NoticeDTO> noticeList(){
		ArrayList<NoticeDTO> list = new ArrayList<NoticeDTO>();
		try {
			conn = getConn();
			sql = "select * from notice order by num desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNum(rs.getInt("num"));
				dto.setTitle(rs.getString("title"));
				dto.setWriter(rs.getString("writer"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setType(rs.getString("type"));
				dto.setReadCount(rs.getInt("readCount"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn,pstmt,rs);
		}
		return list;
	}
	
	// 공지사항 수
	public int noticeCount() {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from notice";
			pstmt = conn.prepareStatement(sql);
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
	
	// 공지사항 삭제
	public int noticeDelete(int num) {
		int result = 0;
		try {
			conn = getConn();
			// 2. 파일 삭제
			sql = "delete from notice where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn,pstmt,rs);
		}
		return result;
	}
	
	// 공지사항 조회
	public NoticeDTO noticeInfo(int num) {
		NoticeDTO dto = new NoticeDTO();
		try {
			conn = getConn();
			sql = "update notice set readCount = readCount+1 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.executeUpdate();
			
			sql = "select * from notice where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setWriter(rs.getString("writer"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setType(rs.getString("type"));
				dto.setReadCount(rs.getInt("readCount"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn,pstmt,rs);
		}
		return dto;
	}
	
	// 공지사항 수정
	public int noticeUpdate(NoticeDTO dto,int num) {
		int result = 0;
		try {
			conn = getConn();
			sql = "update notice set title=?,content=? where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, num);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn,pstmt,rs);
		}
		return result;
	}
	
}
