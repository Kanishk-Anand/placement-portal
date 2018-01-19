<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="connect.jsp" %>

<%
	if(conn!=null && request.getParameter("student_email")!=null && request.getParameter("student_pass")!=null){
		String email=request.getParameter("student_email");
		String pass=request.getParameter("student_pass");
		String q ="SELECT student_id FROM student WHERE email='"+email+"' AND password='"+pass+"';";
		rs=st.executeQuery(q);
		if(rs.next()){
			HttpSession sess=request.getSession();
			sess.setAttribute("student_id", rs.getString("student_id"));
			conn.close();
			st.close();
			response.setStatus(response.SC_MOVED_TEMPORARILY);
			response.setHeader("Location", "student_company.jsp"); 
			
		}
		else{
		conn.close();
		st.close();
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", "index.html?status=1"); 
		}
	}



%>
