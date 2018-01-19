<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="connect.jsp" %>

<%
	if(conn!=null && request.getParameter("faculty_email")!=null && request.getParameter("faculty_pass")!=null){
		String email=request.getParameter("faculty_email");
		String pass=request.getParameter("faculty_pass");
		//System.out.println(email + pass);
		String q ="SELECT faculty_id FROM faculty WHERE email='"+email+"' AND password='"+pass+"';";
		rs=st.executeQuery(q);
		if(rs.next()){
			//System.out.println(rs.getString("faculty_id"));
			conn.close();
			st.close();
			response.setStatus(response.SC_MOVED_TEMPORARILY);
			response.setHeader("Location", "interview.html"); 
			
		}
		else{
			conn.close();
			st.close();
			response.setStatus(response.SC_MOVED_TEMPORARILY);
			response.setHeader("Location", "index.html?status=1"); 
		}
	}



%>
