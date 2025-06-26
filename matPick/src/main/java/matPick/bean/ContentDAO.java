package matPick.bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import matPick.bean.ContentDTO;

public class ContentDAO {
   private static ContentDAO instance = new ContentDAO();
   private ContentDAO() {}
   public static ContentDAO getInstance() {
      return instance;
   }
   
   private Connection   conn;
   private ResultSet   rs;
   private String       sql;
   private PreparedStatement pstmt;
   
   private Connection getConn() throws Exception {
      Class.forName("oracle.jdbc.driver.OracleDriver");
      String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String user = "cjh";
		String pw = "tiger";
      
       
      conn = DriverManager.getConnection(url, user, pw);
      return conn;
   }
   
   private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
      try { if( conn != null ) { conn.close(); } } catch ( SQLException e)  { e.printStackTrace(); }
      try { if( pstmt!= null ) {pstmt.close(); } } catch ( SQLException e)  { e.printStackTrace(); }
      try { if(   rs != null ) {   rs.close(); } } catch ( SQLException e)  { e.printStackTrace(); }
   }
   
   // 새 글 쓰기 (1차)   
   public int contentInsert( ContentDTO dto ) {
      int result = 0;   
      
      try {
         conn = getConn();
         // 이미지, 회원정보 추후 추가 예정 img 서머노트 사용시 db 저장 x  
         sql = " insert into content( category, num, title, content, writer, readcount, reg ) "
                       + " values( ?, content_seq.nextval, ?, ?, ?, 0, sysdate)";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString( 1,  dto.getCategory());
         pstmt.setString( 2,  dto.getTitle() );
         pstmt.setString( 3,  dto.getContent() );
         pstmt.setString(4, dto.getWriter() );
         result = pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close(conn, pstmt, rs);
      }                  
      return result;
   }
   
   public int contentCount(String category) {
         int result = 0;
         try {    
            conn = getConn();
            if(category.equals("전체글")) {
               sql = " select count(*) from content";
               pstmt = conn.prepareStatement(sql);
            } else {
               sql = " select count(*) from content where category = ? ";
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, category );
            }
            rs = pstmt.executeQuery();
            if ( rs.next() ) {
               result = rs.getInt(1);
            }
         } catch (Exception e) {   
            e.printStackTrace();
         } finally {
            close(conn, pstmt, rs);
         }
         return result;
      }
   
   // 게시판 목록
   public ArrayList<ContentDTO> contentList(int start, int end) {
      ArrayList<ContentDTO> list = new ArrayList<ContentDTO>();
      
      try {
         conn = getConn();
         sql = "SELECT * FROM ( "
                   + "  SELECT b.*, rownum r FROM ( "
                   + "    SELECT * FROM content c "
                   + "    left JOIN users u ON c.writer = u.id "
                   + "    ORDER BY c.num DESC "
                   + "  ) b "
                   + ") WHERE r >= ? AND r <= ?";
         
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, start);
         pstmt.setInt(2,  end);
         rs = pstmt.executeQuery();
         // 테이블 추가시 추가해야함
         while( rs.next() ) {
            ContentDTO dto = new ContentDTO();
            dto.setNum(rs.getInt("num"));
            dto.setWriter(rs.getString("writer"));
            dto.setTitle(rs.getString("title"));    
            dto.setContent(rs.getString("content"));
            dto.setReadCount(rs.getInt("readCount"));
            dto.setReg(rs.getTimestamp("reg"));
               dto.setCategory(rs.getString("category"));
               dto.setNick(rs.getString("nick"));
            list.add(dto);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close(conn, pstmt, rs);
      }
      
      return list;
   }
      
   public ArrayList<ContentDTO> categoryContentList(int start, int end, String category) {
      ArrayList<ContentDTO> list = new ArrayList<ContentDTO>();
      
      try {
         conn = getConn();
         sql = " SELECT * FROM ( "
                  + " SELECT b.*, rownum r FROM ( "
                   + " SELECT c.*, u.nick FROM content c "
                   + " left JOIN users u ON c.writer = u.id "
                   + " WHERE c.category = ? "
                   + " ORDER BY c.num DESC "
                   + "  ) b "
                   + ") WHERE r >= ? AND r <= ?";
         
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, category);
         pstmt.setInt(2, start);
         pstmt.setInt(3,  end);
         rs = pstmt.executeQuery();
         // 테이블 추가시 추가해야함
         while( rs.next() ) {
            ContentDTO dto = new ContentDTO();
            dto.setNum(rs.getInt("num"));
            dto.setWriter(rs.getString("writer"));
            dto.setTitle(rs.getString("title"));    
            dto.setContent(rs.getString("content"));
            dto.setReadCount(rs.getInt("readCount"));
            dto.setReg(rs.getTimestamp("reg"));
            dto.setCategory(rs.getString("category"));
            dto.setNick(rs.getString("nick"));
            list.add(dto);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close(conn, pstmt, rs);
      }
      return list;
   }
   
   
   
   // 글 내용 확인
   public ContentDTO contentContent( int num ) {
      ContentDTO dto = new ContentDTO();
      
      try {
         conn = getConn();
         sql = " update content set readCount=readCount+1 where num=? ";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1 , num);
         pstmt.executeUpdate();
         
         sql = "select * from content c join users u on c.writer=u.id where num=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1,  num);
         rs = pstmt.executeQuery();
         if( rs.next() ) {
            dto.setNum( rs.getInt("num") );
            dto.setWriter(rs.getString("writer"));
            dto.setTitle( rs.getString("title") );
            dto.setContent( rs.getString("content") );
            dto.setReadCount( rs.getInt("readCount") );
            dto.setReg( rs.getTimestamp("reg") );
               dto.setCategory(rs.getString("category"));
               dto.setNick(rs.getString("nick"));
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close(conn, pstmt, rs);
      }
      return dto;
   }
   // 글 내용 수정
   public int contentUpPro(ContentDTO dto) {
      int result = 0;
      
      try {
         conn = getConn();
         sql = " update content set title=?, content=?, category=?, reg=sysdate where num=? ";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1,  dto.getTitle() );
         pstmt.setString(2, dto.getContent() );
         pstmt.setString(3, dto.getCategory());
         pstmt.setInt(4,  dto.getNum() );
         
         result = pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close(conn, pstmt, rs);
      }
      return result;
   }
   
   public int ContentDelete(int num) {
      int result = 0;
      
      try {
         conn = getConn();
         sql = " delete from content where num=? ";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1,  num);
         result = pstmt.executeUpdate();
         
      } catch (Exception e) {     
         e.printStackTrace();
      } finally {
         close(conn, pstmt, rs);
      }
      return result;
   }
   
   public ArrayList<ContentDTO> myBoardList(int startRow, int endRow, String sid) {
	   ArrayList<ContentDTO> list = new ArrayList<>();

	   try {
	      conn = getConn();
	      sql = " SELECT * FROM ( "
	           + " SELECT b.*, rownum r FROM ( "
	           + " SELECT c.*, u.nick FROM content c "
	           + " JOIN users u ON c.writer = u.id "
	           + " WHERE c.writer = ? "
	           + " ORDER BY c.num DESC "
	           + " ) b "
	           + " ) WHERE r >= ? AND r <= ?";
	      pstmt = conn.prepareStatement(sql);
	      pstmt.setString(1, sid); // writer 조건 먼저
	      pstmt.setInt(2, startRow);
	      pstmt.setInt(3, endRow);
	      rs = pstmt.executeQuery();

	      while (rs.next()) {
	         ContentDTO dto = new ContentDTO();
	         dto.setNum(rs.getInt("num"));
	         dto.setWriter(rs.getString("writer"));
	         dto.setTitle(rs.getString("title"));
	         dto.setReg(rs.getTimestamp("reg"));
	         dto.setReadCount(rs.getInt("readCount"));
	         dto.setCategory(rs.getString("category"));
	         dto.setNick(rs.getString("nick"));
	         list.add(dto);
	      }
	   } catch (Exception e) {
	      e.printStackTrace();
	   } finally {
	      close(conn, pstmt, rs);
	   }
	   return list;
	}

   // 게시물 활동랭킹
   public ArrayList<ContentDTO> boardTopCount(){
      ArrayList<ContentDTO> list = new ArrayList<ContentDTO>();
      try {
         conn = getConn();
         sql = "select u.nick,count(*) as boardCount from content c "
         		+ "join users u on c.writer=u.id group by u.nick order by boardCount desc fetch first 5 rows only";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         while(rs.next()) {
            ContentDTO dto = new ContentDTO();
            dto.setNick(rs.getString("nick"));
            dto.setBoardCount(rs.getInt("boardCount"));
            list.add(dto);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close(conn, pstmt, rs);
      }
      return list;
   }

   
   /* 전체 게시글 인기글 조회 */
   public ArrayList<ContentDTO> hotContentList(int startRow, int endRow) {
       ArrayList<ContentDTO> list = new ArrayList<>();

       try {
           conn = getConn();
           sql = "SELECT * FROM ( " +
                    "  SELECT a.*, ROWNUM rnum FROM ( " +
                    "    SELECT c.*, u.nick FROM content c " +
                    "    left JOIN users u ON c.writer = u.id " +
                    "    ORDER BY c.readCount DESC " +
                    "  ) a WHERE ROWNUM <= ? " +
                    ") WHERE rnum >= ?";

           pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, endRow);     // 먼저 큰 값
           pstmt.setInt(2, startRow);   // 그다음 작은 값
           rs = pstmt.executeQuery();

           while (rs.next()) {
               ContentDTO dto = new ContentDTO();
               dto.setNum(rs.getInt("num"));
               dto.setWriter(rs.getString("writer"));
               dto.setTitle(rs.getString("title"));
               dto.setReg(rs.getTimestamp("reg"));
               dto.setReadCount(rs.getInt("readCount"));
               dto.setCategory(rs.getString("category"));
               dto.setNick(rs.getString("nick"));
               list.add(dto);
           }
       } catch (Exception e) {
           e.printStackTrace();
       } finally {
           close(conn, pstmt, rs);
       }

       return list;
   }

