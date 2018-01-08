<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
<%@include file="connect.jsp"%>

<%
	if(request.getParameter("compname")!=null && conn!=null){
		String compname=request.getParameter("compname");
		if(compname.compareTo("")!=0){
		compname="'%"+compname+"%'";
		//System.out.println(compname);
		String q="SELECT company_name FROM company WHERE company_name LIKE "+compname+";";
		rs=st.executeQuery(q);
		//System.out.println(rs.getString("company_name"));
		while(rs.next()){
			//rs.getString("company_name");
			response.getWriter().write("<a onclick='displayCompanyInfo('"+rs.getString("company_name")+"')>"+rs.getString("company_name")+"</a>"); 
		}
		}
	
	}
	if(request.getParameter("displaycompany")!=null && conn!=null){
		String displaycompany=request.getParameter("displaycompany");
		String q="SELECT * FROM company WHERE company_name="+displaycompany+";";
		rs=st.executeQuery(q);
		String branch="";
		String rounds="";
		String gpa="";
		String cdate="";
		String ctime="";
		String responseText="";
		while(rs.next()){
			cdate=rs.getString("interview_date");
			ctime=rs.getString("interview_time");
			branch=rs.getString("branch");
			rounds=rs.getString("rounds");
			gpa=rs.getString("gpa");
			responseText=cdate + "+" + ctime + "+" + branch + "+" + rounds + "+" + gpa;
			pw.flush();
			pw.write(responseText);
		}
	}
	
%>