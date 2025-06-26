<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="matPick.bean.UsersDAO" %>
<%@ page import="matPick.bean.UsersDTO" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
   String sid = (String)session.getAttribute("sid");
   String pw = request.getParameter("pw");
   String nick = request.getParameter("nick");
   String email = request.getParameter("email");
   String telecom = request.getParameter("telecom");
   String phone = request.getParameter("phone");
   String birthDate = request.getParameter("birth_date");
   
   UsersDTO dto = new UsersDTO();
     dto.setId(sid);
    dto.setPw(pw);
    dto.setNick(nick);
    dto.setEmail(email);
    dto.setTelecom(telecom);
    dto.setPhone(phone);
    

    
   UsersDAO dao = UsersDAO.getInstance();
   int result = dao.updateUsers(dto);
   if(result != 0 ){ // 업데이트가 됐을경우 %>
      <script>
         alert("정보수정이 완료되었습니다.")
         window.location="myPage.jsp";
      </script>
<%    }else{ %>
      <script>
         alert("다시 작성해주세요.")
         history.go(-1);
      </script>
<%    }%>