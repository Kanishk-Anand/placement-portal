<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.*,java.io.*" %>
<%
	String jdbcUrl = "jdbc:postgresql://localhost:5432/postgres";
    String username = "postgres";
    String password = "kanishk";
	Class.forName("org.postgresql.Driver").newInstance();
	Connection conn=null; 
	Statement st=null;
	PreparedStatement ps=null;
	ResultSet rs=null;
	PrintWriter pw=response.getWriter();
	
	try{
		conn=DriverManager.getConnection(jdbcUrl,username,password);
		st=conn.createStatement();

	}
	catch(Exception e){
		e.printStackTrace();
	}
	
	
%>