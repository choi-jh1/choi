package matPick.bean;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class QnaDAO {
   private QnaDAO() {} 
   private static QnaDAO instance = new QnaDAO();
   public static QnaDAO getInstance() {
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
   // 문의/건의 작성 
   public int boardInsert(QnaDTO dto) {
      int result = 0;
      try {
         conn=getConn();
         sql = "insert into qna (num, writer, title, img, content,ask, reg) values (qna_seq.NEXTVAL, ?, ?, ?, ?,1, sysdate)";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, dto.getWriter());
         pstmt.setString(2, dto.getTitle());
         pstmt.setString(3, dto.getImg());
         pstmt.setString(4, dto.getContent());
         result = pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close(conn,pstmt,rs);
      }
      return result;
   }
      
   // 글 목록 조회
   public ArrayList<QnaDTO> imgList(int startRow,int endRow){
      ArrayList<QnaDTO> list = new ArrayList<QnaDTO>();
      try {
         conn=getConn();
           sql = "SELECT * FROM ( "
                   + "  SELECT b.*, rownum r FROM ( "
                   + "    SELECT q.*, u.nick FROM qna q "
                   + "    JOIN users u ON q.writer = u.id "
                   + "    ORDER BY q.num DESC "
                   + "  ) b "
                   + ") WHERE r >= ? AND r <= ?";
         
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, startRow);
         pstmt.setInt(2, endRow);
         rs = pstmt.executeQuery();
         while(rs.next()) {
            QnaDTO dto = new QnaDTO();
            dto.setNum(rs.getInt("num"));
            dto.setTitle(rs.getString("title"));
            dto.setWriter(rs.getString("writer"));
            dto.setReg(rs.getTimestamp("reg"));
            dto.setImg(rs.getString("img"));
            dto.setAsk(rs.getInt("ask"));
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
   // 총 글 개수 
   public int imgCount() {
      int result=0;
      try {
         conn = getConn();
         sql = "select count(*) from qna";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            result=rs.getInt(1);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close(conn,pstmt,rs);
      }
      return result;
   }
   // 글 내용 
   public QnaDTO imgContent(int num) {
      QnaDTO dto = new QnaDTO();
      try {
         conn=getConn();
         sql = "SELECT q.*, u.nick FROM qna q " +
                 "JOIN users u ON q.writer = u.id " +
                 "WHERE q.num = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            dto.setNum(rs.getInt("num"));
            dto.setWriter(rs.getString("writer"));
            dto.setTitle(rs.getString("title"));
            dto.setImg(rs.getString("img"));
            dto.setReg(rs.getTimestamp("reg"));
            dto.setContent(rs.getString("content"));
            dto.setNick(rs.getString("nick"));
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally{
         close(conn,pstmt,rs);
      }
      return dto;      
   }
   
      // 글 삭제 
      public String imgDelete(int num) {
         String img = "";
         try {
            conn = getConn();
            sql = "select * from qna where num = ?"; // 글 번호에 해당하는 정보 모두 꺼내 
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num); 
            rs = pstmt.executeQuery();
            if(rs.next()) {
               img = rs.getString("img"); // 파일이름꺼내기
            }
            sql = "delete from  qna where num=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num);
            pstmt.executeUpdate();
         } catch (Exception e) {
            e.printStackTrace();
         } finally {
            close(conn,pstmt,rs);
         }
         return img;
      }
      
      // 상태 변경
      public void ask(int boardNum) {
         try {
         conn = getConn();
         sql = "update qna set ask=2 where num=?";
         pstmt.setInt(1, boardNum);
         pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         close(conn,pstmt,rs);
      }
     }
   
      // 답변 대기중 수
      public int waitCount() {
         int result = 0;
         try {
         conn = getConn();
         sql = "select count(*) from qna where ask=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, 1);
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
      
      // 내 문의내역 조회
      public ArrayList<QnaDTO> myQna(int startRow,int endRow,String sid){
         ArrayList<QnaDTO> list = new ArrayList<QnaDTO>();
         try {
         conn = getConn();
           sql = "SELECT * FROM ( "
                   + "  SELECT b.*, rownum r FROM ( "
                   + "    SELECT q.*, u.nick FROM qna q "
                   + "    JOIN users u ON q.writer = u.id "
                   + "    ORDER BY q.num DESC "
                   + "  ) b "
                   + ") WHERE r >= ? AND r <= ? AND writer = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, startRow);
         pstmt.setInt(2, endRow);
         pstmt.setString(3, sid);
         rs = pstmt.executeQuery();
         while(rs.next()) {
            QnaDTO dto = new QnaDTO();
            dto.setNum(rs.getInt("num"));
            dto.setTitle(rs.getString("title"));
            dto.setWriter(rs.getString("writer"));
            dto.setReg(rs.getTimestamp("reg"));
            dto.setImg(rs.getString("img"));
            dto.setAsk(rs.getInt("ask"));
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
      
      
      // 내 문의/건의 글 수
      public int myQnaCount(String sid) {
         int result = 0;
         try {
         conn = getConn();
         sql = "select count(*) from qna where writer=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, sid);
         rs = pstmt.executeQuery();
         if(rs.next()){
            result = rs.getInt(1);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         close(conn,pstmt,rs);
      }
         return result;
      }
      // 전체 문의/건의 글 개수
      public int qnaCount() {
          int result = 0;
          try {
              conn = getConn();
              sql = "SELECT COUNT(*) FROM qna";
              pstmt = conn.prepareStatement(sql);
              rs = pstmt.executeQuery();
              if (rs.next()) {
                  result = rs.getInt(1);
              }
          } catch (Exception e) {
              e.printStackTrace();
          } finally {
              close(conn, pstmt, rs);
          }
          return result;
      }
}








