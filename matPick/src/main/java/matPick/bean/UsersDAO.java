package matPick.bean;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;


public class UsersDAO {
   private UsersDAO() {}
   private static UsersDAO instance = new UsersDAO();
   
   public static UsersDAO getInstance() {
      return instance;
   }
   private Connection conn;
   private ResultSet rs;
   private PreparedStatement pstmt;
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
      try {if(conn != null) {conn.close();}} catch (SQLException e) {e.printStackTrace();}
      try {if(pstmt != null) {pstmt.close();}} catch (SQLException e) {e.printStackTrace();}
      try {if(rs != null) {rs.close();}} catch (SQLException e) {e.printStackTrace();}
   }
   
   // 회원가입
   public int insertUsers( UsersDTO dto ) {
      int result = 0;
      try {
    	  conn = getConn();
    	  String sql = "INSERT INTO users (id, pw, name, nick, email, telecom, phone, gender, birth_date, reg, role) "
                 + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, ?)";
    	  pstmt = conn.prepareStatement(sql);
		  pstmt.setString(1, dto.getId());
		  pstmt.setString(2, dto.getPw());
		  pstmt.setString(3, dto.getName());
		  pstmt.setString(4, dto.getNick());
		  pstmt.setString(5, dto.getEmail());
		  pstmt.setString(6, dto.getTelecom());
		  pstmt.setString(7, dto.getPhone());
		  pstmt.setString(8, dto.getGender());
		  pstmt.setTimestamp(9, dto.getBirth_date());
		  if((dto.getId()).equals("admin")) {
			  pstmt.setString(10, "admin");
		  }else {
			  pstmt.setString(10, "user");
		  }
		  result = pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         close(conn,pstmt,rs);
      }   
      return result;
   }
  
   

   // 아이디 중복 확인
   public boolean confirmId(String id) {
      boolean result = false;
      try {
         conn = getConn();
         sql = "select id from users where id = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         rs = pstmt.executeQuery();
         if (rs.next()) {
            result = true;
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close(conn,pstmt,rs);
      }
      return result;
   }
   
   // 이메일 중복 확인
   public boolean confirmEmail(String email) {
      boolean result = false;
      try {
         conn = getConn();
         sql = "select email from users where email = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1,email);
         rs = pstmt.executeQuery();
         if (rs.next()) {
            result = true;
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
          close(conn,pstmt,rs);
       }
      return result;
   }
   
   // id, pw 확인 후 로그인
    public boolean loginCheck(UsersDTO dto) {
        boolean result = false;
        try {
            conn = getConn();
            sql = "select id from users where id = ? and pw = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getId().trim());
            pstmt.setString(2, dto.getPw().trim());
            rs = pstmt.executeQuery();
            if(rs.next()) {
                result=true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            close(conn,pstmt,rs);
        }
        return result;
    }  
    // 비밀번호 확인
    public boolean checkPassword(String id, String pw) {
        boolean result = false;
        try {
            conn = getConn();
            sql = "select id from users where id = ? and pw = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pw);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                result=true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            close(conn,pstmt,rs);
        }
        return result;
    }
    
    // 마이페이지(내정보보기)
    public UsersDTO myPage(String id) {
       UsersDTO dto = new UsersDTO();

       try {
         conn = getConn();
         sql = "select * from users where id = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            dto.setId(id);
            dto.setPw(rs.getString("pw"));
            dto.setName(rs.getString("name"));
            dto.setNick(rs.getString("nick"));
            dto.setEmail(rs.getString("email"));
            dto.setTelecom(rs.getString("telecom"));
            dto.setPhone(rs.getString("phone"));
            dto.setGender(rs.getString("gender"));
            dto.setBirth_date(rs.getString("birth_date"));
            dto.setRole(rs.getString("role"));
            dto.setStatus(rs.getString("status"));
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close(conn, pstmt, rs);
      }
       return dto;
    }
    
    // 역할,닉네임 조회
    public UsersDTO userRole(String id) {
       UsersDTO dto = new UsersDTO();
       try {
         conn = getConn();
         sql = "select role,nick from users where id=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            dto.setRole(rs.getString("role"));
            dto.setNick(rs.getString("nick"));
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         close(conn,pstmt,rs);
      }
       return dto;
    }
    
    // 회원 목록
    public ArrayList<UsersDTO> userList(int startRow, int endRow){
       ArrayList<UsersDTO> list = new ArrayList<UsersDTO>();
       try {
         conn = getConn();
         sql = "select * from (select b.*, rownum r from(select * from users order by reg desc) b) where r>=? and r<=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, startRow);
         pstmt.setInt(2, endRow);
         rs = pstmt.executeQuery();
         while(rs.next()) {
            UsersDTO dto = new UsersDTO();
            dto.setId(rs.getString("id"));
            dto.setName(rs.getString("name"));
            dto.setNick(rs.getString("nick"));
            dto.setReg(rs.getTimestamp("reg"));
            dto.setStatus(rs.getString("status"));
            list.add(dto);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         close(conn,pstmt,rs);
      }
       return list;
    }
    
    // id로 회원 검색
    public ArrayList<UsersDTO> idList(String search,int startRow, int endRow){
       ArrayList<UsersDTO> list = new ArrayList<UsersDTO>();
       try {
         conn = getConn();
         sql = "select * from(select b.*, rownum r from(select * from users where id like ? order by reg desc) b) where r>=? and r<=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, "%"+search+"%");
         pstmt.setInt(2, startRow);
         pstmt.setInt(3, endRow);
         rs = pstmt.executeQuery();
         while(rs.next()) {
            UsersDTO dto = new UsersDTO();
            dto.setId(rs.getString("id"));
            dto.setName(rs.getString("name"));
            dto.setNick(rs.getString("nick"));
            dto.setReg(rs.getTimestamp("reg"));
            dto.setStatus(rs.getString("status"));
            list.add(dto);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         close(conn,pstmt,rs);
      }
       return list;
    }
    
    // 이름으로 회원 검색
    public ArrayList<UsersDTO> nameList(String search,int startRow, int endRow){
       ArrayList<UsersDTO> list = new ArrayList<UsersDTO>();
       try {
         conn = getConn();
         sql = "select * from(select b.*, rownum r from(select * from users where name like ? order by reg desc) b) where r>=? and r<=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, "%"+search+"%");
         pstmt.setInt(2, startRow);
         pstmt.setInt(3, endRow);
         rs = pstmt.executeQuery();
         while(rs.next()) {
            UsersDTO dto = new UsersDTO();
            dto.setId(rs.getString("id"));
            dto.setName(rs.getString("name"));
            dto.setNick(rs.getString("nick"));
            dto.setReg(rs.getTimestamp("reg"));
            dto.setStatus(rs.getString("status"));
            list.add(dto);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         close(conn,pstmt,rs);
      }
       return list;
    }
    
    // 닉네임으로 회원 검색
    public ArrayList<UsersDTO> nickList(String search,int startRow, int endRow){
       ArrayList<UsersDTO> list = new ArrayList<UsersDTO>();
       try {
         conn = getConn();
         sql = "select * from(select b.*, rownum r from(select * from users where nick like ? order by reg desc) b) where r>=? and r<=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, "%"+search+"%");
         pstmt.setInt(2, startRow);
         pstmt.setInt(3, endRow);
         rs = pstmt.executeQuery();
         while(rs.next()) {
            UsersDTO dto = new UsersDTO();
            dto.setId(rs.getString("id"));
            dto.setName(rs.getString("name"));
            dto.setNick(rs.getString("nick"));
            dto.setReg(rs.getTimestamp("reg"));
            dto.setStatus(rs.getString("status"));
            list.add(dto);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         close(conn,pstmt,rs);
      }
       return list;
    }
    // 회원수
    public int userCount() {
       int result = 0;
       try {
         conn = getConn();
         sql = "select count(*) from users";
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
    
    // id에 따른 회원수
    public int idCount(String search) {
       int result = 0;
       try {
         conn = getConn();
         sql = "select count(*) from users where id like ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, "%"+search+"%");
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
    
    // 이름에 따른 회원수
    public int nameCount(String search) {
       int result = 0;
       try {
         conn = getConn();
         sql = "select count(*) from users where name like ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, "%"+search+"%");
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
    
    // 닉네임에 따른 회원수
    public int nickCount(String search) {
       int result = 0;
       try {
         conn = getConn();
         sql = "select count(*) from users where nick like ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, "%"+search+"%");
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
    
    // 아이디에 따른 유저 정보
    public UsersDTO userInfo(String id) {
       UsersDTO dto = new UsersDTO();
       try {
         conn = getConn();
         sql = "select * from users where id=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            dto.setId(rs.getString("id"));
            dto.setPw(rs.getString("pw"));
            dto.setName(rs.getString("name"));
            dto.setNick(rs.getString("nick"));
            dto.setEmail(rs.getString("email"));
            dto.setStatus(rs.getString("status"));
            dto.setBirth_date(rs.getString("birth_date"));
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         close(conn,pstmt,rs);
      }
       return dto;
    }
    
    // 관리자가 유저 정보 수정
    public int userUpdate(UsersDTO dto,String id) {
       int result = 0;
       String wt = null;
       try {
         conn = getConn();
         sql = "update users set pw=?, nick=?, email=?, status=? where id=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, dto.getPw());
         pstmt.setString(2, dto.getNick());
         pstmt.setString(3, dto.getEmail());
         pstmt.setString(4, dto.getStatus());
         pstmt.setString(5, id);
         result = pstmt.executeUpdate();
         
         if ("delete".equals(dto.getStatus())) {
             sql = "delete from users where id = ?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, id);
             pstmt.executeUpdate();
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         close(conn,pstmt,rs);
      }
       return result;
    }
    
    // 30일 지난 회원 탈퇴처리
    public void userDeleteTime() {
       try {
         conn = getConn();
         sql = "delete from users where withdrawTime IS NOT NULL and status='withdraw' and withdrawTime <= sysdate - 30";
         pstmt = conn.prepareStatement(sql);
         pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         close(conn,pstmt,rs);
      }
    }
    
    // 회원 탈퇴 유예기간
    public Timestamp deleteTime(String id) {
       Timestamp ts = null;
       try {
         conn = getConn();
         sql = "select withdrawTime + 30 as userTime from users where id=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            ts = rs.getTimestamp(1);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
          close(conn,pstmt,rs);
       }
       return ts;
    }
    
    // 회원 탈퇴(30일)
    public void userDelete() {
       try {
         conn = getConn();
         sql = "update users set withdrawTime=sysdate";
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         close(conn,pstmt,rs);
      }
    }
    
 // 아이디찾기(이메일을 바탕으로)
    public UsersDTO findId(String email) {
       UsersDTO dto = null; // 이메일에 맞는 id 값이 없을때 dto에 null을 반환
       try {
         conn = getConn();
         sql = "select id from users where email = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1,email); 
         rs = pstmt.executeQuery();
         if(rs.next()) { // 이메일에 맞는 id 값이 있다면
            dto = new UsersDTO(); // dto 객체를 생성해서
            dto.setId(rs.getString("id")); // id 값을 리턴해줌
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close(conn, pstmt, rs);
      }
       return dto;
    }
    
    /* 비밀번호 찾기(이메일+아이디 바탕으로), 임시비밀번호 발급
    일단 select로 이메일과 아이디에 일치하는 pw값이 있는지 확인하고 
    랜덤한 임시비밀번호를 생성하고 사용자의 이메일에 전송한 후 
    DB를 임시비밀번호 값으로 update 해준다  
     */
    public UsersDTO findPw(String email, String id) {
       UsersDTO dto = null; // 이메일과 아이디에 일치하는 값이 없을 때 dto에 null 반환
       try {
         conn = getConn();
         sql = "select pw from users where id = ? and email = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         pstmt.setString(2, email);
         rs = pstmt.executeQuery();
         if(rs.next()) { // 이메일과 아이디에 일치하는 비밀번호 값이 있다면
            dto = new UsersDTO(); // dto 객체를 생성후
            dto.setPw(rs.getString("pw"));
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally{
    	  close(conn,pstmt,rs);
      }
       return dto;
    }
    
    // 임시 비밀번호 생성
    public String generateTempPw() {
       String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*"; // 임시 비밀번호에 사용할 문자열들(영어+숫자+특수문자) length = 62개
       StringBuilder sb = new StringBuilder(); //
       for(int i= 0; i < 10; i++) { // 비밀번호 10자리 
          int idx = (int)(Math.random() * chars.length()); // Math.random(0~1.0)미만의 랜덤 실수반환, chars.length() 62 따라서 0~62미만의 정수반환(int) ex 2.55라면 형변환을 통해 2
          sb.append(chars.charAt(idx)); // chartAt(int index) 메서드는 chars가 가지고있는 특정위치(int index)의 문자를 반환 ex) sb.append(chars(2)) 2번 값 C를 반환한 후 sb 객체에 저장.
       }
       return sb.toString(); // sb에 저장된 임시비밀번호 반환 
    }
    
    // 임시 비밀번호를 DB에 업데이트하는 메서드
    public void updatePw(String id, String email, String newPw) {
       try {
         conn = getConn();
         sql = "update users set pw = ? where id = ? and email = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, newPw);
         pstmt.setString(2, id);
         pstmt.setString(3, email);
         pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close(conn,pstmt,rs);
      }
    }
    
    // 회원정보 수정
    public int updateUsers(UsersDTO dto) {
       int result = 0;
       try {
         conn = getConn();
         sql = "update users set pw = ?, nick = ?, email = ?, telecom = ?, phone = ? where id = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, dto.getPw());
         pstmt.setString(2, dto.getNick());
         pstmt.setString(3, dto.getEmail());
         pstmt.setString(4, dto.getTelecom());
         pstmt.setString(5, dto.getPhone());
         pstmt.setString(6, dto.getId());
         result = pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close(conn,pstmt,rs);
      }
       return result;
    }
    
    // 회원 탈퇴
    public int deleteUsers(UsersDTO dto) {
       int result = 0;
       try {
         conn = getConn();
         sql = "update users set withdrawTime=sysdate, status='withdraw' where id=? and pw=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, dto.getId());
         pstmt.setString(2, dto.getPw());
         result = pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close(conn,pstmt,rs);
      }
       return result;
    }
    // 관리자가 유저 정보 수정
    public int cancelWithdraw(String id) {
       int result = 0;
       try {
    	   conn = getConn();
               sql = "update users set withdrawTime=null, status='active' where id=?";
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1,id);
               result = pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         close(conn,pstmt,rs);
      }
       return result;
    }
    
    
}
