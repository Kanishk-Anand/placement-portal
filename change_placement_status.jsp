<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>

   <%@include file="connect.jsp"%>
   
   <%
   	if(conn!=null && request.getParameter("student_id")!=null &&request.getParameter("comment")!=null){
   		String student_id=request.getParameter("student_id");
   		String comment=request.getParameter("comment");
   		String q="SELECT placed FROM student WHERE student_id='"+student_id+"';";
   		String status="";
   		Boolean bool=true;
   		rs=st.executeQuery(q);
   		int flag=0;
   		while(rs.next()){
   			status=rs.getString("placed");
   			if(status.compareTo("f")==0){
   				status="Placed";
   				bool=true;
   			}
   			else{
   				status="Not Placed";
   				bool=false;
   			}
   			
   		}
   		q="UPDATE student SET placed=?,comment=? WHERE student_id='"+student_id+"';";
   		ps=conn.prepareStatement(q);
   		ps.setBoolean(1,bool);
   		ps.setString(2,comment);
   		int i=ps.executeUpdate();
   		if(i>0){
   			flag=1;
   			response.sendRedirect("student_status.jsp?status="+flag);
   		}
   		else
   			response.sendRedirect("student_status.jsp?status="+flag);
   		
   		conn.close();
   		st.close();
   		pw.close();
   	}
   
   
   	
   	%>