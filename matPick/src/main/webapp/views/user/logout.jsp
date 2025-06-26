<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	// 쿠키와 세션 모두 삭제해야함
	Cookie[] cookies = request.getCookies();
	for( Cookie c : cookies){
		if( c.getName().equals("cid") || c.getName().equals("cpw") || c.getName().equals("cauto")) {
			c.setMaxAge(0);
			response.addCookie(c);
		}
	}
	session.invalidate();
	response.sendRedirect("../main/mainPage.jsp");
%> 