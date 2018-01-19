<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
    <%@include file="connect.jsp" %>
<%
if(request.getParameter("company_id")!=null){
	String id= request.getParameter("company_id");
	//System.out.println(id);
if(conn!=null){
	String q="DELETE FROM company WHERE company_id='"+id+"';";
	String sql="DELETE FROM shortlist WHERE company_id="+Integer.parseInt(id)+";";
	st=conn.createStatement();
	int i=st.executeUpdate(q);
	int j=st.executeUpdate(sql);
	if(i>0 && j>0){
		//System.out.println("Deleted successfully");
		pw.print("OK");
	}
	else
		pw.print("Error");
	conn.close();
	st.close();
}
}




%>