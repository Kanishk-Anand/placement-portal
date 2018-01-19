<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="connect.jsp"%>
<% 
if(request.getParameter("add_id")!=null){
	String id= request.getParameter("add_id");
if(conn!=null){
	
	String sid=(String)session.getAttribute("student_id");
	int student_id=Integer.parseInt(sid);
	String q="INSERT INTO shortlist (company_id,student_id) VALUES (?,?);";
	ps=conn.prepareStatement(q);
	ps.setInt(1,Integer.parseInt(id));
	ps.setInt(2,student_id);
	int i=ps.executeUpdate();
	if(i>0){
		//System.out.println("Updated successfully");
		pw.write("OK");
	}
	else
		pw.write("Error");
	
}
}

if(request.getParameter("remove_id")!=null){
	String id= request.getParameter("remove_id");
	int company_id=Integer.parseInt(id);
	//System.out.println(id);
if(conn!=null){
	String sid=(String)session.getAttribute("student_id");
	int student_id=Integer.parseInt(sid);
	String q="DELETE FROM shortlist WHERE student_id='"+student_id+"' AND company_id='"+company_id+"';";
	st=conn.createStatement();
	int i=st.executeUpdate(q);
	
	if(i>0){
		//System.out.println("Deleted successfully");
		pw.print("OK");
	}
	else
		pw.print("Error");
}
}


if(conn!=null)
	conn.close();
if(st!=null)
	st.close();


 %>