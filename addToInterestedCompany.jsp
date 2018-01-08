<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="connect.jsp"%>
<% 
if(request.getParameter("add_id")!=null){
	String id= request.getParameter("add_id");
if(conn!=null){
	String q="SELECT interested_companies FROM student WHERE student_id=1 ;";
	rs=st.executeQuery(q);
	String com="";
	while(rs.next()){
		com=rs.getString("interested_companies");
		com=com+id;
	}
	q="UPDATE student SET interested_companies=? WHERE student_id=1;";
	ps=conn.prepareStatement(q);
	ps.setString(1,com);
	int i=ps.executeUpdate();
	if(i>0){
		System.out.println("Updated successfully");
		pw.write("OK");
	}
	else
		System.out.println("Error");
}
}

if(request.getParameter("remove_id")!=null){
	String id= request.getParameter("remove_id");
	System.out.println(id);
if(conn!=null){
	String q="SELECT interested_companies FROM student WHERE student_id=1 ;";
	rs=st.executeQuery(q);
	String com="";
	while(rs.next()){
		com=rs.getString("interested_companies");
		com=com.replace(id,"");
	}
	q="UPDATE student SET interested_companies=? WHERE student_id=1;";
	ps=conn.prepareStatement(q);
	ps.setString(1,com);
	int i=ps.executeUpdate();
	if(i>0){
		System.out.println("Updated successfully");
		pw.print("OK");
	}
	else
		System.out.println("Error");
}
}



 %>