<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
<%@include file="connect.jsp"%>

<%
	if(request.getParameter("compname")!=null && conn!=null){
		String compname=request.getParameter("compname");
		if(compname.compareTo("")!=0){
			compname=compname.toLowerCase();
			compname="'%"+compname+"%'";
		//System.out.println(compname);
			String q="SELECT DISTINCT company_name,company_id FROM company WHERE company_name LIKE "+compname+";";
			rs=st.executeQuery(q);
		//System.out.println(rs.getString("company_name"));
			int count=0;
				while(rs.next()){
			//rs.getString("company_name");
					pw.flush();
					count++;
					response.getWriter().write("<a href='#company_form' onclick="+"\"displayCompanyInfo('"+rs.getString("company_name")+"','"+rs.getString("company_id")+"');\">"+rs.getString("company_name")+"</a><br>"); 
			
				}
				if(count==0)
					pw.write("404");
		
			}
		else{
			pw.write("404");
		}
	
	}
	if(request.getParameter("displaycompany")!=null && conn!=null){
		String displaycompany=request.getParameter("displaycompany");
		String q="SELECT * FROM company WHERE company_name='"+displaycompany+"';";
		rs=st.executeQuery(q);
		String branch="";
		String rounds="";
		String gpa="";
		String cdate="";
		String ctime="";
		String responseText="";
		String description="";
		
		while(rs.next()){
			cdate=rs.getString("interview_date");
			ctime=rs.getString("interview_time");
			branch=rs.getString("branch");
			rounds=rs.getString("rounds");
			gpa=rs.getString("gpa");
			description=rs.getString("description");
			responseText=cdate + "+" + ctime + "+" + branch + "+" + rounds + "+" + gpa + "+" +description;
			
			pw.flush();
			pw.write(responseText);
			
		}
		
		
		
	}
	if(conn!=null)
		conn.close();
	if(st!=null)
		st.close();
	
%>