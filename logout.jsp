<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

 <%
 	if(session.getAttribute("student_id")!=null){
 		session.removeAttribute("student_id");
 	}
 	if(session.getAttribute("faculty_id")!=null){
 		session.removeAttribute("faculty_id");
 	}
 	response.sendRedirect("index.html");
 %>