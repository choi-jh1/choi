<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="matPick.bean.UsersDAO"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>
<jsp:useBean class="matPick.bean.UsersDTO" id="dto"/>
<jsp:setProperty name="dto" property="*"/>


<%
   Cookie[] cookies = request.getCookies();
   for( Cookie c : cookies ){
      if( c.getName().equals("cid")){dto.setId(c.getValue());}
      if( c.getName().equals("cpw")){dto.setPw(c.getValue());}
      if( c.getName().equals("cauto")){dto.setAuto(c.getValue());}
   }
   UsersDAO dao =UsersDAO.getInstance();
   boolean result = dao.loginCheck(dto);
   
   dto = dao.myPage(dto.getId());
   
   
   // 관리자 로그인시 하루에 한번만 실행
   if(dto.getRole() != null && (dto.getRole()).equals("admin") ){
      // Date 클래스 객체 생성
      Date lastRun = (Date)application.getAttribute("lastCleanupDate");
      Date now = new Date();
      
      // 최초로 실행되거나 24시간이 지나면 실행 가능
      if(lastRun == null || now.getTime() - lastRun.getTime() > (1000*60*60*24)){
         // 30일 지난 계정 삭제
         dao.userDeleteTime();
      }
   }
   
   if (dto.getStatus() != null && result == true && !((dto.getStatus()).equals("suspended"))){
         if( dto.getAuto() != null && dto.getAuto().equals("1")){
            Cookie coo1 = new Cookie("cid", dto.getId());
            Cookie coo2 = new Cookie("cpw", dto.getPw());
            Cookie coo3 = new Cookie("cauto", dto.getAuto());
         
            coo1.setMaxAge(60*60);
            coo2.setMaxAge(60*60);
            coo3.setMaxAge(60*60);
            
            response.addCookie(coo1);
            response.addCookie(coo2);
            response.addCookie(coo3);
         }
         session.setAttribute("sid", dto.getId());
         session.setAttribute("role", dto.getRole());
         
         if((dto.getStatus()).equals("withdraw")){
             Timestamp ts = dao.deleteTime(dto.getId());%>
             <script>
                alert("탈퇴 예정인 계정입니다.\n<%=ts%>");
                window.location = "../main/mainPage.jsp";
             </script>
<%         }else{%>
               <script>
                  window.location = "../main/mainPage.jsp";
             </script>
         <%} 
     }else if(dto.getStatus() != null && (dto.getStatus()).equals("suspended")){ %>
            <script>
               alert("계정이 정지된 상태 입니다.");
               window.location="../main/mainPage.jsp";
            </script>
<%    }else{ %>
         <script>
            alert("아이디/비밀번호를 확인해주세요.");
            window.location="../user/loginForm.jsp";
         </script>
   <%    }%>