/* 카테고리 별 인기글 출력 */
   public ArrayList<ContentDTO> hotContentListByCategory(String category, int startRow, int endRow) {
       ArrayList<ContentDTO> list = new ArrayList<>();

       try {
           conn = getConn();
           sql = "SELECT * FROM ( " +
                    "  SELECT a.*, ROWNUM rnum FROM ( " +
                    "    SELECT c.*, u.nick FROM content c " +
                    "    left JOIN users u ON c.writer = u.id " +
                    "    WHERE c.category = ? " +
                    "    ORDER BY c.readCount DESC " +
                    "  ) a WHERE ROWNUM <= ? " +
                    ") WHERE rnum >= ?";
           pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, category);
           pstmt.setInt(2, endRow);
           pstmt.setInt(3, startRow);
           rs = pstmt.executeQuery();

           while (rs.next()) {
               ContentDTO dto = new ContentDTO();
               dto.setNum(rs.getInt("num"));
               dto.setWriter(rs.getString("writer"));
               dto.setTitle(rs.getString("title"));
               dto.setReg(rs.getTimestamp("reg"));
               dto.setReadCount(rs.getInt("readCount"));
               dto.setCategory(rs.getString("category"));
               dto.setNick(rs.getString("nick"));
               list.add(dto);
           }
       } catch (Exception e) {
           e.printStackTrace();
       } finally {
           close(conn, pstmt, rs);
       }

       return list;
   }

   public ContentDTO updateContent(int num) {
      ContentDTO dto = new ContentDTO();

      try {
         conn = getConn();
         sql = " select * from content where num=? ";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();

         if (rs.next()) {
            dto.setNum(rs.getInt("num"));
            dto.setWriter(rs.getString("writer"));
            dto.setTitle(rs.getString("title"));
            dto.setContent(rs.getString("content"));
            dto.setReadCount(rs.getInt("readCount"));
            dto.setCategory(rs.getString("category"));
            dto.setReg(rs.getTimestamp("reg"));

         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close(conn, pstmt, rs);
      }
      return dto;
   }
   
	// 내 글 개수 
	   public int myBoardCount(String writer) {
	      int result=0;
	      try {
	         conn = getConn();
	         sql = "select count(*) from content where writer=?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, writer);
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
	   
	   // 검색 조회
	      // 게시글 검색 리스트 (제목/작성자 검색 + 닉네임 포함 + 페이징)
	      public ArrayList<ContentDTO> searchContentList(String filter, String keyword, int start, int end, String category) {
	          ArrayList<ContentDTO> list = new ArrayList<>();
	          try {
	              conn = getConn();
	              String column = "c.title";
	              if ("작성자".equals(filter)) column = "u.nick";

	              if ("전체글".equals(category)) {
	                  sql = "SELECT * FROM ( " +
	                        "  SELECT b.*, rownum r FROM ( " +
	                        "    SELECT c.*, u.nick FROM content c " +
	                        "    JOIN users u ON c.writer = u.id " +
	                        "    WHERE " + column + " LIKE ? " +
	                        "    ORDER BY c.num DESC " +
	                        "  ) b " +
	                        ") WHERE r >= ? AND r <= ?";

	                  pstmt = conn.prepareStatement(sql);
	                  pstmt.setString(1, "%" + keyword + "%");
	                  pstmt.setInt(2, start);
	                  pstmt.setInt(3, end);
	              } else {
	                  sql = "SELECT * FROM ( " +
	                        "  SELECT b.*, rownum r FROM ( " +
	                        "    SELECT c.*, u.nick FROM content c " +
	                        "    JOIN users u ON c.writer = u.id " +
	                        "    WHERE c.category = ? AND " + column + " LIKE ? " +
	                        "    ORDER BY c.num DESC " +
	                        "  ) b " +
	                        ") WHERE r >= ? AND r <= ?";

	                  pstmt = conn.prepareStatement(sql);
	                  pstmt.setString(1, category);
	                  pstmt.setString(2, "%" + keyword + "%");
	                  pstmt.setInt(3, start);
	                  pstmt.setInt(4, end);
	              }

	              rs = pstmt.executeQuery();
	              while (rs.next()) {
	                  ContentDTO dto = new ContentDTO();
	                  dto.setNum(rs.getInt("num"));
	                  dto.setTitle(rs.getString("title"));
	                  dto.setWriter(rs.getString("writer"));
	                  dto.setNick(rs.getString("nick"));
	                  dto.setReg(rs.getTimestamp("reg"));
	                  dto.setReadCount(rs.getInt("readcount"));
	                  dto.setCategory(rs.getString("category"));
	                  list.add(dto);
	              }
	          } catch (Exception e) {
	              e.printStackTrace();
	          } finally {
	              close(conn, pstmt, rs);
	          }
	          return list;
	      }




	   // 검색 결과 개수
	   // 검색된 게시글 수 카운트 (페이징용)
	   public int searchContentCount(String filter, String keyword, String category) {
	       int count = 0;
	       try {
	           conn = getConn();
	           String column = "c.title";
	           if ("작성자".equals(filter)) column = "u.nick";

	           if ("전체글".equals(category)) {
	               sql = "SELECT COUNT(*) FROM content c " +
	                     "JOIN users u ON c.writer = u.id " +
	                     "WHERE " + column + " LIKE ?";
	               pstmt = conn.prepareStatement(sql);
	               pstmt.setString(1, "%" + keyword + "%");
	           } else {
	               sql = "SELECT COUNT(*) FROM content c " +
	                     "JOIN users u ON c.writer = u.id " +
	                     "WHERE c.category = ? AND " + column + " LIKE ?";
	               pstmt = conn.prepareStatement(sql);
	               pstmt.setString(1, category);
	               pstmt.setString(2, "%" + keyword + "%");
	           }

	           rs = pstmt.executeQuery();
	           if (rs.next()) {
	               count = rs.getInt(1);
	           }
	       } catch (Exception e) {
	           e.printStackTrace();
	       } finally {
	           close(conn, pstmt, rs);
	       }
	       return count;
	   }
	   
	   
	   // 통합검색
	   public ArrayList<ContentDTO> allSearch(String keyword, int start, int end) {
	          ArrayList<ContentDTO> list = new ArrayList<>();
	          try {
	              conn = getConn();
	                  sql = "SELECT * FROM ( " +
	                        "  SELECT b.*, rownum r FROM ( " +
	                        "    SELECT c.*, u.nick FROM content c " +
	                        "    JOIN users u ON c.writer = u.id " +
	                        "    WHERE  c.title  LIKE ? or  c.content  LIKE ?" +
	                        "    ORDER BY c.num DESC " +
	                        "  ) b " +
	                        ") WHERE r >= ? AND r <= ?";

	                  pstmt = conn.prepareStatement(sql);
	                  pstmt.setString(1, "%" + keyword + "%");
	                  pstmt.setString(2, "%" + keyword + "%");
	                  pstmt.setInt(3, start);
	                  pstmt.setInt(4, end);
	                  rs = pstmt.executeQuery();
	                  while (rs.next()) {
		                  ContentDTO dto = new ContentDTO();
		                  dto.setNum(rs.getInt("num"));
		                  dto.setTitle(rs.getString("title"));
		                  dto.setWriter(rs.getString("writer"));
		                  dto.setNick(rs.getString("nick"));
		                  dto.setReg(rs.getTimestamp("reg"));
		                  dto.setReadCount(rs.getInt("readcount"));
		                  dto.setCategory(rs.getString("category"));
		                  list.add(dto);
		              }
	              }catch (Exception e) {
	   	           e.printStackTrace();
	   	       } finally {
	   	           close(conn, pstmt, rs);
	   	       }
	          return list;
	   }
	   
	   // 통합검색 개수
	   public int allCount(String keyword) {
		   int result = 0;
		   try {
			conn = getConn();
			sql = "select count(*) from content where title  LIKE ? or  content  LIKE ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");
            rs = pstmt.executeQuery();
            if(rs.next()) {
            	result = rs.getInt(1);
            }
		} catch (Exception e) {
			e.printStackTrace();
		}
		   return result;
	   }
} 
