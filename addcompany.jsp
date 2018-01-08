<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
 <%@page import="java.sql.*,java.util.*" %>
    	
	<% 
		
	String jdbcUrl = "jdbc:postgresql://localhost:5432/postgres";
    String username = "postgres";
    String password = "kanishk";
		Connection conn=null; 
		Statement st=null;
		PreparedStatement ps=null;
		String rounds="";
		String cname=request.getParameter("company_name");
		String tempgpa=request.getParameter("gpa");
		Float gpa=Float.parseFloat(tempgpa);
		int num=Integer.parseInt(request.getParameter("rounds"));
		String [] arr = request.getParameterValues("branch");
		String branch = String.join(",",arr);
		String cdate=request.getParameter("date");
		String ctime=request.getParameter("company_time");
		
		for(int i=1;i<=num;i++){
			rounds=rounds+request.getParameter("Round "+i)+",";
		}
		//System.out.println(cdate + ctime + branch + rounds);
		Class.forName("org.postgresql.Driver").newInstance();
		try{
			
			conn=DriverManager.getConnection(jdbcUrl,username,password);
			st=conn.createStatement();
			if(conn!=null){
				
				String q="INSERT into company (company_name,interview_date,interview_time,branch,gpa,rounds) VALUES (?,?,?,?,?,?);";
				ps=conn.prepareStatement(q);
				ps.setString(1,cname);
				ps.setString(2,cdate);
				ps.setString(3,ctime);
				ps.setString(4,branch);
				ps.setFloat(5,gpa);
				ps.setString(6,rounds);
				int i=ps.executeUpdate();
			if(i>0){
				System.out.println("Inserted");
			}
			else
				System.out.println("Connection Error");
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			
			if(conn!=null)
				conn.close();
			if(st!=null)
				st.close();
		}
	%>