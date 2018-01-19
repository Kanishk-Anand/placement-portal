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
		int param=Integer.parseInt(request.getParameter("update"));
		String cname=request.getParameter("company_name");
		cname=cname.toLowerCase();
		String tempgpa=request.getParameter("gpa");
		Float gpa=Float.parseFloat(tempgpa);
		int num=Integer.parseInt(request.getParameter("rounds"));
		String [] arr = request.getParameterValues("branch");
		String branch = String.join(",",arr);
		String cdate=request.getParameter("date");
		String ctime=request.getParameter("company_time");
		String description=request.getParameter("description");
		System.out.println(ctime);
		if(ctime.compareTo("")==0){
			ctime="09:00";
		}
		//System.out.println(request.getParameter("update"));
		
		//System.out.println(param);
		String q="";
		for(int i=1;i<=num;i++){
			rounds=rounds+request.getParameter("Round "+i)+",";
		}
		//System.out.println(cdate + ctime + branch + rounds);
		Class.forName("org.postgresql.Driver").newInstance();
		try{
			
			conn=DriverManager.getConnection(jdbcUrl,username,password);
			st=conn.createStatement();
			if(conn!=null){
				if(param==2){
					 q="INSERT into company (company_name,interview_date,interview_time,branch,gpa,rounds,description) VALUES (?,?,?,?,?,?,?);";
					 param=2;
				}
				else{
					
					 q="UPDATE company SET company_name=?,interview_date=?,interview_time=?,branch=?,gpa=?,rounds=?,description=? WHERE company_name='"+cname+"';";
					 param=1;
				}
				ps=conn.prepareStatement(q);
				ps.setString(1,cname);
				ps.setString(2,cdate);
				ps.setString(3,ctime);
				ps.setString(4,branch);
				ps.setFloat(5,gpa);
				ps.setString(6,rounds);
				ps.setString(7,description);
				int i=ps.executeUpdate();
				if(i>0){
					if(param==1){
					
						response.sendRedirect("modify_interview.html?success="+param);
					}
					else{
						response.setStatus(response.SC_MOVED_TEMPORARILY);
						response.setHeader("Location", "interview.html?success="+param); 
					}
				}	
				else
					param=0;
					response.setStatus(response.SC_MOVED_TEMPORARILY);
					response.setHeader("Location", "interview.html?success="+param); 
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