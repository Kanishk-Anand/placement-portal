<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
<%@include file="connect.jsp" %>
<%
	
	if(conn!=null && request.getParameter("cid")!=null && request.getParameter("gpa")!=null){
		int count=0;
		String sid="";
		float gpa=Float.parseFloat(request.getParameter("gpa"));
		int cid=Integer.parseInt(request.getParameter("cid"));
		String sql="SELECT s.student_id FROM shortlist s, student WHERE student.student_id=s.student_id AND student.cgpa<"+gpa+" AND s.company_id="+cid+";";
		rs=st.executeQuery(sql);
		while(rs.next()){
			count++;
			sid=sid+rs.getInt("student_id")+",";
		}
		//System.out.println(sid);
		if(count>0){
			pw.write(String.valueOf(count)+"+"+sid);
		}
		else
			pw.write("0");
	}
	
	if(conn!=null && request.getParameter("update")!=null){
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
		String sid=request.getParameter("stu_id");
		String rounds="";
		//System.out.println(ctime);
		if(ctime.compareTo("")==0){
			ctime="09:00";
		}
		String q="";
		for(int i=1;i<=num;i++){
			rounds=rounds+request.getParameter("Round "+i)+",";
		}
		
		q="UPDATE company SET company_name=?,interview_date=?,interview_time=?,branch=?,gpa=?,rounds=?,description=? WHERE company_name='"+cname+"';";
		ps=conn.prepareStatement(q);
		ps.setString(1,cname);
		ps.setString(2,cdate);
		ps.setString(3,ctime);
		ps.setString(4,branch);
		ps.setFloat(5,gpa);
		ps.setString(6,rounds);
		ps.setString(7,description);
		int i=ps.executeUpdate();
		int param=0;
		int j=0,flag=0;
		System.out.println("here sid="+sid);
		
		if(sid!=null && !sid.isEmpty()){
			//System.out.println("original sid "+sid);
			//System.out.println(sid.length());
			System.out.println(sid);
			//System.out.println(sid.length());
			//System.out.println("now sid "+sid);
			sid="("+sid+")";
			//System.out.println("updated sid "+sid);
			String sql="DELETE FROM shortlist WHERE student_id IN "+sid+";";
			st=conn.createStatement();
			j=st.executeUpdate(sql);
			flag=1;
		}
		if(i>0||(flag==1 && j>0)){
			param=1;
			response.sendRedirect("modify_interview.html?success="+param);
		}
		else{
			param=0;
			
			response.sendRedirect("interview.html?success="+param); 
		}
		
	}
%>
    
    